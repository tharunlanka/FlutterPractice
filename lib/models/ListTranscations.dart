class ListTranscations {
  late final String id;
  late final String title;
  late final double amount;
  DateTime? date;

  ListTranscations({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['amount'] = amount;
    data['date'] = date;
    return data;
  }

  ListTranscations.fromMapObj(Map<String, dynamic> map){
    date=map['date'];
    amount=map['amount'];
    title=map['title'];
    id=map['id'];
  }

}
