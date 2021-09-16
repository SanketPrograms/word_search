// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:word_search/word_search.dart';
//
// class CrossWordWidget extends StatefulWidget {
//   const CrossWordWidget({Key? key}) : super(key: key);
//
//   @override
//   _CrossWordWidgetState createState() => _CrossWordWidgetState();
// }
//
// class _CrossWordWidgetState extends State<CrossWordWidget> {
//   int numBoxperRow = 6;
//
//   double padding = 5;
//
//   ValueNotifier<List<List<String>>>? listChars;
//   ValueNotifier<List<CrossWordAnswers>>? answerList;
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     listChars =  ValueNotifier<List<List<String>>>([]);
//     answerList =   ValueNotifier<List<CrossWordAnswers>>([]) ;
//
//
//     genrateRandomWords();
//
//
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(title: Text("Word Play",style:GoogleFonts.poppins(fontWeight: FontWeight.bold)),),
//       body: Container(
//
//
//         child: Column(children: [
//           Expanded(
//
//             child: Row(
//               children: [
//                 Expanded(
//
//                   child: Padding(
//                     padding:  EdgeInsets.all(padding),
//                     child: const TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Enter Alphabets',
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: MaterialButton(height: 40,onPressed: (){},child: Icon(Icons.save,color: Colors.white,),color: Colors.cyan,),
//                 )
//               ],
//             ),
//           ),
//
//           Container( alignment: Alignment.center,
//               width: double.infinity,
//               // height: size.width,
//               height: size.width - padding * 2,
//               color: Colors.black45,
//               padding:  EdgeInsets.all(padding),
//               margin:  EdgeInsets.all(padding),
//               child: drawCrosswordBox()),
//             // Container(
//             //   alignment:Alignment.center,
//             //     child:drawAnswerList()
//             // ),
//
//
//           Expanded(
//             child: Row(
//               children: [
//                 Expanded(
//
//                   child: Padding(
//                     padding:  EdgeInsets.all(padding),
//                     child: const TextField(
//
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Find Word',
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: MaterialButton(height: 40,onPressed: (){},child: Icon(Icons.search,color: Colors.white,),color: Colors.cyan,),
//                 )
//               ],
//             ),
//           ),
//         ],),
//       ),
//
//
//     );
//   }
//
//   Widget drawCrosswordBox(){
//
//     return LayoutBuilder(
//       builder:(context , constraints){
//         return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: numBoxperRow,
//             crossAxisSpacing: padding,
//             mainAxisSpacing: padding,
//
//             childAspectRatio:1 ),
//         itemCount: numBoxperRow * numBoxperRow,
//       shrinkWrap: true,
//       //  physics: ScrollPhysics(),
//         itemBuilder: (context , index){
//
//           String char = listChars!.value.expand((e) => e).toList()[index];
//
//
//           print(char);
//
//
//
//           //List of elements
//
//           return Container(
//             decoration: BoxDecoration(
//               color:  char == "w"?Colors.yellowAccent:Colors.white
//             ),
//          alignment: Alignment.center,
//             child: Text(char.toUpperCase(),style:GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold)),
//           );
//
//         },
//
//         );
//
//
//       }
//
//     );
//
//   }
//
//   void genrateRandomWords() {
//
//     //used for inputs of alphabet or word
//     final List<String> wordsInput = ["s"];
//
//     final  WSSettings ws  = WSSettings(
//
//       width:numBoxperRow,
//       height:numBoxperRow,
//
//       orientations: List.from([
//         WSOrientation.horizontal,
//         WSOrientation.horizontalBack,
//         WSOrientation.vertical,
//         WSOrientation.verticalUp,
//         WSOrientation.diagonal,
//         WSOrientation.diagonalUp,
//
//       ])
//
//     );
//
//     final WordSearch wordSearch = WordSearch();
//
//
//     //Created new puzzle
//     final WSNewPuzzle newPuzzle = wordSearch.newPuzzle(wordsInput, ws);
//
//
//     //check for empty and errors
//
//     if(newPuzzle.errors.isEmpty){
//
//      // ValueNotifier<List<String>> charsArray = newPuzzle.puzzle;
//
//    //   print("char is ${charsArray.toString()}");
//
//       listChars?.value = newPuzzle.puzzle;
//        final WSSolved solved = wordSearch.solvePuzzle(newPuzzle.puzzle, wordsInput);
//
//       answerList!.value = solved.found.map((solve) => new CrossWordAnswers(solve, numPerRow: numBoxperRow)).toList();
//     }
//   }
//   // drawAnswerList(){
//   //   return Container(
//   //     child:ValueListenableBuilder(
//   //       builder: (context,List<CrossWordAnswers> value , child){
//   //
//   //         int perColTotal = 3;
//   //
//   //         List<Widget> list = List.generate(((value.length ~/ perColTotal) + (value.length % perColTotal) > 0?1:0),(int index)
//   //         {
//   //           int maxColumn = (index + 1) * perColTotal;
//   //           return Container(
//   //             margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
//   //             child: Row(
//   //               crossAxisAlignment: CrossAxisAlignment.center,
//   //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //               children: List.generate(maxColumn > value.length ? maxColumn - value.length : perColTotal, (indexChild) {
//   //
//   //                 int indexArray = (index) * perColTotal + indexChild;
//   //
//   //                 return Text(value[indexArray].wsLocation!.word.toUpperCase(),style: GoogleFonts.poppins(
//   //                 fontSize: 14,fontWeight: FontWeight.bold,
//   //                   color: value[indexArray].done ? Colors.green : Colors.black,
//   //                   decoration: value[indexArray].done ? TextDecoration.lineThrough:TextDecoration.none
//   //               ));}),
//   //             ),
//   //           );
//   //         });
//   //
//   //
//   //
//   //         // List<Widget> list = List.generate(answerList!.value.length, (index) => Row(
//   //         //   children: [
//   //         //
//   //         //   ],
//   //         // ));
//   //
//   //         return Container(
//   //           child: Column(
//   //             children:list,
//   //           ),
//   //         );
//   //       },
//   //       valueListenable: answerList!
//   //     )
//   //   );
//   // }
// }
//
// class CrossWordAnswers {
//
//   bool done = false;
//   int? indexArray;
//   WSLocation? wsLocation;
//   List<int>? answerLines;
//
//   CrossWordAnswers(this.wsLocation, {int? numPerRow}){
//     this.indexArray = this.wsLocation!.y  * numPerRow! + this.wsLocation!.x;
//     genrateAnswerLine(numPerRow);
//   }
//
//   void genrateAnswerLine(int numPerRow) {
//     this.answerLines = <int>[];
//
//     this.answerLines!.addAll(List<int>.generate(this.wsLocation!.overlap,(index)=>generateIndexBaseOnAxis(this.wsLocation, index , numPerRow)));
//   }
//
//   generateIndexBaseOnAxis(WSLocation? wsLocation, int i, int numPerRow) {
//     int x = wsLocation!.x , y = wsLocation.y;
//
//
//     if(wsLocation.orientation == WSOrientation.horizontal || wsLocation.orientation == WSOrientation.horizontalBack) {
//       x = (wsLocation.orientation == WSOrientation.horizontal) ? x + i : x - i;
//     } else {
//       y = (wsLocation.orientation == WSOrientation.vertical) ? y + i : x - i;
//     }
//
//     return x + y * numPerRow;
//
//   }
// }
