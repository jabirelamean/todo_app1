import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app1/test/cubit/cubit.dart';
import 'package:todo_app1/test/cubit/states.dart';

class Counter extends StatelessWidget {
  Counter({Key? key}) : super(key: key);

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state){},
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              title: Text('Counter'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: IconButton(
                      onPressed: (){
                        CounterCubit.get(context).plus();
                      },
                      icon: Icon(Icons.add,
                        size: 40,),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${CounterCubit.get(context).counter}',
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: (){
                        CounterCubit.get(context).minus();
                      },
                      icon: Icon(Icons.arrow_right_alt,
                        size: 40,),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
