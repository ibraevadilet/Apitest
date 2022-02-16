import 'dart:math';

import 'package:api_hw/bloc/getuser_bloc.dart';
import 'package:api_hw/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

final bloc = GetuserBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            bloc.add(GetAllEvent());
          },
          child: const Icon(Icons.download),
        ),
        appBar: AppBar(
          title: const Text("Test Api"),
        ),
        body: BlocBuilder<GetuserBloc, GetUserState>(
          bloc: bloc,
          builder: (context, state) {
            if(state is GetuserLoaded){
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (contex, index) {
                  return ListViewBody(userModel: state.data[index]);
                });
            }else if(state is GetuserLoading){
              const Center(child: CircularProgressIndicator(),);
            } else if(state is  GetuserError){
              Center(child: Text(state.message),);
            }
            return const Center(child: Text("Download data"),);
          },
        ));
  }
}

class ListViewBody extends StatelessWidget {
  const ListViewBody({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          CircleAvatar(
            radius: 70,
            child: Text(
                "${userModel.name?.split(' ').map((e) => e.split('').first).join()}"),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            userModel.address?.street ?? "Adress",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            userModel.phone ?? "Phone",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
