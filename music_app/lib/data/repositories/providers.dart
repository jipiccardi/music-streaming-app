import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'songs_repository.dart';

final songsRepositoryProvider = Provider<SongsRepository>(
  (ref) => FirebaseSongsRepository(),
);
