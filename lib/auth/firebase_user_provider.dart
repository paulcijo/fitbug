import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FitHeatFirebaseUser {
  FitHeatFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

FitHeatFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FitHeatFirebaseUser> fitHeatFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<FitHeatFirebaseUser>(
        (user) => currentUser = FitHeatFirebaseUser(user));
