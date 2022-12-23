import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:get_it/get_it.dart';
import 'package:my_project/utils/validate_query_param_helper.dart';
import 'package:supabase/supabase.dart';

Future<Response> onRequest(RequestContext context)  async {
  final request = context.request;
  final method = request.method;

  switch (method) {
    case HttpMethod.get:
      try {
        final queryParam = request.uri.queryParameters;
        print("queryParam: ${queryParam}");
        final queryParamValidate = context.validateQueryParam(
          params: ['user_id'],
          queryParam: queryParam,
        );

        if (queryParamValidate.isEmpty) {
          final String? userId = queryParam['user_id'];
          final supaBase = GetIt.instance.get<SupabaseClient>();
          return await supaBase
              .from('user_clothes')
              .select('*')
              .eq('user_id', userId)
              .then((value) {
            return Response.json(statusCode: HttpStatus.ok, body: {
              'success': true,
              'data': value,
            });
          }).catchError((onError) {
            onError as PostgrestException;
            return Response.json(
              statusCode: HttpStatus.internalServerError,
              body: {
                'success': false,
                'data': {
                  'code': onError.code,
                  'message': onError.message,
                  'details': onError.details,
                  'hint': onError.hint,
                },
              },
            );
          });
        } else {
          return Response.json(
            statusCode: HttpStatus.internalServerError,
            body: {
              'success': false,
              'data': 'Missing ${queryParamValidate} query param'
            },
          );
        }
      } catch (exception) {
        return Response.json(
            statusCode: HttpStatus.internalServerError,
            body: {'success': false, 'data': exception.toString()});
      }

    default:
      return Response.json(
          statusCode: HttpStatus.notAcceptable,
          body: {'success': false, 'data': 'Method request not allow'});
  }
}
