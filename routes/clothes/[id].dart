import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final request = context.request;
  final method = request.method;

  switch (method) {
    case HttpMethod.get:
      try {
        final supaBase = GetIt.instance.get<SupabaseClient>();
        return await supaBase
            .from('clothes')
            .select('*')
            .eq('id', id)
            .maybeSingle()
            .then((value) {
          return Response.json(statusCode: HttpStatus.ok, body: {
            'success': true,
            'data': value,
          });
        }).catchError(
              (onError) {
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
          },
        );
      } catch (exception) {
        return Response.json(
            statusCode: HttpStatus.internalServerError,
            body: {'success': false, 'data': exception});
      }

    default:
      return Response.json(
          statusCode: HttpStatus.notAcceptable,
          body: {'success': false, 'data': 'Method request not allow'});
  }
}
