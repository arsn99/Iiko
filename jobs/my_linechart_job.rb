load 'Iiko.rb'
 puts "LINEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
iiko = Iiko::IikoRequests.new
iiko.GetToken()
data = iiko.IikoPostRequest()

points= []
la = []
DishDiscountSumInt = []
labels = ['January', 'February', 'March', 'April', 'May', 'June', 'July','Aug']

data['data'].each do |iikos|
	  points << { x:iikos['Mounth'][0..1].to_i , y: iikos['DishDiscountSumInt.average'] }
	  
end

points.each do |i|
	DishDiscountSumInt<<i[:y]
end
puts DishDiscountSumInt
points.each do |i|
	la<<labels[i[:x]-1]
end

SCHEDULER.every '10s', :first_in => 0 do |job|

  data = [
    {
      label: '2018',
      data: DishDiscountSumInt,
      backgroundColor: [ 'rgba(255, 99, 132, 0.2)' ] * la.length,
      borderColor: [ 'rgba(255, 99, 132, 1)' ] * la.length,
      borderWidth: 1,
    }, {
      label: '2019',
      data: Array.new(la.length) { rand(40..80) },
      backgroundColor: [ 'rgba(255, 206, 86, 0.2)' ] * la.length,
      borderColor: [ 'rgba(255, 206, 86, 1)' ] * la.length,
      borderWidth: 1,
    }
  ]

  send_event('linechart', { labels: la, datasets: data })
end