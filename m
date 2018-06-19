From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add support to use Last level cache
Date: Tue, 19 Jun 2018 14:04:44 +0530
Message-ID: <CAFp+6iFm29ufb2Pr7Gb-2O_aN3GQLH4rcyWhbQGZ3QiwCC8vPg@mail.gmail.com>
References: <20180615105329.26800-1-vivek.gautam@codeaurora.org>
	<20180615165232.GE2202@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180615165232.GE2202-5wv7dgnIgG8@public.gmane.org>
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
Cc: pdaly-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,


On Fri, Jun 15, 2018 at 10:22 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi Vivek,
>
> On Fri, Jun 15, 2018 at 04:23:29PM +0530, Vivek Gautam wrote:
>> Qualcomm SoCs have an additional level of cache called as
>> System cache or Last level cache[1]. This cache sits right
>> before the DDR, and is tightly coupled with the memory
>> controller.
>> The cache is available to all the clients present in the
>> SoC system. The clients request their slices from this system
>> cache, make it active, and can then start using it. For these
>> clients with smmu, to start using the system cache for
>> dma buffers and related page tables [2], few of the memory
>> attributes need to be set accordingly.
>> This change makes the related memory Outer-Shareable, and
>> updates the MAIR with necessary protection.
>>
>> The MAIR attribute requirements are:
>>     Inner Cacheablity = 0
>>     Outer Cacheablity = 1, Write-Back Write Allocate
>>     Outer Shareablity = 1
>
> Hmm, so is this cache coherent with the CPU or not?

Thanks for reviewing.
Yes, this LLC is cache coherent with CPU, so we mark for Outer-cacheable.
The different masters such as GPU as able to allocated and activate a slice
in this Last Level Cache.

> Why don't normal
> non-cacheable mappings allocated in the LLC by default?

Sorry, I couldn't fully understand your question here.
Few of the masters on qcom socs are not io-coherent, so for them
the IC has to be marked as 0.
But they are able to use the LLC with OC marked as 1.

Handling the IO-coherency is possibly a separate change to address?

>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index f7a96bcf94a6..8058e7205034 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -249,6 +249,7 @@ struct arm_smmu_domain {
>>       struct mutex                    init_mutex; /* Protects smmu pointer */
>>       spinlock_t                      cb_lock; /* Serialises ATS1* ops and TLB syncs */
>>       struct iommu_domain             domain;
>> +     bool                            has_sys_cache;
>>  };
>>
>>  struct arm_smmu_option_prop {
>> @@ -862,6 +863,8 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>>
>>       if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
>>               pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_NO_DMA;
>> +     if (smmu_domain->has_sys_cache)
>> +             pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_SYS_CACHE;
>>
>>       smmu_domain->smmu = smmu;
>>       pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>> @@ -1477,6 +1480,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>>       case DOMAIN_ATTR_NESTING:
>>               *(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>>               return 0;
>> +     case DOMAIN_ATTR_USE_SYS_CACHE:
>> +             *((int *)data) = smmu_domain->has_sys_cache;
>> +             return 0;
>
> I really don't like exposing this to clients directly like this,
> particularly as there aren't any in-tree users. I would prefer that we
> provide a way for the io-pgtable code to have its MAIR values overridden
> so that all non-coherent DMA ends up using the system cache.

>From the way it looks from the users of LLC (as also pointed to by Jordan),
the masters have to request and activate their slices in the cache, and then
they can start using it. Before that the transaction don't go through LLC.

But I will try to find out more on this.

Thanks & Regards
Vivek

>
> Will
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
