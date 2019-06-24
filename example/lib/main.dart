import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expand Widget',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expand Widget')),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Text(
                    'Expand Text',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 8),
                  ExpandText(
                    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Nullam suscipit risus pulvinar, hendrerit nisi quis, vehicula ante. Morbi ut diam elit.
Praesent non justo sodales, auctor lacus id, congue massa. Duis ac odio dui. Sed sed egestas metus. 
Donec hendrerit velit magna. Vivamus elementum, nulla ac tempor euismod, erat nunc mollis diam, nec consequat nisl ex eu tellus.
Curabitur fringilla enim at lorem pulvinar, id ornare tellus aliquam. Cras eget nibh tempor lacus aliquam rutrum.''',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 4),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Text(
                    'Expand Child',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 8),
                  OutlineButton(
                    child: Text('Button0'),
                    onPressed: () => print('Pressed button0'),
                  ),
                  ExpandChild(
                    child: Column(
                      children: <Widget>[
                        OutlineButton(
                          child: Text('Button1'),
                          onPressed: () => print('Pressed button1'),
                        ),
                        OutlineButton(
                          child: Text('Button2'),
                          onPressed: () => print('Pressed button2'),
                        ),
                        OutlineButton(
                          child: Text('Button3'),
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
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Text(
                    'Show Child',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 8),
                  OutlineButton(
                    child: Text('Button0'),
                    onPressed: () => print('Pressed button0'),
                  ),
                  ShowChild(
                    indicator: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "SHOW MORE",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.caption.color,
                        ),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        OutlineButton(
                          child: Text('Button1'),
                          onPressed: () => print('Pressed button1'),
                        ),
                        OutlineButton(
                          child: Text('Button2'),
                          onPressed: () => print('Pressed button2'),
                        ),
                        OutlineButton(
                          child: Text('Button3'),
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
