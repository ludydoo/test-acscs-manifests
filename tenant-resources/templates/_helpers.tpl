{{/*
Expand the name of the chart.
*/}}
{{- define "tenant-resources.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tenant-resources.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Tenant Labels
*/}}
{{- define "tenant-resources.tenantLabels" -}}
rhacs.redhat.com/org-id: "{{ .Values.tenant.organizationId }}"
rhacs.redhat.com/tenant: "{{ .Values.tenant.id }}"
rhacs.redhat.com/instance-type: "{{ .Values.tenant.instanceType }}"
{{- end }}

{{/*
Common labels
*/}}
{{- define "tenant-resources.labels" -}}
helm.sh/chart: {{ include "tenant-resources.chart" . }}
{{ include "tenant-resources.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "tenant-resources.tenantLabels" . }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "tenant-resources.annotations" -}}
rhacs.redhat.com/org-name: "{{ .Values.tenant.organizationName }}"
{{- end }}

{{/*
Selector labels
*/}}
{{- define "tenant-resources.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tenant-resources.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "localNetworkCidrRanges" -}}
{{- tpl (.Files.Get "config/local-network-cidr-ranges.yaml.tpl") . -}}
{{- end -}}

{{- define "localNetworkCidrRangesIPv6" -}}
{{- tpl (.Files.Get "config/local-network-cidr-ranges-ipv6.yaml.tpl") . -}}
{{- end -}}
