import 'package:flutter/material.dart';
import 'repository/contact_repository.dart';
import 'screens/add_contact.dart';
import 'screens/contact_list.dart';
import '../model/contact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ContactRepository contactRepository = ContactRepository();

  // Add inbuilt contact when initializing ContactRepository
  MyApp() {
    Contact inbuiltContact = Contact(
      name: 'Aafrin Sulaiha',
      contact: '9600744285',
      email: 'aafrinsulaiha@gmail.com',
    );
    contactRepository.addContact(inbuiltContact);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => ContactList(contactRepository: contactRepository),
        '/addContact': (context) =>
            AddContactPage(contactRepository: contactRepository),
      },
    );
  }
}
