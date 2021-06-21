import 'package:get_it/get_it.dart';
import 'auth_provider.dart';
import 'conversation_provider.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton<ConversationProvider>(() => ConversationProvider());
  locator.registerLazySingleton<AuthProvider>(() => AuthProvider());
}
