import 'package:acme_fit/repository/user_data_repo.dart';
import 'package:acme_fit/screens/home_screen.dart';
import 'package:acme_fit/screens/initial_screen/initial_screen.dart';
import 'package:acme_fit/screens/initial_screen/widgets/log_in_widget.dart';
import 'package:acme_fit/viewmodels/authentication_vm.dart';
import 'package:acme_fit/viewmodels/tracked_data_vm.dart';
import 'package:acme_fit/viewmodels/user_data_vm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthenticationVM()),
        ChangeNotifierProvider(create: (context) => UserDataVM()),
        ChangeNotifierProvider(create: (context) => TrackedDataVM()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const LogInPage(),
      ),
    );
  }
}

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  FirebaseAuth? _auth;
  AuthenticationVM? auths;

  User? user;
  @override
  void initState() {
    _auth = FirebaseAuth.instance;
    auths = Provider.of<AuthenticationVM>(context, listen: false);
    user = _auth!.currentUser;
    if (user != null) {
      userToken();
    }
    super.initState();
  }

  userToken() async {
    String k = await user!.getIdToken();
    auths!.store(user!.uid, k, user!.displayName, user!.email, user!.photoURL);
    UserDataRepo.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return user == null ? const InitialScreen() : const HomeScreen();
  }
}
