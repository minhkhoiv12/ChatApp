import 'package:chatapp/utilities/assets_manager.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  Country selectedCountry = Country(
    phoneCode: '84',
    countryCode: 'VN',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Vietnam',
    example: 'Vietnam',
    displayName: 'Vietnam',
    displayNameNoCountryCode: 'VN',
    e164Key: '',
  );
  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0,),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: LottieBuilder.asset(AssetsMenager.chatBubble),
              ),
              Text(
                'Chat App',
                style: GoogleFonts.openSans(
                  fontSize: 28,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Hãy nhập số điện thoại của bạn chúng tôi sẽ gửi mã xác minh đến số điện thoại của bạn.',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _phoneNumberController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  setState(() {
                    _phoneNumberController.text = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Số điện thoại',
                  hintStyle: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Container(
                    padding: const EdgeInsets.fromLTRB(
                    8.0,
                    12.0,
                    8.0,
                    12.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          countryListTheme: CountryListThemeData(
                            bottomSheetHeight: 400,
                            
                            textStyle: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            inputDecoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Tìm kiếm quốc gia',
                              hintStyle: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                           
                          ),
                          onSelect: (Country country) {
                            setState(() {
                              selectedCountry = country;
                            });
                          },
                        );
                      },
                      child: Text(
                        '${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}',
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      
                    ),
                  ),
                  suffixIcon:  _phoneNumberController.text.length > 9 ? 
                  InkWell(
                     onTap: () {
                             
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ) : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}