load 'Iiko.rb'
 puts "BUUUUUUUUUUUUUUUUUUUUUUUUUUZZZZZ"
def nbsp
  [160].pack('U*')
end
iiko = Iiko::IikoRequests.new
iiko.GetToken()
data = iiko.IikoPostRequestForBuzz()
puts iiko.print()
points= []
la = []
DishDiscountSumInt = []
max = 0

data['data'].each do |iikos|
	  points << { sum:iikos['DishDiscountSumInt'] , type: iikos['PayTypes'], order: iikos['UniqOrderId'] }
	  if iikos['UniqOrderId'].to_s.length>max
		max = iikos['UniqOrderId'].to_s.length
	  end
	  
end

max=max*2+1

points = points.sort_by { |h| -h[:sum]}
la<<{label:"Тип оплаты",value:"Сум./Чек."}
points.each_with_index do |i,k|

	if i[:order].to_s.length%2==1
		@ord=max-(i[:order].to_s.length)*2
	else
		@ord=max-(i[:order].to_s.length)*2
	end
	str = i[:sum].to_s+nbsp+"/"+nbsp*@ord+i[:order].to_s
	la<<{label:(k+1).to_s+". "+i[:type],value:str}	
end




SCHEDULER.every '2s' do 
  send_event('buzzwords', { items: la })
end
puts "KEka"