$HEADER$
import UIKit

class $CLASS$: UITableViewController, StoryboardNameProtocol {

    static var storyboardName: StoryboardType {
        return .$STORYBOARD$
    }
    static let CellID = "$CLASS_NO_SUFFIX$CellID"

    private lazy var tableDataSource: $CLASS_NO_SUFFIX$DataSource = {
        return $CLASS_NO_SUFFIX$DataSource()
    }()

    private lazy var tableDelegate: $CLASS_NO_SUFFIX$Delegate = {
        return $CLASS_NO_SUFFIX$Delegate()
    }()

    // MARK: Closures

    var sampleClosure: VoidClosure?

    // MARK: VC Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate
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

}
