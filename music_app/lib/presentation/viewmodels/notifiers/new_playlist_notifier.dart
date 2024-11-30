import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/data/repositories/providers.dart';
import 'package:music_app/data/repositories/songs_repository.dart';
import 'package:music_app/presentation/utils/base_screen_state.dart';
import 'package:music_app/presentation/viewmodels/states/new_playlist_state.dart';

class NewPlaylistNotifier extends AutoDisposeFamilyNotifier<NewPlaylistState, String> {
  late final SongsRepository songsRepository =
      ref.read(songsRepositoryProvider);

  @override
  NewPlaylistState build(String arg) {
    return const NewPlaylistState();
  }

  Future<void> setAvailableSongs() async{
    state = state.copyWith(screenState: const BaseScreenState.loading());

    try {
      final songs = await songsRepository.getAllSongs();
      state = state.copyWith(
          screenState: const BaseScreenState.idle(), songs: songs);
    } catch (error) {
      state = state.copyWith(
        screenState: BaseScreenState.error(error.toString()),
      );
    }
  }
}