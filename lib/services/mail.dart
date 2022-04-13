import 'dart:convert';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:http/http.dart' as http;
import 'package:print_color/print_color.dart';

class SendMailServices {
  static Future sendMail(email, subject, meessage) async {
    // final Email email = Email(
    //   body: 'Email body',
    //   subject: 'Email subject',
    //   cc: ['elnndselman@gmail.com'],
    //   isHTML: false,
    // );

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    Print.yellow(email);
    try {
      // await FlutterEmailSender.send(email);
      final response = await http.post(url,
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            'service_id': 'service_bvi9f8b',
            'template_id': 'template_r9ttznt',
            'user_id': '5Yi_JUzgmP6lOrq8Y',
            'template_params': {
              'from_name': 'car rent app',
              'to_name': email.toString().trim(),
              'user_email': 'elnndselman@gmail.com',
              'to_email': email.toString().trim(),
              'user_subject': subject,
              'message': meessage
            }
          }));
      if (response.body.toString().toLowerCase().trim() == 'ok') {
        return 'sended';
      }
    } catch (e) {
      print(e);
    }
  }
}
