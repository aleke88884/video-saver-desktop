import 'package:hive/hive.dart';
import 'package:video_desktop_saver/features/keyboard/data/typing_result.dart';
import 'package:video_desktop_saver/features/keyboard/domain/result_repository.dart';

class ResultRepositoryImpl implements ResultRepository {
  ResultRepositoryImpl({required this.box});

  final Box<TypingResult> box;
  @override
  void addResult(String result) {
    final typingResult = TypingResult(
      wpm: double.parse(result.split(' ')[0]),
   
      timeStamp: DateTime.now(),
    );
    box.add(typingResult);
  }

  @override
  void deleteResult(String id) {}

  @override
  List<String> getAllResults() {
    return box.values.map((result) => '${result.wpm} WPM').toList();
  }

  @override
  String? getResultById(String id) {
    final result = box.values.firstOrNull!;
    return '${result.wpm} WPM';
  }

  @override
  void updateResult(String id, String newContent) {}
}
