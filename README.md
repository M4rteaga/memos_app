# Memos App

A simple flutter app to record ideas, uploud them to google cloud bucket and played them remotely

## Dependencies

- record: enable recording capability
- audioplayers: for audio playing
- riverpod: state managment
- googleapis: easy connection with gcs

## Instructions
1. To replicate this you should create a bucket in GCS with the name of bucket-memo-app (if you wish to change this name in the project it is located in gcs_api.dart).
2. Create a service account in gcs, grant access for reading and creating objects in buckets, and download the credentials as json. Finally add your credential under the assets folder with the name of service_account.json
3. After that you should be able to run this project. If not please reach out or open a issue.
