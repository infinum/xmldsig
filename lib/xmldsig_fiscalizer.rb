require "nokogiri"
require "openssl"
require "base64"
require "xmldsig_fiscalizer/version"
require "xmldsig_fiscalizer/canonicalizer"
require "xmldsig_fiscalizer/signed_document"
require "xmldsig_fiscalizer/transforms/transform"
require "xmldsig_fiscalizer/transforms/canonicalize"
require "xmldsig_fiscalizer/transforms/enveloped_signature"
require "xmldsig_fiscalizer/transforms"
require "xmldsig_fiscalizer/reference"
require "xmldsig_fiscalizer/signature"

module Xmldsig_fiscalizer
  NAMESPACES = {
      "ds"  => "http://www.w3.org/2000/09/xmldsig#",
      "ec"  => "http://www.w3.org/2001/10/xml-exc-c14n#",
      "wsu" => "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"
  }
end
