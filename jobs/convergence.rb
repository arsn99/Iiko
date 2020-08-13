load 'Iiko.rb'
 
iiko = Iiko::IikoRequests.new
iiko.GetToken()
data = iiko.IikoPostRequest()
points= []

data['data'].each do |iikos|
	  points << { x:iikos['Mounth'][0..1].to_i , y: iikos['DishDiscountSumInt.average'] }
end

SCHEDULER.every '10s', :first_in => 0 do |job|
	send_event('convergence', points: points)
end