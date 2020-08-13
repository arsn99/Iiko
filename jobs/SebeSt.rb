load 'Iiko.rb'
 puts "SEBESSSSSSSSSSSSSSSSSSSS"
iiko = Iiko::IikoRequests.new
iiko.GetToken()
data = iiko.IikoPostRequestForSebesToday()
current_valuation = 0
current_karma = 0

SCHEDULER.every '5s' do
  last_valuation = current_valuation
  today = data['data'][1]['ProductCostBase.Profit']
  yesterday = data['data'][0]['ProductCostBase.Profit'].to_s+"$" 
  send_event('valuation', { current: today, last: yesterday,moreinfo:yesterday.to_s})
end