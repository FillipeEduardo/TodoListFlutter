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
    controlador.
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 20
              )
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (BuildContext ctx, int index) {
            final item = widget.items[index];
            return CheckboxListTile(
              title: Text(item.title!),
              key: Key(item.title!),
              value: item.done,
              onChanged: (value) {
                setState(
                  () {
                    item.done = value;
                  },
                );
              },
            );
          },
        ));
  }
}
