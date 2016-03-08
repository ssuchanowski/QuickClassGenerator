$HEADER$
import UIKit

struct $CLASS$Configurator: VCConfiguratorProtocol {

    let flowManager: FlowManager

    func configure(viewController: $CLASS$) {
        viewController.sampleClosure = sampledAction(viewController)

        viewController.addNavBarLogo()
    }

    // MARK: Actions

    private func sampleAction(presenter: $CLASS$) -> VoidClosure {
        return {
            // TODO: implementation
        }
    }

}
