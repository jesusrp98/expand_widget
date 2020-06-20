# Expand Widget

[![Package](https://img.shields.io/pub/v/expand_widget.svg?style=for-the-badge)](https://pub.dartlang.org/packages/expand_widget)
[![Build](https://img.shields.io/github/workflow/status/jesusrp98/expand_widget/Flutter%20Package%20CI?style=for-the-badge)](https://github.com/jesusrp98/expand_widget/actions)
[![Patreon](https://img.shields.io/badge/Support-Patreon-orange.svg?style=for-the-badge)](https://www.patreon.com/jesusrp98)
[![License](https://img.shields.io/github/license/jesusrp98/expand_widget.svg?style=for-the-badge)](https://www.gnu.org/licenses/gpl-3.0.en.html)

This Dart package offers developers a streamlined library of Flutter widgets, useful for expanding widgets and text views, when users interact with them.

There are two main 'expand' widgets:

- **Expand Child:** Useful to show more widgets related to the content already visible by the user.
- **Expand Text:** Useful when texts can be quite big for a certain screen. It adds the ability to show the full content when the user wants to.

<p align="center">
  <img src="https://raw.githubusercontent.com/jesusrp98/expand_widget/master/screenshots/0.png" width="300" hspace="4">
  <img src="https://raw.githubusercontent.com/jesusrp98/expand_widget/master/screenshots/1.png" width="300" hspace="4">
</p>

## Features

- The `ExpandArrowStyle` parameter allows you to select various render options, related to the expand arrow itself.
<p align="center">
  <img src="https://raw.githubusercontent.com/jesusrp98/expand_widget/master/screenshots/2.png" width="300" hspace="4">
</p>

- Hide the arrow widget when the view is being expanded, using the `hideArrowOnExpanded` parameter.

- Custimze the arrow widget itself: color, size, padding, icon...
<p align="center">
  <img src="https://raw.githubusercontent.com/jesusrp98/expand_widget/master/screenshots/3.png" width="300" hspace="4">
</p>

- Use custom expanding hint strings! By default, it will use the ones provided by `MaterialLocalizations`.

- Expand text view with swipe-down gestures, using the `expandOnGesture`, which by default is set to `false`.

- You can also customize expand animation duration and curve easilly.

## Example

Here is an example of a simple use of this package, featuring the `ExpandChild` & `ExpandText` widgets.

If you want to take a deeper look at the example, take a look at the [example](https://github.com/jesusrp98/expand_widget/tree/master/example) folder provided with the project.

- **`ExpandChild`**

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

- **`ExpandText`**

```
ExpandText(
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  textAlign: TextAlign.justify,
),
```

## Getting Started

This project is a starting point for a Dart [package](https://flutter.io/developing-packages/), a library module containing code that can be shared easily across multiple Flutter or Dart projects.

For help getting started with Flutter, view our [online documentation](https://flutter.io/docs), which offers tutorials, samples, guidance on mobile development, and a full API reference.

## Built with

- [Flutter](https://flutter.dev/) - Beatiful native apps in record time.
- [Android Studio](https://developer.android.com/studio/index.html/) - Tools for building apps on every type of Android device.
- [Visual Studio Code](https://code.visualstudio.com/) - Code editing. Redefined.

## Authors

- **Jesús Rodríguez** - you can find me on [GitHub](https://github.com/jesusrp98), [Twitter](https://twitter.com/jesusrp98) & [Reddit](https://www.reddit.com/user/jesusrp98).
- Huge thanks to [James McIntosh](https://github.com/JamesMcIntosh) for his support!

## License

This project is licensed under the GNU GPL v3 License - see the [LICENSE](LICENSE) file for details.
