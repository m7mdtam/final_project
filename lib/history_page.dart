// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'Db_helper.dart';
import 'home_page.dart';
import 'favorite_page.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> _history = [];
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    final data = await DbHelper.fetchHistory();
    setState(() {
      _history = data;
    });
  }

  Future<void> _deleteHistory(int id) async {
    await DbHelper.deleteHistory(id);
    _fetchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Translation History',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black54,
                offset: Offset(4.0, 4.0),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(239, 48, 82, 141),
        leading: Icon(
          Icons.history,
          color: Colors.white,
        ),
      ),
      body: _history.isEmpty
          ? Center(
              child: Text(
                'No history available.',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final item = _history[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Color.fromARGB(239, 48, 82, 141),
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      '${item['h_english']} - ${item['h_turkish']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteHistory(item['id']),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedLabelStyle:
            TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 14.0),
        backgroundColor: Color.fromARGB(239, 48, 82, 141),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HistoryPage()),
            );
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => FavoritePage()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, color: Colors.white),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star_border,
              color: Colors.white,
            ),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
