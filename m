From: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Fix for ThunderX erratum #27704
Date: Thu, 12 Jan 2017 07:41:57 +0100
Message-ID: <b0eb1127-182e-63e3-6dd4-c3b40228b909@semihalf.com>
References: <1484135507-24872-1-git-send-email-tn@semihalf.com>
	<2c048126-a4d6-16af-987a-3174401a3960@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2c048126-a4d6-16af-987a-3174401a3960-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: Prasun.Kapoor-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Sunil.Goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Geethasowjanya.Akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11.01.2017 13:19, Robin Murphy wrote:
> On 11/01/17 11:51, Tomasz Nowicki wrote:
>> The goal of erratum #27704 workaround was to make sure that ASIDs and VMIDs
>> are unique across all SMMU instances on affected Cavium systems.
>>
>> Currently, the workaround code partitions ASIDs and VMIDs by increasing
>> global cavium_smmu_context_count which in turn becomes the base ASID and VMID
>> value for the given SMMU instance upon the context bank initialization.
>>
>> For systems with multiple SMMU instances this approach implies the risk
>> of crossing 8-bit ASID, like for CN88xx capable of 4 SMMUv2, 128 context bank each:
>> SMMU_0 (0-127 ASID RANGE)
>> SMMU_1 (127-255 ASID RANGE)
>> SMMU_2 (256-383 ASID RANGE) <--- crossing 8-bit ASID
>> SMMU_3 (384-511 ASID RANGE) <--- crossing 8-bit ASID
>
> I could swear that at some point in the original discussion it was said
> that the TLBs were only shared between pairs of SMMUs, so in fact 0/1
> and 2/3 are independent of each other

Indeed TLBs are only shared between pairs of SMMUs but the workaround 
makes sure ASIDs are unique across all SMMU instances so we do not have 
to bother about SMMUs probe order.

  - out of interest, have you
> managed to hit an actual problem in practice or is this patch just by
> inspection?

Except SMMU0/1 devices all other devices under other SMMUs will fail on 
guest power off/on. Since we try to invalidate tlb with 16bit ASID but 
we actually have 8 bit zero padded 16 bit entry.

>
> Of course, depending on the SMMUs to probe in the right order isn't
> particularly robust, so it's still probably a worthwhile change.
>
>> Since we use 8-bit ASID now we effectively misconfigure ASID[15:8] bits for
>> SMMU_CBn_TTBRm register. Also, we still use non-zero ASID[15:8] bits
>> upon context invalidation. This patch adds 16-bit ASID support for stage-1
>> AArch64 contexts for Cavium SMMUv2 model so that we use ASIDs consistently.
>>
>> Signed-off-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
>> ---
>>  drivers/iommu/arm-smmu.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index a60cded..ae8f059 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -260,6 +260,7 @@ enum arm_smmu_s2cr_privcfg {
>>
>>  #define TTBCR2_SEP_SHIFT		15
>>  #define TTBCR2_SEP_UPSTREAM		(0x7 << TTBCR2_SEP_SHIFT)
>> +#define TTBCR2_AS			(1 << 4)
>>
>>  #define TTBRn_ASID_SHIFT		48
>>
>> @@ -778,6 +779,9 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>>  			reg = pgtbl_cfg->arm_lpae_s1_cfg.tcr;
>>  			reg2 = pgtbl_cfg->arm_lpae_s1_cfg.tcr >> 32;
>>  			reg2 |= TTBCR2_SEP_UPSTREAM;
>> +			if (smmu->model == CAVIUM_SMMUV2 &&
>
> I'd be inclined to say "smmu->version == ARM_SMMU_V2" there, rather than
> make it Cavium-specific - we enable 16-bit VMID unconditionally where
> supported, so I don't see any reason not to handle 16-bit ASIDs in the
> same manner.

I agree, I will enable 16-bit ASID for ARM_SMMU_V2.

>
>> +			    cfg->fmt == ARM_SMMU_CTX_FMT_AARCH64)
>> +				reg2 |= TTBCR2_AS;
>>  		}
>>  		if (smmu->version > ARM_SMMU_V1)
>>  			writel_relaxed(reg2, cb_base + ARM_SMMU_CB_TTBCR2);
>>
>
> Either way:
>
> Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Thanks Robin!

Tomasz
