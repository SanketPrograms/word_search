import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_grid/Constants/constants.dart';

class CrossWords extends StatefulWidget {
  const CrossWords({Key? key}) : super(key: key);

  @override
  _CrossWordsState createState() => _CrossWordsState();
}

class _CrossWordsState extends State<CrossWords> {
  List<String>? userInputs = [];
  List<String>? findWord = [];
  List<String> singleWord = [];

  List<Color> BoxColor = [];
  TextEditingController inputController = new TextEditingController();
  TextEditingController findController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Word Play",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    userInputs!.clear();
                    inputController.clear();
                    findController.clear();
                  });
                },
                icon: Icon(Icons.delete_outline))
          ],
        ),
        body: ListView(
          //  mainAxisSize: MainAxisSize.min,

          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    // height: size.width,
                    height: size.width - padding * 2,
                    color: Colors.white30,
                    padding: EdgeInsets.all(padding),
                    margin: EdgeInsets.all(padding),
                    child: userInputs.toString() == "[]"
                        ? Image.asset("assets/images/crossword.jpg")
                        : dynamicGridView()),
              ),
            ),
            Card(
              elevation: elevation,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: inputController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Alphabets',
                            labelStyle: GoogleFonts.poppins()),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:  EdgeInsets.all(paddingAll),
                        child: MaterialButton(
                          height: 40,
                          onPressed: () {
                            setState(() {
                              if (inputController.text.isEmpty) {
                              } else {
                                userInputs?.add(inputController.text);
                                inputController.clear();
                              }
                            });
                          },
                          child: const Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          color: Colors.cyan,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: elevation,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: findController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Find Word',
                            labelStyle: GoogleFonts.poppins()),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          height: 40,
                          onPressed: () {

                            findWord!.add(findController.text);



                            // getSearchedWord();
                            setState(() {

                            });
                            dynamicGridView();
                          },
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          color: Colors.cyan,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dynamicGridView() {
    var findList;

    singleWord = findController.text.trim().split("");


    // print("this is findword $findWord");
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: padding,
            mainAxisSpacing: padding,
            childAspectRatio: 1),
        itemCount: userInputs!.length,
        shrinkWrap: true,
        //  physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          //   String char = listChars!.value.expand((e) => e).toList()[index];
          singleWord.forEach((element) {
            print(element);
          });
          //List of elements

          return Card(
            elevation: elevation,
            child: Container(
              decoration: BoxDecoration(
                  color: userInputs![index] == findController.text
                      ? Colors.yellow
                      : boxColor),
              alignment: Alignment.center,
              child: Text(userInputs![index].toUpperCase(),
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor)),
            ),
          );
        },
      );
    });
  }

// getSearchedWord() {
// //  final List<String> wl = ['sanket', 'hello'];
//
//   // Create the puzzle sessting object
//   final WSSettings ws = WSSettings(
//     width: 10,
//     height: 10,
//     orientations: List.from([
//       WSOrientation.horizontal,
//       WSOrientation.vertical,
//       WSOrientation.diagonal,
//     ]),
//   );
//
//   // Create new instance of the WordSearch class
//   final WordSearch? wordSearch = WordSearch();
//
//   // Create a new puzzle
//   final WSNewPuzzle newPuzzle = wordSearch!.newPuzzle(userInputs, ws);
//
//   /// Check if there are errors generated while creating the puzzle
//   if (newPuzzle.errors.isEmpty) {
//     // The puzzle output
//     print('Puzzle 2D List');
//     print(newPuzzle.toString());
//
//     // Solve puzzle for given word list
//     final WSSolved solved =
//     wordSearch.solvePuzzle(newPuzzle.puzzle,findWord);
//
//     print('Found Words!');
//     solved.found.forEach((element) {
//       print('word: ${element.word}, orientation: ${element.orientation}');
//       print('m:${element.x}, n:${element.y}');
//     });
//
//     print('Not found Words!');
//     solved.notFound.forEach((element) {
//       print('word: ${element}');
//     });
//   } else {
//
//     newPuzzle.errors.forEach((error) {
//       print(error);
//     });
//   }
// }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }
}
