import 'package:video_desktop_saver/features/keyboard/data/text_model.dart';

abstract class TextRepository {
  List<TextModel> getAllTexts();
  TextModel? getTextById(String id);
  void addText(TextModel text);
  void updateText(String id, String newContent);
  void deleteText(String id);
}
