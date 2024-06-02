import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordController = TextEditingController();
  final String _correctPassword = 'p123';

  void _verifyPassword() {
    if (_passwordController.text == _correctPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          'Login successful!',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        )),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          'Invalid password , Try again !!',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            color: Colors.black.withOpacity(0.4),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 200, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
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
                  height: 5,
                ),
                Text(
                  'Welcome to Cyprus Dictionary',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    labelText: 'Enter the Password',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _verifyPassword,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
