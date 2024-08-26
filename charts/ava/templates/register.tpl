apiVersion: batch/v1
kind: Job
metadata:
  name: {{ include "ava.fullname" . }}-register-job
  labels:
    {{- include "avaRegister.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": "post-install"
spec:
  template:
    metadata:
      labels:
        {{- include "avaRegister.labels" . | nindent 8 }}
    spec:
      containers:
        - name: register
          image: "{{ .Values.register.image.repository }}:{{ .Values.register.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.register.image.pullPolicy }}
          command:
            {{- toYaml .Values.register.command | nindent 12 }}
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
