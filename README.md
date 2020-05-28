# ErddapMat
A native Matlab/Octave client for accessing data and metadata from instances of NOAA's Erddap Data Server

 - [Installation](#installation)
 - [Methods](#methods)
     - [getDatasetsOnServer](#getdatasetsonserver)
     - [suggestServers](#getdatasetsonserver)

## Installation

## Methods

### getDatasetsOnServer

```matlab
em = ErddapMat();
datasets = em.getDatasetsOnServer("http://erddap.marine.ie");
```

### suggestServers


```matlab
em = ErddapMat();
knownServers = em.suggestServers();
```
