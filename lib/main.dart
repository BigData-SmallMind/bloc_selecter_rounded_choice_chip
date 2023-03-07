import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morphing_widgets/main_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<MyHomePageCubit>(
            create: (_) => MyHomePageCubit(),
            child: Container(
              width: 300,
              height: 300,
              color: Colors.blue,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Row(children: [
                  ...Tag.values
                      .map(
                        (tag) => _TagChip(
                          tag: tag,
                        ),
                      )
                      .toList(),
                ]),
              ),
            )),
      ),
    );
  }
}

enum Tag { life, happiness, work, nature, science, love, funny }

class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.tag,
    Key? key,
  }) : super(key: key);

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MyHomePageCubit, MyHomePageState, List<Tag>?>(
      selector: (state) {
        return state.tagList;
      },
      builder: (context, tagList) {
        final isSelected =
            tagList?.any((tagElement) => tagElement == tag) ?? false;
        debugPrint('selectedTags::$tagList');
        return RoundedChoiceChip(
          label: tag.toLocalizedString(),
          isSelected: isSelected,
          onSelected: (newValue) {
            _releaseFocus(context);
            final cubit = context.read<MyHomePageCubit>();
            cubit.onTagSelected(isSelected: newValue, tag: tag);
          },
        );
      },
    );
  }
}

class RoundedChoiceChip extends StatelessWidget {
  const RoundedChoiceChip({
    required this.label,
    required this.isSelected,
    this.avatar,
    this.labelColor,
    this.selectedLabelColor,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.onSelected,
    Key? key,
  }) : super(key: key);

  final String label;
  final Widget? avatar;
  final ValueChanged<bool>? onSelected;
  final Color? labelColor;
  final Color? selectedLabelColor;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      shape: const StadiumBorder(
        side: BorderSide(),
      ),
      avatar: avatar,
      label: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? (selectedLabelColor ?? Colors.purple)
              : (labelColor ?? Colors.green),
        ),
      ),
      onSelected: onSelected,
      selected: isSelected,
      backgroundColor: (backgroundColor ?? Colors.purple),
      selectedColor: (selectedBackgroundColor ?? Colors.green),
    );
  }
}

extension on Tag {
  String toLocalizedString() {
    switch (this) {
      case Tag.life:
        return 'life';
      case Tag.happiness:
        return 'happiness';
      case Tag.work:
        return 'work';
      case Tag.nature:
        return 'nature';
      case Tag.science:
        return 'science';
      case Tag.love:
        return 'love';
      case Tag.funny:
        return 'funny';
    }
  }
}

void _releaseFocus(BuildContext context) {
  FocusScope.of(context).unfocus();
}
