import 'package:flutter/material.dart';
import 'package:final_project/Db_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String? _translatedWord;
  String? _imagePath;

  void _translateWord() async {
    final englishWord = _controller.text.trim();
    if (englishWord.isNotEmpty) {
      final result = await DbHelper.getTranslation(englishWord);
      setState(() {
        if (result != null) {
          _translatedWord = result['turkish'];
          _imagePath = result['image'];
        } else {
          _translatedWord = 'Translation not found';
          _imagePath = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English to Turkish Translator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter English word',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _translateWord,
              child: Text('Translate'),
            ),
            SizedBox(height: 20),
            if (_translatedWord != null)
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      _translatedWord!,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_imagePath != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        _imagePath!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}