class Mocha::Expectation
  attr_reader :cardinality
end

class Mocha::API::HaveReceived
  def description
    "have received :#{@expected_method_name}; #{@expectation.cardinality.mocha_inspect}"
  end
end