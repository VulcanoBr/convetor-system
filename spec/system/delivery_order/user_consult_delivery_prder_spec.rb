require 'rails_helper'

describe 'Usuario consulta Codigo de Rastreio' do

    it 'pesquisa codigo de rastreamento com sucesso e sem data de entrega' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :active)

        order = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: 12345678901, sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: 62429965704, recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :in_delivery)

        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        vehicle = Vehicle.find_by("maximum_load >= ? AND status = ?", order.weight, 0)
        
        DeliveryOrder.create!(code: 'XXX1234567890XX', deadline_hours: '98', delivery_fee: '13',
           km_price: '10', amount: '23', delivery_forecast: '2023-02-09', delivery_date: '', delivery_reason:'xxxx',
            status: :in_delivery, closure_status: '0', order_id: order.id, mode_transport_id: mod1.id, vehicle_id: vehicle2.id)
        
        dev = DeliveryOrder.where(code: "XXX1234567890XX")

        # Act
        visit root_path
        fill_in 'Codigo de Rastreio', with: 'XXX1234567890XX'
        click_on 'Pesquisar'

        # Assert
        expect(current_path).to eq pesq_budget_delivery_order_index_path
        expect(page).to have_content("Codigo do Rastreio: XXX1234567890XX")
        expect(page).to have_content('Remetente')
        expect(page).to have_content('Rua São Siva, 100, Rubens Jardim - Macarena - AM - 45987-876')
        expect(page).to have_content('Destinatario')
        expect(page).to have_content('Avenida Silva, 1200,São Roque - Mateuzinho - GO - 76987-345')
        expect(page).to have_content('Veiculo')
        expect(page).to have_content('Vitara For You - Suzuki / 2018 placa: XYZ-9268')

        expect(page).to have_content('Previsão de Entrega')
        expect(page).to have_content('09/02/2023')

        expect(page).not_to have_content('Data da Entrega')
        expect(page).not_to have_content('19/02/2023')

        expect(page).not_to have_content("Codigo de Rastreio #{"XXXX"} não encontrado !!!")

        expect(page).to have_content('Sair')
    end

    it 'pesquisa codigo de rastreamento com sucesso e com data de entrega' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :active)

        order = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: 12345678901, sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: 62429965704, recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :in_delivery)

        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        vehicle = Vehicle.find_by("maximum_load >= ? AND status = ?", order.weight, 0)
        
        DeliveryOrder.create!(code: 'XXX1234567890XX', deadline_hours: '98', delivery_fee: '13',
           km_price: '10', amount: '23', delivery_forecast: '2023-02-09', delivery_date: '2023-02-13', delivery_reason:'xxxx',
            status: :in_delivery, closure_status: '0', order_id: order.id, mode_transport_id: mod1.id, vehicle_id: vehicle2.id)
        
        dev = DeliveryOrder.where(code: "XXX1234567890XX")

        # Act
        visit root_path
        fill_in 'Codigo de Rastreio', with: 'XXX1234567890XX'
        click_on 'Pesquisar'

        # Assert
        expect(current_path).to eq pesq_budget_delivery_order_index_path
        expect(page).to have_content("Codigo do Rastreio: XXX1234567890XX")
        expect(page).to have_content('Remetente')
        expect(page).to have_content('Rua São Siva, 100, Rubens Jardim - Macarena - AM - 45987-876')
        expect(page).to have_content('Destinatario')
        expect(page).to have_content('Avenida Silva, 1200,São Roque - Mateuzinho - GO - 76987-345')
        expect(page).to have_content('Veiculo')
        expect(page).to have_content('Vitara For You - Suzuki / 2018 placa: XYZ-9268')

        expect(page).to have_content('Previsão de Entrega')
        expect(page).to have_content('09/02/2023')

        expect(page).to have_content('Data da Entrega')
        expect(page).to have_content('13/02/2023')

        expect(page).not_to have_content("Codigo de Rastreio #{"XXXX"} não encontrado !!!")

        expect(page).to have_content('Sair')
    end

    it 'pesquisa codigo de rastreamento sem sucesso' do

        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        mod1 = ModeTransport.create!(name: 'Entrega Rapida', minimum_distance: 0, maximum_distance: 500, 
            minimum_weight: 0, maximum_weight: 200, delivery_fee: 10.0, status: :active)
        mod2 = ModeTransport.create!(name: 'Entrega Expressa', minimum_distance: 0, maximum_distance: 100, 
                minimum_weight: 0, maximum_weight: 10, delivery_fee: 50.0, status: :active)

        deadline1 = Deadline.create!(start_distance:0, final_distance: 100, deadline_hours: 24, mode_transport_id: mod1.id)
        deadline2 = Deadline.create!(start_distance:101, final_distance: 300, deadline_hours: 48,mode_transport_id: mod1.id)
        deadline3 = Deadline.create!(start_distance:301, final_distance: 1300, deadline_hours: 72, mode_transport_id: mod1.id)

        price1 = Price.create!(start_weight:0, final_weight: 100, km_price: 0.24, mode_transport_id: mod1.id)
        price2 = Price.create!(start_weight:101, final_weight: 300, km_price: 0.48,mode_transport_id: mod1.id)
        price3 = Price.create!(start_weight:301, final_weight: 600, km_price: 0.72, mode_transport_id: mod1.id)

        order = Order.create!(code: 'XXX1234567890XX', product_code: 'Produto_A', description: 'Produto não perecivel', 
            height: 15, width: 20, depth: 5, weight: 10, distance: 450, user_id: usuario.id,
            sender_name: 'Joaquim Severo', sender_identification: 12345678901, sender_email: 'joaquim@email.com',
            sender_phone: '21 988975959', sender_address: 'Rua São Siva, 100, Rubens Jardim', sender_city: 'Macarena', 
            sender_state: 'AM', sender_zipcode: '45987-876', recipient_name: 'Lilian Monteiro', 
            recipient_identification: 62429965704, recipient_email: 'lili@email.com', recipient_phone: '21 988887676',
            recipient_address: 'Avenida Silva, 1200,São Roque', recipient_city: 'Mateuzinho', recipient_state: 'GO', 
            recipient_zipcode: '76987-345', status: :in_delivery)

        calc = ModeTransport.where("minimum_distance <= #{order.distance} AND maximum_distance >= #{order.distance}")
            .and(ModeTransport.where("minimum_weight <= #{order.weight} AND maximum_weight >= #{order.weight}" ))
            
        res = Price.where(mode_transport_id:  calc.ids )
            .and(Price.where("start_weight <= #{order.weight} AND final_weight >= #{order.weight}" ))
           
        des = Deadline.where(mode_transport_id:  calc.ids )
            .and(Deadline.where("start_distance <= #{order.distance} AND final_distance >= #{order.distance}" ))

        category1 = Category.create!(name: 'Carro')
        vehicle1 = Vehicle.create!(nameplate:'XYZ-3454', brand: 'Ford', vehicle_model: 'Mustang GTX', 
                    year_manufacture: '2020', maximum_load: 950, category: category1, status: :in_operation)
        vehicle2 = Vehicle.create!(nameplate:'XYZ-9268', brand: 'Suzuki', vehicle_model: 'Vitara For You', 
                        year_manufacture: '2018', maximum_load: 800, category: category1, status: :in_operation)
        vehicle = Vehicle.find_by("maximum_load >= ? AND status = ?", order.weight, 0)
        codigo_atual = order.code
        DeliveryOrder.create!(code: 'XXX1234567890XX', deadline_hours: '98', delivery_fee: '13',
           km_price: '10', amount: '23', delivery_forecast: '2023-02-09', delivery_date: '2023-02-13', delivery_reason:'xxxx',
            status: :in_delivery, closure_status: '0', order_id: order.id, mode_transport_id: mod1.id, vehicle_id: vehicle2.id)
        
        dev = DeliveryOrder.where(code: "XXX1234XX")

        # Act
        visit root_path
        fill_in 'Codigo de Rastreio', with: 'XXX123XX'
        click_on 'Pesquisar'

        # Assert
        expect(current_path).to eq pesq_budget_delivery_order_index_path

        expect(page).to have_content("Codigo de Rastreio #{"XXX123XX"} não encontrado !!!")

        expect(page).to have_content('Sair')
    end


end

