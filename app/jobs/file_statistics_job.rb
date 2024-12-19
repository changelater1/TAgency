class FileStatisticsJob < ApplicationJob
  #include Sidekiq::Job

  def perform(order_id)
    order = Order.find(order_id)
    file_content = order.file.download
    symbols_count = file_content.size
    symbols_count_without_spaces = file_content.gsub(/\s+/, '').size
    words_count = file_content.split(/\s+/).size
    order.update(symbols_count: symbols_count, symbols_count_without_spaces: symbols_count_without_spaces, words_count: words_count)

  end

  
end