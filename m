From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V2] iommu/arm-smmu-v2: ThunderX mis-extends 64bit registers
Date: Thu, 06 Aug 2015 17:31:24 +0100
Message-ID: <55C38BDC.4030304@arm.com>
References: <1438793668-15597-1-git-send-email-tchalamarla@caviumnetworks.com>
	<20150806161625.GJ25483@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150806161625.GJ25483-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tirumalesh Chalamarla <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robert.richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <robert.richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/08/15 17:16, Will Deacon wrote:
> Hi Tirumalesh,
>
> I think this looks pretty good now, just one small comment below.
>
> On Wed, Aug 05, 2015 at 05:54:28PM +0100, Tirumalesh Chalamarla wrote:
[...]
>> -#define TTBRn_HI_ASID_SHIFT            16
>> +#define TTBRn_ASID_SHIFT		48
>>
>>   #define FSR_MULTI			(1 << 31)
>>   #define FSR_SS				(1 << 30)
>> @@ -762,22 +774,17 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
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
>> +		u64 reg64 = pgtbl_cfg->arm_lpae_s1_cfg.ttbr[0];
>
> Can we move this declaration to the start of the function along with
> u32 reg, please? It's used in both cases of the if/else block so it
> might be a tad cleaner.

We could also drop the _LO suffix from the relevant #defines (so they 
match the architectural names) and remove the now-unused _HI versions 
entirely.

Robin.

>
> Will
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
