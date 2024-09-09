# App Registrations Analyser

## Projektbeschreibung

Das **App Registrations Analyser**-Projekt ermöglicht es, eine Übersicht über alle Azure AD App-Registrierungen zu erhalten, einschliesslich ihrer Zertifikate, Client Secrets und weiteren Details. Es bietet ausserdem die Möglichkeit, doppelte oder veraltete App-Registrierungen in Azure Active Directory zu identifizieren und zu entfernen.

## Hauptfunktionen

- Extrahiert detaillierte Informationen über App-Registrierungen in Azure AD (z. B. App-Name, App-ID, Objekt-ID, Antwort-URLs, Zertifikate und Geheimnisse).
- Erzeugt eine CSV-Datei mit den Informationen aller App-Registrierungen.
- Unterstützt das Filtern und Gruppieren von App-Registrierungen basierend auf `ApplicationID`.
- Ermöglicht das automatische Entfernen von doppelten App-Registrierungen.
- Hilft beim CleanUp des Tenants

## Dateien

- **analyser.ps1**: Skript zum Abrufen und Analysieren der Azure AD App-Registrierungen und Speichern der Ergebnisse als CSV.
- **remover.ps1**: Skript zum Identifizieren und Löschen von App-Registrierungen basierend auf einer zuvor erstellten CSV-Datei.

## Voraussetzungen

- PowerShell 5.1 oder höher.
- AzureAD PowerShell Modul (`Install-Module -Name AzureAD`).
- Azure AD Administratorrechte für das Abrufen und Löschen von App-Registrierungen.

## Verwendung

1. Führe `analyser.ps1` aus, um eine CSV-Datei mit App-Registrierungsdetails zu generieren.
2. Verwende `remover.ps1`, um App-Registrierungen zu identifizieren und zu entfernen.

> **Achtung:** Bearbeite die CSV-Datei und entferne die App-Registrierungen aus dem File, die nicht gelöscht werden sollen.

## Autor

Erstellt von `Dines Nimalthas`
