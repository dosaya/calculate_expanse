class TransactionModel {
  final String title;
  final double amount;
  final String type;
  final String category;
  final DateTime date;
  final String note;

  const TransactionModel({
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    this.note = '',
});
  bool get isIncome => type == 'Income';
}
