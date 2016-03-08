$HEADER$
import UIKit

class $CLASS$: UIViewController, StoryboardNameProtocol {

    static var storyboardName: StoryboardType {
        return .$STORYBOARD$
    }

    @IBOutlet weak private var sampleButton: UIButton!

    var sampleClosure: VoidClosure?

    // MARK: VC Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeAppearance()

        guard
            let _ = sampleClosure
        else {
            assertionFailure()
            return
        }
    }

    // MARK: Appearance

    private func customizeAppearance() {
        // TODO: implementation
    }

    // MARK: Actions

    @IBAction func didTapSampleButton(sender: AnyObject) {
        sampleClosure?()
    }

}
