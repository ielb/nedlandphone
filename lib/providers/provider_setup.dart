import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'conversation_provider.dart';
import 'auth_provider.dart';
import 'locator.dart';


List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ConversationProvider>(
    create: (context) => locator<ConversationProvider>(),
  ),
  ChangeNotifierProvider<AuthProvider>(
    create: (context) => locator<AuthProvider>(),
  ),
];
