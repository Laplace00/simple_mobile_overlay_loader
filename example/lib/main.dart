import 'package:flutter/material.dart';
import 'package:simple_mobile_overlay_loader/simple_mobile_overlay_loader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final loader = showLoaderOverlay(context, message: 'Loading…');
            // Simulate work
            await Future.delayed(const Duration(seconds: 3));
            if (loader.mounted) loader.remove();
          },
          child: const Text('Start Loader'),
        ),
      ),
    );
  }
}
