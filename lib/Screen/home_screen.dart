import 'package:books_app/Screen/book_detail.dart';
import 'package:books_app/Screen/cart_screen.dart';
import 'package:books_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// class HomeScreen extends StatefulWidget {
//   final VoidCallback
//       toggleTheme; // כששולחים בפרופס פונקציות שעשינו במיין אנחנו מכריזים עליהם בדפים האחרים שאנחנו משתמשים בהם.
//   final bool isDarkMode;
//   HomeScreen({required this.toggleTheme, required this.isDarkMode});

//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Book> displayBooks = books;
//   TextEditingController searchController = TextEditingController();

//   void _filterBooks(String query) {
//     setState(() {
//       displayBooks = books.where((book) {
//         return book.title.toLowerCase().contains(query.toLowerCase()) ||
//             book.author.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Book App"),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
//             onPressed: widget.toggleTheme,
//           )
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(8),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: searchController,
//                 onChanged: _filterBooks,
//                 decoration: InputDecoration(
//                   hintText: "Search Books..",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   prefixIcon: Icon(Icons.search),
//                 ),
//               ),
//               SizedBox(height: 20),
//               _buildSectionTitle("Books Collection", widget.isDarkMode),
//               buildBooksSlider(displayBooks),
//               _buildSectionTitle("More Books", widget.isDarkMode),
//               buildBookList(displayBooks),
//               // Add more widgets here as needed
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _buildSectionTitle(String title, bool isDarkMode) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontSize: 18,
//         color: isDarkMode ? Colors.white : Colors.black
//       ),
//     );
//   }

//   Widget buildBooksSlider(List<Book> books) {
//     return CarouselSlider.builder(
//       itemCount: books.length,
//       itemBuilder: (context, index, child) {
//         final book = books[index];
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => BookDetailScreen(book: book),
//               ),
//             );
//           },
//           child: Stack(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   image: DecorationImage(
//                     image: AssetImage(book.imageURL),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.black54,
//                     borderRadius: BorderRadius.vertical(
//                       bottom: Radius.circular(20),
//                     ),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   child: Text(
//                     book.title,
//                     textAlign: TextAlign.center,
//                     maxLines: 1,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//         options: CarouselOptions(
//         autoPlay: true,
//         enlargeCenterPage: true,
//         autoPlayInterval: Duration(seconds: 5),
//       ),
//     );
//   }

//   Widget buildBookList(List<Book> books) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       height: 250,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: books.length,
//         itemBuilder: (context, index){
//           final book = books[index];
//           return GestureDetector(
//             onTap: (){
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => BookDetailScreen(book: book),
//                 ),
//               );
//             },
//               child: Stack(
//               children: [
//                 Container(
//                   width: 180,
//                   margin: EdgeInsets.symmetric(horizontal: 10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     image: DecorationImage(
//                       image: AssetImage(book.imageURL),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }





class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  HomeScreen({required this.toggleTheme, required this.isDarkMode});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _isDarkMode;
  List<Book> displayBooks = books;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void _toggleTheme() {
    widget.toggleTheme();
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _filterBooks(String query) {
    setState(() {
      displayBooks = books.where((book) {
        return book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book App"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: _toggleTheme,
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
        
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: searchController,
                onChanged: _filterBooks,
                decoration: InputDecoration(
                  hintText: "Search Books...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 20),
              _buildSectionTitle("Books Collection", _isDarkMode),
              buildBooksSlider(displayBooks),
              _buildSectionTitle("More Books", _isDarkMode),
              buildBookList(displayBooks),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDarkMode) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  Widget buildBooksSlider(List<Book> books) {
    return CarouselSlider.builder(
      itemCount: books.length,
      itemBuilder: (context, index, child) {
        final book = books[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailScreen(book: book),
              ),
            );
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(book.imageURL),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    book.title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayInterval: Duration(seconds: 5),
      ),
    );
  }

  Widget buildBookList(List<Book> books) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailScreen(book: book),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  width: 180,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(book.imageURL),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}