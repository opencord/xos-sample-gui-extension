class DashboardExtensionComponent {
  static $inject = ['XosSidePanel'];

  constructor(
    private XosSidePanel: any
  ) {
  }
}

export const xosDashboardExtensionComponent: angular.IComponentOptions = {
  template: require('./dashboard-extension.html'),
  controllerAs: 'vm',
  controller: DashboardExtensionComponent
};
