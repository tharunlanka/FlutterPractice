
class UserDetails {
  String? avatar;
  String? name;
  String? date;
  String? amount;

  UserDetails({
    this.avatar,
    this.name,
    this.date,
    this.amount,
  });

  UserDetails.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    name = json['name'];
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['name'] = name;
    data['date'] = date;
    data['amount'] = amount;
    return data;
  }
}