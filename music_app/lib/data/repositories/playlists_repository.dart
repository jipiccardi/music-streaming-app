import 'package:music_app/data/models/playlist.dart';

abstract interface class PlaylistsRepository {
  Future<List<Playlist>> getAllPlaylists();
}