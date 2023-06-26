import 'Message.dart';

class Choices {
  Choices({
      required this.index,
      required this.message,
      required this.finishReason,});

  Choices.fromJson(dynamic json) {
    index = json['index'];
    message = (json['message'] != null ? Message.fromJson(json['message']) : null)!;
    finishReason = json['finish_reason'];
  }
  late int index;
  late Message message;
  late String finishReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['index'] = index;
    if (message != null) {
      map['message'] = message.toJson();
    }
    map['finish_reason'] = finishReason;
    return map;
  }

}