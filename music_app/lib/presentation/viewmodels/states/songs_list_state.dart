import 'package:equatable/equatable.dart';
import 'package:music_app/presentation/utils/base_screen_state.dart';
import '../../../domain/song.dart';

class SongsListState extends Equatable{
  final BaseScreenState screenState;
  final List<Song> songs;

  const SongsListState({
    this.screenState = const BaseScreenState.idle(),
    this.songs = const[]
  });

  SongsListState copyWith({
    BaseScreenState? screenState,
    List<Song>? songs,
  }){
    return SongsListState(
      screenState: screenState ?? this.screenState,
      songs: songs ?? this.songs,
    );
  }

  @override
  List<Object?> get props => throw [songs];
}