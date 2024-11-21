import 'package:music_app/domain/song.dart';
import 'package:music_app/domain/songs_repository.dart';

class FirebaseSongsRepository implements SongsRepository {
  // TODO implement with firebase

  final List<Song> _songs = [
    Song(id: '1', title: 'Snow', filePath: "...", genre: "..."),
    Song(id: '2', title: 'Aeroplane', filePath: "...", genre: "..."),
    Song(id: '1', title: 'Snow', filePath: "...", genre: "..."),
    Song(id: '2', title: 'Aeroplane', filePath: "...", genre: "..."),
    Song(id: '1', title: 'Snow', filePath: "...", genre: "..."),
    Song(id: '2', title: 'Aeroplane', filePath: "...", genre: "..."),
    Song(id: '1', title: 'Snow', filePath: "...", genre: "..."),
    Song(id: '2', title: 'Aeroplane', filePath: "...", genre: "..."),
    Song(id: '1', title: 'Snow', filePath: "...", genre: "..."),
    Song(id: '2', title: 'Aeroplane', filePath: "...", genre: "..."),
  ];

  @override
  Future<List<Song>> getAllSongs() => Future.delayed(
        const Duration(seconds: 2),
        () => _songs,
      );
}
