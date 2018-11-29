package it.nextworks.nfvmano.nfvodriver.sm.messages;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;;


public class OperationStatusResponse{

    @JsonProperty("status")
    private String status;

    @JsonCreator
    public OperationStatusResponse(@JsonProperty("status") String status){
        this.status = status;
    }

    public String getOperationStatus(){
        return this.status;
    }

}