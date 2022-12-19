import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final method = request.method;
  if (method == HttpMethod.post) {
    final body = await request.body();
    return Response.json(
      body: {
        'data': json.decode(body),
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
