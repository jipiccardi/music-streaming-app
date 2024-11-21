import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  final String id;
  final String title;
  final String? album;
  final String? artist;
  final String? coverArt;
  final String filePath;
  final String genre;

  Song({
    required this.id,
    required this.title,
    this.album,
    this.artist,
    this.coverArt,
    required this.filePath,
    required this.genre,
  });

  static Song fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Song(
      id: data?['id'],
      title: data?['title'],
      album: data?['album'],
      artist: data?['artist'],
      coverArt: data?['coverArt'],
      filePath: data?['filePath'],
      genre: data?['genre'],
    );
  }
}
