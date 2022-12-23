import 'package:dart_frog/dart_frog.dart';

extension ValidateQueryParam on RequestContext {
  List<String> validateQueryParam({
    required List<String> params,
    required Map<String, dynamic> queryParam,
  }) {
    List<String> paramError = [];
    for (String param in params) {
      if (!queryParam.keys.contains(param)) {
        paramError.add(param);
      }
    }
    return paramError;
  }
}
