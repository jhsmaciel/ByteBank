import 'package:bytebanksqlite/model/Contact.dart';

class Transaction {
  final double value;
  final Contact contact;
  final String id;

  Transaction(
    this.id,
    this.value,
    this.contact,
  );

  Transaction.fromJson(Map<String, dynamic> json):
        id = json['id'],
        value = json['value'],
        contact = Contact.fromJson(json['contact']);

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'value': value.toString(),
        'contact': contact.toJson(),
      };

  @override
  String toString() {
    return 'Transaction{id: $id, value: $value, contact: $contact}';
  }
}
