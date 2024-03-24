import 'dart:convert';

import 'package:apicalls/apiprovider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> postdata() async {
    const apiposturl = 'https://jsonplaceholder.typicode.com/posts';

    final res = await http.post(
      Uri.parse(apiposturl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "name": "morpheus",
        "job": "leader",
      }),
    );
    if (res.statusCode == 200) {
      final response = jsonDecode(res.body);
      print(response);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApiProvider>(context, listen: false).getdata();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<ApiProvider>(
          builder: (BuildContext context, provider, _) {
            if (provider.userr.isEmpty) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final user = provider.userr;
                    return ListTile(
                      onTap: postdata,
                      title: Text("${user['first_name']} ${user['last_name']}"),
                      subtitle: Text("${user['id']} ${user['email']}"),
                      leading: CircleAvatar(
                        child: Image.network(user['avatar']),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
