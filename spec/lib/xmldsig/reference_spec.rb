require "spec_helper"

describe Xmldsig_fiscalizer::Reference do
  let(:document) { Nokogiri::XML::Document.parse File.read("spec/fixtures/signed.xml") }
  let(:reference) { Xmldsig_fiscalizer::Reference.new(document.at_xpath('//ds:Reference', Xmldsig_fiscalizer::NAMESPACES)) }

  describe "#digest_value" do
    it "returns the digest value in the xml" do
      reference.digest_value.should == Base64.decode64("ftoSYFdze1AWgGHF5N9i9SFKThXkqH2AdyzA3/epbJw=")
    end
  end

  describe "#document" do
    it "returns the document" do
      reference.document.should == document
    end
  end

  describe "#sign" do
    let(:document) { Nokogiri::XML::Document.parse File.read("spec/fixtures/unsigned.xml") }

    it "sets the correct digest value" do
      reference.sign
      reference.digest_value.should == Base64.decode64("ftoSYFdze1AWgGHF5N9i9SFKThXkqH2AdyzA3/epbJw=")
    end
  end

  describe "#referenced_node" do
    it "returns the referenced_node by id" do
      reference.referenced_node.to_s.should ==
        document.at_xpath("//*[@ID='foo']").to_s
    end

    it "returns the referenced node by parent" do
      reference.stub(:reference_uri).and_return("")
      reference.referenced_node.to_s.should ==
        document.root.to_s
    end

    it "returns the reference node when using WS-Security style id attribute" do
      node = document.at_xpath('//*[@ID]')
      node.add_namespace('wsu', Xmldsig_fiscalizer::NAMESPACES['wsu'])
      node['wsu:Id'] = node['ID']
      node.remove_attribute('ID')

      reference.referenced_node.
        attribute_with_ns('Id', Xmldsig_fiscalizer::NAMESPACES['wsu']).value.
        should == 'foo'
    end

    it "raises ReferencedNodeNotFound when the refenced node is not present" do
      node = document.at_xpath('//*[@ID]')
      node.remove_attribute('ID')

      expect { reference.referenced_node }.
        to raise_error(Xmldsig_fiscalizer::Reference::ReferencedNodeNotFound)
    end
  end

  describe "#reference_uri" do
    it "returns the reference uri" do
      reference.reference_uri.should == "#foo"
    end
  end
end
