import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/layout/shop_layout.dart';
import 'package:shop/model/categories_model/category_model.dart';
import 'package:shop/model/home_model/home_model.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/shared/components/build_product_Item.dart';
import 'package:shop/shared/network/local/cache_helper/cache_helper.dart';
import 'package:shop/shared/network/local/shared_keys/shared_keys.dart';
import '../../model/onboarding_model/onboarding_model.dart';

Widget textFormFieldCustom({
  TextEditingController? controller,
  String? label,
  IconData? prefix,
  IconData? suffix,
  String? Function(String?)? validator,
  TextInputType? keyboardType,
  void Function(String)? onChanged,
  void Function()? onTap,
  void Function()? onSuffixPressed,
void Function(String)? onFieldSubmitted ,
  bool obscureText = false
}
    )
=>TextFormField(
  onTap: onTap,
  onChanged:onChanged ,
  keyboardType:keyboardType ,
  validator: validator,
  controller: controller,
  onFieldSubmitted:onFieldSubmitted ,
  obscureText: obscureText,
  decoration: InputDecoration(
      labelStyle:const TextStyle(
          fontSize: 20,
          color:Colors.grey,
          fontWeight: FontWeight.bold
      ),
      suffixIcon: InkWell(
          onTap:onSuffixPressed,
          child: Icon(suffix)),
      suffixIconColor: Colors.grey,
      prefixIconColor: Colors.grey,
      labelText:label??'',
      prefixIcon: Icon(prefix),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            width: 3,
            color: Colors.blueGrey
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
            width: 2,
            color: Colors.grey
        ),
      ),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
              width: 3,
              color: Colors.red
          )
      )
  ),
);
void navigateTo(context,widget)=>Navigator.push(context,MaterialPageRoute(builder:(context)=>widget));
void navigateToAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:(context)=>widget),(route)=>false);

Widget buildOnboardingItem({OnBoardingModel? model})=>Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(child: Image.network(model?.image??"")),
    Text(model?.title??'',
        style:const TextStyle(
          fontSize: 25,
          color: Colors.black,
        )),
    Text(model?.body??'',
        style:const TextStyle(
          fontSize: 20,
          color: Colors.black,
        )),
  ],
);

List<OnBoardingModel>onboardingScreenContent=[
  OnBoardingModel(
    image: 'https://img.pikbest.com/png-images/20211009/father-and-son-buying-food-in-supermarket_6138962.png!sw800',
    title: 'onboard 1 Title Screen',
    body: 'onboard 1 Screen Body',
  ),OnBoardingModel(
    image: 'https://img.pikbest.com/png-images/20211009/father-and-son-buying-food-in-supermarket_6138962.png!sw800',
    title: 'onboard 2 Title Screen',
    body: 'onboard 2 Screen Body',
  ),OnBoardingModel(
    image: 'https://img.pikbest.com/png-images/20211009/father-and-son-buying-food-in-supermarket_6138962.png!sw800',
    title: 'onboard 3 Title Screen',
    body: 'onboard 3 Screen Body',
  ),
];

Widget buildingElevatedButton({required void Function()? onPressed,String?buttonLabel})=> ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.deepOrange,
      minimumSize: const Size(double.infinity,50),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      )
  ),
  onPressed: onPressed,
  child:Text(buttonLabel??'',style:const TextStyle(color: Colors.white,fontSize: 20) ,) );
void showToast({
  required String message,
  required ToastStates state
})=>Fluttertoast.showToast(
msg:message ,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state: state),
textColor: Colors.white,
fontSize: 16.0
);
enum ToastStates{success,error,warning}
Color chooseToastColor({required ToastStates state}){
  Color color;
  switch(state){
    case ToastStates.success:
      color=Colors.green;
      break;
    case ToastStates.error:
      color=Colors.red;
      break;
    case ToastStates.warning:
      color=Colors.amber;
      break;
  }
  return color;
}

