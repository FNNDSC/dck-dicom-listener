# dck-dicom-listener

A dock for `pypx`-based dicom listener.

```
# Build image
$> docker build --no-cache -t dicom-listener .

# Run image
$> docker run -d -p 10402:10402 -v /tmp:/incoming dicom-listener:latest

```
