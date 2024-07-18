import 'package:books_app/Screen/home_screen.dart';
import 'package:books_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class IntroScreen extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  IntroScreen({required this.toggleTheme, required this.isDarkMode});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: toggleTheme,
          ),
        ],
      ),
      

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Welcome to the largest bookstore",
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
            ), 
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: books.length,
               itemBuilder: (context, index) {
                  final book = books[index];
                  return GridTile(
                    child: Image.asset(book.imageURL, fit: BoxFit.cover),
                    footer: GridTileBar(
                      backgroundColor: Colors.black54,
                      title: Text(book.title, textAlign: TextAlign.center),
                    ),
                  );

                },
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(toggleTheme: toggleTheme, isDarkMode: isDarkMode),
                  ),
                );
              },
              child: Text("Enter the home page"),
            ),
          ],
        ),
      ),
    );
  }
}