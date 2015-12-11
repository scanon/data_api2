#BEGIN_HEADER
from biokbase.workspace.client import Workspace as workspaceService
import doekbase.data_api.sequence.assembly.api
import doekbase.data_api.annotation.genome_annotation.api
from doekbase.data_api import cache
import logging
#END_HEADER


class data_api2:
    '''
    Module Name:
    data_api2

    Module Description:
    A KBase module: data_api2
    '''

    ######## WARNING FOR GEVENT USERS #######
    # Since asynchronous IO can lead to methods - even the same method -
    # interrupting each other, you must be *very* careful when using global
    # state. A method could easily clobber the state set by another while
    # the latter method is running.
    #########################################
    #BEGIN_CLASS_HEADER
    workspaceURL = None
    #END_CLASS_HEADER

    # config contains contents of config file in a hash or None if it couldn't
    # be found
    def __init__(self, config):
        #BEGIN_CONSTRUCTOR
        self.workspaceURL = config['workspace-url']
        self.shockURL = config['shock-url']
        self.logger = logging.getLogger()
        log_handler = logging.StreamHandler()
        log_handler.setFormatter(logging.Formatter("%(asctime)s [%(levelname)s] %(message)s"))
        self.logger.addHandler(log_handler)


        self.services = {
                "workspace_service_url": self.workspaceURL,
                "shock_service_url": self.shockURL,
            }
        try:
            redis_host = config['redis_host']
            redis_port = config['redis_port']
        except:
            redis_host = None
            redis_port = None
        if redis_host is not None and redis_port is not None:
            self.logger.info("Activating REDIS at host:{} port:{}".format(redis_host, redis_port))
            cache.ObjectCache.cache_class = cache.RedisCache
            cache.ObjectCache.cache_params = {'redis_host': redis_host, 'redis_port': redis_port}
        else:
            self.logger.info("Not activating REDIS")

        #END_CONSTRUCTOR
        pass

    def get_taxon(self, ctx, ObjectReference):
        # ctx is the context object
        # return variables are: returnVal
        #BEGIN get_taxon
        returnVal=dict()
        genome_annotation_api = doekbase.data_api.annotation.genome_annotation.api.GenomeAnnotationAPI(self.services, ctx['token'], ObjectReference)
        taxon=genome_annotation_api.get_taxon(ref_only=True)
        print "Gname %s"%(taxon)

        returnVal=taxon

        #END get_taxon

        # At some point might do deeper type checking...
        if not isinstance(returnVal, basestring):
            raise ValueError('Method get_taxon return value ' +
                             'returnVal is not type basestring as required.')
        # return the results
        return [returnVal]
