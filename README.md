# Erddap for Matlab
A native Matlab/Octave client for accessing data and metadata from instances of NOAA's Erddap Data Server

 - [Installation](#installation)
 - [Methods](#methods)
     - [getDatasetsOnServer](#getdatasetsonserver)
     - [suggestServers](#getdatasetsonserver)

## Installation

### Matlab

### GNU Octave

## Namespace: `Erddap`

## Class: `ErddapServer`

### getDatasetsOnServer

```Matlab
getDatasetsOnServer(serverBaseURL);
```

Returns a cell array of strings containing the output of the RESTful call to an Erddap server's base information page.

#### Example

```Matlab
em = ErddapMat();
datasets = em.getDatasetsOnServer("http://erddap.marine.ie");
```

## Function `Erddap.suggestServers()`


```Matlab
em = ErddapMat();
knownServers = em.suggestServers();
```
