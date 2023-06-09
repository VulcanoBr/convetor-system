class DeliveryOrderController < ApplicationController 

    before_action :authenticate_user!

    before_action :set_delivery_order, only: [:show, :edit, :update, :closed_budget]

    def show 

    end

    def closed_budget 
        
    end

    def index  
        @delivery_orders = DeliveryOrder.all.in_delivery
    end

    def edit
        
    end

    def pesq_budget  
        @pesq_delivery = params[:query]
        if params[:query].present?
            @delivery_order = DeliveryOrder.where(code: params[:query])
        else
            @delivery_order = ''
        end
    end

    def start_budget
        order = Order.find(params[:delivery_order][:order_id])
        vehicle = Vehicle.find_by("maximum_load >= ? AND status = ?", params[:maximum_load], 0)
        if !vehicle.blank?
            @delivery_order = DeliveryOrder.new(delivery_order_params)
            @delivery_order.vehicle_id = vehicle.id
            @delivery_order.amount =  (params[:maximum_load].to_i * @delivery_order.km_price) + @delivery_order.delivery_fee
            @delivery_order.delivery_forecast = Date.today + ((@delivery_order.deadline_hours / 24) + 1)
            if @delivery_order.save 
                vehicle.in_delivery!
                order.in_delivery!
                redirect_to @delivery_order, notice: "Serviço de entrega para ordem #{order.code} contratado com sucesso !!!"
            else
                flash.now[:notice] = "Serviço de entrega para ordem #{order.code}  NÃO contratado  !!!"
                redirect_to orders_path
            end
        else
            flash.now[:notice] = "Serviço de entrega para ordem #{order.code}  NÃO contratado  !!!"
            redirect_to no_budget_delivery_delivery_order_path(order.id)
        end
    end

    def no_budget_delivery
        @order = Order.find(params[:id])
    end

    def update
        if @delivery_order.update(delivery_order_params)
            order = Order.find(@delivery_order.order_id)
            vehicle = Vehicle.find(@delivery_order.vehicle_id)
            vehicle.in_operation!
            order.closed!
            closed
            redirect_to closed_budget_delivery_order_index_path(id: @delivery_order.id),
                notice: 'Ordem de Entrega encerrada com sucesso!!!'
        else  
            flash.now[:notice] = 'Ordem de Entrega NÃO encerrada !!!'
            render 'edit'
        end
    end

    def closed 
        @delivery_order.closed!
    end

    private

    def set_delivery_order 
        @delivery_order = DeliveryOrder.find(params[:id])
    end

    def delivery_order_params 
        params.require(:delivery_order).permit(:code, :deadline_hours, :delivery_fee,
            :km_price, :amount, :delivery_forecast,  :delivery_reason, :delivery_date,
            :status, :closure_status, :order_id, :mode_transport_id, :vehicle_id)
    end
end