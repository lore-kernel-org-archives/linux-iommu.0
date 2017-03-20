From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V3 3/5] drivers: arm-smmu: Add clock support for
	QCOM_SMMUV2
Date: Mon, 20 Mar 2017 20:01:53 +0530
Message-ID: <fa0a35be-a717-44ca-1ec5-208827bfb503@codeaurora.org>
References: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
	<1489073748-3659-4-git-send-email-sricharan@codeaurora.org>
	<20170316211039.rbqq262syalyfcs6@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170316211039.rbqq262syalyfcs6@rob-hp-laptop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

On 3/17/2017 2:40 AM, Rob Herring wrote:
> On Thu, Mar 09, 2017 at 09:05:46PM +0530, Sricharan R wrote:
>> The QCOM_SMMUV2 is an implementation of the arm,smmu-v2 architecture.
>> The qcom,smmu is instantiated for each of the multimedia cores (for eg)
>> Venus (video encoder/decoder), mdp (display) etc, and they are connected
>> to the Multimedia Aggregator Interconnect (MMAGIC). So the access to
>> any of the MMU's registers, as well as MMU's downstream bus access,
>> requires the specified MMAGIC clocks to be enabled. So adding a new
>> binding for the qcom,smmu-v2 and the required mmagic clock bindings for
>> the same. Also adding the support for enabling the qcom,smmu-v2 clocks in
>> the driver.
>>
>>                -------------  ---------
>>                |   VENUS   |  | MDP   |
>> 	       |	   |  |       |
>> 	       -------------  --------
>> 		     |           |
>> 		     |           |
>>                   ------      ---------
>>                   |SMMU |     | SMMU  |
>>                   |	|     |       |
>>                   ------      --------
>> 		    |            |
>> 		    |            |
>>        -----------------------------------------
>>        |	MMAGIC INTERCONNECT (MMSS NOC) |
>>        |                                       |
>>        -----------------------------------------
>>                    |                 |
>> 		   |           ----------------------------------
>>                  -----         | 	SYSTEM NOC		|
>>                  |DDR|	       |				|
>>                  -----         ---------------------------------
>> 		   |		    |
>>                    |               ------
>> 		   |<-------------| CPU|
>> 				  ------
>>
>> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  .../devicetree/bindings/iommu/arm,smmu.txt         |   8 ++
>>  drivers/iommu/arm-smmu.c                           | 124 +++++++++++++++++++++
>>  2 files changed, 132 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> index b369c13..88e02d6 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> @@ -17,6 +17,7 @@ conditions.
>>                          "arm,mmu-401"
>>                          "arm,mmu-500"
>>                          "cavium,smmu-v2"
>> +			"qcom,smmu-v2"
>
> I know Cavium did it, but I'd prefer to see SoC specific compatibles
> here.

ok, will change it to be soc specific.

>
>>
>>                    depending on the particular implementation and/or the
>>                    version of the architecture implemented.
>> @@ -74,6 +75,13 @@ conditions.
>>                    "cfg_clk" is optional if required to access the TCU's programming
>>                    interface, apart from the "tcu_clk".
>>
>> +		  Should have "mmagic_ahb_clk", "mmagic_cfg_ahb_clk",
>> +                              "smmu_core_ahb_clk", "smmu_core_axi_clk",
>> +                              "mmagic_core_axi_clk" for "qcom,smmu-v2"
>
> This is instead of the above clocks?
>

These clocks are for 'qcom,smmu-v2'. I should have put
that first, then the clock names.

> Are these clocks all really part of the SMMU or are the mmagic clocks
> working around no proper driver for the mmagic?
>

infact because of the absence of the mmagic driver to handle it.
But i think, i will have to rework this, because handling mmagic
clocks is going to pushed elsewhere, to the the gdscs(powerdomains).
So adding the mmagic clocks should not be required here after that.

Regards,
  Sricharan

>> +
>> +		  "mmagic_core_axi_clk" is required for smmu's access to the
>> +                   downstream bus and rest for the smmu's register group access.
>> +
>>  - clocks:         Phandles for respective clocks described by clock-names.
>>
>>  - power-domains:  Phandles to SMMU's power domain specifier. This is
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member of Code Aurora Forum, hosted by The Linux Foundation
