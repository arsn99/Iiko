load 'Iiko.rb'
puts "PIE"
iiko = Iiko::IikoRequests.new
iiko.GetToken()
data = iiko.IikoPostRequestForBuzz()

points= []
la = []
DishDiscountSumInt = []
#labels = ['January', 'February', 'March', 'April', 'May', 'June', 'July','Aug']


data['data'].each do |iikos|
	  points << { type:iikos['PayTypes'] , sum: iikos['DishDiscountSumInt'] }
	  
end
points = points.sort_by { |h| -h[:sum]}

points.each do |i|
	DishDiscountSumInt<<i[:sum]
	la<<i[:type]
end


SCHEDULER.every '10s', :first_in => 0 do |job|

  data = [
    {
      # Create a random set of data for the chart
      data: DishDiscountSumInt ,
      backgroundColor: [
        '#F7464A',
        '#46BFBD',
        '#FDB45C',
		'#FFC000',
		'#FFCE56',
		'#000E56',
		'#FFCE56',
		'#CCCEC6'
      ],
      hoverBackgroundColor: [
        '#FF6384',
        '#36A2EB',
        '#F00056',
		'#FFC000',
		'#FFCE56',
		'#000E56',
		'#FFCE56',
		'#CCCEC6'
      ],
    },
  ]

  send_event('piechart', { labels: la, datasets: data })
end
