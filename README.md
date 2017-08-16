# xos-sample-gui-extension

## Installation with platform-install

To install an extension, add the following to the profile manifest `.yml` file intended to be deployed in`build/platform-install/`
, and deploy with `ansible-playbook -i inventory/{PROFILE_NAME} deploy-xos-playbook.yml`

```
enabled_gui_extensions:
  - name: sample
    path: orchestration/xos-sample-gui-extension
```

_NOTE: the `name` field must match the subdirectory specified in `conf/app/gulp.conf.js` (eg: `dist/extensions/sample`)_

## Creating an XOS GUI Extension

### Starting Development

To begin development, we recommend copying over this sample extension over to the appropriate area in your file system: 

* If creating a GUI extension to used with a service, create the folder `gui` in the service's `xos` folder as follows: `orchestration/xos_services/service_name/xos/gui/`  
* If creating an independent GUI extension, you can create the folder `xos-gui-extension-name` in the `cord/orchestration` folder.


### Including Extra Files

Additional necessary files (such as stylesheets or config files) can be added to the profile manifest as follows, with `xos-sample-extension/src/` as the root.

```yaml
enabled_gui_extensions:
  - name: sample
    path: orchestration/xos-sample-gui-extension
    extra_files:
      -  app/style/style.css
```

### Generating config files

During development, you may find it necessary to create separate config files in order to include other files used in
your extension (such as images). The path to your extension may vary depending on whether you are running it locally 
(`./xos/extensions/extension-name`) vs. on a container in production (`./extensions/extension-name`).

You can create separate `customconfig.local.js` and `customconfig.production.js` files in the `conf/` folder, and then edit the 
following portion of the appropriate `webpack.conf.js` file as follows:

```js
new CopyWebpackPlugin([
      { from: `./conf/app/app.config.${env}.js`, to: `app.config.js` },
      { from: `./conf/app/style.config.${brand}.js`, to: `style.config.js` },
      // add your file here
      { from: `./conf/app/customconfig.local.js`, to: `customconfig.js`}
    ]),
```

`webpack.conf.js` will be used in a local development environment, such as when running `npm start`

`webpack-dist.conf.js` will be used in a production container after deploying a profile.

### Handy XOS Components and Services

#### XosNavigationService
Used to create custom navigation links in the left navigation panel.

#### XosModelStore
Provides easy access to model ngResources provided by an XOS service. Can be used as follows:

```typescript
import {Subscription} from 'rxjs/Subscription;
export class ExampleComponent {
    static $inject = ['XosModelStore];
    public resource;
    private modelSubscription : Subscription;
    constructor(
      private XosModelStore: any,
    ){}
    
    $onInit() {
        this.modelSubscription = this.XosModelStore.query('SampleModel', '/sampleservice/SampleModels').subscribe(
          res => {
            this.resource = res;
          }
        );
    }
}
export const exampleComponent : angular.IComponentOptions = {
  template: require('./example.component.html'),
  controllerAs: 'vm',
  controller: ExampleComponent
}
```

#### XosKeyboardShortcut
Allows for the creation of custom user keyboard shortcuts. See the provided `components/demo.ts` as an example.

#### XosComponentInjector
Allows for the injection of components into the XOS GUI by specifying a target element ID. Useful IDs include:
* `#dashboard-component-container`: the dashboard as seen on the XOS home
* `#side-panel-container`: a side panel that can slide out from the right. However, there is also a `XosSidePanel` 
service that can make development easier.

#### XosSidePanel
Makes the injection of a custom side panel somewhat easier (no need to specify a target)

