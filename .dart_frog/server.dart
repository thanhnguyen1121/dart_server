// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../main.dart' as entrypoint;
import '../routes/index.dart' as index;
import '../routes/user/user_cart.dart' as user_user_cart;
import '../routes/user/index.dart' as user_index;
import '../routes/user/[id].dart' as user_$id;
import '../routes/clothes/[id].dart' as clothes_$id;
import '../routes/auth/sign_up.dart' as auth_sign_up;
import '../routes/auth/sign_in.dart' as auth_sign_in;

import '../routes/_middleware.dart' as middleware;

void main() => hotReload(createServer);

Future<HttpServer> createServer() {
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final handler = Cascade().add(buildRootHandler()).handler;
  return entrypoint.run(handler, ip, port);
}

Handler buildRootHandler() {
  final pipeline = const Pipeline().addMiddleware(middleware.middleware);
  final router = Router()
    ..mount('/auth', (context) => buildAuthHandler()(context))
    ..mount('/clothes', (context) => buildClothesHandler()(context))
    ..mount('/user', (context) => buildUserHandler()(context))
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildAuthHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/sign_up', (context) => auth_sign_up.onRequest(context,))..all('/sign_in', (context) => auth_sign_in.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildClothesHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/<id>', (context,id,) => clothes_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildUserHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/user_cart', (context) => user_user_cart.onRequest(context,))..all('/', (context) => user_index.onRequest(context,))..all('/<id>', (context,id,) => user_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => index.onRequest(context,));
  return pipeline.addHandler(router);
}
