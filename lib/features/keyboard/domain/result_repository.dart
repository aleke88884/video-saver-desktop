abstract class ResultRepository {
  List<String> getAllResults();
  String? getResultById(String id);
  void addResult(String result);
  void updateResult(String id, String newContent);
  void deleteResult(String id);
}
