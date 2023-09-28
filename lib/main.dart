import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Stich Week 5'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  
  bool pageFirstLoad = true;
  bool isLoadingItemsFromDatabase = false;

  List<Item> items = [
    Item("Jaden", "Frye", 1, "Spender"),
    Item("McKenna", "Reynolds", 2, "Saver"),
    Item("Kendrick", "Singh", 3, "Spender"),
    Item("Jessie", "Boyer", 4, "Frequent"),
    Item("Denise", "Wood", 5, "Occasional"),
    Item("Edith", "Reed", 6, "Saver"),
    Item("Natalia", "Daniel", 7, "Saver"),
    Item("Griffin", "Crawford", 8, "Saver"),
    Item("Skyler", "Tate", 9, "Occasional"),
    Item("Alan", "Malone", 10, "Frequent")
  ];

  void _handleButtonPress() 
  {
    setState(() {
      pageFirstLoad = false;
      isLoadingItemsFromDatabase = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoadingItemsFromDatabase = false;
      });
    });
  }

  void _resetPage() {
    setState(() {
      pageFirstLoad = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: pageFirstLoad 
          ? ElevatedButton(
              onPressed: _handleButtonPress, 
              child: Text("Load Items"),
            ) 
          : isLoadingItemsFromDatabase 
            ? const Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[
                CircularProgressIndicator(), 
                Text("Please wait")
              ], 
            ) 
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: items.map((items){
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                        Text(items.FirstName, style: TextStyle(fontSize: 20)), 
                        Text(items.LastName, style: TextStyle(fontSize: 20)), 
                        Text("CustomerID: ${items.CustomerID}"), 
                        Text("Type: ${items.Type}"),
                        Divider(),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),    
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _resetPage,
          child: Text("Reset"),
      ),
    );
  }
}

class Item {
  String FirstName;
  String LastName;
  int CustomerID;
  String Type;

  Item(this.FirstName, this.LastName, this.CustomerID, this.Type);
}
