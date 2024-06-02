# LabeledStepper

A native SwiftUI Stepper that shows the value with more features! (like long press to repeat) ;)


<img width="432" alt="Screen Shot 2022-01-13 at 16 16 51" src="https://user-images.githubusercontent.com/15649873/149333025-7f06ccfa-d891-4cba-a661-4e133a0b4e4a.png">


### Features
- [x] Long press to increase or decrease the value automatically
- [x] Change the repeat speed of the long-press
- [x] Limitable range
- [x] Custom theme
- [x] Custom sizing for each component
- [X] Exact same API with the Native SwiftUI.Stepper
- [ ] Enhanced animations

### Using it in a `List` or a `Form`
In Vanilla Swift's behavior, button actions differed and overridden with the row action (which is unexpected in my POV). To make any button (including stepper's buttons) work as expected in a `List` or a `Form`, you need to set the button style to ANYTHING-BUT-THE-AUTOMATIC like:

```
LabeledStepper(
  "Title",
  description: "Description",
  value: $value
)
.buttonStyle(.plain) // 👈 Any style but the `automatic` here.
```
