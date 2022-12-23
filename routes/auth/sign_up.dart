import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final method = request.method;
  if (method == HttpMethod.post) {
    try {
      final body = await request.body();
      final bodyRequest = json.decode(body);
      return Response.json(statusCode: HttpStatus.ok, body: {
        'success': true,
        'data': bodyRequest,
      });
    } catch (exception) {
      return Response.json(
          statusCode: HttpStatus.internalServerError,
          body: {'data': '${exception}'});
    }
  } else {
    return Response.json(
        statusCode: HttpStatus.notAcceptable,
        body: {'data': 'Method request not allow'});
  }
}
