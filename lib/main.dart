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
      home: MyHomePage(),
    );
  }
}

//リスト一覧画面
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todoList = [];
  List<bool> isChecked = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDoリスト"),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            onDismissed: (direction) {
              setState(() {
                todoList.removeAt(index);
                isChecked.removeAt(index);
              });
            },
            key: UniqueKey(),
            child: Card(
                child: CheckboxListTile(
              title: Text(todoList[index]),
              value: isChecked[index],
              onChanged: (value) {
                setState(() {
                  isChecked[index] = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //画面遷移
          final newTodoTitle = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) {
            //遷移先を指定
            return ToDoListAddPage();
          }));
          if (newTodoTitle != null) {
            setState(() {
              //リスト追加
              todoList.add(newTodoTitle);
              isChecked.add(false);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

//リスト追加画面
class ToDoListAddPage extends StatefulWidget {
  @override
  State<ToDoListAddPage> createState() => _ToDoListAddPageState();
}

class _ToDoListAddPageState extends State<ToDoListAddPage> {
  String todoTitle = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("リスト追加"),
      ),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          children: [
            TextField(
              //入力されたテキストの値を受け取る
              onChanged: (value) {
                setState(() {
                  todoTitle = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                //前の画面に戻る
                Navigator.of(context).pop(todoTitle);
              },
              child: Text("追加"),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
