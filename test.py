#!/usr/bin/env python
import sys
import data_api2.data_api2Client

url=sys.argv[1]

p=data_api2.data_api2Client.data_api2(url=url)

obj_name="ReferenceGenomeAnnotations/kb|g.140057"
feature='kb|g.140057.CDS.2901'
gene='kb|g.140057.locus.2922'
mrna='kb|g.140057.mRNA.2840'
taxon= u'1779/523209/1'
assembly='1837/56/1'

print p.get_taxon(obj_name)
print p.get_assembly(obj_name)

print p.get_features(obj_name,[feature])
print p.get_cds_by_mrna(obj_name,[mrna])

