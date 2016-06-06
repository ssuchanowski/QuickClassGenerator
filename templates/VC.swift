$HEADER$
import UIKit

class $CLASS$: UIViewController, StoryboardInstantiable {

    static var storyboardName: StoryboardType {
        return .$STORYBOARD$
    }

    @IBOutlet weak var sampleButton: UIButton!

    var uiConfigurationClosure: VoidClosure?
    var sampleClosure: VoidClosure?

    // MARK: - VC Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeAppearance()
        fireAnalytics()

        guard
            let _ = uiConfigurationClosure,
            let _ = sampleClosure
        else {
            assertionFailure()
            return
        }
    }

    // MARK: - Appearance

    private func customizeAppearance() {
        uiConfigurationClosure?()
    }

    // MARK: - Analytics

    private func fireAnalytics() {
        GoogleAnalyticsHelper.sharedInstance.trackScreen(self)
    }

    // MARK: - Actions

    @IBAction func didTapSampleButton(sender: AnyObject) {
        sampleClosure?()
    }

}
