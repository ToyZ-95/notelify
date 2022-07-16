import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:notelify/utils/snack_messages.dart';

class UserController extends GetxController {
  bool isUserLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listenUserChanges();
  }

  Future<bool> loginUser(String email, String password) async {
    isUserLoading = true;
    update();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isUserLoading = false;
      update();

      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        SnackMessages.showError("User is not verified!!");
        return false;
      }

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      isUserLoading = false;
      update();

      SnackMessages.showError(e.code);

      return false;
    }
  }

  Future<bool> signUpUser(
      String email, String password, String displayName) async {
    isUserLoading = true;
    update();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.updateDisplayName(displayName);
      isUserLoading = false;
      update();

      await sendVerificationEmail();

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      isUserLoading = false;
      update();

      SnackMessages.showError(e.code);
    } catch (e) {
      print(e);
      SnackMessages.showError(e.toString());
    }
    return false;
  }

  Future<void> sendVerificationEmail({bool showSnackMessage = false}) async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      if (showSnackMessage) {
        SnackMessages.showError("Verification Email Sent!");
      }
    } catch (e) {
      SnackMessages.showError(e.toString());
    }
  }

  listenUserChanges() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
}
