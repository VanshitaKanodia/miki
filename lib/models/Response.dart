import 'Choices.dart';
import 'Usage.dart';

class Response {
  Response({
      required this.id,
      required this.object,
      required this.created,
      required this.model,
      required this.choices,
      required this.usage,});

  Response.fromJson(dynamic json) {
    id = json['id'];
    object = json['object'];
    created = json['created'];
    model = json['model'];
    if (json['choices'] != null) {
      choices = [];
      json['choices'].forEach((v) {
        choices.add(Choices.fromJson(v));
      });
    }
    usage = (json['usage'] != null ? Usage.fromJson(json['usage']) : null)!;
  }
  late String id;
  late String object;
  late int created;
  late String model;
  late List<Choices> choices;
  late Usage usage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['object'] = object;
    map['created'] = created;
    map['model'] = model;
    if (choices != null) {
      map['choices'] = choices.map((v) => v.toJson()).toList();
    }
    if (usage != null) {
      map['usage'] = usage.toJson();
    }
    return map;
  }

}