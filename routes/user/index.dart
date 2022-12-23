import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:get_it/get_it.dart';
import 'package:my_project/models/user_model.dart';
import 'package:supabase/supabase.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  final method = request.method;

  switch (method) {
    case HttpMethod.get:
      try {
        final supaBase = GetIt.instance.get<SupabaseClient>();
        return await supaBase
            .from('users')
            .select('*')
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

    case HttpMethod.post:
      try {
        final body = await request.body();
        UserModel userModel = UserModel.fromJson(json.decode(body));
        final supaBase = GetIt.instance.get<SupabaseClient>();
        return await supaBase
            .from('users')
            .insert(userModel.toJson())
            .select()
            .then((value) {
          return Response.json(statusCode: HttpStatus.ok, body: {
            'success': true,
            'data': "Thêm dữ liệu thành công",
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

    case HttpMethod.put:
      try {
        final body = await request.body();
        UserModel userModel = UserModel.fromJson(json.decode(body));
        final supaBase = GetIt.instance.get<SupabaseClient>();
        return await supaBase
            .from('users')
            .update(userModel.toJson())
            .eq('id', userModel.id)
            .then((value) {
          return Response.json(statusCode: HttpStatus.ok, body: {
            'success': true,
            'data': "Sửa dữ liệu thành công",
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

    case HttpMethod.delete:
      try {
        final body = await request.body();
        UserModel userModel = UserModel.fromJson(json.decode(body));
        final supaBase = GetIt.instance.get<SupabaseClient>();
        return await supaBase
            .from('users')
            .delete()
            .eq('id', userModel.id)
            .then((value) {
          return Response.json(statusCode: HttpStatus.ok, body: {
            'success': true,
            'data': "Xóa dữ liệu thành công",
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
