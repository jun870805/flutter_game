import 'package:flutter/material.dart';
import '../../includes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _reloadAppToken() async {
    Result<AppToken> result;

    try {
      result = await sharedApiClient.token.getCsrf();

      // if (!mounted) return Result<AppToken>.empty();
      if (!result.success) throw Exception(result.msg);
    } catch (error) {
      print(error);
    }

    // return result;
  }

  @override
  void initState() {
    super.initState();
    _reloadAppToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game',
      theme: ThemeData.dark(),
      home: const GamePage(),
    );
  }
}
