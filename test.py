#!/usr/bin/env python
import sys
import data_api2.data_api2Client

url=sys.argv[1]

p=data_api2.data_api2Client.data_api2(url=url)

taxon=p.get_taxon("ReferenceGenomeAnnotations/kb|g.207118")

print taxon
