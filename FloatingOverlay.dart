import 'package:flutter/material.dart';

class FloatingOverlayApp extends StatefulWidget {
  const FloatingOverlayApp({super.key});

  @override
  State<FloatingOverlayApp> createState() => _FloatingOverlayAppState();
}

class _FloatingOverlayAppState extends State<FloatingOverlayApp> {
  OverlayEntry? screenrecordingOverlay;
  OverlayEntry? messageOverlay;
  Offset screenoffset=const Offset(90, 340);
  Offset messageoffset=const Offset(30, 405);
  bool isshowing=false;

  showOverlay(BuildContext context){
    if(isshowing==true){
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Already Floating',style: TextStyle(
          fontWeight: FontWeight.bold,fontSize: 18
        ),),backgroundColor: Colors.red,)
      );
    }
    screenrecordingOverlay=OverlayEntry(builder:(context) {
      return Positioned(
        top: screenoffset.dy,//40,
        left: screenoffset.dx,//50,
        child: GestureDetector(
          onPanUpdate: (details) {
            print('trying to move-$details');
            screenoffset+=details.delta;
            screenrecordingOverlay!.markNeedsBuild();
          },
          child: ElevatedButton.icon(
            style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(5),
                        backgroundColor: const MaterialStatePropertyAll(Colors.red),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23))),
                        fixedSize: const MaterialStatePropertyAll(Size(130, 50)),
                      ),
            onPressed: (){
              print('Start Screen Recording');
            }, icon: const Icon(Icons.circle),
           label: const Text('Start Record...')),
        ),
      );
    },);
        messageOverlay= OverlayEntry(builder: (context) {
      return Positioned(
        top: messageoffset.dy,
        left: messageoffset.dx, 
        child: GestureDetector(
          onPanUpdate: (details) {
            messageoffset += details.delta;
            messageOverlay!.markNeedsBuild();
          },
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
            width: 250,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 39, 112, 176),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 197, 197, 197),
                    offset: Offset(0.0, 1.0),
                    blurRadius: 6.0,
                  ),
                ]),
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Text('Message :-  Hey! How are you',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          ),
          // ),
        ),
      );
    });
    Overlay.of(context).insertAll([screenrecordingOverlay!,messageOverlay!]);//You can add more
    isshowing=true;
    setState(() {
      
    });
  }
  hideOverlay(BuildContext context){
    if(isshowing==false){
        return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Already Hidden',style: TextStyle(
          fontWeight: FontWeight.bold,fontSize: 18
        ),),backgroundColor: Colors.black,)
      );
    }
    screenrecordingOverlay!.remove();
    messageOverlay!.remove();
    isshowing=false;
    setState(() {
      
    });
  }
  @override
  void dispose() {
    screenrecordingOverlay!.remove();
    screenrecordingOverlay!.dispose();
    screenrecordingOverlay=null;
    messageOverlay!.remove();
    messageOverlay!.dispose();
    messageOverlay=null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.indigo,
          title: const Text(
            'Floating Overlay App',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img1.png',
              height: 300,
              width: 350,
            ),
            const SizedBox(
              height: 100,
            ),
            MaterialButton(
              color: Colors.red,
              minWidth: 250,
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: const Text(
                'Show Overlay',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
              onPressed: () {
                showOverlay(context);
              },
            ),
            MaterialButton(
              color: Colors.teal,
              minWidth: 250,
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                hideOverlay(context);
              },
              child: const Text(
                'Hide Overlay',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ],
        ))));
  }
}












