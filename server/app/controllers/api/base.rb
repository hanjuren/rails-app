module API
  class Base < Grape::API
    mount API::V1::All
  end
end