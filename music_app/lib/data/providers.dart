import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/data/firebase_songs_repository.dart';

import '../domain/songs_repository.dart';

final songsRepositoryProvider = Provider<SongsRepository>(
  (ref) => FirebaseSongsRepository(),
);
