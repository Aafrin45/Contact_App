// contact_repository.dart
import '../model/contact.dart';

class ContactRepository {
  List<Contact> contacts = [];

  ContactRepository();

  void addContact(Contact contact) {
    contacts.add(contact);
  }

  void updateContact(Contact oldContact, Contact newContact) {
    int index = contacts.indexOf(oldContact);
    if (index != -1) {
      contacts[index] = newContact;
    }
  }

  void deleteContact(int index) {
    if (index >= 0 && index < contacts.length) {
      contacts.removeAt(index);
    }
  }
}
