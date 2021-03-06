module Experian
  module CreditProfile
    class Request < Experian::Request

      def build_request
        super do |xml|
          xml.tag!('EAI', Experian.eai)
          xml.tag!('DBHost', ConnectCheck.db_host)
          add_reference_id(xml)
          xml.tag!('Request', xmlns: Experian::XML_REQUEST_NAMESPACE, version: '1.0') do
            xml.tag!('Products') do
              xml.tag!('CreditProfile') do
                add_subscriber(xml)
                add_primary_applicant(xml)
                add_account_type(xml)
                add_output_type(xml)
                add_vendor(xml)
                add_options(xml)
              end
            end
          end
        end
      end

      def add_reference_id(xml)
        xml.tag!('ReferenceId', @options[:reference_id]) if @options[:reference_id]
      end

      def add_subscriber(xml)
        xml.tag!('Subscriber') do
          xml.tag!('Preamble', Experian.preamble)
          xml.tag!('OpInitials', Experian.op_initials)
          xml.tag!('SubCode', Experian.subcode)
        end
      end

      def add_primary_applicant(xml)
        xml.tag!('PrimaryApplicant') do
          xml.tag!('Name') do
            xml.tag!('Surname', @options[:last_name])
            xml.tag!('First', @options[:first_name])
            xml.tag!('Middle', @options[:middle_name]) if @options[:middle_name]
            xml.tag!('Gen', @options[:generation_code]) if @options[:generation_code]
          end
          xml.tag!('SSN', @options[:ssn]) if @options[:ssn]

          xml.tag!('CurrentAddress') do
            xml.tag!('Street', @options[:street])
            xml.tag!('City', @options[:city]) if @options[:city]
            xml.tag!('State', @options[:state]) if @options[:state]
            xml.tag!('Zip', @options[:zip])
          end if @options[:zip]

          xml.tag!('PreviousAddress') do
            xml.tag!('Street', @options[:previous_street])
            xml.tag!('City', @options[:previous_city])
            xml.tag!('State', @options[:previous_state])
            xml.tag!('Zip', @options[:previous_zip])
          end if @options[:previous_zip]

          xml.tag!('DriverLicense') do
            xml.tag!('State', @options[:driver_license_state])
            xml.tag!('Number', @options[:driver_license_number])
          end if @options[:driver_license_number]

          xml.tag!('Employment') do
            xml.tag!('Company', @options[:company])
            xml.tag!('Address', @options[:employment_steet])
            xml.tag!('City', @options[:employment_city])
            xml.tag!('State', @options[:employment_state])
            xml.tag!('Zip', @options[:employment_zip])
          end if @options[:employment_zip]

          xml.tag!('Phone') do
            xml.tag!('Number', @options[:phone_number])
            xml.tag!('Type', @options[:phone_type])
          end if @options[:phone_number]

          xml.tag!('Age', @options[:age]) if @options[:age]
          xml.tag!('YOB', @options[:yob]) if @options[:yob]
          xml.tag!('DOB', @options[:dob]) if @options[:dob]
        end
      end

      def add_account_type(xml)
        xml.tag!('AccountType') do
          xml.tag!('Type', @options[:account_type])
          xml.tag!('Terms', @options[:account_terms]) if @options[:account_terms]
          xml.tag!('FullAmount', @options[:account_full_amount]) if @options[:account_full_amount]
          xml.tag!('AbbreviatedAmount', @options[:account_abbreviated_amount]) if @options[:account_abbreviated_amount]
        end if @options[:account_type]
      end

      def add_output_type(xml)
        xml.tag!('OutputType') do # Y
          xml.tag!('XML') do
            xml.tag!('ARFVersion', Experian::ARF_VERSION)
          end
        end
      end

      def add_vendor(xml)
        xml.tag!('Vendor') do
          xml.tag!('VendorNumber', Experian.vendor_number)
        end
      end

      def add_options(xml)
        xml.tag!('Options') do
          xml.tag!('ReferenceNumber', @options[:reference_number])
          xml.tag!('EndUser', @options[:end_user])
        end if @options[:reference_number]
      end
    end
  end
end