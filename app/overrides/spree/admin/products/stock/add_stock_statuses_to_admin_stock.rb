Deface::Override.new(
  virtual_path: 'spree/admin/products/stock',
  name: 'add_stock_statuses_to_admin_stock',
  insert_before: '#add_stock_form',
  text: <<-HTML
          <%= render partial: 'spree/admin/products/stock_status' %>
  HTML
)