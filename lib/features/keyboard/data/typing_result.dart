// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

part 'typing_result.g.dart';

@HiveType(typeId: 0)
class TypingResult extends HiveObject {
  @HiveField(0)
  double wpm;

  @HiveField(1)
  DateTime timeStamp;
  TypingResult({
    required this.wpm,
    required this.timeStamp,
  });
}
