#### Flutter Apps Built as a Widget Tree

At the top of the tree, there is `MaterialApp` if you use the Material Theme.
The root widget et is mostly a stateless widget.

```dart
return MaterialApp(
    title: '',
    theme: ThemeData(),
    home: CustomWidget(),
);
```

### clean and rebuild the app

```sh
cd ./android
./gradlew clean build
```

#### example private function which return a widget

```dart
 Widget _loginButton() {
    return SizedBox(...)
 }
```

#### Few Widget Examples

**TextStyle**

```dart
TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.amber,
)
```

**Scaffold**

```dart
return Scaffold(
    appBar: AppBar(centerTitle: true, title: const Text("Login")),
    body: _buildBodyUI(),
);

//Creates a widget that avoids operating system interfaces.
body: SafeArea(child: _buildBodyUI()),
// (Ctrl+Shift+R / rightClick) on the widget -> refactor -> wrap with widget
```

**Column**

```dart
Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [_buildText(), _buildForm(), _loginButton()],
)
```

**Text**

```dart
Text(
    "Recipe Book",
    style: ...,
)
```

**SizedBox**

```dart
SizedBox(
    width: MediaQuery.sizeOf(context).width * 0.9,
    height: MediaQuery.sizeOf(context).height * 0.3,
    child: Form(...),
)
```

**Form**

```dart
Form(
    child: Column(...),
)

//Validations

//on top of the widget add
GlobalKey<FormState> _formKey = GlobalKey();
String? userName, password;

//in the Form widget add
key: _formKey,

//in the text form field add
onSaved: (newValue) {
  setState(() {
    userName = newValue;
  });
},
validator: (value) {
    if (value == null || value.isEmpty) {
        return "Enter a username";
    }
},

//on the submit button add
onPressed: () {
  if (_formKey.currentState?.validate() ?? false) {
    _formKey.currentState?.save()
  }
},
```

**TextFormField**

```dart
TextFormField(
    validator: (value) {
        if (value == null || value.isEmpty) {
            return "Enter a username";
        }
    },
    decoration: const InputDecoration(hintText: "Password"),
)
```

**Take all remaining space**

```dart
Expanded()
```

### Load data from an async(Future function)

```dart
FutureBuilder(
    future: DataService().getRecepies(),
    builder: (context, snapshot) {
        return Container();
})
```

### render data programmatically in a list view

```dart
FutureBuilder(
    future: DataService().getRecepies(), //use initState method instead of this, this runs everytime widget rebuild
    builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Couldn't load the data"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("No data available")));
          }
        return ListView.builder(
            itemCount: snapshot.data!.length ?? 0,
            itemBuilder: (context, index){
                Recipe recipe = snapshot.data![index];
                return ListTile(
                    title: Text(recipe.name),
                );
        });
})
```

### Singleton Design Pattern

```dart
class HTTPService {
  static final HTTPService _singleton = HTTPService._internal();
  //_singleton is a static final field of type HTTPService.
  //It is initialized with a private named constructor HTTPService._internal().
  //Being static ensures that there is only one instance of _singleton in the memory, shared across all instances of the class.

  factory HTTPService() {
    return _singleton; //factory constructor returns the existing _singleton instance
  }

  HTTPService._internal() {
    //_internal is a private named constructor.
    //It is used to initialize the singleton instance.
    //This constructor can only be called within the class itself, preventing external code from creating additional instances.
    // Initialization code here, if any
  }
}
```

### convert json object to dart object

-   goto https://app.quicktype.io/ website and convert
-   Give a name
-   select only `Null safety` and `Generate CopyWith method`
-   copy the code and paste in your model class

### Sample http base class

```dart
import 'package:dio/dio.dart';

class HttpService {
  static final HttpService _singleton = HttpService._internal();

  final _dio = Dio(); //install dio package, use pubspec.yaml

  final BASE_URL = 'https://dummyjson.com/';

  factory HttpService() {
    return _singleton;
  }

  HttpService._internal() {
    setupBaseRequest();
  }

  Future<void> setupBaseRequest({String? bearerToken = ""}) async {
    final headers = {'Content-Type': 'application/json'};

    if (bearerToken != null) {
      headers['Authorization'] = "Bearer $bearerToken";
    }

    final options = BaseOptions(
      baseUrl: BASE_URL,
      headers: headers,
      validateStatus: (status) {
        if (status == null) return false;
        return status < 500;
      },
    );
    _dio.options = options;
  }

  Future<Response?> get(path) async {
    try {
      final response = _dio.get(path);
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Response?> post(String path, Map data) async {
    try {
      final response = _dio.post(path, data: data);
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
```

### map response data into your model

```dart
//This is a separate class to deal with http_service class
//initialize _httpService property on top of the class
Future<List<Recipe>?> getProducts() async {
    try {
      final response = await _httpService.get("/recipes");

      if (response!.statusCode == 200 && response!.data != null) {
        List data = response!.data["recipes"];

        List<Recipe> products =
            data.map((toElement) => Recipe.fromJson(toElement)).toList();

        return products;
      } else {
        print("Response is null or status code is not 200");
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
```

#### pass data to a screen via Navigator

```dart
onTap: () {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              RecipePage(recipe: product)));
},

//on sub page
//add required this.recipe
const RecipePage({super.key, required this.recipe});
final Recipe recipe;
```

#### design with flex

```dart
child: Column(
  children: [
    Expanded(flex: 1, child: Container()),
    Expanded(flex: 7, child: Container()),
  ],
),
```

### Work with database(sqlite)

#### Initialize Singleton DB connection

```dart
//db.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

class DatabaseHelper {
  static final DatabaseHelper _singleton = DatabaseHelper._internal();

  static Database? _database;

  factory DatabaseHelper() {
    return _singleton;
  }

  DatabaseHelper._internal();

  //getter for database property
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<Database> _initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    final database = openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );

    return database;
  }
}
```

#### use database connection from a model

```dart
//todo.dart
import 'package:demo_app/database/db.dart';
import 'package:sqflite/sqflite.dart';

class Todo {
  final int id;
  final String title;
  final String description;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, Object> toMap() {
    return {'id': id, 'title': title, 'description': description};
  }

  @override
  String toString() {
    return 'Todo{id: $id, title: $title, description: $description}';
  }

//method should be static in order to access from other classes like ToDo.insert
  static Future<void> insert(Todo todo) async {
    final db = await DatabaseHelper().database;

    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
```

#### db interactions from widgets

```dart
void _insertInitialTodo() async {
    var todo = const Todo(
      id: 21,
      title: "title 1",
      description: "description",
    );
    await Todo.insert(todo);
  }

  Future<List<Todo>> _getAllTodos() async {
    return await Todo.getAllTodos();
  }
```
