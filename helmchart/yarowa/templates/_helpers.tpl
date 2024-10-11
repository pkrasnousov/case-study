{{/* Define the name of the application */}}
{{- define "yarowa.fullname" -}}
{{- printf "%s-%s" .Release.Name "yarowa" | trunc 63 -}}
{{- end -}}

{{/* Define common labels */}}
{{- define "yarowa.labels" -}}
app: {{ include "yarowa.fullname" . }}
{{- end -}}