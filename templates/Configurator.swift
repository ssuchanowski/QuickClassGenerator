$HEADER$
import UIKit

struct $CLASS$Configurator: VCConfiguratorProtocol {

    let flowManager: FlowManager

    func configure(viewController: $CLASS$) {
        viewController.uiConfigurationClosure = uiConfigurationAction(viewController)
        viewController.sampleClosure = sampleAction(viewController)

        viewController.addNavBarLogo()
    }

    // MARK: Actions

    private func uiConfigurationAction(presenter: $CLASS$) -> VoidClosure {
        return {
            // TODO: implementation
        }
    }

    private func sampleAction(presenter: $CLASS$) -> VoidClosure {
        return {
            // TODO: implementation
        }
    }

}
