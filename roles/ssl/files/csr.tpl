{
	"subject": {"commonName": {{ toJson .Insecure.CR.Subject.CommonName }}},
        "sans": [{"type": "email", "value": "admin@google.com"}, {"type": "dns", "value": "www.{{.Subject.CommonName}}"}],
	"dnsNames": {{ toJson .Insecure.CR.DNSNames }},
	"emailAddresses": {{ toJson .Insecure.CR.EmailAddresses }},
	"ipAddresses": {{ toJson .Insecure.CR.IPAddresses }},
	"uris": {{ toJson .Insecure.CR.URIs }},
{{- if typeIs "*rsa.PublicKey" .Insecure.CR.PublicKey }}
	"keyUsage": ["keyEncipherment", "digitalSignature"],
{{- else }}
	"keyUsage": ["digitalSignature"],
{{- end }}
	"extKeyUsage": ["serverAuth", "clientAuth"]
}
