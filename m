From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Avoid ILLEGAL setting of STE.S1STALLD
Date: Wed, 20 Sep 2017 18:18:33 +0800
Message-ID: <ee8b2057-9c9d-6d25-d993-e1269ff33b38@huawei.com>
References: <1505365722-45418-1-git-send-email-xieyisheng1@huawei.com>
 <e297bd61-ab6f-21a2-9c5a-372d3c4c40b1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e297bd61-ab6f-21a2-9c5a-372d3c4c40b1@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Will Deacon <Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "liubo95@huawei.com" <liubo95@huawei.com>, "chenjiankang1@huawei.com" <chenjiankang1@huawei.com>
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

Thanks for reviewing.
On 2017/9/19 19:43, Jean-Philippe Brucker wrote:
> On 14/09/17 06:08, Yisheng Xie wrote:
>> According to Spec, it is ILLEGAL to set STE.S1STALLD if STALL_MODEL
>> is not 0b00, which means we should not disable stall mode if stall
>> or terminate mode is not configuable.
>>
>> As Jean-Philippe's suggestion, this patch introduce a feature bit
>> ARM_SMMU_FEAT_STALL_FORCE, which means smmu only supports stall force.
>> Therefore, we can avoid the ILLEGAL setting of STE.S1STALLD.by checking
>> ARM_SMMU_FEAT_STALL_FORCE.
>>
>> This patch keeps the ARM_SMMU_FEAT_STALLS as the meaning of stall supported
>> (force or configuable) to easy to expand the future function, i.e. we can
>> only use ARM_SMMU_FEAT_STALLS to check whether we should register fault
>> handle or enable master can_stall, etc to supporte platform SVM.
>>
>> After apply this patch, the feature bit and S1STALLD setting will be like:
>> STALL_MODEL  FEATURE                                              S1STALLD
>> 0b00         ARM_SMMU_FEAT_STALLS                                 0b1
>> 0b01         !ARM_SMMU_FEAT_STALLS && !ARM_SMMU_FEAT_STALL_FORCE  0b0
>> 0b10         ARM_SMMU_FEAT_STALLS && ARM_SMMU_FEAT_STALL_FORCE    0b0
> 
> Thanks for the patch. Since it's the same problem, could you also fix the
> context descriptor value? The spec says, in 5.5 Fault configuration:
> 
> "A CD (Stage 1 translation enabled) is considered ILLEGAL if one of the
> following applies:
> * SMMU_(S_)IDR0.STALL_MODEL == 0b10 and CD.S == 0."
Sure, I will fix this it in next version.

> 
> So I think we should always set CD.S if the SMMU has STALL_FORCE.
> 
> As Will pointed out, more work is needed for STALL_FORCE. We can't enable
> translation at all for devices that don't support stalling (e.g. PCI). We
> should force them into bypass or abort mode depending on the config. Maybe
> we can fix that later, after the devicetree property is added.
It is fare.

> 
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index e67ba6c..d2a3627 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -603,7 +603,8 @@ struct arm_smmu_device {
>>  #define ARM_SMMU_FEAT_TRANS_S1		(1 << 9)
>>  #define ARM_SMMU_FEAT_TRANS_S2		(1 << 10)
>>  #define ARM_SMMU_FEAT_STALLS		(1 << 11)
>> -#define ARM_SMMU_FEAT_HYP		(1 << 12)
>> +#define ARM_SMMU_FEAT_STALL_FORCE	(1 << 12)
>> +#define ARM_SMMU_FEAT_HYP		(1 << 13)
> 
> We probably should keep the feature bits backward compatible and only add
> new ones at the end. It's not ABI, but it's printed at boot time and I
> sometimes use them when inspecting the kernel output to see what an SMMU
> supports.
Take it, also will fixed it in next version.

Thanks
Yisheng Xie
> 
> Thanks,
> Jean
> 
>>  	u32				features;
>>  
>>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
>> @@ -1112,7 +1113,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
>>  #endif
>>  			 STRTAB_STE_1_STRW_NSEL1 << STRTAB_STE_1_STRW_SHIFT);
>>  
>> -		if (smmu->features & ARM_SMMU_FEAT_STALLS)
>> +		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
>> +		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
>>  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
>>  
>>  		val |= (ste->s1_cfg->cdptr_dma & STRTAB_STE_0_S1CTXPTR_MASK
>> @@ -2536,9 +2538,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>>  			 coherent ? "true" : "false");
>>  
>>  	switch (reg & IDR0_STALL_MODEL_MASK << IDR0_STALL_MODEL_SHIFT) {
>> -	case IDR0_STALL_MODEL_STALL:
>> -		/* Fallthrough */
>>  	case IDR0_STALL_MODEL_FORCE:
>> +		smmu->features |= ARM_SMMU_FEAT_STALL_FORCE;
>> +		/* Fallthrough */
>> +	case IDR0_STALL_MODEL_STALL:
>>  		smmu->features |= ARM_SMMU_FEAT_STALLS;
>>  	}
>>  
>>
> 
> 
> .
> 
