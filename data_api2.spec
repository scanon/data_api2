/*
A KBase module: data_api2

*/

module data_api2 {
	/*
	A string representing a reference id.
	*/
	typedef string ObjectReference;

  typedef structure {
    string contig_id;
    string strand;
    int start;
    int length;
  } Region;

  typedef structure  {
    list<string> type_list;
    list<Region> region_list;
    list<string> function_list;
    list<string> alias_list;
  } Feature_id_filters;

typedef structure  {
    mapping<string, list<string>> by_type;
    mapping<string, mapping<string, mapping<string, list<string>>>> by_region;
    mapping<string, list<string>> by_function;
    mapping<string, list<string>> by_alias;
} Feature_id_mapping;

typedef structure  {
    string feature_id;
    string feature_type;
    string feature_function;
    mapping<string, list<string>> feature_aliases;
    int feature_dna_sequence_length;
    string feature_dna_sequence;
    string feature_md5;
    list<Region> feature_locations;
    list<string> feature_publications;
    list<string> feature_quality_warnings;
    list<string> feature_quality_score;
    list<string> feature_notes;
    string feature_inference;
} Feature_data;

typedef structure  {
    string protein_id;
    string protein_amino_acid_sequence;
    string protein_function;
    list<string> protein_aliases;
    string protein_md5;
    list<string> protein_domain_locations;
} Protein_data;

    /**
     * Retrieve the Taxon associated with this GenomeAnnotation.
     *
     */
    funcdef get_taxon(ObjectReference ref) returns (ObjectReference) authentication required;

    /**
     * Retrieve the Assembly associated with this GenomeAnnotation.
     *
     */
    funcdef get_assembly(ObjectReference ref) returns (ObjectReference) authentication required;

    /**
     * Retrieve the list of Feature types in this GenomeAnnotation.
     *
     */
    funcdef get_feature_types(ObjectReference ref) returns (list<string>) authentication required;

    /**
     * Retrieve the descriptions for each Feature type in this GenomeAnnotation.
     *
     */
    funcdef get_feature_type_descriptions(ObjectReference ref,
                                          list<string> feature_type_list ) returns (mapping<string,string> ) authentication required;

    /**
     * Retrieve the count of each Feature type in this GenomeAnnotation.
     *
     */
    funcdef get_feature_type_counts(ObjectReference ref, list<string> feature_type_list) returns (mapping<string,int> ) authentication required;

    /**
     * Retrieve Feature ids in this GenomeAnnotation, optionally filtered by type, region, function, alias.
     *
     */
    funcdef get_feature_ids(ObjectReference ref,Feature_id_filters filters,
                                       string group_type) returns (Feature_id_mapping ) authentication required;

    /**
     * Retrieve Feature data available in this GenomeAnnotation.
     *
     */
    funcdef get_features(ObjectReference ref,list<string> feature_id_list) returns (mapping<string, Feature_data> ) authentication required;

    /**
     * Retrieve Protein data available in this GenomeAnnotation.
     *
     */
    funcdef get_proteins(ObjectReference ref) returns (mapping<string, Protein_data> ) authentication required;

    /**
     * Retrieve Feature locations in this GenomeAnnotation.
     *
     */
    funcdef get_feature_locations(ObjectReference ref,list<string> feature_id_list) returns (mapping<string, list<Region>> ) authentication required;

    /**
     * Retrieve Feature publications in this GenomeAnnotation.
     *
     */
    funcdef get_feature_publications(ObjectReference ref,
                                                      list<string> feature_id_list) returns (mapping<string,list<string>> ) authentication required;

    /**
     * Retrieve Feature DNA sequences in this GenomeAnnotation.
     *
     */
    funcdef get_feature_dna(ObjectReference ref,list<string> feature_id_list) returns (mapping<string,string> ) authentication required;

    /**
     * Retrieve Feature functions in this GenomeAnnotation.
     *
     */
    funcdef get_feature_functions(ObjectReference ref,list<string> feature_id_list) returns (mapping<string,string> ) authentication required;

    /**
     * Retrieve Feature aliases in this GenomeAnnotation.
     *
     */
    funcdef get_feature_aliases(ObjectReference ref,list<string> feature_id_list) returns (mapping<string,list<string>> ) authentication required;

    /**
     * Retrieve the CDS id for each Gene id in this GenomeAnnotation.
     *
     */
    funcdef get_cds_by_gene(ObjectReference ref,
                                             list<string> gene_id_list) returns (mapping<string,list<string>> ) authentication required;

    /**
     * Retrieve the CDS id for each mRNA id in this GenomeAnnotation.
     *
     */
    funcdef  get_cds_by_mrna(ObjectReference ref,
                                       list<string> mrna_id_list) returns (mapping<string,string>) authentication required;

    /**
     * Retrieve the Gene id for each CDS id in this GenomeAnnotation.
     *
     */
    funcdef get_gene_by_cds(ObjectReference ref,
                                       list<string> cds_id_list) returns (mapping<string,string> ) authentication required;

    /**
     * Retrieve the Gene id for each mRNA id in this GenomeAnnotation.
     *
     */
    funcdef  get_gene_by_mrna(ObjectReference ref,
                                        list<string> mrna_id_list) returns (mapping<string,string>) authentication required;

    /**
     * Retrieve the mRNA id for each CDS id in this GenomeAnnotation.
     *
     */
    funcdef get_mrna_by_cds(ObjectReference ref,
                                       list<string> gene_id_list) returns (mapping<string,string> ) authentication required;

    /**
     * Retrieve the mRNA id for each Gene id in this GenomeAnnotation.
     *
     */
    funcdef get_mrna_by_gene(ObjectReference ref,list<string> gene_id_list) returns (mapping<string, list<string>> ) authentication required;
};
