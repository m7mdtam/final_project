// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'history_page.dart';
import 'Db_helper.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int _currentIndex = 2;
  List<Map<String, dynamic>> _favorites = [];

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    final favorites = await DbHelper.fetchFavorites();
    setState(() {
      _favorites = favorites;
    });
  }

  Future<void> _removeFromFavorites(int id) async {
    await DbHelper.deleteFavorite(id);
    _fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Translations',
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
        leading: Icon(Icons.star,
            color: const Color.fromARGB(
                255, 249, 225, 8)), // Set the leading icon to a star
      ),
      body: _favorites.isEmpty
          ? Center(
              child: Text(
                'No favorite translations available.',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final favorite = _favorites[index];
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
                      '${favorite['f_english']} - ${favorite['f_turkish']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeFromFavorites(favorite['id']),
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
