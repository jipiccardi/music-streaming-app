import 'song.dart';

abstract interface class SongsRepository {
  Future<List<Song>> getAllSongs();
}
