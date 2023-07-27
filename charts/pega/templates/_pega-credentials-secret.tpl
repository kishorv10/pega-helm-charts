{{- define "pegaCredentialsSecretTemplate" }}
kind: Secret
apiVersion: v1
metadata:
  name: {{ template "pegaCredentialsSecret" $ }}
  namespace: {{ .Release.Namespace }}
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "0"
    "helm.sh/hook-delete-policy": before-hook-creation
data:

  {{ if (eq (include "useBasicAuthForCustomArtifactory" .) "true") }}
  # Base64 encoded username for basic authentication of custom artifactory
  CUSTOM_ARTIFACTORY_USERNAME: {{ .Values.global.customArtifactory.authentication.basic.username | b64enc }}
  # Base64 encoded password for basic authentication of custom artifactory
  CUSTOM_ARTIFACTORY_PASSWORD: {{ .Values.global.customArtifactory.authentication.basic.password | b64enc }}
  {{- end }}

  {{ if (eq (include "useApiKeyForCustomArtifactory" .) "true") }}
  # Base64 encoded dedicated apikey header name and apikey value for authentication of custom artifactory
  CUSTOM_ARTIFACTORY_APIKEY_HEADER: {{ .Values.global.customArtifactory.authentication.apiKey.headerName | b64enc }}
  # Base64 encoded password for basic authentication of custom artifactory
  CUSTOM_ARTIFACTORY_APIKEY: {{ .Values.global.customArtifactory.authentication.apiKey.value | b64enc }}
  {{- end }}

 {{ if (eq (include "performDeployment" .) "true") }}
  {{ if .Values.stream.trustStorePassword -}}
  # Base64 encoded password for the stream trust store
  STREAM_TRUSTSTORE_PASSWORD: {{ .Values.stream.trustStorePassword | b64enc }}
  {{- end }}
  {{ if .Values.stream.keyStorePassword -}}
  # Base64 encoded password for the stream key store
  STREAM_KEYSTORE_PASSWORD: {{ .Values.stream.keyStorePassword | b64enc }}
  {{- end }}
  {{ if .Values.stream.jaasConfig -}}
  # Base64 encoded password for the stream trust store
  STREAM_JAAS_CONFIG: {{ .Values.stream.jaasConfig | b64enc }}
  {{- end }}
  {{ range $index, $dep := .Values.global.tier}}
  {{ if and ($dep.pegaDiagnosticUser) (eq $dep.name "web") }}
  # Base64 encoded username for a Tomcat user that will be created with the PegaDiagnosticUser role
  PEGA_DIAGNOSTIC_USER: {{ $dep.pegaDiagnosticUser | b64enc }}
  # Base64 encoded password for a Tomcat user that will be created with the PegaDiagnosticUser role
  PEGA_DIAGNOSTIC_PASSWORD: {{ $dep.pegaDiagnosticPassword | b64enc }}
  {{ end }}
  {{ end }}
{{ end }}
type: Opaque
{{- end }}
