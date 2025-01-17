class Facility
  attr_reader :services,
              :registered_vehicles,
              :name,
              :address,
              :phone
              
  attr_accessor :collected_fees
                
  def initialize(hash)
    @name = hash[:name]
    @address = hash[:address]
    @phone = hash[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    services << service

  end

  def register_vehicle(car)
    return nil unless @services.include?("Vehicle Registration")
    
    if car.antique? 
      @collected_fees += 25
      car.plate_type = :antique
    elsif car.electric_vehicle?
      @collected_fees += 200
      car.plate_type = :ev
    else
      @collected_fees += 100
      car.plate_type = :regular
    end
    car.registration_date = Date.today
    @registered_vehicles << car  
  end

  def administer_written_test(registrant)
    if @services.include?("Written Test") && registrant.age >= 16 && registrant.permit?
      registrant.license_data[:written] = true
      true
    else 
      false
    end
  end

  def administer_road_test(registrant)
    if @services.include?("Road Test") && registrant.license_data[:written] == true
      registrant.license_data[:license] = true
    else
      false
    end
  end

  def renew_drivers_license(registrant)
    if @services.include?('Renew License') && registrant.license_data[:license] == true
      registrant.license_data[:renewed] = true
    else
      false
    end  
  end
end

