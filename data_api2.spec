/*
A KBase module: data_api2

*/

module data_api2 {
	/*
	A string representing a reference id.
	*/
	typedef string ObjectReference;

	/*
	A string representing a workspace name.
	*/
	typedef string workspace_name;

	/*
	Get taxon for an Annotation
	ObjectReference - the assembly id
	*/
	funcdef get_taxon(ObjectReference) returns (ObjectReference) authentication required;
};
