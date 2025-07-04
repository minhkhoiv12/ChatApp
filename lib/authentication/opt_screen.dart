import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  String? otpCode;
  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: GoogleFonts.openSans(
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.grey.shade200,
      border: Border.all(
        color: Colors.transparent,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  'Verification',
                  style: GoogleFonts.openSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'Nhập mã 6 chữ số được gửi đến số',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Số điện thoại của bạn',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 68,
                  child: Pinput(
                    length: 6,
                    controller: controller,
                    focusNode: focusNode,
                    defaultPinTheme: defaultPinTheme,
                    onCompleted: (pin) {
                      setState(() {
                        otpCode = pin;
                      });
                      // verify otp code
                      verifyOTPCode(
                        verificationId: verificationId,
                        otpCode: otpCode!,
                      );
                    },
                    focusedPinTheme: defaultPinTheme.copyWith(
                      height: 68,
                      width: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade200,
                        border: Border.all(
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyWith(
                      height: 68,
                      width: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade200,
                        border: Border.all(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                authProvider.isLoading
                    ? const CircularProgressIndicator()
                    : const SizedBox.shrink(),
                authProvider.isSuccessful
                    ? Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                    : const SizedBox.shrink(),
                authProvider.isLoading
                    ? const SizedBox.shrink()
                    : Text(
                        'Không nhận được mã?',
                        style: GoogleFonts.openSans(fontSize: 16),
                      ),
                const SizedBox(height: 10),
                authProvider.isLoading
                    ? const SizedBox.shrink()
                    : TextButton(
                        onPressed: () {
                          // TODO resend otp code
                        },
                        child: Text(
                          'Resend Code',
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}