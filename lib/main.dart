import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
// import 'package:mysignapp/Mydb.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'Mydb.dart';
// import 'package:path/path.dart';






void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  data a = data();
  @override
  void initState() {

    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {


      await a.initTexts();


    });

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // drawer: const Drawer(),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.announcement_outlined),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          backgroundColor: Colors.grey[300],
          title: const Padding(
            padding: EdgeInsets.all(80.0),
            child: Text('Bienvenue ..'),
          ),
        ),
        body: Column(
          children: [
            Avatar(),
            ComingText(),
          ],
        )


    );








  }
}










class Avatar extends StatefulWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  TextEditingController controllerText = TextEditingController();
  Flutter3DController controller = Flutter3DController();
  String chosenAnimation = 'assets/AuRevoir1.glb';
  String myText = '';




  void play() {
    controller.playAnimation(animationName: chosenAnimation);
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Flutter3DViewer(
              key: UniqueKey(), // Use UniqueKey to force widget rebuild
              controller: controller,
              src: chosenAnimation, // Chemin vers votre fichier d'animation Blender
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 10),
            child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),),
              controller: controllerText,
              onChanged :(text) async {
                setState(() {
                  myText = text;
                  if (myText.isEmpty) {
                    chosenAnimation='assets/AuRevoir1.glb';
                  }
                  else if (myText == 'Au revoir') {
                    chosenAnimation = 'assets/AuRevoir1.glb';
                  }
                  else if (myText =='nom') {
                    chosenAnimation ='assets/lenom.glb';
                  }
                  else if (myText =='cv?') {
                    chosenAnimation ='assets/CaVa.glb';
                  }
                  else if (myText =='prenom') {
                    chosenAnimation ='assets/leprenom.glb';
                  }
                  else {
                    chosenAnimation = 'assets/AuRevoir1.glb';
                  }

                });
                // _animationKey = UniqueKey();
                // controller.playAnimation(animationName: chosenAnimation);

                // Rebuild the Flutter3DViewer widget with the new animation
              },
              onSubmitted: (String value){
              print('works');
                play();
                // stop();
              },

            ),


          ),
        ],
      ),
    );
  }
}

class ComingText extends StatefulWidget {
  const ComingText({Key? key}) : super(key: key);

  @override
  State<ComingText> createState() => _ComingTextState();
}

class _ComingTextState extends State<ComingText> {
late WebSocketChannel channel;
String ReceivedText ='' ;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
   // appel();
  }

void appel() async{
  final url = Uri.parse('ws://192.168.4.1:80');
  channel = WebSocketChannel.connect(url);
  channel.stream.listen((message) {
    setState(() {
      ReceivedText = message;
    });
  });
}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(19, 0, 19, 1),
      child: Container(
        child: Text(
          ReceivedText,
          style: const TextStyle(
            fontSize: 25,
            fontStyle: FontStyle.italic,
          ),
        ),
        width: 370,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}






