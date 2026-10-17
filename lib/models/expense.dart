class Expense {
  final int? id;
  final String title;
  final double amount;
  final String note;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'note': note,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: (map['amount'] as num).toDouble(),
      note: map['note'] ?? '',
    );
  }
}