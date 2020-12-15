class Contact {
  final int id;
  final String fullName;
  final int accountNumber;

  Contact(this.id, this.fullName, this.accountNumber);

  Contact.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      fullName = json['name'],
      accountNumber = json['accountNumber'];

  @override
  String toString() {
    return 'Contact{id: $id, fullName: $fullName, accountNumber: $accountNumber}';
  }

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'name': fullName,
      'accountNumber': accountNumber
    };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Contact &&
              runtimeType == other.runtimeType &&
              fullName == other.fullName &&
              accountNumber == other.accountNumber;

  @override
  int get hashCode =>
      fullName.hashCode ^
      accountNumber.hashCode;

}