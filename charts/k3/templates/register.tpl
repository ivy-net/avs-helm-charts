apiVersion: batch/v1
kind: Job
metadata:
  name: {{ include "k3.fullname" . }}-register-job
  labels:
    {{- include "k3Register.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": "post-install"
spec:
  template:
    metadata:
      labels:
        {{- include "k3Register.labels" . | nindent 8 }}
    spec:
      containers:
      initContainers:
        - name: register-init
          {{- with .Values.register.initContainer.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with .Values.register.initContainer.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.register.initContainer.image.repository }}:{{ .Values.register.initContainer.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.register.initContainer.image.pullPolicy }}
          {{- with .Values.register.initContainer.volumeMounts }}
          volumeMounts:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            {{- toYaml .Values.register.initContainer.env | nindent 12 }}
        - name: register
          image: "{{ .Values.register.image.repository }}:{{ .Values.register.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.register.image.pullPolicy }}
          args:
            {{- toYaml .Values.register.args | nindent 12 }}
          env:
            {{- toYaml .Values.node.env | nindent 12 }}
          volumeMounts:
            {{- toYaml .Values.node.volumeMounts | nindent 12 }}
      restartPolicy: Never
      volumes:
        {{- toYaml .Values.volumes | nindent 8 }}
  backoffLimit: 2
