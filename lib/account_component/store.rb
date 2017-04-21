module AccountComponent
  class Store
    include EntityStore

    category :account
    entity Account
    projection Projection
    reader EventSource::Postgres::Read
  end
end
