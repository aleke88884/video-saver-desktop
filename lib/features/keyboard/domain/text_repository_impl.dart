import 'package:hive/hive.dart';
import 'package:video_desktop_saver/features/keyboard/data/text_model.dart';
import 'package:video_desktop_saver/features/keyboard/domain/text_repository.dart';

class TextRepositoryImpl implements TextRepository {
  TextRepositoryImpl({required Box<TextModel> box}) : _box = box;

  final Box<TextModel> _box;

  @override
  List<TextModel> getAllTexts() {
    return _box.values.toList();
  }

  @override
  TextModel? getTextById(String id) {
    return _box.values.firstWhere(
      (text) => text.id == id,
      orElse: () => TextModel(id: '', content: ''),
    );
  }

  @override
  void addText(TextModel text) {
    _box.put(text.id, text);
  }

  @override
  void updateText(String id, String newContent) {
    final text = _box.get(id);
    if (text != null) {
      text.content = newContent;
      text.save();
    }
  }

  @override
  void deleteText(String id) {
    _box.delete(id);
  }
}
