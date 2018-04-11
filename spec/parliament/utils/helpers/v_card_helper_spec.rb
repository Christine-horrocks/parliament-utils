require 'spec_helper'

RSpec.describe Parliament::Utils::Helpers::VCardHelper, vcr: true do

  context '#create_vcard' do
    let(:dummy_class) {Class.new { include Parliament::Utils::Helpers::VCardHelper} }
    let(:instance) {dummy_class.new}
    let(:contact_point)   { Parliament::Utils::Helpers::FilterHelper.filter(Parliament::Utils::Helpers::ParliamentHelper.parliament_request.contact_point_by_id.set_url_params({ contact_point_id: 'wk1atnfh' }), 'ContactPoint').first}
    let(:generated_vcard) {instance.create_vcard(contact_point)}
    let(:generated_vcard_fields) {generated_vcard.cache.keys}

    it 'creates a vcard maker object' do
      expect(generated_vcard_fields[0].instance_variable_get(:@line)).to eq('BEGIN:VCARD')
      expect(generated_vcard_fields[1].instance_variable_get(:@line)).to include('VERSION')
      expect(generated_vcard_fields[2].instance_variable_get(:@line)).to eq('ADR:;;addressLine1 - 1\\, addressLine2 - 1\\, postCode - 1;;;;')
      expect(generated_vcard_fields[3].instance_variable_get(:@line)).to eq('EMAIL:email - 1')
      expect(generated_vcard_fields[4].instance_variable_get(:@line)).to eq('TEL:phoneNumber - 1')
      expect(generated_vcard_fields[5].instance_variable_get(:@line)).to eq('TEL;TYPE=fax:faxNumber - 1')
      expect(generated_vcard_fields[6].instance_variable_get(:@line)).to eq('END:VCARD')
    end
  end

end
