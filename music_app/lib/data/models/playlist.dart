class Playlist {
  final String id;
  final String userId;
  final String name;
  final String? coverArt;
  final List<String>? songs;

  Playlist({
    required this.id,
    required this.userId,
    required this.name,
    this.coverArt,
    this.songs,
  });

  factory Playlist.fromFirestore(Map<String, dynamic> data, String id) {
    return Playlist(
      id: id,
      userId: data['userId'],
      name: data['name'],
      coverArt: data['coverArt'],
      songs: List<String>.from(data['songs']),
    );
  }
}