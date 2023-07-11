import 'package:flutter/material.dart';
import 'package:flutter_kos/shared/shared_preferences.dart';
import 'package:flutter_kos/shared/snackbar.dart';
import 'package:flutter_kos/shared/theme.dart';
import 'package:flutter_kos/ui/pages/menu_page.dart';
import 'package:flutter_kos/ui/pages/widgets/button.dart';
import 'package:flutter_kos/ui/pages/widgets/form.dart';

class SignInpage extends StatelessWidget {
  const SignInpage({super.key});

  void login(BuildContext ctx, String email, String pass) async {
    if (email.isEmpty && pass.isEmpty) {
      CustomSnackBar.showToast(ctx, 'Inputan Masih Kosong!');
    } else {
      String pEmail = await SharedPrefUtils.readEmail();
      String pPassword = await SharedPrefUtils.readPassword();
      if (email == pEmail && pass == pPassword) {
        Navigator.pushNamedAndRemoveUntil(ctx, '/menu', (route) => false);
      } else {
        CustomSnackBar.showToast(ctx, 'Login Gagal!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailCotroller = TextEditingController();
    final TextEditingController passwordCotroller = TextEditingController();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Container(
            width: 350,
            height: 300,
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 30,
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/kostopia.png'),
            )),
          ),
          Text(
            'Sign In & Nikmati\npelayanan untuk anda',
            style: blackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: whiteColor),
            child: Column(
              children: [
                CustomFormField(
                  title: 'Alamat Email',
                  controller: emailCotroller,
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomFormField(
                  title: 'Password',
                  obscureText: true,
                  controller: passwordCotroller,
                ),
                const SizedBox(
                  height: 38,
                ),
                CustomFillButton(
                  title: 'Sign In',
                  onPressed: () {
                    login(
                      context,
                      emailCotroller.text,
                      passwordCotroller.text,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          CustomTextButton(
            title: 'Buat Akun Baru',
            onPressed: () {
              Navigator.pushNamed(context, '/sign-up');
            },
          ),
        ],
      ),
    );
  }
}
