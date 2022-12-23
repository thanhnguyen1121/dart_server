import 'package:dart_frog/dart_frog.dart';
import 'package:my_project/middleware/bear_authentication.dart';

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use((context) => bearerAuthMiddleware(context));
}
