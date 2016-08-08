module SessionsHelper

	# Cart
	#Cart Contents
    def cart_contents
        products = @session[:cart][:products]

        if (products && products != {})

            #Determine Quantities
            quantities = Hash[products.uniq.map {|i| [i, products.count(i)]}]

            #Get products from DB
            products_array = Product.find(products.uniq)

            #Create Qty Array
            products_new = {}
            products_array.each{
                |a| products_new[a] = {"qty" => quantities[a.id.to_s]}
            }

            #Output appended
            return products_new

        end

    end
end
