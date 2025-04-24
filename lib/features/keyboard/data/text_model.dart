// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'text_model.g.dart';

@HiveType(typeId: 1)
class TextModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String content;
  TextModel({
    required this.id,
    required this.content,
  });
}
