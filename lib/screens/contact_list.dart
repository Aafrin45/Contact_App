import 'package:flutter/material.dart';
import '../repository/contact_repository.dart';
import '../screens/add_contact.dart';
import '../screens/edit_contact.dart';

class ContactList extends StatefulWidget {
  final ContactRepository contactRepository;

  const ContactList({Key? key, required this.contactRepository}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts List', style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List of contacts
            widget.contactRepository.contacts.isEmpty
                ? const Text(
                    'No Contacts yet..',
                    style: TextStyle(fontSize: 22),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: widget.contactRepository.contacts.length,
                      itemBuilder: (context, index) =>
                          _getRow(index, widget.contactRepository),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddContactPage(
                contactRepository: widget.contactRepository,
              ),
            ),
          );

          // Update the list if a new contact was added
          if (result != null && result) {
            setState(() {});
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _getRow(int index, ContactRepository contactRepository) {
    String name = contactRepository.contacts[index].name;
    String firstLetter = name.isNotEmpty ? name[0].toUpperCase() : '';

    return Card(
      elevation: 0, // Set elevation to 0 to remove the shadow
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            firstLetter,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              contactRepository.contacts[index].contact,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            Text(
              contactRepository.contacts[index].email,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditContactPage(
                          contact: contactRepository.contacts[index],
                          contactRepository: widget.contactRepository,
                        ),
                      ),
                    ).then((result) {
                      if (result != null && result) {
                        setState(() {});
                      }
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _handleDeleteIconTap(index, widget.contactRepository);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleDeleteIconTap(int index, ContactRepository contactRepository) {
    _showDeleteConfirmationDialog(context, index, contactRepository);
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, int index, ContactRepository contactRepository) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Delete Contact"),
          content: const Text("Are you sure you want to delete this contact?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                setState(() {
                  contactRepository.deleteContact(index);
                });
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
