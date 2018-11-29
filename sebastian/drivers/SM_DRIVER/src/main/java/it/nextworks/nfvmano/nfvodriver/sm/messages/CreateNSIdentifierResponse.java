package it.nextworks.nfvmano.nfvodriver.sm.messages;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonCreator;;


public class CreateNSIdentifierResponse{

    @JsonProperty("nsId")
    private String nsId;

    @JsonCreator
    public CreateNSIdentifierResponse(@JsonProperty("nsId") String nsId){
        this.nsId = nsId;
    }

    public String getNSId(){
        return this.nsId;
    }

}