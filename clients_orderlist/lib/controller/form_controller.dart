import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../model/form_model.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {
  // Google App Script Web URL.
  //Clients Order List URL = https://docs.google.com/spreadsheets/d/1d45iRKjPv-Dwj2jNaPHePqUgQ6dqVbWHydOaXkpUUDM/edit#gid=0
  static const String URLApiByOne =
      "https://script.google.com/macros/s/AKfycbwqbpHyvJZM63saBauYLlH_Zrh43I-aAtDAzh3ytUaVl6W2T9_CWtyMrnOsIcU97ASDZw/exec"; // เปลี่ยนทุกครั้งที่มีการ Deploy
  static const String URLGoogle =
      'https://docs.google.com/spreadsheets/d/1wYjELha9sKd7hqW9QIfonXh7_FNb8TLAvPDu6qdTo_o/'; //ไม่ต้องเปลี่ยน
  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  String strBack = "";
  void submitForm(
      FeedbackForm feedbackForm, void Function(String) callback) async {
    try {
      String txtParams = URLApiByOne +
          "?" +
          "val1=" +
          feedbackForm.val1 +
          "&" +
          "val2=" +
          feedbackForm.val2 +
          "&" +
          "val3=" +
          feedbackForm.val3 +
          "&" +
          "val4=" +
          feedbackForm.val4 +
          "&" +
          "val5=" +
          feedbackForm.val5 +
          "&" +
          "val6=" +
          feedbackForm.val6 +
          "&" +
          "val7=" +
          feedbackForm.val7 +
          "&" +
          "val8=" +
          feedbackForm.val8 +
          "&" +
          "val9=" +
          feedbackForm.val9 +
          "&" +
          "val10=" +
          feedbackForm.val10;
      await http.get(Uri.parse(txtParams)).then((response) {
        Map<String, dynamic> jdata =
            convert.jsonDecode(response.body)['status'];
        print('Howdy, ${jdata['status']}!');
        //var strBack = callback(convert.jsonDecode(response.body)['status']);
      });
    } catch (e) {
      print(e);
      print(strBack);
    }
  }
}
