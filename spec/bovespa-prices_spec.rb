require 'simplecov'
SimpleCov.start

require File.expand_path('../../lib/bovespa-prices', __FILE__)

describe Bovespa::Stock do
	let(:stock) { Bovespa::Stock.new }
	let(:stock_to_s) { 

		code = 'VALE5'
		name = 'Vale'
		opening_price = '50'
		min_price = '49'
		max_price = '51.4'
		average_price = '50'
		last_price = '50.45'
		variation = '-2.45'

		"#{code} - '#{name}' #{opening_price} #{min_price} #{max_price} #{average_price} #{last_price} #{variation}"
	}

	[:code, :name, :date, :opening_price, :min_price, :max_price, :average_price, :last_price, :variation].each do |p|
		it "should respond to #{p}" do
			stock.respond_to?(p).should == true
		end

		it "should respond to #{p}=" do
			stock.respond_to?("#{p}=".to_sym).should == true
		end
	end

	it 'should show all informations about stock' do
		code = 'VALE5'
		name = 'Vale'
		opening_price = '50'
		min_price = '49'
		max_price = '51.4'
		average_price = '50'
		last_price = '50.45'
		variation = '-2.45'

		st = Bovespa::Stock.new
		st.code = 'VALE5'
		st.name = 'Vale'
		st.opening_price = '50'
		st.min_price = '49'
		st.max_price = '51.4'
		st.average_price = '50'
		st.last_price = '50.45'
		st.variation = '-2.45'

		st.to_s.include?('VALE5').should == true
		st.to_s.include?('Vale').should == true
		st.to_s.include?('50').should == true
		st.to_s.include?('49').should == true
		st.to_s.include?('51.4').should == true
		st.to_s.include?('50').should == true
		st.to_s.include?('50.45').should == true
		st.to_s.include?('-2.45').should == true
	end
end

describe Bovespa::Stock do
	let(:xml_one){
		'<?xml version="1.0"?>
		 <ComportamentoPapeis>
		 	<Papel Codigo="VALE5" Nome="VALE PNA     N1" Ibovespa="#" Data="31/08/2012 18:59:59" Abertura="32,88" Minimo="32,54" Maximo="33,24" Medio="32,61" Ultimo="33,04" Oscilacao="2,25"/>
		 </ComportamentoPapeis>'
	}
	let(:xml_two){
		'<?xml version="1.0"?>
		<ComportamentoPapeis>
			<Papel Codigo="VALE5" Nome="VALE PNA     N1" Ibovespa="#" Data="31/08/2012 18:59:59" Abertura="32,88" Minimo="32,54" Maximo="33,24" Medio="32,61" Ultimo="33,04" Oscilacao="2,25"/>
			<Papel Codigo="RDCD3" Nome="REDECARD ON      NM" Ibovespa="#" Data="31/08/2012 18:41:32" Abertura="33,88" Minimo="33,52" Maximo="33,88" Medio="33,65" Ultimo="33,56" Oscilacao="-0,71"/>
		</ComportamentoPapeis>'
	}

	it "should parse a xml with one stock from bovespa to one Stock" do
		HTTPClient.any_instance.stub(:get_content).and_return(xml_one)

		result = Bovespa.new.get(:VALE5)

		result.should be_a_kind_of Bovespa::Stock
		result.to_s.should == "VALE5 - 'VALE PNA     N1' 32.88 32.54 33.24 32.61 33.04 2.25"
	end

	it "should parse a xml with two stocks from bovespa to one Stock" do
		HTTPClient.any_instance.stub(:get_content).and_return(xml_two)

		result = Bovespa.new.get(:VALE5, :RDCD3)

		result.should_not be_empty
		result.should be_a_kind_of Hash
		result.size.should == 2
		result.should have_key :VALE5
		result.should have_key :RDCD3

		result[:VALE5].should be_a_kind_of Bovespa::Stock
		result[:VALE5].to_s.should == "VALE5 - 'VALE PNA     N1' 32.88 32.54 33.24 32.61 33.04 2.25"

		result[:RDCD3].should be_a_kind_of Bovespa::Stock
		result[:RDCD3].to_s.should == "RDCD3 - 'REDECARD ON      NM' 33.88 33.52 33.88 33.65 33.56 -0.71"
	end
end