// contact.dart
class Contact {
  String name;
  String contact;
  String email;

  Contact({required this.name, required this.contact, required this.email});

  bool isValid() {
    return name.isNotEmpty && _validateContactNumber(contact) && _validateEmail(email);
  }

  bool _validateEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool _validateContactNumber(String contactNumber) {
    // Add your validation logic for the contact number
    return contactNumber.isNotEmpty && contactNumber.length == 10 && int.tryParse(contactNumber) != null;
  }
}
