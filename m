From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: add support for iova_to_phys through
	ATS1PR
Date: Tue, 23 Sep 2014 18:12:00 -0700
Message-ID: <vnkwiokdx1nj.fsf@mitchelh-linux.qualcomm.com>
References: <1410460244-18943-1-git-send-email-mitchelh@codeaurora.org>
	<1410460244-18943-3-git-send-email-mitchelh@codeaurora.org>
	<20140922152614.GP25809@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140922152614.GP25809-5wv7dgnIgG8@public.gmane.org> (Will Deacon's message of "Mon,
	22 Sep 2014 16:26:14 +0100")
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 22 2014 at 08:26:14 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi Mitch,
>
> On Thu, Sep 11, 2014 at 07:30:44PM +0100, Mitchel Humpherys wrote:
>> Currently, we provide the iommu_ops.iova_to_phys service by doing a
>> table walk in software to translate IO virtual addresses to physical
>> addresses. On SMMUs that support it, it can be useful to ask the SMMU
>> itself to do the translation. This can be used to warm the TLBs for an
>> SMMU. It can also be useful for testing and hardware validation.
>> 
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
>> +	u32 tmp;
>> +	u64 phys;
>> +
>> +	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cfg->cbndx);
>> +
>> +	if (smmu->version == 1) {
>> +		u32 reg = iova & ~0xFFF;
>> +		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
>> +	} else {
>> +		u32 reg = iova & ~0xFFF;
>> +		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_LO);
>> +		reg = (iova & ~0xFFF) >> 32;
>> +		writel_relaxed(reg, cb_base + ARM_SMMU_CB_ATS1PR_HI);
>> +	}
>> +
>> +	if (readl_poll_timeout(cb_base + ARM_SMMU_CB_ATSR, tmp,
>> +				!(tmp & ATSR_ACTIVE), 10, ATSR_LOOP_TIMEOUT)) {
>> +		dev_err(dev,
>> +			"iova to phys timed out on 0x%pa for %s. Falling back to software table walk.\n",
>> +			&iova, dev_name(dev));
>
> dev_err already prints the device name.

Ah of course.  I'll remove the dev_name.

>
>> +		return arm_smmu_iova_to_phys_soft(domain, iova);
>> +	}
>> +
>> +	phys = readl_relaxed(cb_base + ARM_SMMU_CB_PAR_LO);
>> +	phys |= ((u64) readl_relaxed(cb_base + ARM_SMMU_CB_PAR_HI)) << 32;
>> +
>> +	if (phys & CB_PAR_F) {
>> +		dev_err(dev, "translation fault on %s!\n", dev_name(dev));
>> +		dev_err(dev, "PAR = 0x%llx\n", phys);
>> +	}
>> +	phys = (phys & 0xFFFFFFF000ULL) | (iova & 0x00000FFF);
>
> How does this work for 64k pages?

So at the moment we're always assuming that we're using v7/v8 long
descriptor format, right?  All I see in the spec (14.5.15 SMMU_CBn_PAR)
is that bits[47:12]=>PA[47:12]...  Or am I missing something completely?

As a mental note, if we add support for v7 short descriptors (which we
would like to do sometime soon) then we'll have to handle the
supersection case here as well.


-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
