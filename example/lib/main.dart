// ignore_for_file: avoid_print

import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expand Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expand Widget'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    'Expand Text',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  const ExpandText(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam suscipit risus pulvinar, hendrerit nisi quis, vehicula ante. Morbi ut diam elit. Praesent non justo sodales, auctor lacus id, congue massa. Duis ac odio dui. Sed sed egestas metus. Donec hendrerit velit magna. Vivamus elementum, nulla ac tempor euismod, erat nunc mollis diam, nec consequat nisl ex eu tellus. Curabitur fringilla enim at lorem pulvinar, id ornare tellus aliquam. Cras eget nibh tempor lacus aliquam rutrum.',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    'Expand Child',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    child: const Text('Button0'),
                    onPressed: () => print('Pressed button0'),
                  ),
                  ExpandChild(
                    child: Column(
                      children: [
                        OutlinedButton(
                          child: const Text('Button1'),
                          onPressed: () => print('Pressed button1'),
                        ),
                        OutlinedButton(
                          child: const Text('Button2'),
                          onPressed: () => print('Pressed button2'),
                        ),
                        OutlinedButton(
                          child: const Text('Button3'),
                          onPressed: () => print('Pressed button3'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    'Expand Child Horizontally',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        OutlinedButton(
                          child: const Text('Button'),
                          onPressed: () => print('Pressed button0'),
                        ),
                        ExpandChild(
                          expandDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(
                                4,
                                (index) => OutlinedButton(
                                  child: Text('Button$index'),
                                  onPressed: () =>
                                      print('Pressed button$index'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    'Custom icon & text',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    child: const Text('Button0'),
                    onPressed: () => print('Pressed button0'),
                  ),
                  ExpandChild(
                    hideIndicatorOnExpand: true,
                    indicatorIconColor: Colors.red,
                    indicatorIconSize: 40,
                    expandIndicatorStyle: ExpandIndicatorStyle.both,
                    indicatorIcon: Icons.cake,
                    indicatorHintTextStyle: const TextStyle(fontSize: 16),
                    child: Column(
                      children: [
                        OutlinedButton(
                          child: const Text('Button1'),
                          onPressed: () => print('Pressed button1'),
                        ),
                        OutlinedButton(
                          child: const Text('Button2'),
                          onPressed: () => print('Pressed button2'),
                        ),
                        OutlinedButton(
                          child: const Text('Button3'),
                          onPressed: () => print('Pressed button3'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    'Custom widget',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    child: const Text('Button0'),
                    onPressed: () => print('Pressed button0'),
                  ),
                  ExpandChild(
                    indicatorIconColor: Colors.red,
                    indicatorIconSize: 40,
                    expandIndicatorStyle: ExpandIndicatorStyle.both,
                    indicatorIcon: Icons.cake,
                    indicatorHintTextStyle: const TextStyle(fontSize: 16),
                    indicatorBuilder: (context, onTap, expanded) => InkWell(
                      onTap: onTap,
                      child: FlutterLogo(
                        style: expanded
                            ? FlutterLogoStyle.horizontal
                            : FlutterLogoStyle.stacked,
                        size: 50,
                      ),
                    ),
                    child: Column(
                      children: [
                        OutlinedButton(
                          child: const Text('Button1'),
                          onPressed: () => print('Pressed button1'),
                        ),
                        OutlinedButton(
                          child: const Text('Button2'),
                          onPressed: () => print('Pressed button2'),
                        ),
                        OutlinedButton(
                          child: const Text('Button3'),
                          onPressed: () => print('Pressed button3'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
