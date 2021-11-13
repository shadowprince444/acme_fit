import 'package:acme_fit/screens/home_screen/home_screen.dart';
import 'package:acme_fit/screens/initial_screen/initial_screen.dart';
import 'package:acme_fit/viewmodels/authentication_vm.dart';
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
        //ChangeNotifierProvider(create: (context) => UserDataVM()),
        // ChangeNotifierProvider(create: (context) => TrackedDataVM()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
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
  late FirebaseAuth _auth;
  AuthenticationVM? auths;

  User? user;
  @override
  void initState() {
    _auth = FirebaseAuth.instance;

    user = _auth.currentUser;
    if (user != null) {
      auths = Provider.of<AuthenticationVM>(context, listen: false);
      userToken();
    }
    super.initState();
  }

  userToken() async {
    String k = await user!.getIdToken();
    auths!.store(user!.uid, k, user!.displayName, user!.email, user!.photoURL);
    // UserDataRepo.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return user == null ? const InitialScreen() : const HomeScreen();
  }
}
