import 'package:autocarservice/providers/auth_provider.dart';
import 'package:autocarservice/register_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:autocarservice/registerscreen.dart';

class RegisterController extends StateNotifier<RegisterState> {
  RegisterController(this.ref) : super(const RegisterStateInitial());

  final Ref ref;

  void Register(String email, String password) async {
    //state = const RegisterScreenLoading();
    try {
      await ref
          .read(authRepositoryProvider)
          .createUserWithEmailAndPassword(email, password);
      state = const RegisterStateSuccess();
    } catch (e) {
      state = RegisterStateError(e.toString());
    }
  }

  void signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}

final RegisterControllerProvider =
    StateNotifierProvider<RegisterController, RegisterState>((ref) {
  return RegisterController(ref);
});
