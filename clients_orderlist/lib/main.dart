import 'dart:convert';
// import 'dart:html';
import 'dart:io';

// import 'package:ecbox_ggsheet_toto/motor_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:ecbox_ggsheet_toto/report_data.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'controller/form_controller.dart';
import 'model/form_model.dart';
import 'model/resdata.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NJ Fashion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '-NJ-'),
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
  int _counter = 0;
  String val1 = "0";
  String val2 = "0";
  String val3 = "0";
  String val4 = "0";
  String val5 = "0";
  String val6 = "0";
  String val7 = "0";
  String val8 = "0";
  String val9 = "0";
  String val10 = "0";
  String val11 = "0";
  String val12 = "0";
  String val13 = "0";
  String val14 = "0";
  String val15 = "0";
  String val16 = "0";
  String val17 = "0";
  String val18 = "0";
  String val19 = "0";
  String val20 = "0";
  String val21 = "0";

  String val1MinDef = "0";
  String val1MaxDef = "0";
  String _tmpMinDef = "0";
  String _tmpMaxDef = "0";
  String val3MinDef = "0";
  String val3MaxDef = "0";
  String tDisplay = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Timer? timer;
  bool flgUpdate = false;
  int sec_data = 5;
  @override
  void initState() {
    super.initState();
    timer = new Timer.periodic(new Duration(seconds: sec_data),
        (Timer timer) async {
      if (!flgUpdate) {
        //--->await this._fetchData();
        flgUpdate = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    final timer =
        Timer(const Duration(seconds: 5), () => print('Timer finished'));
    timer.cancel();
  }

  //Future<void> _fetchData() async {
  _fetchData() async {
    return;
    String _sReturn = "";

    const apiUrl = FormController.URLApiByOne;
    final response = await http.get(Uri.parse(apiUrl));
    final data = jsonDecode(response.body);
    for (dynamic res_data in data) {
      _sReturn += res_data.toString() + ", ";
    }
    _sReturn = _sReturn.replaceAll('[', '').replaceAll(']', '');
    print(_sReturn);

    setState(() {
      //--Debug--> tDisplay = _sReturn;
      List<String> _split = _sReturn.split(',');
      val1 = _split[0];
      val2 = _split[1];
      val3 = _split[2];
      val1MinDef = _split[3];
      val1MaxDef = _split[4];
      _tmpMinDef = _split[5];
      _tmpMaxDef = _split[6];
      val3MinDef = _split[7];
      val3MaxDef = _split[8];
    });
    final timer =
        Timer(const Duration(seconds: 5), () => print('Timer finished'));
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    TextEditingController minval3idController = TextEditingController();
    TextEditingController maxval3idController = TextEditingController();
    TextEditingController minval2Controller = TextEditingController();
    TextEditingController maxval2Controller = TextEditingController();
    TextEditingController minval1Controller = TextEditingController();
    TextEditingController maxval1Controller = TextEditingController();

    TextEditingController flagController = TextEditingController();
    TextEditingController curval1Controller = TextEditingController();
    TextEditingController curval2Controller = TextEditingController();
    TextEditingController curval3Controller = TextEditingController();
    TextEditingController resDataController = TextEditingController();
    minval1Controller.text = val1MinDef;
    maxval1Controller.text = val1MaxDef;
    minval2Controller.text = _tmpMinDef;
    maxval2Controller.text = _tmpMaxDef;
    minval3idController.text = val3MinDef;
    maxval3idController.text = val3MaxDef;

    // autoPress(); --- ปิดในหน้านี้
    _showSnackbar(String message) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('ผลการบันทึก'),
          content: Text(message.toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    void _submitForm() {
      // Validate returns true if the form is valid, or false
      // otherwise.
      //if (minval3idController.text == "0" ||
      //    maxval3idController.text == "0" ||
      //    curval3Controller.text == "") {
      //  return;
      //}
      if (_formKey.currentState!.validate()) {
        // If the form is valid, proceed.
        print(curval1Controller.text);
        FeedbackForm feedbackForm = FeedbackForm(
            minval3idController.text,
            maxval3idController.text,
            minval2Controller.text,
            "x",
            "x",
            "x",
            "x",
            "x",
            "x",
            "x",
            "x",
            "x",
            "x",
            "x",
            "x",
            "x",
            "x",
            "x",
            "x",
            "x",
            "x");

        FormController formController = FormController();
        formController.submitForm(feedbackForm, (String response) {
          print("Response: $response");
          if (response == FormController.STATUS_SUCCESS) {
            // Feedback is saved succesfully in Google Sheets.
            _showSnackbar(FormController.STATUS_SUCCESS);
          } else {
            // Error Occurred while saving data in Google Sheets.
            _showSnackbar("Error Occurred!");
          }
        });

        flgUpdate = true;
      }
    }

    void _launchURL() async {
      // Open Google Sheet in default browser
      const url = FormController.URLGoogle;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Update data',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Divider(color: Colors.blue),
            Text(
              '----------',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //----Start Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: minval3idController,
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration(labelText: 'Min Humidity'),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: maxval3idController,
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration(labelText: 'Max Humidity'),
                            ),
                          ),
                        ],
                      ),
                      //----Start Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: minval2Controller,
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration(labelText: 'Min Temp'),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: maxval2Controller,
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration(labelText: 'Max Temp'),
                            ),
                          ),
                        ],
                      ),
                      //----Start Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: minval1Controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Min Electrin Conductor'),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: maxval1Controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Max Electric Conductor'),
                            ),
                          ),
                        ],
                      ),
                      //----Start Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(""),
                                Text(""),
                                Text(
                                  "Update current data",
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                                Divider(color: Colors.black)
                              ],
                            ),
                          ),
                        ],
                      ),
                      //----Start Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: curval3Controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Humidity current'),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color.fromRGBO(247, 48, 13, 1)
                                      .withOpacity(0.6)),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: curval2Controller,
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration(labelText: 'Temp current'),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color.fromARGB(255, 20, 160, 2)
                                      .withOpacity(0.6)),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: curval1Controller,
                              keyboardType: TextInputType.number,
                              decoration:
                                  InputDecoration(labelText: 'EC current'),
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Color.fromARGB(255, 10, 109, 240)
                                      .withOpacity(0.6)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(100, 34, 29, 1)),
                        ),
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          // builder: (context) => MotorSetting()));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        child: Text('Motor Settings'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //----Start Horizoltal line
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: <Widget>[Divider(color: Colors.black)],
                  ),
                ),
              ],
            ),
            //----Start Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        '$tDisplay',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            color: Colors.black.withOpacity(0.6)),
                      ),
                      Divider(color: Colors.black)
                    ],
                  ),
                ),
              ],
            ),
            //----Start Row for button menu
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _launchURL,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(100, 34, 29, 1)),
                        ),
                        child: Text('Open G-Sheet'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          _fetchData();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        child: Text('Get data'),
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   child: Column(
                //     children: <Widget>[
                //       ElevatedButton(
                //         onPressed: () {
                //           Navigator.of(context).push(MaterialPageRoute(
                //               builder: (context) => Report()));
                //         },
                //         style: ButtonStyle(
                //           backgroundColor: MaterialStateProperty.all<Color>(
                //               Color.fromRGBO(100, 34, 29, 1)),
                //         ),
                //         child: Text('Report'),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
