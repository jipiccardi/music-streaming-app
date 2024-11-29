import 'package:music_app/domain/song.dart';
import 'package:music_app/presentation/utils/base_screen_state.dart';

class SongPlayerState {
  final BaseScreenState screenState;
  final Song? song;

  const SongPlayerState({
    this.screenState = const BaseScreenState.idle(),
    this.song,
  });

  SongPlayerState copyWith({
    BaseScreenState? screenState,
    Song? song,
    bool? isPlaying,
  }) {
    return SongPlayerState(
      screenState: screenState ?? this.screenState,
      song: song ?? this.song,
    );
  }
}
