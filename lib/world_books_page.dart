import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'audio_provider.dart';

class WorldBooksPage extends StatelessWidget {
  final List<Map<String, String>> books = [
    {"title": "Gulliver sayohati", "file": "audio4.mp3"},
    {"title": "1984", "file": "audio5.mp3"},
    {"title": "Don Kixot", "file": "audio6.mp3"},
  ];

  @override
  Widget build(BuildContext context) {
    // Provider orqali audio holatini kuzatamiz
    final audioProvider = Provider.of<AudioProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        title: Text("Jahon adabiyoti", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFA0522D),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          String title = books[index]["title"]!;
          String file = books[index]["file"]!;
          // Hozirgi kitob aynan shu sahifadagi ushbu qator ekanligini tekshiramiz
          bool isThisPlaying = audioProvider.currentTitle == title && audioProvider.isPlaying;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Color(0xffF7B980),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffED925F),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: Icon(
                        isThisPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onPressed: () => audioProvider.playPause(title, file),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}