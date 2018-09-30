# Custom Modal View Controller

Easy way to present a card-like modal view controller in swift.

## Getting Started

### Installing

1. Add this file to your project.
2. Set the file's target to the project's name.
3. Present this modal view controller as follows:

```
let myViewController = MyViewController(nibName: "MyViewController", bundle: nil, padding: X, radius: X, backgroundBlurStyle: .light, isSwipeToDismissEnabled: true, swipeToDismissDirection: .down)

myViewController(withCalendar: self.calendar!)

self.navigationController?.present(myViewController, animated: true, completion: nil)
```

## Contributing

If you'd like to improve and/or expand the content of this library, feel free to submit pull requests.

## Authors

* **Anthony Krivonos** - *Initial work* - [Portfolio](https://anthonykrivonos.com)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Vicki Shao for all the support and flames! 🔥
