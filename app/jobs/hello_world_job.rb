# frozen_string_literal: true
class HelloWorldJob < ApplicationJob
  def perform
    puts 'Hello World!'
  end
end
