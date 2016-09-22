Mongoid::Clients::StorageOptions::ClassMethods.module_eval do
  def store_in(options)
    options[:client] = options.delete(:session) if options && options[:session]

    Mongoid::Clients::Validators::Storage.validate(self, options)
    storage_options.merge!(options)
  end
end
