import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:my_project/config/configs.dart';
import 'package:my_project/utils/hash.dart';

List<Map<String, String>> users = [
  {"username": "test", "password": Hash.create("insecure")},
  {"username": "beep", "password": Hash.create("beepboop")}
];

bool _check(Map<String, String> user, Map<String, String> creds) {
  print("user: ${user} -- creds: ${creds}");
  return (user['username'] == creds['username'] &&
      user['password'] == creds['password']);
}

int expiredAfter = 60;

Future<Response> auth(RequestContext context) async {
  print("auth");
  try {
    final body = await context.request.body();
    print("body: $body");
    dynamic data = json.decode(body);
    String user = data['username'];
    String hash = Hash.create(data['password']);

    Map<String, String> creds = {"username": user, "password": hash};
    int index = users.indexWhere((user) => _check(user, creds));

    if (index == -1) {
      throw Exception();
    }

    JwtClaim claim = JwtClaim(
      subject: user,
      issuer: 'ACME Widgets Corp',
      audience: ['example.com'],
      expiry: DateTime.now().add(
        Duration(seconds: expiredAfter),
      ),
    );

    String token = issueJwtHS256(claim, Configs.secret);
    return Response.json(statusCode: HttpStatus.ok, body: {
      'success': true,
      'data': {
        'token': token,
      }
    });
  } catch (e) {
    print("e: ${(e as Exception).toString()}");
    return Response.json(statusCode: HttpStatus.unauthorized, body: {
      'success': false,
      'data': {'message': 'Incorrect username/password'}
    });
  }
}

Future<Response> verify(RequestContext context) async {
  print("verify");
  try {
    String token =
        context.request.headers['Authorization']?.replaceAll('Bearer ', '') ??
            '';
    JwtClaim claim = verifyJwtHS256Signature(token, Configs.secret);
    claim.validate(issuer: 'ACME Widgets Corp', audience: 'example.com');
    return Response.json(statusCode: HttpStatus.ok, body: {
      'success': true,
      'data': {
        'message': 'Verify successfully',
      }
    });
  } catch (e) {
    if (e is JwtException) {
      return Response.json(statusCode: HttpStatus.forbidden, body: {
        'success': false,
        'data': {
          'message': e.message,
        }
      });
    }
    return Response.json(statusCode: HttpStatus.forbidden, body: {
      'success': false,
      'data': {
        'message': e,
      }
    });
  }
}

Handler bearerAuthMiddleware(Handler handler) {
  return (context) async {
    final path = context.request.uri.path;
    Response response;
    if (path == "/") {
      response = await auth(context);
    } else {
      response = await verify(context);
    }
    return response;
  };
}
