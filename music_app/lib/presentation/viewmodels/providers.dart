import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/presentation/viewmodels/notifiers/song_player_notifier.dart';
import 'package:music_app/presentation/viewmodels/states/song_player_state.dart';

import 'states/songs_list_state.dart';
import 'notifiers/songs_list_notifier.dart';

final songsListViewModelProvider =
    NotifierProvider<SongsListNotifier, SongsListState>(SongsListNotifier.new);

final songPlayerViewModelProvider = AutoDisposeNotifierProviderFamily<
    SongPlayerNotifier, SongPlayerState, String>(SongPlayerNotifier.new);
