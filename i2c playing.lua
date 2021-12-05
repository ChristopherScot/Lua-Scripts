address = 0x5A  -- MPR121 I2C Address
test = 2     -- temp reg
bus = 0              -- I2C bus
sda, scl = 2, 1   -- Used pins for SDA and SCL
 
-- init I2C Bus   
   i2c.setup(bus, sda, scl, i2c.SLOW)
 
-- MPR121 Communication 
  i2c.start(bus)      
  i2c.address(bus, address, i2c.TRANSMITTER)
  i2c.write(bus, 0xB4)
  i2c.stop(bus)

  i2c.start(bus)
  i2c.address(bus, address, i2c.RECEIVER)
  c=i2c.read(bus, 0xB5)
  i2c.stop(bus)

print(c)