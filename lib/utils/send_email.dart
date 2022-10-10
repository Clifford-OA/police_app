// ignore_for_file: avoid_print, prefer_function_declarations_over_variables, duplicate_ignore

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:telephony/telephony.dart';

class SendEmailClass {
  final Telephony telephony = Telephony.instance;

  // ignore: duplicate_ignore
  Future sendEmail({toName, description, fineAmount, toEmail}) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_d7wq1ps';
    const templateId = 'template_ynovx6k';
    const userId = '9WODARR5Zm2srqUTX';

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'origin': 'http://localhost'
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'to_name': toName,
            'description': description,
            'fine_amount': fineAmount,
            'email': toEmail
          }
        }));
    // ignore: avoid_print
    print(response);
    return response;
  }

  Future<void> sendMail(
      {toName, description, fineAmount, toEmail, fineId, context}) async {
    // final Email email = Email(
    //   body: body,
    //   subject: 'FINE MESSAGE FROM MTTD - GHANA POLICE',
    //   recipients: [toEmail],
    //   // attachmentPaths: attachments,
    //   // isHTML: isHTML,
    // );


    // try {
    //   await FlutterEmailSender.send(email);
    //   platformResponse = 'success';
    // } catch (error) {
    //   print(error);
    //   platformResponse = error.toString();
    // }

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(platformResponse),
    //   ),
    // );
  }

  Future sendSms({
    vehicleNum,
    description,
    fineAmount,
    phone,
    location,
    toEmail,
    fineId,
  }) async {
    // bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;

    String title = 'FINE FROM MTTD - GHANA POLICE';
    // String bodyCharge = 'Fine Amount: GHC $fineAmount';
    // String fineTitle = 'Offense: $description';
    String vehicle = 'Vehicle Number: $vehicleNum';
    String mess = 'Download "MTTD Fine Payment App" from playstore';
    String fine = 'Fine ID: $fineId';
    String body =
        '$title\n$fine\n$vehicle\n$mess';

    final SmsSendStatusListener listener = (SendStatus status) {
      // Handle the status
      print(status);
    };
    await telephony.sendSms(
        to: phone.toString(), message: body, statusListener: listener);

    // print('sent message');
    // statusListener: listener);
  }
}
