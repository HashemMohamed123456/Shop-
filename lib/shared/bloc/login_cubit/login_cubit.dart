import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/bloc/login_cubit/login_states.dart';
import 'package:shop/shared/network/remote/Dio_Helper/dio_helper.dart';
import 'package:shop/shared/network/remote/Dio_Helper/endpoints/endpoints.dart';

import '../../../model/Login_Model/login_model.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of<LoginCubit>(context);
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  LoginModel? loginModel;
void userLogin({required String email,required String password }){
  emit(LoginLoadingState());
  DioHelper.postData(path:Endpoints.login, body:{
    'email':email,
    'password':password
  }).then((value){
    loginModel=LoginModel.fromJson(value.data);
    print(value.data);
    emit(LoginSuccessState(loginModel: loginModel));
  }).catchError((error){
    emit(LoginErrorState(error.toString()));
  });
}
IconData passwordSuffix=Icons.visibility;
bool isPassword=true;
void changePasswordSuffixIcon(){
  isPassword=!isPassword;
  passwordSuffix=isPassword?passwordSuffix=Icons.visibility:Icons.visibility_off;
  emit(ChangePasswordSuffixIconState());
}
}