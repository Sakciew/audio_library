import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentTitle;
  String? _currentFile;
  bool _isPlaying = false;

  String? get currentTitle => _currentTitle;
  bool get isPlaying => _isPlaying;

  AudioProvider() {
    // Player holatini kuzatib borish
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
      notifyListeners();
    });
  }

  void playPause(String title, String file) async {
    if (_currentFile == file && _isPlaying) {
      await _audioPlayer.pause();
    } else if (_currentFile == file && !_isPlaying) {
      await _audioPlayer.resume();
    } else {
      await _audioPlayer.stop();
      _currentTitle = title;
      _currentFile = file;
      await _audioPlayer.play(AssetSource("audios/$file"));
    }
    notifyListeners();
  }

  void stop() async {
    await _audioPlayer.stop();
    _currentTitle = null;
    _currentFile = null;
    _isPlaying = false;
    notifyListeners();
  }
}