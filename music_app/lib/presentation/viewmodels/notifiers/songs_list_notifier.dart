import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/domain/songs_repository.dart';
import 'package:music_app/presentation/utils/base_screen_state.dart';
import 'package:music_app/presentation/viewmodels/states/songs_list_state.dart';
import '../../../data/providers.dart';

class SongsListNotifier extends Notifier<SongsListState> {
  late final SongsRepository songsRepository =
      ref.read(songsRepositoryProvider);

  @override
  SongsListState build() {
    return const SongsListState();
  }

  Future<void> fetchSongs() async {
    state = state.copyWith(
      screenState: const BaseScreenState.loading(),
    );

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
