import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:music_app/domain/song.dart';
import 'package:music_app/domain/songs_repository.dart';

class FirebaseSongsRepository implements SongsRepository {
  final FirebaseFirestore _firestore;

  FirebaseSongsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Song>> getAllSongs() async {
    final querySnapshot = await _firestore.collection('songs').get();

    return querySnapshot.docs.map((doc) {
      return Song.fromFirestore(doc.data(), doc.id);
    }).toList();
  }

  @override
  Future<Song?> getSongById(String songId) async {
    final doc = await _firestore.collection('songs').doc(songId).get();
    return doc.exists ? Song.fromFirestore(doc.data()!, doc.id) : null;
  }
}
