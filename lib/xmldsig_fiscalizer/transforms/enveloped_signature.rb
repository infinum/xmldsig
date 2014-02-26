module Xmldsig_fiscalizer
  class Transforms < Array
    class EnvelopedSignature < Transform
      def transform
        node.xpath("descendant::ds:Signature", Xmldsig_fiscalizer::NAMESPACES).first.remove
        node
      end
    end
  end
end
