From: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
Date: Tue, 9 Feb 2016 17:07:47 +0000
Message-ID: <D3352A05-3713-457E-AB65-1DEFB6F9E912@caviumnetworks.com>
References: <1454698027-20911-1-git-send-email-tchalamarla@caviumnetworks.com>
	<56B9D2F4.8070308@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <56B9D2F4.8070308-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
Content-ID: <71739E5B83370744B856CD882181BE45-Tk6F3M/euE6cE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Akula, Geethasowjanya" <Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org






On 2/9/16, 3:52 AM, "Robin Murphy" <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:

>On 05/02/16 18:47, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org wrote:
>> From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>>
>> An issue exists whereby the Linux kernel requires that ASIDs are a
>> unique namespace per SMMU.
>
>I too tend to consider the SMMUv2 architecture an "issue", but we should 
>probably still call it by its name ;)
>
>>  That ASID-local choice conflicts with the
>> CN88xx SMMU, where only shared ASID namespaces are supported;
>> specifically within a given node SMMU0 and SMMU1 share, as does SMMU2
>> and SMMU3. CN88xx SMMU also requires global VMIDs.
>
>"Global" meaning unique across all 4 SMMUs? Or just unique across each 
>pair as per ASIDs?...
>
>> This patch tries to address these issuee by supplying asid and vmid
>> transformations from devicetree.
>>
>> Signed-off-by: Akula Geethasowjanya <Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> Signed-off-by: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> ---
>>   .../devicetree/bindings/iommu/arm,smmu.txt         | 16 ++++++
>>   drivers/iommu/arm-smmu.c                           | 59 ++++++++++++++++++----
>>   2 files changed, 65 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> index 7180745..eef06d0 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> @@ -55,6 +55,22 @@ conditions.
>>                     aliases of secure registers have to be used during
>>                     SMMU configuration.
>>
>> +- thunderx,smmu-asid-transform	: Enable proper handling for buggy
>> +		  implementations that require special transformations
>> +		  for smmu asid. if this property exists asid-transform
>> +		  property must be present.
>> +
>> +- thunderx,smmu-vmid-transform	: Enable proper handling for buggy
>> +		  implementations that require special transformations
>> +		  for smmu vmid. if this property exists vmid-transform
>> +		  property must be present.
>> +
>> +- asid-transform 	: Transform mask that needs to be applied to asid.
>> +			This property has to be specified as '/bits/ 8' value.
>> +
>> +- vmid-transform 	: Transform mask that needs to be applied to vmid.
>> +			This property has to be specified as '/bits/ 8' value.
>> +
>
>...because I've seen a ThunderX boot log indicating 4x128 context banks, 
>and I don't see how applying an 8-bit mask to an 8-bit value is going to 
>produce anything _globally_ unique in that case.
>
>Regardless, I'm not sure this is an accurate description of the hardware 
>as DT should be - this is more implying that each SMMU _requires_ a 
>particular set of ASIDs/VMIDs to be used, which is not the same thing 
>that the commit message and other comments say.

