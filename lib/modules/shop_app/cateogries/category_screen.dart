import 'package:app_test/layout/shop_app/cubit/shop_home_cubit.dart';
import 'package:app_test/layout/shop_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopHomeStates>(
      listener: (context,state){},
      builder: (context,state){
        return ListView.separated(
            itemBuilder: (context,index)=>buildCategoryItem(
                ShopCubit.get(context).categoriesHomeModel?.data?.data![index].image ??"",
                ShopCubit.get(context).categoriesHomeModel?.data?.data![index].name??""),
            separatorBuilder: (context,index)=> Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(height: 1,color: Colors.grey,),
            ),
            itemCount: ShopCubit.get(context).categoriesHomeModel?.data?.data?.length??0);
      });
  }
  
  Widget buildCategoryItem(String image,String name)=>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
           Image(image: NetworkImage(image),width: 80,height: 80 ,fit: BoxFit.cover,),
          const SizedBox(width: 20,),
          Text(name,style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        const  Spacer(),
         const Icon(Icons.arrow_right)
        ],),
      );
}
