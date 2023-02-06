class DeliveryOrder < ApplicationRecord
  belongs_to :order
  belongs_to :mode_transport
  belongs_to :vehicle

  enum status: { in_delivery: 0 }
end