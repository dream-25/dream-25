import 'package:drm25/screens/home_screen/home_screen_widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignInAccount? user = _currentUser;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        appBar: AppBar(
          foregroundColor: Colors.blueGrey.shade900,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [],
          ),
        ),
        drawer: (user != null)
            ? HomeScreenDrawer(user.displayName.toString(),
                user.email.toString(), user.photoUrl.toString())
            : HomeScreenDrawer(
                "Dream-25", "Welcome to the dream's world", "none"),
      ),
    );
  }
}
