class InvoiceValidatorService
    include HTTParty
    base_uri 'https://my.api.mockaroo.com'
    headers 'X-API-Key' => 'b490bb80'
  
    def self.validate_invoice(invoice_number)
        response = post('/invoices.json', body: { invoice_id: invoice_number }.to_json)
        { status: JSON.parse(response.body)['status'] } 
    end
end