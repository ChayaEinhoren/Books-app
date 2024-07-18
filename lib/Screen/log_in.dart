import 'package:books_app/Model/model.dart';
import 'package:books_app/Screen/intro_screen.dart';
import 'package:books_app/Screen/register.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;
  LoginScreen({required this.isDarkMode, required this.toggleTheme});
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userNameController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => IntroScreen(
          isDarkMode: widget.isDarkMode,
          toggleTheme: widget.toggleTheme,
        ), 
      ) 
     );
    }
    catch (e) {
      print("Registration failed: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed')),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBookCarousel(),
                SizedBox(height: 20),
                _buildTextField(userNameController, 'User Name'),
                SizedBox(height: 10),
                _buildTextField(passwordController, 'Password',
                    obsucureText: true),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(
                          isDarkMode: widget.isDarkMode,
                          toggelTheme: widget.toggleTheme,
                        ),
                      ),
                    );
                  },
                  child: Text('Dont have an account? Register'),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {bool obsucureText = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      obscureText: obsucureText,
    );
  }

  Widget _buildBookCarousel() {
    return CarouselSlider.builder(
      itemCount: books.length,
      itemBuilder: (context, index, child) {
        final book = books[index];
        return _buildBookItem(book);
      },
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2,
        autoPlayInterval: Duration(seconds: 3),
      ),
    );
  }

  Widget _buildBookItem(Book book) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(book.imageURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
