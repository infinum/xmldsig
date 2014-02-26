require 'spec_helper'

describe Xmldsig_fiscalizer::Transforms::EnvelopedSignature do
  let(:unsigned_xml) { File.read('spec/fixtures/unsigned_nested_signature.xml') }
  let(:unsigned_document) { Xmldsig_fiscalizer::SignedDocument.new(unsigned_xml) }

  it 'only removes the first signature element' do
    node_with_nested_signature = unsigned_document.signatures.last.references.first.referenced_node

    described_class.new(node_with_nested_signature, nil).transform

    remaining_signatures = node_with_nested_signature.xpath('descendant::ds:Signature', Xmldsig_fiscalizer::NAMESPACES)
    remaining_signatures.count.should == 1
    signature = Xmldsig_fiscalizer::Signature.new(remaining_signatures.first)

    signature.references.first.reference_uri.should == '#baz'
  end
end
