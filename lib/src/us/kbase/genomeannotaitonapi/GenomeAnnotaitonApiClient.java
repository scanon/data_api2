package us.kbase.genomeannotaitonapi;

import com.fasterxml.jackson.core.type.TypeReference;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import us.kbase.auth.AuthToken;
import us.kbase.common.service.JsonClientCaller;
import us.kbase.common.service.JsonClientException;
import us.kbase.common.service.RpcContext;
import us.kbase.common.service.UnauthorizedException;

/**
 * <p>Original spec-file module name: genome_annotaiton_api</p>
 * <pre>
 * </pre>
 */
public class GenomeAnnotaitonApiClient {
    private JsonClientCaller caller;


    /** Constructs a client with a custom URL and no user credentials.
     * @param url the URL of the service.
     */
    public GenomeAnnotaitonApiClient(URL url) {
        caller = new JsonClientCaller(url);
    }
    /** Constructs a client with a custom URL.
     * @param url the URL of the service.
     * @param token the user's authorization token.
     * @throws UnauthorizedException if the token is not valid.
     * @throws IOException if an IOException occurs when checking the token's
     * validity.
     */
    public GenomeAnnotaitonApiClient(URL url, AuthToken token) throws UnauthorizedException, IOException {
        caller = new JsonClientCaller(url, token);
    }

    /** Constructs a client with a custom URL.
     * @param url the URL of the service.
     * @param user the user name.
     * @param password the password for the user name.
     * @throws UnauthorizedException if the credentials are not valid.
     * @throws IOException if an IOException occurs when checking the user's
     * credentials.
     */
    public GenomeAnnotaitonApiClient(URL url, String user, String password) throws UnauthorizedException, IOException {
        caller = new JsonClientCaller(url, user, password);
    }

    /** Get the token this client uses to communicate with the server.
     * @return the authorization token.
     */
    public AuthToken getToken() {
        return caller.getToken();
    }

    /** Get the URL of the service with which this client communicates.
     * @return the service URL.
     */
    public URL getURL() {
        return caller.getURL();
    }

    /** Set the timeout between establishing a connection to a server and
     * receiving a response. A value of zero or null implies no timeout.
     * @param milliseconds the milliseconds to wait before timing out when
     * attempting to read from a server.
     */
    public void setConnectionReadTimeOut(Integer milliseconds) {
        this.caller.setConnectionReadTimeOut(milliseconds);
    }

    /** Check if this client allows insecure http (vs https) connections.
     * @return true if insecure connections are allowed.
     */
    public boolean isInsecureHttpConnectionAllowed() {
        return caller.isInsecureHttpConnectionAllowed();
    }

    /** Deprecated. Use isInsecureHttpConnectionAllowed().
     * @deprecated
     */
    public boolean isAuthAllowedForHttp() {
        return caller.isAuthAllowedForHttp();
    }

    /** Set whether insecure http (vs https) connections should be allowed by
     * this client.
     * @param allowed true to allow insecure connections. Default false
     */
    public void setIsInsecureHttpConnectionAllowed(boolean allowed) {
        caller.setInsecureHttpConnectionAllowed(allowed);
    }

    /** Deprecated. Use setIsInsecureHttpConnectionAllowed().
     * @deprecated
     */
    public void setAuthAllowedForHttp(boolean isAuthAllowedForHttp) {
        caller.setAuthAllowedForHttp(isAuthAllowedForHttp);
    }

    /** Set whether all SSL certificates, including self-signed certificates,
     * should be trusted.
     * @param trustAll true to trust all certificates. Default false.
     */
    public void setAllSSLCertificatesTrusted(final boolean trustAll) {
        caller.setAllSSLCertificatesTrusted(trustAll);
    }
    
    /** Check if this client trusts all SSL certificates, including
     * self-signed certificates.
     * @return true if all certificates are trusted.
     */
    public boolean isAllSSLCertificatesTrusted() {
        return caller.isAllSSLCertificatesTrusted();
    }
    /** Sets streaming mode on. In this case, the data will be streamed to
     * the server in chunks as it is read from disk rather than buffered in
     * memory. Many servers are not compatible with this feature.
     * @param streamRequest true to set streaming mode on, false otherwise.
     */
    public void setStreamingModeOn(boolean streamRequest) {
        caller.setStreamingModeOn(streamRequest);
    }

