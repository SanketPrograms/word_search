import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_grid/Constants/constants.dart';

class word_search extends StatefulWidget {
  word_search({Key? key}) : super(key: key);

  @override
  State<word_search> createState() => _word_searchState();
}

class _word_searchState extends State<word_search> {
  TextEditingController controllerRow = TextEditingController();
  TextEditingController inputController = TextEditingController();
  TextEditingController ControllerColumn = TextEditingController();
  TextEditingController  searchwordController = TextEditingController();
  int j = -1;
  int i = 0;
  bool hideM = true;
  bool hideN = false;
  bool  hideSearchWord = false;
  int rowCount = 1;
  bool hideInputCController = false;
  String rowText = "";
  String ColumnText = "";

  // List<List<String>> gridState = [['','']];
  List<List<String>> gridState = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // /  print(gridState[0][0].toString()); /////take in this way for loop
    // /  print(gridState[0][0].toString() == controller.text); /////take in this way for loop

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => word_search()),
                      (route) => false);
                });
              },
              icon: Icon(Icons.refresh))
        ],
        title: Text(
          'Game World',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      ),
      body: _buildGameBody(),
    );
  }

  Widget _buildGameBody() {
    int gridStateLength = gridState.length;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          Visibility(
            visible: hideM,
            child: Card(
              elevation: elevation,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: controllerRow,

                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ], // Only numbers can be entered
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Value of N (Row)',
                            labelStyle: GoogleFonts.poppins(fontSize: 11)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          height: 40,
                          onPressed: () {

                            rowText = controllerRow.text.toString();
                            //     hideMN = false;
                            // gridState = controllerMRow.text;
                            setState(() {
                              int i = 0;
                              gridState = List.generate(
                                  int.parse(controllerRow.text),
                                  (i) => List.filled(
                                      int.parse(controllerRow.text), "",
                                      growable: false),
                                  growable: false);
                              gridState[i][i] = "";
                              print(gridState);
                              print(gridState.length.toString());
                              hideM = false;
                              hideN = true;
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
          ),
          Visibility(
            visible: hideN,
            child: Card(
              elevation: elevation,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: ControllerColumn,

                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ], // Only numbers can be entered
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Value of M (Column)',
                            labelStyle: GoogleFonts.poppins(fontSize: 11)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          height: 40,
                          onPressed: () {
                            //     hideMN = false;
                            // gridState = controllerMRow.text;

                            setState(() {
                              searchwordController.text = "Word";
                              ColumnText = ControllerColumn.text.toString();
                              hideInputCController = true;
                              rowCount = int.parse(ControllerColumn.text);
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
          ),
          Visibility(
            visible: hideInputCController,
            child: Card(
              elevation: elevation,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: inputController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Alphabets',
                            labelStyle: GoogleFonts.poppins(fontSize: 11)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(paddingAll),
                        child: MaterialButton(
                          height: 40,
                          onPressed: () {
                            setState(() {

                              print(searchwordController.text);
                             if(inputController.text.isNotEmpty) {
                               if (j < gridState.length) {
                                 j++;
                               }
                               else {
                                 j = 0;
                                 i++;
                               }


                               // for( i; i < gridState.length; i++){
                               //
                               //   for(j; j ==i; j++){
                               //    // gridState[0][1]
                               //     print(j);
                               gridState[i][j] = inputController.text;

                               inputController.clear();
                               //    // gridState[j][i];
                               //   }
                               // }
                               hideN = false;
                               hideSearchWord = true;
                             }
                             else{
                               print("empty");
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
          ),
          Visibility(
            visible: hideSearchWord,
            child: Card(
              elevation: elevation,
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextField(
                        controller: searchwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Search Word',
                            labelStyle: GoogleFonts.poppins(fontSize: 11)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(paddingAll),
                        child: MaterialButton(
                          height: 40,
                          onPressed: () {
                         setState(() {

                         });
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
          ),

          ControllerColumn.text.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Enter Value of Column n Row",
                    style: GoogleFonts.poppins(),
                  ),
                )
              : Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Container(
                                width: double.infinity,

                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black, width: 2.0)),
                                child: GridView.builder(
                                shrinkWrap: true,
                                 physics: NeverScrollableScrollPhysics(),

                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        rowCount, //count of mainaxis and crossAxis
                                  ),
                                  itemBuilder: _buildGridItems,
                                  itemCount: rowCount * gridState.length, // m * n
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Row(M): $rowText",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,fontSize: 16
                      ),),
                      Text("Column(N): $ColumnText",style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,fontSize: 16
                      ),),
                    ],
                  ),
                ],
              ),
        ]),
      ),
    );
  }

  Widget _buildGridItems(BuildContext context, int index) {


    print("this is ${searchwordController.text.trim().split("")}");
    int gridStateLength = gridState.length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);


    return GestureDetector(
      //    onTap: () => _gridItemTapped(x, y),
      child: GridTile(
        child: Column(
          children: [

                Expanded(
                  child: Card(
                    elevation: 20,
                    child: Container(

                      width: double.infinity,

                      decoration: BoxDecoration(
                        color:gridState[x][y].contains(searchwordController.text.toString())||searchwordController.text.isEmpty?Colors.yellowAccent.shade100: Colors.white,
                          border: Border.all(width: 0.5)),
          child: Center(
                            child: _buildGridItem(x, y),
                          ),
                    ),
                  )
                ),
              ],
            ),

   //     ),
      ),
    );
  }

  Widget _buildGridItem(int x, int y) {



    print(y);
    switch (gridState[x][y]) {
      case '':
        return Text('');
        break;
      default:
        return

          Text(gridState[x][y].toString().toUpperCase(),style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,fontSize: 16
        ),);
    }

  }

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
