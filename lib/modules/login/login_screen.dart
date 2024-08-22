import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/shop_layout.dart';
import 'package:shop/modules/register/register_screen.dart';
import 'package:shop/shared/bloc/login_cubit/login_cubit.dart';
import 'package:shop/shared/bloc/login_cubit/login_states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper/cache_helper.dart';

import '../../shared/network/local/shared_keys/shared_keys.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            if(state.loginModel?.status==true){
              showToast(message:state.loginModel?.message??'', state:ToastStates.success);
              CacheHelper.setData(key: 'token', value:state.loginModel?.data?.token)?.then((value){
                SharedKeys.token=state.loginModel?.data?.token;
                navigateToAndFinish(context,const ShopLayout());
              });

            }else{
              showToast(message:state.loginModel?.message??'', state:ToastStates.error);
            }
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: LoginCubit.get(context).formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),),Text('Login Now To Browse Our Hot Offers',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),),
                        const SizedBox(height: 40,),
                        textFormFieldCustom(
                          controller: LoginCubit.get(context).emailController,
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            prefix:Icons.email_outlined,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Email Can\'t be Empty';
                              }
                              return null;
                            }),
                        const SizedBox(height: 20,),
                        textFormFieldCustom(
                          obscureText:LoginCubit.get(context).isPassword,
                          onFieldSubmitted: (value){
                            if(LoginCubit.get(context).formKey.currentState!.validate()){
                              LoginCubit.get(context).userLogin(email:LoginCubit.get(context).emailController.text,
                                  password:LoginCubit.get(context).passwordController.text);
                            }
                          },
                          controller: LoginCubit.get(context).passwordController,
                            label: 'Password',
                            keyboardType: TextInputType.visiblePassword,
                            suffix: LoginCubit.get(context).passwordSuffix,
                            prefix: Icons.lock_outline_rounded,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Password Can\'t be Empty';
                              }
                              return null;
                            },
                            onSuffixPressed: (){
                            LoginCubit.get(context).changePasswordSuffixIcon();
                            }),
                        const SizedBox(height: 30,),
                        (state is LoginLoadingState)?
                        const Center(child: CircularProgressIndicator(color: Colors.deepOrange,),):
                        buildingElevatedButton(onPressed:(){
                          if(LoginCubit.get(context).formKey.currentState!.validate()){
                            LoginCubit.get(context).userLogin(email:LoginCubit.get(context).emailController.text,
                                password:LoginCubit.get(context).passwordController.text);
                          }
                        },buttonLabel: 'Login'),
                        const SizedBox(height: 20,),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t Have an Account?',style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ) ,),
                            TextButton(onPressed:(){
                              navigateTo(context,const RegisterScreen());
                            }, child:const Text('Register',style: TextStyle(color: Colors.deepOrange),))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
