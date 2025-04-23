import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_desktop_saver/core/constants/app_constants.dart';
import 'package:video_desktop_saver/features/home/data/video_dto.dart';
import 'package:video_desktop_saver/features/home/domain/supabase_service.dart';

class SupabaseServiceImpl implements SupabaseService {
  final SupabaseClient supabaseClient;
  SupabaseServiceImpl({required this.supabaseClient});
  @override
  Future<void> deleteVideo({required int id}) async {
    try {
      await supabaseClient.from(AppConstants.videoTable).delete().eq('id', id);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<VideoDto>> getAllVideos() {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoDto>> getVideoById({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideoDto>> insertVideo(
      {required String title, required String videoUrl}) {
    throw UnimplementedError();
  }
}
