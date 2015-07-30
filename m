From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v2: ThunderX(errata-23399) mis-extends
	64bit registers
Date: Thu, 30 Jul 2015 20:08:57 +0100
Message-ID: <55BA7649.3080608@arm.com>
References: <1438278906-29627-1-git-send-email-tchalamarla@caviumnetworks.com>
	<20150730184523.GC16663@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150730184523.GC16663-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robert.richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <robert.richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 30/07/15 19:45, Will Deacon wrote:
> Hello,
>
> On Thu, Jul 30, 2015 at 06:55:06PM +0100, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org wrote:
>> From: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>>
>> The SMMU architecture defines two different behaviors when 64-bit
>> registers are written with 32-bit writes.  The first behavior causes
>> zero extension into the upper 32-bits.  The second behavior splits a
>> 64-bit register into "normal" 32-bit register pairs.
>>
>> On some passes of ThunderX,
>> the following registers incorrectly zero extended when they should
>> instead behave as normal 32-bit register pairs:
>>
>>    SMMU()_(S)GFAR
>>    SMMU()_NSGFAR
>>    SMMU()_CB()_TTBR0
>>    SMMU()_CB()_TTBR1
>>    SMMU()_CB()_FAR
>>
>> Signed-off-by: Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 51 ++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 36 insertions(+), 15 deletions(-)
>
> [...]
>
>> @@ -762,22 +766,39 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
>>
>>   	/* TTBRs */
>>   	if (stage1) {
>> -		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
>> -		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
>> -		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0] >> 32;
>> -		reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
>> -		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
>> -
>> -		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
>> -		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_LO);
>> -		reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1] >> 32;
>> -		reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
>> -		writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_HI);
>> +		if (smmu->options & ARM_SMMU_OPT_64BIT_WRITES_ONLY) {
>> +			reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
>> +			reg64 |= ((u64) ARM_SMMU_CB_ASID(cfg)) <<
>> +						(TTBRn_HI_ASID_SHIFT + 32);
>> +			writeq_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
>> +
>> +			reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
>> +			reg64 |= ((u64)ARM_SMMU_CB_ASID(cfg)) <<
>> +						(TTBRn_HI_ASID_SHIFT + 32);
>> +			writeq_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_LO);
>> +		} else {
>> +			reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
>> +			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_LO);
>> +			reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0] >> 32;
>> +			reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
>> +			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR0_HI);
>> +
>> +			reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1];
>> +			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_LO);
>> +			reg = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[1] >> 32;
>> +			reg |= ARM_SMMU_CB_ASID(cfg) << TTBRn_HI_ASID_SHIFT;
>> +			writel_relaxed(reg, cb_base + ARM_SMMU_CB_TTBR1_HI);
>> +		}
>
> I'm fine with making this sort of change if you need it, but this is pretty
> ugly. Worse, it won't compile for 32-bit ARM.
>
> How about we add a wrapper around these, say smmu_writeq(...), which can
> then either expand to 2x writel_relaxed or 1x writeq_relaxed depending on
> CONFIG_64BIT and your erratum workaround?

Would we even need a specific erratum workaround then? I don't see an 
issue with always using writeq on 64-bit, and there's not much we can do 
for 32-bit if it has no way to write the upper half of the TTBR on this 
thing.

Robin.

>
> Don't forgot to update the ATOS code too (so you need to write the high word
> first).
>
> Will
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
