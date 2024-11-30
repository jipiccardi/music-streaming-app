import 'package:music_app/data/models/playlist.dart';
import 'package:music_app/services/firestore_database_service.dart';

abstract interface class PlaylistsRepository {
  Future<List<Playlist>> getAllPlaylists();
  Future<void> removePlaylist(String id);
  Future<Playlist> addPlaylist(Playlist playlist);
}

class FirebasePlaylistsRepository implements PlaylistsRepository {
  final _firestore = FirestoreDatabase().firestore;

  @override
  Future<List<Playlist>> getAllPlaylists() async {
    final querySnapshot = await _firestore.collection('playlists').get();

    return querySnapshot.docs.map((doc) {
      return Playlist.fromFirestore(doc.data(), doc.id);
    }).toList();
  }

  @override
  Future<void> removePlaylist(String id) async {
    await _firestore.collection('playlists').doc(id).delete();
  }

  @override
  Future<Playlist> addPlaylist(Playlist playlist) async {
    final docRef = await _firestore.collection('playlists').add({
      'userId': playlist.userId,
      'name': playlist.name,
      'coverArt': playlist.coverArt,
      'songs': playlist.songs,
    });

    final docSnapshot = await docRef.get();

    return Playlist.fromFirestore(
        docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
  }
}
