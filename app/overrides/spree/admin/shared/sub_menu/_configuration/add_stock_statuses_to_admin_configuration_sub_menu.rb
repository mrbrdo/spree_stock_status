Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_configuration',
  name: 'add_stock_statuses_to_admin_configuration_sub_menu',
  insert_bottom: '#sidebar-configuration',
  partial: 'spree/admin/stock_statuses_menu_button'
)