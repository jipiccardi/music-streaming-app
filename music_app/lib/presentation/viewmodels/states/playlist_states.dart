import 'package:music_app/data/models/playlist.dart';
import 'package:music_app/presentation/utils/base_screen_state.dart';

class PlaylistState {
  final BaseScreenState screenState;
  final List<Playlist> playlists;

  const PlaylistState({
    this.screenState = const BaseScreenState.idle(),
    this.playlists = const [],
  });

  PlaylistState copyWith({
    BaseScreenState? screenState,
    List<Playlist>? playlists,
  }) {
    return PlaylistState(
      screenState: screenState ?? this.screenState,
      playlists: playlists ?? this.playlists,
    );
  }
}