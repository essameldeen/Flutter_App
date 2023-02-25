import 'package:app_test/layout/news_app/cubit/cubit.dart';
import 'package:app_test/layout/news_app/cubit/states.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: defaultFormField(
                controller: searchController,
                hint: "Enter your Value",
                label: "Search",
                validator: ( value){
                  if(value?.isEmpty==true){
                    return "Search value must not be empty";
                  }
                  return null;
                },
                onChange: (newValue){
                  NewsCubit.get(context).getSearchResult(newValue);
                },
                prefixIcon: Icons.search,
                textInputType: TextInputType.text),
          ),
          Expanded(child: articleBuilder(list)),
        ],),
      );
      } ,
    );
  }
}
