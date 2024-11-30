import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/data/repositories/playlists_repository.dart';

import 'songs_repository.dart';

final songsRepositoryProvider = Provider<SongsRepository>(
  (ref) => FirebaseSongsRepository(),
);

final playlistsRepositoryProvider = Provider<PlaylistsRepository>(
  (ref) => FirebasePlaylistsRepository(),
);