From: Olav Haugan <ohaugan@codeaurora.org>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu: Do not access non-existing SMR
 registers
Date: Wed, 06 Aug 2014 09:44:38 -0700
Message-ID: <53E25B76.6090208@codeaurora.org>
References: <1407175263-10699-1-git-send-email-ohaugan@codeaurora.org> <1407175263-10699-3-git-send-email-ohaugan@codeaurora.org> <20140806101948.GD23882@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20140806101948.GD23882@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "mitchelh@codeaurora.org" <mitchelh@codeaurora.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 8/6/2014 3:19 AM, Will Deacon wrote:
> Hi Olav,
> 
> On Mon, Aug 04, 2014 at 07:01:03PM +0100, Olav Haugan wrote:
>> The SMR registers do not exist when stream matching is not
>> supported by the hardware. Avoid writing to this register if not needed.
>>
>> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index c16431f..1f3a5b3 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -1731,7 +1731,10 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>>  
>>  	/* Mark all SMRn as invalid and all S2CRn as bypass */
>>  	for (i = 0; i < smmu->num_mapping_groups; ++i) {
>> -		writel_relaxed(~SMR_VALID, gr0_base + ARM_SMMU_GR0_SMR(i));
>> +		if (smmu->features & ARM_SMMU_FEAT_STREAM_MATCH) {
>> +			writel_relaxed(~SMR_VALID,
>> +					gr0_base + ARM_SMMU_GR0_SMR(i));
>> +		}
>>  		writel_relaxed(S2CR_TYPE_BYPASS,
>>  			gr0_base + ARM_SMMU_GR0_S2CR(i));
> 
> smmu->num_mapping_groups should be zero for an SMMU that doesn't include
> the SMR registers, so I don't think this change is needed. Are you seeing
> problems with real hardware?

Yes, you are correct. However, since that is the case we wouldn't be
setting the S2CR registers to bypass then? Seems like
num_mappings_groups should be initialized regardless whether stream
matching or stream indexing is used. SMMU_IDR0.NUMSMRG specifies the
number of stream mapping register groups (Section 2.5.2 of the ARM
SMMUv1-v2 spec). So with stream indexing support this register should
still tell us how many S2CR registers exist? As far as I can tell there
are no other register telling us how many S2CR registers exist. That
also brings up another point that there is no check in the code to
ensure we are not trying to program more than the available S2CR
registers when we use stream indexing.

No, I don't see any issue on real hardware.

Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
