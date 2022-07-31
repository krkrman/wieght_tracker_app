import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wieght_tracker_app/business%20logic/cubits/home_cubit/home_cubit.dart';
import 'package:wieght_tracker_app/data/models/weight_model.dart';
import 'package:wieght_tracker_app/presentation/widgets/common/bordered_form_field.dart';
import 'package:wieght_tracker_app/presentation/widgets/common/custom_button.dart';
import 'package:wieght_tracker_app/presentation/widgets/common/custom_text.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.getWeights();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Weight Tracker'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: IconButton(
                  icon: const Icon(Icons.logout_rounded),
                  onPressed: () => FirebaseAuth.instance.signOut(),
                ),
              ),
            ],
          ),
          body: ListView.builder(
              itemCount: homeCubit.weights.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(homeCubit.weights[index].weight),
                  subtitle: Text(
                    homeCubit.weights[index].dateTime.toString(),
                  ),
                  trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () => updateWeightDialogBox(
                                  context, textEditingController, homeCubit, index),
                              icon: const Icon(Icons.edit_note_outlined)),
                          IconButton(
                              onPressed: () => homeCubit.deleteWeight(homeCubit.weights[index]),
                              icon: const Icon(Icons.delete_forever_outlined))
                        ],
                      )),
                );
              }),
          floatingActionButton: FloatingActionButton(
            onPressed: () => addNewWeightDialogBox(context, textEditingController, homeCubit),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void updateWeightDialogBox(BuildContext context, TextEditingController textEditingController,
      HomeCubit homeCubit, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Enter your weight"),
        content: BorderedFormField(
          prefixIcon: Icons.edit,
          validate: (String? value) {},
          label: 'Weight',
          textInputType: TextInputType.number,
          controller: textEditingController,
        ),
        actions: <Widget>[
          CustomButton(
              text: 'Okay',
              onPressed: () async {
                await homeCubit.addWeight(WeightModel(
                    weight: textEditingController.text, dateTime: homeCubit.weights[index].dateTime));
                debugPrint('here');
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  void addNewWeightDialogBox(
      BuildContext context, TextEditingController textEditingController, HomeCubit homeCubit) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Enter your weight"),
        content: BorderedFormField(
          prefixIcon: Icons.edit,
          validate: (String? value) {},
          label: 'Weight',
          textInputType: TextInputType.number,
          controller: textEditingController,
        ),
        actions: <Widget>[
          CustomButton(
              text: 'Okay',
              onPressed: () async {
                DateTime now = DateTime.now();
                await homeCubit.addWeight(WeightModel(
                    weight: textEditingController.text,
                    dateTime: DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second)));
                debugPrint('here');
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