Widget homeBuilder({HomeModel? homeModel,CategoriesModel? categoriesModel})=>SingleChildScrollView(
  child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
    CarouselSlider(items:homeModel?.data?.banners?.map((e)=>Image(image:NetworkImage('${e.image}',),
      fit: BoxFit.cover,width: double.infinity,)).toList(),
        options:CarouselOptions(
          height: 250,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlay: true,
          reverse: false,
          autoPlayInterval:const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(seconds:1 ),
          viewportFraction: 1,
          scrollDirection: Axis.horizontal,
          initialPage: 0,
          enlargeCenterPage: true,
          aspectRatio: 16/10,
          enlargeFactor: 0.2
  
        )),
    const SizedBox(height: 10,),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Categories',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24),),
          const SizedBox(height: 10,),
          SizedBox(height: 100,child: ListView.separated(physics: const BouncingScrollPhysics()
              ,scrollDirection: Axis.horizontal,
              itemBuilder:(context,index)=>buildCategoryItem(model: categoriesModel?.data?.data?[index]), separatorBuilder:(context,index)=>const SizedBox(width: 5,), itemCount:categoriesModel?.data?.data?.length??0)),
          const SizedBox(height: 10,),
          const Text('New Products',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 24),),
        ],
      ),
    ),
    const SizedBox(height: 10,),
    Container(
      color: Colors.grey[300],
      child: GridView.count(
        physics: const BouncingScrollPhysics(),
          childAspectRatio: 1/1.6,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          shrinkWrap: true,
          crossAxisCount:2,
          children: List.generate(homeModel?.data?.products?.length??0,(index)=>
      BuildProductItem(product: homeModel?.data?.products?[index])
      )
      ),
    ),
  ],),
);

Widget buildProductGridView({Products? product,void Function()? onPressed,})=>Container(
  color: Colors.white,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Image(image: NetworkImage('${product?.image}',),height: 200,width: double.infinity,),
    if(product?.discount!=0)Container(color:Colors.green,child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Text('Discount',style: TextStyle(color: Colors.white),),
    ),),
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${product?.name}',maxLines: 2,overflow: TextOverflow.ellipsis,style: const TextStyle(height: 1.3),),
          Row(
            children: [
              Text('${product?.price} EGP',maxLines: 2,overflow: TextOverflow.ellipsis,style: const TextStyle(color:Colors.deepOrange,fontSize: 12),),
              const SizedBox(width: 5,),
              if(product?.discount!=0)Text('${product?.oldPrice}',style: const TextStyle(color: Colors.blueGrey,fontSize: 10,decoration: TextDecoration.lineThrough),),
            const Spacer(),
              IconButton(onPressed:onPressed, icon: CircleAvatar(radius: 15,backgroundColor:product!.inFavorites!?Colors.deepOrange:Colors.grey[300],child:const Icon(Icons.favorite_border_outlined,color: Colors.white,size: 14,)))
            ],
          ),
        ],
      ),
    ),
  ],
  ),
);
Widget buildCategoryItem({DataModel? model})=>Container(
  clipBehavior: Clip.antiAliasWithSaveLayer,
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25)
  ),
  child: Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image: NetworkImage('${model?.image}'),width: 150,height: 100,fit:BoxFit.cover,),
      Container(
        height: 20,
        width:150,
        color: Colors.black.withOpacity(0.7),
        child: Center(child: Text('${model?.name}',style: const TextStyle(color:Colors.white),overflow: TextOverflow.ellipsis,maxLines: 1,)),
      )
    ],
  ),
);
Widget categoryScreenItem({DataModel? model})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: Image.network('${model?.image}',fit: BoxFit.cover,height: 120,width: 120,)),
      const SizedBox(width: 20,),
      Text('${model?.name}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
      const Spacer(),
      IconButton(onPressed:(){}, icon:const Icon(Icons.arrow_forward_ios))
    ],
  ),
);
void signOut(context){
  CacheHelper.removeData(key:'token')?.then((value){
    if(value!){
      navigateToAndFinish(context,const LoginScreen());
    }
  });

}