import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:practice_app/common/logging_utils.dart';
import 'package:practice_app/models/user.dart';
import 'package:practice_app/pages/dashboard/dashboard.dart';
import 'package:practice_app/pages/sign_in/sign_in.dart';

Logger logger = Logger("pages:entry.dart");

class Entry extends StatelessWidget {
  const Entry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FutureBuilder<String>(
      future: verifyToken(),
      builder: buildContext,
    ));
  }

  Widget buildContext(BuildContext context, AsyncSnapshot<String> status) {
    if (status.data == "ok") {
      return  DashboardPage();
    } else {
      return SignInPage();
    }
  }

  Future<String> verifyToken() async {
    Response response = await User().verifyToken();
    logger.info(response.body);
    return response.statusCode == StatusCode.OK ? "ok" : "fail";
  }
}
