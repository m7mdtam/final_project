// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_declarations
import 'package:final_project/login_page.dart';
import 'package:flutter/material.dart';
import 'package:final_project/Db_helper.dart';
import 'package:flutter/services.dart';
import 'history_page.dart';
import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  String? _translatedWord;
  int _currentIndex = 0;
  bool _isFavorite = false;

  void _translateWord() async {
    final englishWord = _controller.text.trim();
    if (englishWord.isNotEmpty) {
      final result = await DbHelper.getTranslation(englishWord);
      setState(() {
        if (result != null) {
          _translatedWord = result['turkish'];
          DbHelper.insertHistory(englishWord, _translatedWord!);
        } else {
          _translatedWord = 'Translation not found';
        }
      });
    }
  }

  void _addToFavorites(String english, String turkish) async {
    await DbHelper.insertFavorite(english, _translatedWord!);
  }

  void _copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Text copied to clipboard')),
    );
  }

  void _showAddWordDialog() {
    final TextEditingController englishController = TextEditingController();
    final TextEditingController turkishController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Color.fromARGB(239, 48, 82, 141),
              width: 2,
            ),
          ),
          title: Text(
            'Add New Word',
            style: TextStyle(
              color: Color.fromARGB(239, 48, 82, 141),
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.grey,
                  offset: Offset(3.0, 3.0),
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: englishController,
                decoration: InputDecoration(
                  labelText: 'English',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(239, 48, 82, 141),
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: turkishController,
                decoration: InputDecoration(
                  labelText: 'Turkish',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color.fromARGB(239, 48, 82, 141),
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(239, 48, 82, 141),
                shadowColor: Colors.black,
                foregroundColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                final english = englishController.text.trim();
                final turkish = turkishController.text.trim();
                if (english.isNotEmpty && turkish.isNotEmpty) {
                  await DbHelper.insertWord(english, turkish);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                      'Word added successfully',
                      style: TextStyle(color: Colors.green),
                    )),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                      'Both fields are required',
                      style: TextStyle(color: Colors.red),
                    )),
                  );
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Color.fromARGB(239, 48, 82, 141),
        title: Text(
          'Cyprus Dictionary',
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
              size: 35,
            ),
            onPressed: _showAddWordDialog,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(239, 48, 82, 141),
              ),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('lib/images/hello.jpeg'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hello Guest ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(239, 48, 82, 141),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: Color.fromARGB(239, 48, 82, 141), width: 2),
              ),
              child: ListTile(
                leading: Icon(Icons.contact_mail,
                    color: Color.fromARGB(239, 48, 82, 141)),
                title: Text(
                  'Contact Us',
                  style: TextStyle(
                      color: Color.fromARGB(239, 48, 82, 141),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Contact Information',
                          style: TextStyle(
                              color: Color.fromARGB(239, 48, 82, 141),
                              fontWeight: FontWeight.bold),
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Name: Mohammed Altamimi',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Email: mohammedtamimi72@gmail.com',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Phone: 05338303401',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Name: Yazeed Nasasreh',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Email: yazeednasasreh@gmail.com',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Phone: 05338303401',
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(239, 48, 82, 141),
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text(
                  'Log Out',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/loginbk.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),

                  // ignore: sized_box_for_whitespace
                  child: Container(
                      height: 120,
                      width: 120,
                      child: Image(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            "lib/images/icon1.jpeg",
                          ))),
                ),
                SizedBox(
                  height: 35,
                ),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter English word',
                    hintStyle:
                        TextStyle(color: Colors.blueGrey), // Hint text color
                    filled: true,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    prefixIcon: Icon(Icons.translate,
                        color: Colors.blue), // Prefix icon
                  ),
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                  cursorColor: Colors.white,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _translateWord,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Color.fromARGB(239, 48, 82, 141), // Text color
                    shadowColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Text('Translate'),
                ),
                SizedBox(height: 13),
                if (_translatedWord != null)
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      padding: EdgeInsets.all(9.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 10.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _translatedWord!,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.copy,
                              color: Colors.white,
                            ),
                            onPressed: () => _copyText(_translatedWord!),
                            tooltip: 'Copied',
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.star,
                              color: _isFavorite ? Colors.yellow : Colors.white,
                            ),
                            onPressed: () {
                              final englishWord = _controller.text.trim();

                              // Check if _translatedWord is not null before adding to favorites
                              if (_translatedWord != null) {
                                // Insert the word into the favorite table
                                _addToFavorites(englishWord, _translatedWord!);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Added to favorites'),
                                  ),
                                );
                                setState(() {
                                  _isFavorite = true;
                                  // Update the state to indicate the word is added to favorites
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Translate a word first'),
                                  ),
                                );
                              }
                            },
                            tooltip: 'Add to Favorites',
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
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
          });
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
