import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/model/register_model/register_model.dart';
import 'package:shop/shared/bloc/register_cubit/register_states.dart';

import '../../network/remote/Dio_Helper/dio_helper.dart';
import '../../network/remote/Dio_Helper/endpoints/endpoints.dart';
class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(RegisterInitialState());
  static RegisterCubit get(context)=>BlocProvider.of<RegisterCubit>(context);
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  IconData passwordSuffix=Icons.visibility;
  bool isPassword=true;
  RegisterModel? registerModel;
  var formKey=GlobalKey<FormState>();
  void changePasswordSuffixIcon(){
    isPassword=!isPassword;
    passwordSuffix=isPassword?passwordSuffix=Icons.visibility:Icons.visibility_off;
    emit(ChangePasswordSuffixIconState());
  }
  void userRegister({required String email,required String password,required String name,required String phone}){
    emit(RegisterLoadingState());
    DioHelper.postData(path:Endpoints.register, body:{
      'name':name,
      'phone':phone,
      'email':email,
      'password':password
    }).then((value){
      registerModel=RegisterModel.fromJson(value.data);
      print(value.data);
      emit(RegisterSuccessState(registerModel:registerModel));
    }).catchError((error){
      emit(RegisterErrorState());
    });
  }
}