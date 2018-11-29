package it.nextworks.nfvmano.nfvodriver.sm.messages;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;;


public class OperationResponse{

    @JsonProperty("operationId")
    private String operationId;

    @JsonCreator
    public OperationResponse(@JsonProperty("operationId") String operationId){
        this.operationId = operationId;
    }

    public String getOperationId(){
        return this.operationId;
    }

}