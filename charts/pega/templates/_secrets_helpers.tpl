{{- define "pega-db-secret-name" }}pega-db-secret{{- end -}}
{{- define "pega-hz-secret-name" }}pega-hz-secret{{- end -}}
{{- define "pega-cassandra-secret-name" }}pega-cassandra-secret{{- end -}}

{{- define "hzSecretResolver" }}
    {{- if ((.Values.hazelcast).external_secret_name) }}{{ .Values.hazelcast.external_secret_name }}{{- else }}{{ template "pega-hz-secret-name" $ }}{{- end }}
{{- end  -}}


{{- define "dbSecretResolver" }}
    {{- if ((.Values.global.jdbc).external_secret_name) }}{{ .Values.global.jdbc.external_secret_name }}{{- else }}{{ template "pega-db-secret-name" }}{{- end }}
{{- end  -}}

{{- define "cassandraSecretResolver" }}
    {{- if ((.Values.dds).external_secret_name) }}{{ .Values.dds.external_secret_name }}{{- else }}{{ template "pega-cassandra-secret-name" }}{{- end }}
{{- end  -}}