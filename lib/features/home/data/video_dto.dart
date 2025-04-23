class VideoDto {
  final int id;
  final String title;
  final String videoUrl;
  final DateTime uploadedAt;

  VideoDto({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.uploadedAt,
  });

  factory VideoDto.fromMap(Map<String, dynamic> map) {
    return VideoDto(
      id: map['id'],
      title: map['title'],
      videoUrl: map['video_url'],
      uploadedAt: DateTime.parse(map['uploaded_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'video_url': videoUrl,
      'uploaded_at': uploadedAt.toIso8601String(),
    };
  }
}
