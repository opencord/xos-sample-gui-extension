class DemoComponent {
  static $inject = ['XosSidePanel', 'XosKeyboardShortcut'];

  constructor(
    private XosSidePanel: any,
    private XosKeyboardShortcut: any
  ) {
    this.XosKeyboardShortcut.registerKeyBinding({
      key: 'v',
      description: 'Alert popup',
      cb: () => {
        alert('This binding is provided by the "xos-sample-gui-extension"');
      },
    }, 'view');
  }

  togglePanel() {
    this.XosSidePanel.injectComponent('xosAlert', {config: {type: 'info'}, show: true}, 'This content is injected by my sample UI extension');
  }

}

export const xosDemoComponent: angular.IComponentOptions = {
  template: require('./demo.html'),
  controllerAs: 'vm',
  controller: DemoComponent
};
