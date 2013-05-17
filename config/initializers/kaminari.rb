WillPaginate.per_page = 20

Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end