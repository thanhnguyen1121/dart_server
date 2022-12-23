import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:my_project/models/user_model.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final method = request.method;
  if (method == HttpMethod.post) {
    final body = await request.body();
    final userInfo = UserModel.fromJson(json.decode(body));
    return Response.json(
      body: {
        'success': true,
        'data': userInfo.toJson(),
      },
    );
  } else {
    return Response.json(
      statusCode: HttpStatus.notAcceptable,
      body: {
        'success': false,
        'data': 'Method request not allow',
      },
    );
  }
}
