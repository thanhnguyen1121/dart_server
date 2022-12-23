import 'package:get_it/get_it.dart';
import 'package:my_project/constants.dart';
import 'package:supabase/supabase.dart';

Future initializeDependencies() async {
  if (!GetIt.instance.isRegistered<SupabaseClient>()) {
    GetIt.instance.registerSingleton(
        SupabaseClient(Constants.supaBaseUrl, Constants.apiKey));
  }
}
