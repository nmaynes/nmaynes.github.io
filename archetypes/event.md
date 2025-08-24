---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
slug: {{ now.Format "2006-01-02" }}-{{ .Name | urlize }}
type: event
draft: true
categories:
  - default
tags:
  - default
---

# ARCHTYPE