def temperature_closest_to_zero(temperatures)
  0
end

def temperature_closest_to_zero(temperatures)
  return 0 if temperatures == []
  temperatures[0]
end

def temperature_closest_to_zero(temperatures)
  return 0 if temperatures == []
  temperatures.min
end

def temperature_closest_to_zero(temperatures)
  return 0 if temperatures == []
  abs_temperatures = []
  for index in 0..temperatures.size-1 do
    abs_temperatures << temperatures[index].abs
  end
  abs_temperatures.min
end

def temperature_closest_to_zero(temperatures)
  return 0 if temperatures == []
  abs_temperatures = []
  for index in 0..temperatures.size-1 do
    abs_temperatures << temperatures[index].abs
  end
  closest_abs_temperature = abs_temperatures.min
  temperatures[abs_temperatures.index(closest_abs_temperature)]
end

def temperature_closest_to_zero(temperatures)
  return 0 if temperatures == []
  abs_temperatures = []
  for index in 0..temperatures.size-1 do
    abs_temperatures << temperatures[index].abs
  end
  closest_abs_temperature = abs_temperatures.min
  temperatures[abs_temperatures.rindex(closest_abs_temperature)]
end

def temperature_closest_to_zero(temperatures)
  return 0 if temperatures == []
  temperatures.sort!
  abs_temperatures = []
  for index in 0..temperatures.size-1 do
    abs_temperatures << temperatures[index].abs
  end
  closest_abs_temperature = abs_temperatures.min
  temperatures[abs_temperatures.rindex(closest_abs_temperature)]
end

#~ def temperature_closest_to_zero(temperatures)
  #~ return 0 if temperatures == []
  #~ abs_temperatures = []
  #~ temperatures.each do |temperature|
    #~ abs_temperatures << temperature.abs
  #~ end
  #~ closest_abs_temperature = abs_temperatures.min
  #~ temperatures[abs_temperatures.rindex(closest_abs_temperature)]
#~ end

#~ def temperature_closest_to_zero(temperatures)
  #~ return 0 if temperatures == []
  #~ abs_temperatures = temperatures.map { |temperature| temperature.abs }
  #~ closest_abs_temperature = abs_temperatures.min
  #~ temperatures[abs_temperatures.rindex(closest_abs_temperature)]
#~ end

#~ def temperature_closest_to_zero(temperatures)
  #~ return 0 if temperatures == []
  #~ abs_temperatures = temperatures.map(& :abs)
  #~ closest_abs_temperature = abs_temperatures.min
  #~ temperatures[abs_temperatures.rindex(closest_abs_temperature)]
#~ end

#~ def temperature_closest_to_zero(temperatures)
  #~ return 0 if temperatures == []
  #~ abs_temperatures = temperatures.map(& :abs)
  #~ closest_abs_temperature = abs_temperatures.min
  #~ closest_temperature_index = abs_temperatures.rindex(closest_abs_temperature)
  #~ temperatures[closest_temperature_index]
#~ end




require 'test/unit'

class TestTemperature < Test::Unit::TestCase
	
  def test01
    temperatures = []
    assert_equal 0, temperature_closest_to_zero(temperatures)
  end
  
  def test02
    temperatures = [0]
    assert_equal 0, temperature_closest_to_zero(temperatures)
  end
  
  def test03
    temperatures = [1]
    assert_equal 1, temperature_closest_to_zero(temperatures)
  end
  
  def test04
    temperatures = [3, 2]
    assert_equal 2, temperature_closest_to_zero(temperatures)    
  end
  
  def test05
    temperatures = [4, -5]
    assert_equal 4, temperature_closest_to_zero(temperatures)
  end
  
  def test06
    temperatures = [-6, -7]
    assert_equal -6, temperature_closest_to_zero(temperatures)
  end 

  def test07
    temperatures = [8, -8, -9]
    assert_equal 8, temperature_closest_to_zero(temperatures)
  end 
  
  def test08
    temperatures = [-8, -7, 7, 8]
    assert_equal 7, temperature_closest_to_zero(temperatures)	  
  end
  
  def test09
    temperatures = [1, -2, -8, 4, 5]
    assert_equal 1, temperature_closest_to_zero(temperatures)	  
  end
  
  def test10
    temperatures = [-5, -4, -2, 12, -40, 4, 2, 18, 11, 5]
    assert_equal 2, temperature_closest_to_zero(temperatures)	  
  end  
	
end