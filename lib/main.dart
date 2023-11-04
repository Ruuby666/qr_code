import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter QR Code Creator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'QR Creator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Color backgroundColor;
  late Color qrColor;
  late String qrString;
  late String opcionEye;
  late String optionQrSelected;

  @override
  void initState() {
    backgroundColor = Colors.transparent;
    qrColor = Colors.transparent;
    qrString = '';
    opcionEye = 'Square';
    optionQrSelected = 'Square';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      width: 330,
                      height: 330,
                    ),
                    QrImageView(
                      //data: 'https://drive.google.com/drive/folders/1abWBg3I_E2oDEsFeTmInuHsUU5h7epBU?usp=sharing',
                      data: qrString,
                      eyeStyle: QrEyeStyle(
                        eyeShape: opcionEye == 'Square'
                            ? QrEyeShape.square
                            : QrEyeShape.circle,
                      ),

                      /// No funciona el eye Style si lo pongo de la misma manera que el dataModuleStyle
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: // es un if en flutter
                            optionQrSelected == 'Circle'
                                ? QrDataModuleShape.circle
                                : QrDataModuleShape.square,
                      ),
                      version: QrVersions.auto,
                      size: 270,
                      gapless: true,
                      foregroundColor: qrColor,
                      backgroundColor: Colors.transparent,
                      embeddedImage: AssetImage('assets/img/logo.png'),
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(70, 70),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Color of backGround'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: backgroundColor,
                                    onColorChanged: (Color color) {
                                      setState(() {
                                        backgroundColor =
                                            color; // Asignar el color seleccionado a la variable
                                      });
                                    },
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Got it')),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('Color of backGround'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Color for QR'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: qrColor,
                                    onColorChanged: (Color color) {
                                      setState(() {
                                        qrColor =
                                            color; // Asignar el color seleccionado a la variable
                                      });
                                    },
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Got it')),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('Color for QR'),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        qrString = val;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Enter you url here",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text('Qr shape',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text('Corners shape',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: DropdownButton(
                        value: optionQrSelected,
                        items: [
                          DropdownMenuItem(
                              child: Text("Circle"), value: "Circle"),
                          DropdownMenuItem(
                            child: Text("Square"),
                            value: "Square",
                          ),
                        ],
                        onChanged: (nuevaOpcionSeleccionada) {
                          setState(() {
                            optionQrSelected = nuevaOpcionSeleccionada;
                          });
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: DropdownButton(
                          value: opcionEye,
                          items: [
                            DropdownMenuItem(
                                child: Text("Square"), value: "Square"),
                            DropdownMenuItem(
                              child: Text("Circle"),
                              value: "Circle",
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              opcionEye = value;
                            });
                          },
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
