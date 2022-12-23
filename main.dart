import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:my_project/dependencies_inject.dart';

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  await initializeDependencies();
  const customStaticFilePath = 'api/static';
  final cascade = Cascade()
      .add(createStaticFileHandler(path: customStaticFilePath))
      .add(handler);
  return serve(cascade.handler, ip, port);
}
