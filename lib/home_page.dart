import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final platform=const MethodChannel("MainChannel");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(child: ElevatedButton(onPressed: (){
                platform.invokeMethod("instagram","com.instagram.android");
              }, child: const Text("Instagram"))),
              const SizedBox(width: 10),
              Expanded(child: ElevatedButton(onPressed: (){
                platform.invokeMethod("twitter","com.twitter.android");
              }, child: const Text("Twitter"))),
              const SizedBox(width: 10),
              Expanded(child: ElevatedButton(onPressed: (){
                platform.invokeMethod("thread","com.instagram.threads");
              }, child: const Text("Threads")))
            ],
          ),
        ),
      ),
    );
  }
}
