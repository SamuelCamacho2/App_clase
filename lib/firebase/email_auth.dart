import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> createUser({required String emailUser, required String pdwUser}) async{
    try {
      final credentials = await auth.createUserWithEmailAndPassword(email: emailUser, password: pdwUser);
      credentials.user!.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> validarUser({required String emailUser, required String pdwUser}) async{
    try {
      final credentials = await auth.signInWithEmailAndPassword(email: emailUser, password: pdwUser);
      if(credentials.user!.emailVerified){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}