I am rewriting this patch to include additional patches to support 16bit VMID and ASID. Will rebase this patch on top of it.
Though for 128 bit 7 bits are sufficient I thought it is still good idea to have this on top of 16bit VMID and ASID. 
>
>Robin.
>
>>   Example:
>>
>>           smmu {
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 59ee4b8..8047834 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -300,8 +300,12 @@ struct arm_smmu_device {
>>   	u32				features;
>>
>>   #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
>> +#define ARM_SMMU_OPT_TRANSFORM_ASID	(1 << 1)
>> +#define ARM_SMMU_OPT_TRANSFORM_VMID	(1 << 2)
>>   	u32				options;
>>   	enum arm_smmu_arch_version	version;
>> +	u8				asid_transform;
>> +	u8				vmid_transform;
>>
>>   	u32				num_context_banks;
>>   	u32				num_s2_context_banks;
>> @@ -330,8 +334,25 @@ struct arm_smmu_cfg {
>>   };
>>   #define INVALID_IRPTNDX			0xff
>>
>> -#define ARM_SMMU_CB_ASID(cfg)		((cfg)->cbndx)
>> -#define ARM_SMMU_CB_VMID(cfg)		((cfg)->cbndx + 1)
>> +/*
>> + * ThunderX has a unique requirement because of ERRATA#27704
>> + * An issue exists whereby the Linux kernel requires that ASIDs are a
>> + * unique namespace per SMMU.  That ASID-local choice conflicts with the
>> + * CN88xx SMMU, where only shared ASID namespaces are supported;
>> + * specifically within a given node SMMU0 and SMMU1 share, as does SMMU2
>> + * and SMMU3.
>> + * CN88xx SMMU also requires global VMIDs.
>> + */
>> +
>> +#define ARM_SMMU_CB_ASID(smmu, cfg)					\
>> +		(((smmu)->options & ARM_SMMU_OPT_TRANSFORM_ASID)	\
>> +		? ((cfg)->cbndx | (smmu)->asid_transform)		\
>> +		: ((cfg)->cbndx))
>> +
>> +#define ARM_SMMU_CB_VMID(smmu, cfg)					\
>> +		(((smmu)->options & ARM_SMMU_OPT_TRANSFORM_VMID)	\
>> +		? (((cfg)->cbndx + 1) | (smmu)->vmid_transform)		\
>> +		: ((cfg)->cbndx + 1))
>>
>>   enum arm_smmu_domain_stage {
>>   	ARM_SMMU_DOMAIN_S1 = 0,
>> @@ -361,6 +382,8 @@ struct arm_smmu_option_prop {
>>
>>   static struct arm_smmu_option_prop arm_smmu_options[] = {
>>   	{ ARM_SMMU_OPT_SECURE_CFG_ACCESS, "calxeda,smmu-secure-config-access" },
>> +	{ ARM_SMMU_OPT_TRANSFORM_ASID, "thunderx,smmu-asid-transform" },
>> +	{ ARM_SMMU_OPT_TRANSFORM_VMID, "thunderx,smmu-vmid-transform" },
>>   	{ 0, NULL},
>>   };
>>
>> @@ -570,11 +593,11 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>>
>>   	if (stage1) {
>>   		base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
>> -		writel_relaxed(ARM_SMMU_CB_ASID(cfg),
>> +		writel_relaxed(ARM_SMMU_CB_ASID(smmu, cfg),
>>   			       base + ARM_SMMU_CB_S1_TLBIASID);
>>   	} else {
>>   		base = ARM_SMMU_GR0(smmu);
>> -		writel_relaxed(ARM_SMMU_CB_VMID(cfg),
>> +		writel_relaxed(ARM_SMMU_CB_VMID(smmu, cfg),
>>   			       base + ARM_SMMU_GR0_TLBIVMID);
>>   	}
>>
>> @@ -596,7 +619,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>>
>>   		if (!IS_ENABLED(CONFIG_64BIT) || smmu->version == ARM_SMMU_V1) {
>>   			iova &= ~12UL;
>> -			iova |= ARM_SMMU_CB_ASID(cfg);
>> +			iova |= ARM_SMMU_CB_ASID(smmu, cfg);
>>   			do {
>>   				writel_relaxed(iova, reg);
>>   				iova += granule;
>> @@ -604,7 +627,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>>   #ifdef CONFIG_64BIT
>>   		} else {
>>   			iova >>= 12;
>> -			iova |= (u64)ARM_SMMU_CB_ASID(cfg) << 48;
>> +			iova |= (u64)ARM_SMMU_CB_ASID(smmu, cfg) << 48;
>>   			do {
>>   				writeq_relaxed(iova, reg);
>>   				iova += granule >> 12;
>> @@ -624,7 +647,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
>>   #endif
>>   	} else {
>>   		reg = ARM_SMMU_GR0(smmu) + ARM_SMMU_GR0_TLBIVMID;
>> -		writel_relaxed(ARM_SMMU_CB_VMID(cfg), reg);
>> +		writel_relaxed(ARM_SMMU_CB_VMID(smmu, cfg), reg);
>>   	}
>>   }
>>
>> @@ -752,7 +775,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>>   		reg |= (CBAR_S1_BPSHCFG_NSH << CBAR_S1_BPSHCFG_SHIFT) |
>>   			(CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
>>   	} else {
>> -		reg |= ARM_SMMU_CB_VMID(cfg) << CBAR_VMID_SHIFT;
>> +		reg |= ARM_SMMU_CB_VMID(smmu, cfg) << CBAR_VMID_SHIFT;
>>   	}
>>   	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
>>
>> @@ -760,11 +783,11 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>>   	if (stage1) {
>>   		reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
>>
>> -		reg64 |= ((u64)ARM_SMMU_CB_ASID(cfg)) << TTBRn_ASID_SHIFT;
>> +		reg64 |= ((u64)ARM_SMMU_CB_ASID(smmu, cfg)) << TTBRn_ASID_SHIFT;
>>   		smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR0);
>>
>>   		reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
>> -		reg64 |= ((u64)ARM_SMMU_CB_ASID(cfg)) << TTBRn_ASID_SHIFT;
>> +		reg64 |= ((u64)ARM_SMMU_CB_ASID(smmu, cfg)) << TTBRn_ASID_SHIFT;
>>   		smmu_writeq(reg64, cb_base + ARM_SMMU_CB_TTBR1);
>>   	} else {
>>   		reg64 = pgtbl_cfg->arm_lpae_s2_cfg.vttbr;
>> @@ -1793,6 +1816,22 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>>
>>   	parse_driver_options(smmu);
>>
>> +	if (smmu->options & ARM_SMMU_OPT_TRANSFORM_ASID) {
>> +		if (of_property_read_u8(dev->of_node, "#asid-transform",
>> +					 &smmu->asid_transform)) {
>> +			dev_err(dev, "missing #asid-transform property\n");
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>> +	if (smmu->options & ARM_SMMU_OPT_TRANSFORM_VMID) {
>> +		if (of_property_read_u8(dev->of_node, "#vmid-transform",
>> +					 &smmu->vmid_transform)) {
>> +			dev_err(dev, "missing #vmid-transform property\n");
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>>   	if (smmu->version > ARM_SMMU_V1 &&
>>   	    smmu->num_context_banks != smmu->num_context_irqs) {
>>   		dev_err(dev,
>>
>
