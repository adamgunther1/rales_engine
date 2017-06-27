class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :result, :invoice_id, :created_at, :updated_at
end
