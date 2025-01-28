import SwiftUI

public struct LabeledStepper: View {

    public init(
        _ title: String,
        description: String = "",
        value: Binding<Int>,
        in range: ClosedRange<Int> = 0...Int.max,
        longPressInterval: Double = 0.3,
        repeatOnLongPress: Bool = true,
        style: Style = .init()
    ) {
        self.title = title
        self.description = description
        self._value = value
        self.range = range
        self.longPressInterval = longPressInterval
        self.repeatOnLongPress = repeatOnLongPress
        self.style = style
    }

    @Binding public var value: Int

    public var title: String = ""
    public var description: String = ""
    public var range = 0...Int.max
    public var longPressInterval = 0.3
    public var repeatOnLongPress = true

    public var style = Style()

    @State private var timer: Timer?
    private var isPlusButtonDisabled: Bool { value >= range.upperBound }
    private var isMinusButtonDisabled: Bool { value <= range.lowerBound }

    /// Perform the math operation passed into the function on the `value` and `1` each time the internal timer runs
    private func onPress(_ isPressing: Bool, operation: @escaping (inout Int, Int) -> ()) {

        guard isPressing else { timer?.invalidate(); return }

        func action(_ timer: Timer?) {
            operation(&value, 1)
        }

        /// Instant action call for short press action
        action(timer)

        guard repeatOnLongPress else { return }

        timer = Timer.scheduledTimer(
            withTimeInterval: longPressInterval,
            repeats: true,
            block: action
        )
    }

    public var body: some View {

        HStack {
            Text(title)
                .foregroundColor(style.titleColor)

            Text(description)
                .foregroundColor(style.descriptionColor)

            Spacer()

            HStack(spacing: 0) {
                /// - Note: The action will be performed inside the `.onLongPressGesture` modifier.
                Button() { } label: { Image(systemName: "minus") }
                .onLongPressGesture(
                    minimumDuration: 0
                ) {} onPressingChanged: { onPress($0, operation: -=) }
                .frame(width: style.buttonWidth, height: style.height)
                .disabled(isMinusButtonDisabled)
                .foregroundColor(
                    isMinusButtonDisabled
                    ? style.inactiveButtonColor
                    : style.activeButtonColor
                )
                .contentShape(Rectangle())

                Divider()
                    .padding([.top, .bottom], 8)

                Text("\(value)")
                    .foregroundColor(style.valueColor)
                    .frame(width: style.labelWidth, height: style.height)

                Divider()
                    .padding([.top, .bottom], 8)

                /// - Note: The action will be performed inside the `.onLongPressGesture` modifier.
                Button() { } label: { Image(systemName: "plus") }
                .onLongPressGesture(
                    minimumDuration: 0
                ) {} onPressingChanged: { onPress($0, operation: +=) }
                .frame(width: style.buttonWidth, height: style.height)
                .disabled(isPlusButtonDisabled)
                .foregroundColor(
                    isPlusButtonDisabled
                    ? style.inactiveButtonColor
                    : style.activeButtonColor
                    )
                .contentShape(Rectangle())
            }
            .background(style.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .frame(height: style.height)
        }
        .lineLimit(1)
    }
}


// MARK: - Preview

struct LabeledStepper_Previews: PreviewProvider {
    struct Demo: View {
        @State private var value: Int = 0

        var body: some View {
            LabeledStepper(
                "Title",
                description: "description",
                value: $value,
                in: 0...10
            )
        }
    }

    static var previews: some View {
        Demo()
            .padding()
    }
}
