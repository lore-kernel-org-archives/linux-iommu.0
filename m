From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 3/6] iommu/arm-smmu: add support for iova_to_phys through
	ATS1PR
Date: Tue, 19 Aug 2014 11:12:41 -0700
Message-ID: <vnkwa970qrfq.fsf@mitchelh-linux.qualcomm.com>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
	<1407891099-24641-4-git-send-email-mitchelh@codeaurora.org>
	<20140819124431.GL23128@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140819124431.GL23128-5wv7dgnIgG8@public.gmane.org> (Will Deacon's message of "Tue,
	19 Aug 2014 13:44:32 +0100")
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
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 19 2014 at 05:44:32 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Aug 13, 2014 at 01:51:36AM +0100, Mitchel Humpherys wrote:
>> Currently, we provide the iommu_ops.iova_to_phys service by doing a
>> table walk in software to translate IO virtual addresses to physical
>> addresses. On SMMUs that support it, it can be useful to ask the SMMU
>> itself to do the translation. This can be used to warm the TLBs for an
>> SMMU. It can also be useful for testing and hardware validation.
>
> I'm not really sold on the usefulness of this feature. If you want hardware
> validation features, I'd rather do something through debugfs, but your
> use-case for warming the TLBs is intriguing. Do you have an example use-case
> with performance figures?

I'm afraid I don't have an example use case or performance numbers at
the moment...

>> Since the address translation registers are optional on SMMUv2, only
>> enable hardware translations when using SMMUv1 or when SMMU_IDR0.S1TS=1
>> and SMMU_IDR0.ATOSNS=0, as described in the ARM SMMU v1-v2 spec.
>
> [...]
>
>> +static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
>> +					dma_addr_t iova)
>> +{
>> +	struct arm_smmu_domain *smmu_domain = domain->priv;
>> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>> +	struct device *dev = smmu->dev;
>> +	void __iomem *cb_base;
>> +	int count = 0;
>> +	u64 phys;
>> +
>> +	arm_smmu_enable_clocks(smmu);
>> +
>> +	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
>> +
>> +	if (smmu->version == 1) {
>> +		u32 reg = iova & 0xFFFFF000;
>> +		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
>> +	} else {
>> +		u64 reg = iova & 0xfffffffffffff000;
>> +		writeq_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
>
> We don't have writeq for arch/arm/.

Ah yes looks like this is an MSM-ism that never made it upstream since
it wouldn't be guaranteed to be atomic. I'll make sure to do arm32
compiles on upstream kernels for future patches, sorry!

I guess we could use <asm-generic/io-64-nonatomic-lo-hi.h> but I can
also re-work this to be two separate writel's.

>> +	}
>> +
>> +	mb();
>
> Why?

My thought was that if we start polling ATSR_ACTIVE prematurely (before
the write to ATS1PR actually finishes) all heck could break loose? Not
sure if that's a bogus assumption due to device memory being strongly
ordered?

>> +	while (readl_relaxed(cb_base + ARM_SMMU_CB_ATSR) & ATSR_ACTIVE) {
>> +		if (++count == ATSR_LOOP_TIMEOUT) {
>> +			dev_err(dev,
>> +				"iova to phys timed out on 0x%pa for %s. Falling back to software table walk.\n",
>> +				&iova, dev_name(dev));
>> +			arm_smmu_disable_clocks(smmu);
>> +			return arm_smmu_iova_to_phys_soft(domain, iova);
>> +		}
>> +		cpu_relax();
>> +	}
>
> Do you know what happened to Olav's patches to make this sort of code
> generic?

I assume you're talking about this, right?

    http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/267943.html

Yeah looks like he never sent an update since it was part of a series
that wasn't going to make it in (the qsmmu driver). I can always bring
that patch (actually Matt Wagantall's patch) in here and rework this to
use that.

>
>> @@ -2005,6 +2073,11 @@ int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>>  		return -ENODEV;
>>  	}
>>  
>> +	if (smmu->version == 1 || (!(id & ID0_ATOSNS) && (id & ID0_S1TS))) {
>
> Are you sure about this? The v2 spec says that is ATOSNS is clear then S1TS
> is also clear.

I was looking at Section 4.1.1 of ARM IHI 0062C ID091613 which states:

    In SMMUv2, the address translation registers are OPTIONAL. The
    address translation registers are implemented only when both:

        o The SMMU_IDR0.S1TS bit is set to 1.
        o The SMMU_IDR0.ATOSNS bit is set to 0.

I assume you're referring to section 9.6.1 of the same document:

    ATOSNS, bit[26]
    Address Translation Operations Not Supported. The possible values of
    this bit are:

        0 Address translation operations are supported. Stage 1
          translation is not supported, that is, the S1TS bit is set to 0.

        1 Address translation operations are not supported. Stage 1
          translation is supported, that is, the S1TS bit is set to 1.

If that really means that S1TS and ATOSNS always have the same value
then Section 4.1.1 doesn't make any sense. Or am I missing something?



-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
