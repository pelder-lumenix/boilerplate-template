module "{{ .ModuleInvocationName }}" {
  source  = "{{ .sourceUrl }}"

  # --------------------------------------------------------------------------------------------------------------------
  # Required input variables
  # --------------------------------------------------------------------------------------------------------------------
  {{ range .requiredVariables }}
  {{- if eq 1 (regexSplit "\n" .Description -1 | len ) }}
  # Description: {{ .Description }}
  {{- else }}
  # Description:
    {{- range $line := regexSplit "\n" .Description -1 }}
    # {{ $line | indent 2 }}
    {{- end }}
  {{- end }}
  # Type: {{ .Type }}
  {{ .Name }} = var.{{ .ModuleInputVar }}.{{ .Name }}
  {{ end }}

  # --------------------------------------------------------------------------------------------------------------------
  # Optional input variables
  # Uncomment the ones you wish to set
  # --------------------------------------------------------------------------------------------------------------------
  {{ range .optionalVariables }}
  {{- if eq 1 (regexSplit "\n" .Description -1 | len ) }}
  # Description: {{ .Description }}
  {{- else }}
  # Description:
    {{- range $line := regexSplit "\n" .Description -1 }}
    # {{ $line | indent 2 }}
    {{- end }}
  {{- end }}
  # Type: {{ .Type }}
  {{ .Name }} = try(var.{{ .ModuleInputVar }}.{{ .Name }}, {{ .DefaultValue }})
  {{ end }}
}
