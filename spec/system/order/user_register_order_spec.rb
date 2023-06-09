require 'rails_helper'

describe 'Usaurio cadastra Pedido de Entrega' do

    
    it 'deve estar autenticado' do
    
        # Arrange

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq new_user_session_path

    end

    it 'e com sucesso' do 

        #Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        allow(SecureRandom).to receive(:alphanumeric).and_return("XXX1234567890XX")
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Criar Ordem de Entrega'

        fill_in 'Codigo Produto', with: 'Codigo produto'
        fill_in 'Descrição', with: 'Descrição'
        fill_in 'Peso', with: '40'
        fill_in 'Altura', with: '35'
        fill_in 'Largura', with: '45'
        fill_in 'Profundidade', with: '10'
        fill_in 'Descrição', with: 'Descrição'
        fill_in 'Nome Remetente', with: 'João da Silva'
        fill_in 'CPF/CNPJ Remetente', with: '62429965704'
        fill_in 'Email Remetente', with: 'silva@email.com'
        fill_in 'Telefone Remetente', with: '21 988975959'
        fill_in 'Endereço Remetente', with: 'Rua sem saida'
        fill_in 'Cidade Remetente', with: 'Rio de Janeiro'
        fill_in 'Estado Remetente', with: 'RJ'
        fill_in 'Cep Remetente', with: '22755-170'
        fill_in 'Nome Destinatario', with: 'Maria da Silva'
        fill_in 'CPF/CNPJ Destinatario', with: '78498924022'
        fill_in 'Email Destinatario', with: 'maria@email.com'
        fill_in 'Telefone Destinatario', with: '21 988972929'
        fill_in 'Endereço Destinatario', with: 'Rua com saida'
        fill_in 'Cidade Destinatario', with: 'Rio de Janeiro'
        fill_in 'Estado Destinatario', with: 'RJ'
        fill_in 'Cep Destinatario', with: '22755-200'
        
        
        fill_in 'Distancia', with: '959'
        click_on 'Salvar'

        # Assert
        expect(page).to have_content('Ordem de Entrega criado com sucesso !!!')
        expect(page).to have_content('Codigo do Pedido: XXX1234567890XX')
        expect(page).to have_content('Codigo Produto: Codigo produto')
        expect(page).to have_content('Descrição: Descrição')
        expect(page).to have_content('Peso: 40')
        expect(page).to have_content('Altura: 35')
        expect(page).to have_content('Largura: 45')
        expect(page).to have_content('Profundidade: 10')
        
        expect(page).to have_content('Nome Remetente: João da Silva')
        expect(page).to have_content('CPF/CNPJ Remetente: 62429965704')
        expect(page).to have_content('Email Remetente: silva@email.com')
        expect(page).to have_content('Telefone Remetente: 21 988975959')
        expect(page).to have_content('Endereço Remetente: Rua sem saida')
        expect(page).to have_content('Cidade Remetente: Rio de Janeiro')
        expect(page).to have_content('Estado Remetente: RJ')
        expect(page).to have_content('Cep Remetente: 22755-170')
        expect(page).to have_content('Nome Destinatario: Maria da Silva')
        expect(page).to have_content('CPF/CNPJ Destinatario: 78498924022')
        expect(page).to have_content('Email Destinatario: maria@email.com')
        expect(page).to have_content('Telefone Destinatario: 21 988972929')
        expect(page).to have_content('Endereço Destinatario: Rua com saida')
        expect(page).to have_content('Cidade Destinatario: Rio de Janeiro')
        expect(page).to have_content('Estado Destinatario: RJ')
        expect(page).to have_content('Cep Destinatario: 22755-200')
      
        expect(page).to have_content('Distancia: 959')
        expect(page).to have_content('Voltar')    
    end

    it 'e sem sucesso, campos obrigatorios' do 

        #Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')
        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Criar Ordem de Entrega'

        fill_in 'Codigo Produto', with: ''
        fill_in 'Peso', with: ''
        fill_in 'Altura', with: ''
        fill_in 'Largura', with: ''
        fill_in 'Profundidade', with: ''
        fill_in 'Descrição', with: ''
        fill_in 'Nome Remetente', with: ''
        fill_in 'CPF/CNPJ Remetente', with: ''
        fill_in 'Email Remetente', with: ''
        fill_in 'Telefone Remetente', with: ''
        fill_in 'Endereço Remetente', with: ''
        fill_in 'Cidade Remetente', with: ''
        fill_in 'Estado Remetente', with: ''
        fill_in 'Cep Remetente', with: ''
        fill_in 'Nome Destinatario', with: ''
        fill_in 'CPF/CNPJ Destinatario', with: ''
        fill_in 'Email Destinatario', with: ''
        fill_in 'Telefone Destinatario', with: ''
        fill_in 'Endereço Destinatario', with: ''
        fill_in 'Cidade Destinatario', with: ''
        fill_in 'Estado Destinatario', with: ''
        fill_in 'Cep Destinatario', with: ''       
        
        fill_in 'Distancia', with: ''
        click_on 'Salvar'

        # Assert
        expect(page).to have_content('Ordem de Entrega NÃO criado !!!')
        expect(page).to have_content('Codigo Produto não pode ficar em branco')
        expect(page).to have_content('Peso não pode ficar em branco')
        expect(page).to have_content('Altura não pode ficar em branco')
        expect(page).to have_content('Largura não pode ficar em branco')
        expect(page).to have_content('Profundidade não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
        expect(page).to have_content('Nome Remetente não pode ficar em branco')
        expect(page).to have_content('CPF/CNPJ Remetente não pode ficar em branco')
        expect(page).to have_content('Email Remetente não pode ficar em branco')
        expect(page).to have_content('Telefone Remetente não pode ficar em branco')
        expect(page).to have_content('Endereço Remetente não pode ficar em branco')
        expect(page).to have_content('Cidade Remetente não pode ficar em branco')
        expect(page).to have_content('Estado Remetente não pode ficar em branco')
        expect(page).to have_content('Cep Remetente não pode ficar em branco')
        expect(page).to have_content('Nome Destinatario não pode ficar em branco')
        expect(page).to have_content('CPF/CNPJ Destinatario não pode ficar em branco')
        expect(page).to have_content('Email Destinatario não pode ficar em branco')
        expect(page).to have_content('Telefone Destinatario não pode ficar em branco')
        expect(page).to have_content('Endereço Destinatario não pode ficar em branco')
        expect(page).to have_content('Cidade Destinatario não pode ficar em branco')
        expect(page).to have_content('Estado Destinatario não pode ficar em branco')
        expect(page).to have_content('Cep Destinatario não pode ficar em branco')
      
        expect(page).to have_content('Distancia não pode ficar em branco')        
           
    end

    it 'e cancelou cadastramento' do
    
        # Arrange
        usuario = User.create!(name: 'Vulcano', email: 'vulcano@email.com', password: 'password')

        # Act
        login_as(usuario)
        visit root_path
        click_on 'Pedidos'
        click_on 'Criar Ordem de Entrega'
        
        click_on 'Cancelar'


        # Assert
        expect(current_path).to eq root_path
        
    end

end 
