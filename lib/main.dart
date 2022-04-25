import 'package:flutter/material.dart';

import 'Models/item.dart';

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

  HomePage() {
    items.add(Item(title: "Banana", done: false));
    items.add(Item(title: "Abacate", done: true));
    items.add(Item(title: "Laranja", done: false));
  }

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
    });
  }

  void remove(int index)
  {
    setState(() {
      widget.items.removeAt(index);
    });
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
            child: CheckboxListTile(
            title: Text(item.title!),
            value: item.done,
            onChanged: (value) {
              setState(
                () {
                  item.done = value;
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
