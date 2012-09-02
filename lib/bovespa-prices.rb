require 'httpclient'
require 'nokogiri'

class Bovespa
	VERSION = "1.0.2"

	class Stock
		attr_accessor :code, :name, :date, :opening_price, :min_price, :max_price, :average_price, :last_price, :variation

		def to_s
			"#{@code} - '#{@name}' #{@opening_price} #{@min_price} #{@max_price} #{@average_price} #{@last_price} #{@variation}"
		end
	end

	def get *stock_codes
		result = Hash.new

		xml = Nokogiri.XML(HTTPClient.new.get_content("http://www.bmfbovespa.com.br/Pregao-Online/ExecutaAcaoAjax.asp?intEstado=1&CodigoPapel=#{URI.escape(stock_codes.join('|'))}"))
		xml.search('Papel').each do |p|
			st = Stock.new
			st.name = p['Nome']
			st.date = p['Data']
			st.opening_price = p['Abertura'].gsub(',','.').to_f
			st.min_price = p['Minimo'].gsub(',','.').to_f
			st.max_price = p['Maximo'].gsub(',','.').to_f
			st.average_price = p['Medio'].gsub(',','.').to_f
			st.last_price = p['Ultimo'].gsub(',','.').to_f
			st.variation = p['Oscilacao'].gsub(',','.').to_f
			st.code = p['Codigo']

			result[st.code.to_sym] = st
		end

		return (stock_codes.size > 1 ? result : result[stock_codes.first])
	end
end