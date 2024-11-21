import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'states/songs_list_state.dart';
import 'notifiers/songs_list_notifier.dart';


final songsListViewModelProvider = 
    NotifierProvider<SongsListNotifier, SongsListState>(SongsListNotifier.new);
