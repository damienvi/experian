module Experian
  module CreditProfile
    class Client < Experian::Client

      def credit_profile(options = {})
        assert_credit_profile_options(options)
        @request = Request.new(options)
        @response = Response.new(submit_request)
      end

      def assert_credit_profile_options(options)
        return if options[:first_name] && options[:last_name] && options[:ssn]
        return if options[:first_name] && options[:last_name] && options[:street] && options[:zip]
        raise Experian::ArgumentError, "Required options missing: first_name, last_name, ssn OR first_name, last_name, street, zip"
      end
    end
  end
end