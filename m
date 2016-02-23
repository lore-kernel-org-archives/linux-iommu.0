From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V2] iommu/arm-smmu-v2: Add support for 16 bit VMID
Date: Tue, 23 Feb 2016 09:53:44 -0800
Message-ID: <56CC9CA8.7080507@caviumnetworks.com>
References: <1455906813-9721-1-git-send-email-tchalamarla@caviumnetworks.com>
	<20160223112219.GE3966@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160223112219.GE3966-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Geethasowjanya.Akula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 02/23/2016 03:22 AM, Will Deacon wrote:
> Hi Tirumalesh,
>
> I still have some questions and comments about this.
>
> On Fri, Feb 19, 2016 at 10:33:33AM -0800, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org wrote:
>> From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>>
>> ARM-SMMUv2 supports upto 16 bit VMID. This patch enables
>> 16 bit VMID when HW supports.
>>
>> changes from V1:
>> 	- Remove DT Property and enable 16 bit VMID if ID says.
>
> Does this mean we can remove the comment from arm_smmu_init_context_bank
> about CBA2R initialisation, or is that behaviour still required by some
> parts? Further, what happens if we set CR0.VMID16EN on those
> implementations?
>

For Thunder, we can remove the prints, The parts which are target for 
upstreaming will check for VMID16EN and don't overwrite 8bit VMID.

>> Signed-off-by: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 24 +++++++++++++++++++++++-
>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index 59ee4b8..92caab8 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -93,6 +93,7 @@
>>   #define sCR0_VMIDPNE			(1 << 11)
>>   #define sCR0_PTM			(1 << 12)
>>   #define sCR0_FB				(1 << 13)
>> +#define sCR0_VMID16EN			(1 << 31)
>>   #define sCR0_BSU_SHIFT			14
>>   #define sCR0_BSU_MASK			0x3
>>
>> @@ -140,6 +141,7 @@
>>   #define ID2_PTFS_4K			(1 << 12)
>>   #define ID2_PTFS_16K			(1 << 13)
>>   #define ID2_PTFS_64K			(1 << 14)
>> +#define ID2_VMID16			(1 << 15)
>>
>>   /* Global TLB invalidation */
>>   #define ARM_SMMU_GR0_TLBIVMID		0x64
>> @@ -189,6 +191,8 @@
>>   #define ARM_SMMU_GR1_CBA2R(n)		(0x800 + ((n) << 2))
>>   #define CBA2R_RW64_32BIT		(0 << 0)
>>   #define CBA2R_RW64_64BIT		(1 << 0)
>> +#define CBA2R_VMID_SHIFT		16
>> +#define CBA2R_VMID_MASK			0xffff
>>
>>   /* Translation context bank */
>>   #define ARM_SMMU_CB_BASE(smmu)		((smmu)->base + ((smmu)->size >> 1))
>> @@ -297,6 +301,7 @@ struct arm_smmu_device {
>>   #define ARM_SMMU_FEAT_TRANS_S2		(1 << 3)
>>   #define ARM_SMMU_FEAT_TRANS_NESTED	(1 << 4)
>>   #define ARM_SMMU_FEAT_TRANS_OPS		(1 << 5)
>> +#define ARM_SMMU_FEAT_VMID16		(1 << 6)
>>   	u32				features;
>>
>>   #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
>> @@ -736,6 +741,10 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>>   #else
>>   		reg = CBA2R_RW64_32BIT;
>>   #endif
>> +		/* if 16bit VMID supported set VMID in CBA2R */
>> +		if (smmu->features & ARM_SMMU_FEAT_VMID16)
>> +			reg |= ARM_SMMU_CB_VMID(cfg) << CBA2R_VMID_SHIFT;
>> +
>>   		writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBA2R(cfg->cbndx));
>>   	}
>>
>> @@ -751,7 +760,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>>   	if (stage1) {
>>   		reg |= (CBAR_S1_BPSHCFG_NSH << CBAR_S1_BPSHCFG_SHIFT) |
>>   			(CBAR_S1_MEMATTR_WB << CBAR_S1_MEMATTR_SHIFT);
>> -	} else {
>> +	} else if (!(smmu->features & ARM_SMMU_FEAT_VMID16)) {
>> +		/*16 bit VMID is not supported set 8 bit VMID here */
>>   		reg |= ARM_SMMU_CB_VMID(cfg) << CBAR_VMID_SHIFT;
>>   	}
>>   	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
>> @@ -1508,6 +1518,9 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
>>   	/* Don't upgrade barriers */
>>   	reg &= ~(sCR0_BSU_MASK << sCR0_BSU_SHIFT);
>>
>> +	if (smmu->features & ARM_SMMU_FEAT_VMID16)
>> +		reg |= sCR0_VMID16EN;
>> +
>>   	/* Push the button */
>>   	__arm_smmu_tlb_sync(smmu);
>>   	writel(reg, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>> @@ -1658,6 +1671,10 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>   	size = arm_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
>>   	smmu->pa_size = size;
>>
>> +	/* See if 16bit VMID is supported */
>> +	if (id & ID2_VMID16)
>> +		smmu->features = ARM_SMMU_FEAT_VMID16;
>
> This should be |=
>
my bad.
>> +
>>   	/*
>>   	 * What the page table walker can address actually depends on which
>>   	 * descriptor format is in use, but since a) we don't know that yet,
>> @@ -1696,6 +1713,11 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>   		dev_notice(smmu->dev, "\tStage-2: %lu-bit IPA -> %lu-bit PA\n",
>>   			   smmu->ipa_size, smmu->pa_size);
>>
>> +	if (smmu->features & ARM_SMMU_FEAT_VMID16)
>> +		dev_notice(smmu->dev, "\t 16 bit VMID Supported.\n");
>> +	else
>> +		dev_notice(smmu->dev, "\t Only 8 bit VMID Supported.\n");
>
> Supporting "only" 8-bit VMIDs is usually plenty ;) In fact, your patch
> doesn't change the allocator, so we'll still use a zero-extended 8-bit
> VMID, so this print is fairly useless.
this will be removed.


>
> Will
>
