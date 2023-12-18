import 'package:festum_app/login_screen.dart';
import 'package:festum_app/screens/register_sprint.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';



class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Festum - A Cloud Platform',
              body: 'Making Registrations Easier.',
              image: Image(image: AssetImage('images/logosplash.png'),
                height: 250,
                width: 250,
                fit: BoxFit.cover,


              ),
              footer: Center(child: Text("Powered by Saola Innovations Pvt. Limited", style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16,
                  fontStyle: FontStyle.normal))),
              // Image.network("https://assets4.lottiefiles.com/packages/lf20_8hthlleg.json"),
              decoration: getPageDecoration(),
            ),

            PageViewModel(
              title: 'Digitalized transactions',
              body: 'This platform is to use a smart contract to manage all the Registration Payments .',
              // image: Lottie.network(
              //   "https://assets10.lottiefiles.com/packages/lf20_fknfveir.json",
              //   height: 300,
              //   width: 400,
              //   fit: BoxFit.cover,
              //   repeat: false,
              //   animate: true,
              // ),
              decoration: getPageDecoration(),
            ),
            // PageViewModel(
            //   title: 'No security flaws',
            //   body: 'Less exposure to threats and hacking systems ensures higher security of the platform',
            //   footer: Center(child: Text("Let's Get Started", style: TextStyle(
            //       fontWeight: FontWeight.w600,
            //       color: Colors.black,
            //       fontSize: 20,
            //       fontStyle: FontStyle.normal))),
            //   // image: Lottie.network(
            //   //   "https://assets2.lottiefiles.com/packages/lf20_xtwsh33k.json",
            //   //   height: 400,
            //   //   width: 400,
            //   //   fit: BoxFit.cover,
            //   //   repeat: false,
            //   //   animate: true,
            //   // ),
            //   decoration: getPageDecoration(),
            // ),
            PageViewModel(
              title: 'Ask all Your Teammates to Log In to Our Platform',
              body: 'Collect their Respective Unique ID',
              footer: Center(child: Text("That's it. Register Now", style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 20,
                  fontStyle: FontStyle.normal))),
              // image: Lottie.network(
              //   "https://lottie.host/629629cf-58f3-4b2e-bd2d-25a01c23bbdf/1QsYLEvSSL.json",
              //   height: 250,
              //   width: 250,
              //   fit: BoxFit.cover,
              //   repeat: false,
              //   animate: true,
              // ),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Register', style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.white)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text('Skip', style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.white)),
          onSkip: () => goToHome(context),
          next: Icon(Icons.arrow_forward,color: Colors.black,),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Colors.brown,
          //skipFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          showNextButton: true,
          // freeze: true,
          // animationDuration: 1000,
        ),
      ),
    );
  }
    void goToHome(context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => RegisterIoT()),
    );

    Widget buildImage(String path) =>
        Center(child: Image.asset(path, width: 350));

    DotsDecorator getDotDecoration() => DotsDecorator(
      color: Color(0xFF000000),
      activeColor: Color(0xFFFFFFFF),
      //activeColor: Colors.orange,
      size: Size(10, 10),
      activeSize: Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );

    PageDecoration getPageDecoration() => PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 20),
      //descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
      imagePadding: EdgeInsets.all(24),
      pageColor: Colors.white,
    );
  }
