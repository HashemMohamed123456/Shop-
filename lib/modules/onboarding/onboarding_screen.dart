import 'package:flutter/material.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class OnboardingScreen extends StatefulWidget {
   const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
var onboardingController=PageController();

bool isLastPage=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed:(){
            CacheHelper.setData(key: 'onBoarding', value:true);
            navigateToAndFinish(context,const LoginScreen());
          }, child:const Text('SKIP',style: TextStyle(color: Colors.deepOrange,fontSize:20)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(index==onboardingScreenContent.length-1){
                    setState(() {
                      isLastPage=true;
                    });
                  }else{
                   setState(() {
                     isLastPage=false;
                   });
                  }
                },
                controller: onboardingController,
                physics:const  BouncingScrollPhysics(),
                itemCount:onboardingScreenContent.length,
                itemBuilder:(context,index){
                return buildOnboardingItem(model: onboardingScreenContent[index]);
              },
              ),
            ),
          const SizedBox(height: 40,),
          Row(
            children: [
              SmoothPageIndicator(controller:onboardingController,
                  count:onboardingScreenContent.length,
              effect:const ExpandingDotsEffect(
                dotColor: Colors.blueGrey,
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Colors.deepOrange,
                expansionFactor: 5,
                spacing:5,
              ),),
              const Spacer(),
              FloatingActionButton(onPressed: (){
                if(isLastPage==true){
                  CacheHelper.setData(key: 'onBoarding', value:true);
                 navigateToAndFinish(context,const LoginScreen());
                }
                else{
                  onboardingController.nextPage(duration:const  Duration(
                      milliseconds: 750
                  ), curve:Curves.fastLinearToSlowEaseIn);
                }

              },child: const Icon(Icons.arrow_forward_ios,color: Colors.white,),)
            ],
          )],
        ),
      ),
    );
  }
}
