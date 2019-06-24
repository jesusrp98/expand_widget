
# Expand Widget
[![Package](https://img.shields.io/pub/v/expand_widget.svg?style=for-the-badge)](https://pub.dartlang.org/packages/expand_widget)
[![License](https://img.shields.io/github/license/jesusrp98/expand_widget.svg?style=for-the-badge)](https://www.gnu.org/licenses/gpl-3.0.en.html)
[![Stars](https://img.shields.io/github/stars/jesusrp98/expand_widget.svg?style=for-the-badge)](https://github.com/jesusrp98/expand_widget/stargazers)
[![PayPal](https://img.shields.io/badge/Donate-PayPal-blue.svg?style=for-the-badge)](https://www.paypal.com/paypalme/my/profile)
[![Patreon](https://img.shields.io/badge/Support-Patreon-orange.svg?style=for-the-badge)](https://www.patreon.com/jesusrp98)

This Dart package offers developers a streamlined library of Flutter widgets, useful for expanding general & text widgets, when user wishes.

When the users clicks the 'expand' arrow, the hidden widgets or content unfold with a cool animation.

There are two main 'expand' widgets:
* **Expand Child:** Useful to show more widgets related to the content already visible by the user.
* **Expand Text:** Useful when texts can be quite big for a small screen. It adds the ability to show the full content if the user wants to.
* **Show Child:** In contrast to the 'Expand Child' widget, it doesn't have the ability to hide again the content.

<p align="center">
  <img src="https://raw.githubusercontent.com/jesusrp98/expand_widget/master/screenshots/0.png" width="300" hspace="4">
  <img src="https://raw.githubusercontent.com/jesusrp98/expand_widget/master/screenshots/1.png" width="300" hspace="4">
  <img src="https://raw.githubusercontent.com/jesusrp98/expand_widget/master/screenshots/2.png" width="300" hspace="4">
</p>

## Example
Here is an example of a simple use of this package, from the `ExpandChild`, `ExpandText` & `ShowChild` widgets. If you want to take a deeper look at the example, take a look at the [example/](https://github.com/jesusrp98/expand_widget/tree/master/example) folder provided with the project.
```
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
```
```
ExpandText(
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  textAlign: TextAlign.justify,
),
```
```
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
```

## Getting Started
This project is a starting point for a Dart [package](https://flutter.io/developing-packages/), a library module containing code that can be shared easily across multiple Flutter or Dart projects.

For help getting started with Flutter, view our [online documentation](https://flutter.io/docs), which offers tutorials, samples, guidance on mobile development, and a full API reference.

## Built with
* [Flutter](https://flutter.io/) - Beatiful native apps in record time.
* [Android Studio](https://developer.android.com/studio/index.html/) - Tools for building apps on every type of Android device.
* [Visual Studio Code](https://code.visualstudio.com/) - Code editing. Redefined.

## Authors
* **Jesús Rodríguez** - you can find me on [GitHub](https://github.com/jesusrp98), [Twitter](https://twitter.com/jesusrp98) & [Reddit](https://www.reddit.com/user/jesusrp98).

## License
This project is licensed under the GNU GPL v3 License - see the [LICENSE.md](LICENSE.md) file for details.
