class transaction {
  final String title;
  final DateTime day;
  final String id;
  final double amount;

  transaction(
      {required this.title,
      required this.amount,
      required this.day,
      required this.id});
}
