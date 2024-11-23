import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/data/providers.dart';
import 'package:music_app/domain/songs_repository.dart';
import 'package:music_app/presentation/utils/base_screen_state.dart';
import 'package:music_app/presentation/viewmodels/states/song_player_state.dart';

class SongPlayerNotifier extends Notifier<SongPlayerState> {
  late final SongsRepository songsRepository =
      ref.read(songsRepositoryProvider);

  @override
  SongPlayerState build() {
    return const SongPlayerState();
  }

  Future<void> fetchSong(int songId) async {
    state = state.copyWith(
      screenState: const BaseScreenState.loading()
    );

    
  }



/*
    Future<void> fetchNote(int noteId) async {
    state = state.copyWith(
      screenState: const BaseScreenState.loading(),
    );

    try {
      final note = await notesRepository.getNoteById(noteId);
      state = state.copyWith(
        screenState: const BaseScreenState.idle(),
        note: note,
      );
    } catch (error) {
      state = state.copyWith(
        screenState: BaseScreenState.error(error.toString()),
      );
    }
  }

  */
}


