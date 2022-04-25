import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/item.dart';
import 'dart:convert';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  List<Item> items = [];
  TextEditingController controlador = TextEditingController();

  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void add()
  {
    if (widget.controlador.text.isEmpty) return;
    setState(() {
      widget.items.add(Item(title: widget.controlador.text, done: false));
      widget.controlador.text = "";
      save();
    });
  }

  void remove(int index)
  {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  Future load() async
  {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null){
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((e) => Item.fromJson(e)).toList();
      setState(() {
        widget.items = result;
      });
      
    }

  }

  save() async
  {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }

  _HomePageState()
  {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: widget.controlador,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
          decoration: InputDecoration(
              labelText: "Nova Tarefa",
              labelStyle: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
      body: 
      ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctx, int index) {
          final item = widget.items[index];
          return Dismissible(
            key: Key(item.title!),
            onDismissed: (direction) {remove(index);},
            background: Container(
              color: Colors.red.withOpacity(0.2),
              
            ),
            child: CheckboxListTile(
            title: Text(item.title!),
            value: item.done,
            onChanged: (value) {
              setState(
                () {
                  item.done = value;
                  save();
                },
              );
            },
          ),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
      ),
    );
    
  }
}
