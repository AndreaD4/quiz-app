class PoweroffRaspberryJob < ApplicationJob
  def perform(*args)
    `echo raspberry | sudo poweroff`
  end
end