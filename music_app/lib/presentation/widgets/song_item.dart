import 'package:flutter/material.dart';
import 'package:music_app/data/models/song.dart';

class SongItem extends StatelessWidget {
  const SongItem({
    super.key,
    required this.song,
    this.onTap,
  });

  final Song song;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(song.title, style: const TextStyle(fontSize: 20)),
      onTap: () => onTap?.call(),
    );
  }
}
