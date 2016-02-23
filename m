From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V2] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
Date: Tue, 23 Feb 2016 15:56:08 -0800
Message-ID: <56CCF198.3090409@caviumnetworks.com>
References: <1455820158-8529-1-git-send-email-tchalamarla@caviumnetworks.com>
	<56CC4E48.1060103@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <56CC4E48.1060103-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 02/23/2016 04:19 AM, Robin Murphy wrote:
> On 18/02/16 18:29, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org wrote:
>> From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>>
>> Due to Errata#27704 CN88xx SMMUv2,supports  only shared ASID and VMID
>> namespaces; specifically within a given node SMMU0 and SMMU1 share,
>> as does SMMU2 and SMMU3.
>>
>> This patch tries to address these issuee by supplying asid and vmid
>> base from devicetree.
>>
>> changes from V1:
>>     - rebased on top of 16 bit VMID patch
>>     - removed redundent options from DT
>>     - insted of transform, DT now supplies starting ASID/VMID
>>
>> Signed-off-by: Akula Geethasowjanya
>> <Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> Signed-off-by: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> ---
>>   .../devicetree/bindings/iommu/arm,smmu.txt         |  8 +++++
>>   drivers/iommu/arm-smmu.c                           | 37
>> +++++++++++++++-------
>>   2 files changed, 34 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> index bb7e569..80b8484 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> @@ -57,6 +57,14 @@ conditions.
>>
>>   - smmu-enable-vmid16 : Enable 16 bit VMID, if allowed.
>>
>> +- asid-base :    Buggy SMMUv2 implementations which doesn't satisfy the
>> +        ASID namespace needs, use this field to specify starting
>> +        ASID for the SMMU.
>> +
>> +- vmid-base :    Buggy SMMUv2 implementations which doesn't satisfy
>> the VMID
>> +        namespace needs, use this field to specify starting VMID
>> +        for the SMMU.
>> +
>
>  From how you've described the situation, this is still just some
> arbitrary number for the sake of a driver workaround and not an actual
> property of the hardware. Either way there should be a proper compatible
> string for this implementation, e.g. something like "cavium,cn88xx-smmu".
>
> Given that, you then shouldn't actually need anything else, because you
> can simply keep track of how many Cavium SMMUs have been probed and
> automatically generate a suitable offset, e.g. (smmu->index *
> ARM_SMMU_MAX_CBS) to ensure global ASID/VMID uniqueness.

