import 'package:video_desktop_saver/features/home/data/video_dto.dart';

abstract class SupabaseService {
  Future<List<VideoDto>> getAllVideos();
  Future<List<VideoDto>> getVideoById({required int id});
  Future<List<VideoDto>> insertVideo(
      {required String title, required String videoUrl});
  Future<void> deleteVideo({required int id});
}