    /** Returns true if streaming mode is on.
     * @return true if streaming mode is on.
     */
    public boolean isStreamingModeOn() {
        return caller.isStreamingModeOn();
    }

    public void _setFileForNextRpcResponse(File f) {
        caller.setFileForNextRpcResponse(f);
    }

    /**
     * <p>Original spec-file function name: get_taxon</p>
     * <pre>
     * *
     * * Retrieve the Taxon associated with this GenomeAnnotation.
     * *
     * </pre>
     * @param   ref   instance of original type "ObjectReference"
     * @return   instance of original type "ObjectReference"
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public String getTaxon(String ref, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(ref);
        TypeReference<List<String>> retType = new TypeReference<List<String>>() {};
        List<String> res = caller.jsonrpcCall("genome_annotaiton_api.get_taxon", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_assembly</p>
     * <pre>
     * *
     * * Retrieve the Assembly associated with this GenomeAnnotation.
     * *
     * </pre>
     * @param   ref   instance of original type "ObjectReference"
     * @return   instance of original type "ObjectReference"
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public String getAssembly(String ref, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(ref);
        TypeReference<List<String>> retType = new TypeReference<List<String>>() {};
        List<String> res = caller.jsonrpcCall("genome_annotaiton_api.get_assembly", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_feature_types</p>
     * <pre>
     * *
     * * Retrieve the list of Feature types in this GenomeAnnotation.
     * *
     * </pre>
     * @param   ref   instance of original type "ObjectReference"
     * @return   instance of list of String
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public List<String> getFeatureTypes(String ref, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(ref);
        TypeReference<List<List<String>>> retType = new TypeReference<List<List<String>>>() {};
        List<List<String>> res = caller.jsonrpcCall("genome_annotaiton_api.get_feature_types", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_feature_type_descriptions</p>
     * <pre>
     * *
     * * Retrieve the descriptions for each Feature type in this GenomeAnnotation.
     * *
     * </pre>
     * @param   arg1   instance of original type "ObjectReference"
     * @param   arg2   instance of list of String
     * @return   instance of mapping from String to String
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,String> getFeatureTypeDescriptions(String arg1, List<String> arg2, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(arg1);
        args.add(arg2);
        TypeReference<List<Map<String,String>>> retType = new TypeReference<List<Map<String,String>>>() {};
        List<Map<String,String>> res = caller.jsonrpcCall("genome_annotaiton_api.get_feature_type_descriptions", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_feature_type_counts</p>
     * <pre>
     * *
     * * Retrieve the count of each Feature type in this GenomeAnnotation.
     * *
     * </pre>
     * @param   arg1   instance of original type "ObjectReference"
     * @param   arg2   instance of list of String
     * @return   instance of mapping from String to Long
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,Long> getFeatureTypeCounts(String arg1, List<String> arg2, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(arg1);
        args.add(arg2);
        TypeReference<List<Map<String,Long>>> retType = new TypeReference<List<Map<String,Long>>>() {};
        List<Map<String,Long>> res = caller.jsonrpcCall("genome_annotaiton_api.get_feature_type_counts", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_feature_ids</p>
     * <pre>
     * *
     * * Retrieve Feature ids in this GenomeAnnotation, optionally filtered by type, region, function, alias.
     * *
     * </pre>
     * @param   arg1   instance of original type "ObjectReference"
     * @param   arg2   instance of type {@link us.kbase.genomeannotaitonapi.FeatureIdFilters FeatureIdFilters} (original type "Feature_id_filters")
     * @param   arg3   instance of String
     * @return   instance of type {@link us.kbase.genomeannotaitonapi.FeatureIdMapping FeatureIdMapping} (original type "Feature_id_mapping")
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public FeatureIdMapping getFeatureIds(String arg1, FeatureIdFilters arg2, String arg3, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(arg1);
        args.add(arg2);
        args.add(arg3);
        TypeReference<List<FeatureIdMapping>> retType = new TypeReference<List<FeatureIdMapping>>() {};
        List<FeatureIdMapping> res = caller.jsonrpcCall("genome_annotaiton_api.get_feature_ids", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_features</p>
     * <pre>
     * *
     * * Retrieve Feature data available in this GenomeAnnotation.
     * *
     * </pre>
     * @param   arg1   instance of original type "ObjectReference"
     * @param   arg2   instance of list of String
     * @return   instance of mapping from String to type {@link us.kbase.genomeannotaitonapi.FeatureData FeatureData} (original type "Feature_data")
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,FeatureData> getFeatures(String arg1, List<String> arg2, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(arg1);
        args.add(arg2);
        TypeReference<List<Map<String,FeatureData>>> retType = new TypeReference<List<Map<String,FeatureData>>>() {};
        List<Map<String,FeatureData>> res = caller.jsonrpcCall("genome_annotaiton_api.get_features", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_proteins</p>
     * <pre>
     * *
     * * Retrieve Protein data available in this GenomeAnnotation.
     * *
     * </pre>
     * @param   ref   instance of original type "ObjectReference"
     * @return   instance of mapping from String to type {@link us.kbase.genomeannotaitonapi.ProteinData ProteinData} (original type "Protein_data")
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,ProteinData> getProteins(String ref, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(ref);
        TypeReference<List<Map<String,ProteinData>>> retType = new TypeReference<List<Map<String,ProteinData>>>() {};
        List<Map<String,ProteinData>> res = caller.jsonrpcCall("genome_annotaiton_api.get_proteins", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_feature_locations</p>
     * <pre>
     * *
     * * Retrieve Feature locations in this GenomeAnnotation.
     * *
     * </pre>
     * @param   arg1   instance of original type "ObjectReference"
     * @param   arg2   instance of list of String
     * @return   instance of mapping from String to list of type {@link us.kbase.genomeannotaitonapi.Region Region}
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,List<Region>> getFeatureLocations(String arg1, List<String> arg2, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(arg1);
        args.add(arg2);
        TypeReference<List<Map<String,List<Region>>>> retType = new TypeReference<List<Map<String,List<Region>>>>() {};
        List<Map<String,List<Region>>> res = caller.jsonrpcCall("genome_annotaiton_api.get_feature_locations", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_feature_publications</p>
     * <pre>
     * *
     * * Retrieve Feature publications in this GenomeAnnotation.
     * *
     * </pre>
     * @param   ref   instance of original type "ObjectReference"
     * @param   featureIdList   instance of list of String
     * @return   instance of mapping from String to list of String
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,List<String>> getFeaturePublications(String ref, List<String> featureIdList, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(ref);
        args.add(featureIdList);
        TypeReference<List<Map<String,List<String>>>> retType = new TypeReference<List<Map<String,List<String>>>>() {};
        List<Map<String,List<String>>> res = caller.jsonrpcCall("genome_annotaiton_api.get_feature_publications", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_feature_dna</p>
     * <pre>
     * *
     * * Retrieve Feature DNA sequences in this GenomeAnnotation.
     * *
     * </pre>
     * @param   ref   instance of original type "ObjectReference"
     * @param   featureIdList   instance of list of String
     * @return   instance of mapping from String to String
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,String> getFeatureDna(String ref, List<String> featureIdList, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(ref);
        args.add(featureIdList);
        TypeReference<List<Map<String,String>>> retType = new TypeReference<List<Map<String,String>>>() {};
        List<Map<String,String>> res = caller.jsonrpcCall("genome_annotaiton_api.get_feature_dna", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_feature_functions</p>
     * <pre>
     * *
     * * Retrieve Feature functions in this GenomeAnnotation.
     * *
     * </pre>
     * @param   ref   instance of original type "ObjectReference"
     * @param   featureIdList   instance of list of String
     * @return   instance of mapping from String to String
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,String> getFeatureFunctions(String ref, List<String> featureIdList, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(ref);
        args.add(featureIdList);
        TypeReference<List<Map<String,String>>> retType = new TypeReference<List<Map<String,String>>>() {};
        List<Map<String,String>> res = caller.jsonrpcCall("genome_annotaiton_api.get_feature_functions", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_feature_aliases</p>
     * <pre>
     * *
     * * Retrieve Feature aliases in this GenomeAnnotation.
     * *
     * </pre>
     * @param   ref   instance of original type "ObjectReference"
     * @param   featureIdList   instance of list of String
     * @return   instance of mapping from String to list of String
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,List<String>> getFeatureAliases(String ref, List<String> featureIdList, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(ref);
        args.add(featureIdList);
        TypeReference<List<Map<String,List<String>>>> retType = new TypeReference<List<Map<String,List<String>>>>() {};
        List<Map<String,List<String>>> res = caller.jsonrpcCall("genome_annotaiton_api.get_feature_aliases", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_cds_by_gene</p>
     * <pre>
     * *
     * * Retrieve the CDS id for each Gene id in this GenomeAnnotation.
     * *
     * </pre>
     * @param   ref   instance of original type "ObjectReference"
     * @param   geneIdList   instance of list of String
     * @return   instance of mapping from String to list of String
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,List<String>> getCdsByGene(String ref, List<String> geneIdList, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(ref);
        args.add(geneIdList);
        TypeReference<List<Map<String,List<String>>>> retType = new TypeReference<List<Map<String,List<String>>>>() {};
        List<Map<String,List<String>>> res = caller.jsonrpcCall("genome_annotaiton_api.get_cds_by_gene", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_cds_by_mrna</p>
     * <pre>
     * *
     * * Retrieve the CDS id for each mRNA id in this GenomeAnnotation.
     * *
     * </pre>
     * @param   ref   instance of original type "ObjectReference"
     * @param   mrnaIdList   instance of list of String
     * @return   instance of mapping from String to String
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,String> getCdsByMrna(String ref, List<String> mrnaIdList, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(ref);
        args.add(mrnaIdList);
        TypeReference<List<Map<String,String>>> retType = new TypeReference<List<Map<String,String>>>() {};
        List<Map<String,String>> res = caller.jsonrpcCall("genome_annotaiton_api.get_cds_by_mrna", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_gene_by_cds</p>
     * <pre>
     * *
     * * Retrieve the Gene id for each CDS id in this GenomeAnnotation.
     * *
     * </pre>
     * @param   ref   instance of original type "ObjectReference"
     * @param   cdsIdList   instance of list of String
     * @return   instance of mapping from String to String
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,String> getGeneByCds(String ref, List<String> cdsIdList, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(ref);
        args.add(cdsIdList);
        TypeReference<List<Map<String,String>>> retType = new TypeReference<List<Map<String,String>>>() {};
        List<Map<String,String>> res = caller.jsonrpcCall("genome_annotaiton_api.get_gene_by_cds", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_gene_by_mrna</p>
     * <pre>
     * *
     * * Retrieve the Gene id for each mRNA id in this GenomeAnnotation.
     * *
     * </pre>
     * @param   ref   instance of original type "ObjectReference"
     * @param   mrnaIdList   instance of list of String
     * @return   instance of mapping from String to String
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,String> getGeneByMrna(String ref, List<String> mrnaIdList, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(ref);
        args.add(mrnaIdList);
        TypeReference<List<Map<String,String>>> retType = new TypeReference<List<Map<String,String>>>() {};
        List<Map<String,String>> res = caller.jsonrpcCall("genome_annotaiton_api.get_gene_by_mrna", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_mrna_by_cds</p>
     * <pre>
     * *
     * * Retrieve the mRNA id for each CDS id in this GenomeAnnotation.
     * *
     * </pre>
     * @param   ref   instance of original type "ObjectReference"
     * @param   geneIdList   instance of list of String
     * @return   instance of mapping from String to String
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,String> getMrnaByCds(String ref, List<String> geneIdList, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(ref);
        args.add(geneIdList);
        TypeReference<List<Map<String,String>>> retType = new TypeReference<List<Map<String,String>>>() {};
        List<Map<String,String>> res = caller.jsonrpcCall("genome_annotaiton_api.get_mrna_by_cds", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }

    /**
     * <p>Original spec-file function name: get_mrna_by_gene</p>
     * <pre>
     * *
     * * Retrieve the mRNA id for each Gene id in this GenomeAnnotation.
     * *
     * </pre>
     * @param   arg1   instance of original type "ObjectReference"
     * @param   geneIdList   instance of list of String
     * @return   instance of mapping from String to list of String
     * @throws IOException if an IO exception occurs
     * @throws JsonClientException if a JSON RPC exception occurs
     */
    public Map<String,List<String>> getMrnaByGene(String arg1, List<String> geneIdList, RpcContext... jsonRpcContext) throws IOException, JsonClientException {
        List<Object> args = new ArrayList<Object>();
        args.add(arg1);
        args.add(geneIdList);
        TypeReference<List<Map<String,List<String>>>> retType = new TypeReference<List<Map<String,List<String>>>>() {};
        List<Map<String,List<String>>> res = caller.jsonrpcCall("genome_annotaiton_api.get_mrna_by_gene", args, retType, true, true, jsonRpcContext);
        return res.get(0);
    }
}