This particular solution might not be accurate in all cases. what 
happens if SMMU stage 1 is used by a guest?
>
> Robin.
>
>>   Example:
>>
>>           smmu {
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 003c442..dc46b9a 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -320,6 +320,9 @@ struct arm_smmu_device {
>>       unsigned long            ipa_size;
>>       unsigned long            pa_size;
>>
>> +    u32                asid_base;
>> +    u32                vmid_base;
>> +
>>       u32                num_global_irqs;
>>       u32                num_context_irqs;
>>       unsigned int            *irqs;
>> @@ -335,8 +338,8 @@ struct arm_smmu_cfg {
>>   };
>>   #define INVALID_IRPTNDX            0xff
>>
>> -#define ARM_SMMU_CB_ASID(cfg)        ((cfg)->cbndx)
>> -#define ARM_SMMU_CB_VMID(cfg)        ((cfg)->cbndx + 1)
>> +#define ARM_SMMU_CB_ASID(smmu, cfg)    ((u16)((smmu)->asid_base +
>> (cfg)->cbndx))
>> +#define ARM_SMMU_CB_VMID(smmu, cfg)    ((u16)((smmu)->vmid_base +
>> (cfg)->cbndx))
>>
>>   enum arm_smmu_domain_stage {
>>       ARM_SMMU_DOMAIN_S1 = 0,
>> @@ -576,11 +579,11 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>>
>>       if (stage1) {
>>           base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
>> -        writel_relaxed(ARM_SMMU_CB_ASID(cfg),
>> +        writel_relaxed(ARM_SMMU_CB_ASID(smmu, cfg),
>>                      base + ARM_SMMU_CB_S1_TLBIASID);
>>       } else {
>>           base = ARM_SMMU_GR0(smmu);
>> -        writel_relaxed(ARM_SMMU_CB_VMID(cfg),
>> +        writel_relaxed(ARM_SMMU_CB_VMID(smmu, cfg),
>>                      base + ARM_SMMU_GR0_TLBIVMID);
>>       }
>>
>> @@ -602,7 +605,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned
>> long iova, size_t size,
>>
>>           if (!IS_ENABLED(CONFIG_64BIT) || smmu->version ==
>> ARM_SMMU_V1) {
>>               iova &= ~12UL;
>> -            iova |= ARM_SMMU_CB_ASID(cfg);
>> +            iova |= ARM_SMMU_CB_ASID(smmu, cfg);
>>               do {
>>                   writel_relaxed(iova, reg);
>>                   iova += granule;
>> @@ -610,7 +613,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned
>> long iova, size_t size,
>>   #ifdef CONFIG_64BIT
>>           } else {
>>               iova >>= 12;
>> -            iova |= (u64)ARM_SMMU_CB_ASID(cfg) << 48;
>> +            iova |= (u64)ARM_SMMU_CB_ASID(smmu, cfg) << 48;
>>               do {
>>                   writeq_relaxed(iova, reg);
>>                   iova += granule >> 12;
>> @@ -630,7 +633,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned
>> long iova, size_t size,
>>   #endif
>>       } else {
>>           reg = ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_TLBIVMID;
>> -        writel_relaxed(ARM_SMMU_CB_VMID(cfg), reg);
>> +        writel_relaxed(ARM_SMMU_CB_VMID(smmu, cfg), reg);
>>       }
>>   }
>>
>> @@ -744,7 +747,7 @@ static void arm_smmu_init_context_bank(struct
>> arm_smmu_domain *smmu_domain,
>>   #endif
>>           /* if 16bit VMID required set VMID in CBA2R */
>>           if (smmu->options & ARM_SMMU_OPT_ENABLE_VMID16)
>> -            reg |= ARM_SMMU_CB_VMID(cfg) << CBA2R_VMID_SHIFT;
>> +            reg |= ARM_SMMU_CB_VMID(smmu, cfg) << CBA2R_VMID_SHIFT;
>>
>>           writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));
>>       }
>> @@ -763,7 +766,7 @@ static void arm_smmu_init_context_bank(struct
>> arm_smmu_domain *smmu_domain,
>>               (CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
>>       } else if (!(smmu->options & ARM_SMMU_OPT_ENABLE_VMID16)) {
>>           /*16 bit VMID is not enabled set 8 bit VMID here */
>> -        reg |= ARM_SMMU_CB_VMID(cfg) << CBAR_VMID_SHIFT;
>> +        reg |= ARM_SMMU_CB_VMID(smmu, cfg) << CBAR_VMID_SHIFT;
>>       }
>>       writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
>>
>> @@ -771,11 +774,11 @@ static void arm_smmu_init_context_bank(struct
>> arm_smmu_domain *smmu_domain,
>>       if (stage1) {
>>           reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
>>
>> -        reg64 |= ((u64)ARM_SMMU_CB_ASID(cfg)) << TTBRn_ASID_SHIFT;
>> +        reg64 |= ((u64)ARM_SMMU_CB_ASID(smmu, cfg)) << TTBRn_ASID_SHIFT;
>>           smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR0);
>>
>>           reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
>> -        reg64 |= ((u64)ARM_SMMU_CB_ASID(cfg)) << TTBRn_ASID_SHIFT;
>> +        reg64 |= ((u64)ARM_SMMU_CB_ASID(smmu, cfg)) << TTBRn_ASID_SHIFT;
>>           smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR1);
>>       } else {
>>           reg64 = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
>> @@ -1812,6 +1815,18 @@ static int arm_smmu_device_dt_probe(struct
>> platform_device *pdev)
>>
>>       parse_driver_options(smmu);
>>
>> +    if (of_property_read_u32(dev->of_node, "#asid-base",
>> +                 &smmu->asid_base)) {
>> +        smmu->asid_base = 0;
>> +    }
>> +
>> +    if (of_property_read_u32(dev->of_node, "#vmid-base",
>> +                 &smmu->vmid_base)) {
>> +        smmu->vmid_base = 1;
>> +    }
>> +    if (smmu->vmid_base == 0)
>> +        smmu->vmid_base = 1;
>> +
>>       if (smmu->version > ARM_SMMU_V1 &&
>>           smmu->num_context_banks != smmu->num_context_irqs) {
>>           dev_err(dev,
>>
>
