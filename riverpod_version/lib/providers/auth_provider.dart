import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/student.dart';
import '../models/auth_result.dart';
import '../repositories/auth_repository.dart';
import '../repositories/auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepositoryImpl.shared);

final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthState {
  const AuthState({
    this.loading = false, this.hidePassword = true, this.hideConfirm = true,
    this.remember = false, this.acceptedTerms = false, this.identifier = '',
    this.password = '', this.name = '', this.studentId = '', this.email = '',
    this.confirm = '', this.otp = '', this.resetIdentifier = '',
  });

  final bool loading, hidePassword, hideConfirm, remember, acceptedTerms;
  final String identifier, password, name, studentId, email, confirm, otp, resetIdentifier;

  AuthState copyWith({
    bool? loading, bool? hidePassword, bool? hideConfirm, bool? remember,
    bool? acceptedTerms, String? identifier, String? password, String? name,
    String? studentId, String? email, String? confirm, String? otp, String? resetIdentifier,
  }) => AuthState(
    loading: loading ?? this.loading,
    hidePassword: hidePassword ?? this.hidePassword,
    hideConfirm: hideConfirm ?? this.hideConfirm,
    remember: remember ?? this.remember,
    acceptedTerms: acceptedTerms ?? this.acceptedTerms,
    identifier: identifier ?? this.identifier,
    password: password ?? this.password,
    name: name ?? this.name,
    studentId: studentId ?? this.studentId,
    email: email ?? this.email,
    confirm: confirm ?? this.confirm,
    otp: otp ?? this.otp,
    resetIdentifier: resetIdentifier ?? this.resetIdentifier,
  );
}

class AuthNotifier extends Notifier<AuthState> {
  AuthRepository get repository => ref.read(authRepositoryProvider);

  @override
  AuthState build() => const AuthState();

  void setIdentifier(String v) => state = state.copyWith(identifier: v);
  void setPassword(String v) => state = state.copyWith(password: v);
  void setName(String v) => state = state.copyWith(name: v);
  void setStudentId(String v) => state = state.copyWith(studentId: v);
  void setEmail(String v) => state = state.copyWith(email: v);
  void setConfirm(String v) => state = state.copyWith(confirm: v);
  void setOtp(String v) => state = state.copyWith(otp: v);
  void togglePassword() => state = state.copyWith(hidePassword: !state.hidePassword);
  void toggleConfirm() => state = state.copyWith(hideConfirm: !state.hideConfirm);
  void toggleRemember() => state = state.copyWith(remember: !state.remember);
  void toggleTerms() => state = state.copyWith(acceptedTerms: !state.acceptedTerms);

  Future<AuthResult> _run(Future<AuthResult> Function() action) async {
    state = state.copyWith(loading: true);
    try { return await action(); }
    finally { state = state.copyWith(loading: false); }
  }

  Future<AuthResult> login() => _run(() => repository.login(state.identifier, state.password));

  Future<AuthResult> register() => _run(() => repository.register(Student(
    name: state.name.trim(), studentId: state.studentId.trim(),
    email: state.email.trim(), password: state.password,
  )));

  Future<AuthResult> requestReset() async {
    final result = await _run(() => repository.requestReset(state.identifier));
    if (result.success) state = state.copyWith(resetIdentifier: state.identifier.trim());
    return result;
  }

  Future<AuthResult> resetPassword() => _run(() => repository.resetPassword(
    state.resetIdentifier, state.otp.trim(), state.password,
  ));

  void clear() => state = const AuthState();
}
