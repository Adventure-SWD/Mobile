import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/testing.dart';
import 'package:metrofood/Model/user.dart';
import 'package:metrofood/api/baseclient.dart';
import 'package:metrofood/regis_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-page';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        body: Center(
            child: isSmallScreen
                ? const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Logo(),
                      _FormContent(),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.all(32.0),
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: const Row(
                      children: [
                        Expanded(child: _Logo()),
                        Expanded(
                          child: Center(child: _FormContent()),
                        ),
                      ],
                    ),
                  )));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          image: const AssetImage('images/logo.png'),
          width: isSmallScreen ? 100 : 200,
          height: isSmallScreen ? 100 : 200,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Welcome to Metro Food!",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}

class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<Users> futureUser;
  late Users user = new Users(
      id: "",
      userName: "",
      email: "",
      accessToken: "",
      storeId: "",
      refreshToken: "",
      expires: DateTime.now());
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> LoginUser() async {
    await futureUser.then((value) {
      user = value;
      if (user.id.isNotEmpty) {
        _saveAndRedirectToHome();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Please enter a valid email';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            _gap(),
            TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )),
            ),
            _gap(),
            CheckboxListTile(
              value: _rememberMe,
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _rememberMe = value;
                });
              },
              title: const Text('Remember me'),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  // if (_formKey.currentState?.validate() ?? false) {
                  //   /// do something
                  // }
                  // Dùng để test, bấm chạy vào màn hình chính
                  emailController.text = 'enduser@gmail.com';
                  passwordController.text = 'P@ssw0rd1';
                  futureUser = BaseClient().fetchLogin(
                      emailController.text, passwordController.text);
                  signIn();
                  LoginUser();
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Sign in with Google',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () async {
                  // User? user = await signInWithGoogle();
                  await signInWithGoogle();
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text('Not Account? Create one'),
              ),
            ),
          ],
        ),
      ),
    );

  }
  // Future<User?> signInWithGoogle() async {
  Future<void> signInWithGoogle() async {
    try {
      // Khởi tạo đối tượng GoogleSignIn
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

      // Nếu người dùng chọn tài khoản Google, thực hiện xác thực
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        if(credential.accessToken != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
              Text('Đăng nhập thành công'),
            ),
          );
          futureUser = BaseClient().fetchLogin(
              'enduser@gmail.com', 'P@ssw0rd1');
          print('Đăng nhập thành công');
          LoginUser();
        }
        // Đăng nhập vào Firebase với credential từ Google
        // final UserCredential authResult = await _auth.signInWithCredential(credential);
        // final User? user = authResult.user;
        // return user;
      } else {
        // Người dùng hủy đăng nhập hoặc không chọn tài khoản Google
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
            Text('Đăng nhập bị huỷ'),
          ),
        );
        print('Đã xảy ra lỗi khi đăng nhập bằng Google, huỷ đăng nhập');
        return null;
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
          Text('Xảy ra lỗi khi đăng nhập'),
        ),
      );
      print('Đã xảy ra lỗi khi đăng nhập bằng Google: $error');
      return null;
    }
  }
  Widget _gap() => const SizedBox(height: 16);
  void _saveAndRedirectToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", user.id);
    await prefs.setString("userName", user.userName);
    await prefs.setString("email", user.email);
    Navigator.pushNamedAndRemoveUntil(
        context, '/main-page', ModalRoute.withName('/main-page'),
        arguments: (user));
  }

  Future<void> signIn() async {
    try {
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'user@gmail.com',
        password: '123456',
      );
      User? user = credential.user;

      if (user != null) {
        // Đăng nhập thành công, thực hiện điều gì đó ở đây
        Navigator.pushNamed(context, '/main-page');
      } else {
        // Người dùng không được trả về hoặc có lỗi khác
        print('Đăng nhập thất bại.');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Không tìm thấy người dùng với địa chỉ email này.');
      } else if (e.code == 'wrong-password') {
        print('Sai mật khẩu cho người dùng này.');
      } else {
        print('Lỗi: ${e.message}');
      }
    } catch (e) {
      print('Lỗi không xác định: $e');
    }
  }
}
