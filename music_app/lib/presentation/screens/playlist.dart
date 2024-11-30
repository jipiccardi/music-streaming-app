import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaylistScreen extends ConsumerStatefulWidget {
  static const name = 'PlaylistScreen';

  const PlaylistScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends ConsumerState<PlaylistScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //TODO
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist'),
      ),
      body: const Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Playlist'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Playlist extends StatelessWidget {
  const _Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Playlist'),
    );
  }
}

