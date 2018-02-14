require 'nori'

module Experian
  module CreditProfile
    class Response < Experian::Response
      include Experian::CreditProfile::IndicatorCodes
      include Experian::Constants

      attr_writer :xml

      def parse_xml_response
        nori = Nori.new(convert_tags_to: lambda { |tag| tag.snakecase.to_sym })
        nori.parse(@xml)
      end
    end
  end
end