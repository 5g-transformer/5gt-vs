package it.nextworks.nfvmano.nfvodriver.sm;

import java.beans.Transient;

import it.nextworks.nfvmano.nfvodriver.sm.SMDriver;

import it.nextworks.nfvmano.libs.osmanfvo.nslcm.interfaces.messages.CreateNsIdentifierRequest;
import it.nextworks.nfvmano.libs.osmanfvo.nslcm.interfaces.messages.InstantiateNsRequest;
import it.nextworks.nfvmano.libs.osmanfvo.nslcm.interfaces.messages.TerminateNsRequest;


import it.nextworks.nfvmano.libs.common.exceptions.MethodNotImplementedException;
import it.nextworks.nfvmano.libs.common.exceptions.NotExistingEntityException;
import it.nextworks.nfvmano.libs.common.messages.GeneralizedQueryRequest;
import it.nextworks.nfvmano.libs.common.exceptions.FailedOperationException;
import it.nextworks.nfvmano.libs.common.exceptions.MalformattedElementException;
import java.util.List;
import   java.util.ArrayList;
import java.util.Date;
import org.junit.Test;
import java.util.Map;
import java.util.HashMap;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;    
import org.springframework.test.context.ContextConfiguration;
import org.springframework.core.io.ClassPathResource;
import it.nextworks.nfvmano.libs.osmanfvo.nslcm.interfaces.elements.ParamsForVnf;
import it.nextworks.nfvmano.libs.osmanfvo.nslcm.interfaces.elements.SapData;
import it.nextworks.nfvmano.libs.osmanfvo.nslcm.interfaces.elements.VnfInstanceData;
import it.nextworks.nfvmano.libs.osmanfvo.nslcm.interfaces.elements.VnfLocationConstraints;
import it.nextworks.nfvmano.libs.records.nsinfo.PnfInfo;
import it.nextworks.nfvmano.libs.common.elements.AffinityRule;
import it.nextworks.nfvmano.libs.common.elements.Filter;

public class SMDriverApplicationTests{

  
    
/*    @Test
    public void testCreateNsIdentifier(){
        
        
        realTestCreateNsIdentifier();

    }

    private String realTestCreateNsIdentifier(){
        SMDriver sm = new SMDriver("192.168.137.17");
        try{
            CreateNsIdentifierRequest req = new CreateNsIdentifierRequest("nsdId","nsNAme","nsDescription","nsdTenant");
            
            return sm.createNsIdentifier(req);
        }catch( MethodNotImplementedException e){
            System.out.println("error");
            return null;
        }catch( NotExistingEntityException e){
            System.out.println("error");
            return   null;
        }catch( FailedOperationException e){
            System.out.println("error");
            return null;
        }catch( MalformattedElementException e){
            System.out.println("error");
            return null;
        }
    }

    private String realTestInstantiateNS(String nsId)
    {
        
        SMDriver sm = new SMDriver("192.168.137.17");
        InstantiateNsRequest req=null;
        if (nsId!=null){
            try{
            List<SapData> sapData = new ArrayList<>();
            List<PnfInfo> pnfInfo = new ArrayList<>();
            List<VnfInstanceData> vnfInstanceData = new ArrayList<>();
            List<String> nestedNsInstanceId = new ArrayList<>();
            List<VnfLocationConstraints> locationConstraints = new ArrayList<>();
            Map<String,String> additionalParamForNs = new HashMap<>();
            List<ParamsForVnf> additionalParamForVnf = new ArrayList<>();
            List<AffinityRule> additionalAffinityOrAntiAffinityRule= new ArrayList<>();
             req = new InstantiateNsRequest(nsId, "flavourid",
			    sapData,pnfInfo,vnfInstanceData,nestedNsInstanceId,
                locationConstraints, additionalParamForNs, additionalParamForVnf,
                new  Date(),"instantiationLevelId",additionalAffinityOrAntiAffinityRule);
                return sm.instantiateNs(req);
            
            }catch( MethodNotImplementedException e){
                System.out.println("error");
                return null;
            }catch( NotExistingEntityException e){
                System.out.println("error");
                return null;
            }catch( FailedOperationException e){
                System.out.println("error");
                return null;
            }catch( MalformattedElementException e){
                System.out.println("error");
                return null;
            }
        
        }else{
            System.out.println("null nsId");
            return null;
        }
    }
    @Test
    public void testInstantiateNs(){
        String nsId = realTestCreateNsIdentifier();
        realTestInstantiateNS(nsId);
        

    }

    private String getOperationStatus(){
       String nsId = realTestCreateNsIdentifier();
        String operationId =  realTestInstantiateNS(nsId);
       SMDriver sm = new SMDriver("192.168.137.17");
       try{
        return sm.getOperationStatus(operationId).name();
       }catch(Exception e){
            e.printStackTrace();
            return null;
       }
       

    }

    @Test
    public void testGetOperationStatus(){
        System.out.println("Operation status:"+getOperationStatus());
    }

    private String terminateNS(){
        String nsId = realTestCreateNsIdentifier();
        String operationId =  realTestInstantiateNS(nsId);
       SMDriver sm = new SMDriver("192.168.137.17");
       try{
           TerminateNsRequest req = new TerminateNsRequest(nsId,new Date());
        return sm.terminateNs(req);
       }catch(Exception e){
            e.printStackTrace();
            return null;
       }
    }
    
     @Test
    public void testTerminateNS(){
        System.out.println("Terminate ns:"+terminateNS());
    }
  
    
    @Test 
    public void testGetNsdByIdVersion() {
    	String nsdId = "vCDN_v02";
    	String nsdVersion = "0.2";
    	SMDriver smd = new SMDriver ("192.168.137.17");
    	try {
    		Map<String, String> filterParams = new HashMap<>();
    		filterParams.put("NSD_ID", nsdId);
    		filterParams.put("NSD_VERSION", nsdVersion);
    		Filter f = new Filter(filterParams);
			smd.queryNsd(new GeneralizedQueryRequest(f, null));
		} catch (MethodNotImplementedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MalformattedElementException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NotExistingEntityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FailedOperationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
  */
   
}