From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v2] iommu/arm-smmu: avoid calling request_irq in atomic
	context
Date: Mon, 28 Jul 2014 16:48:05 -0700
Message-ID: <vnkwoaw9oxje.fsf@mitchelh-linux.qualcomm.com>
References: <1406572692-27460-1-git-send-email-mitchelh@codeaurora.org>
	<20140728190327.GU15536@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140728190327.GU15536-5wv7dgnIgG8@public.gmane.org> (Will Deacon's message of "Mon,
	28 Jul 2014 20:03:27 +0100")
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 28 2014 at 12:03:27 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> Hi Mitchel,
>
> Thanks for the quick v2, but now I spotted a problem :)
>
> On Mon, Jul 28, 2014 at 07:38:12PM +0100, Mitchel Humpherys wrote:
>>  static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>> @@ -1172,10 +1158,11 @@ static void arm_smmu_domain_remove_master(struct arm_smmu_domain *smmu_domain,
>>  
>>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>  {
>> -	int ret = -EINVAL;
>> +	int irq, ret = -EINVAL;
>>  	struct arm_smmu_domain *smmu_domain = domain->priv;
>>  	struct arm_smmu_device *smmu;
>> -	struct arm_smmu_master_cfg *cfg;
>> +	struct arm_smmu_master_cfg *master_cfg;
>> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>>  	unsigned long flags;
>>  
>>  	smmu = dev_get_master_dev(dev)->archdata.iommu;
>> @@ -1203,12 +1190,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>>  	}
>>  	spin_unlock_irqrestore(&smmu_domain->lock, flags);
>>  
>> +	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
>> +	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
>> +			  "arm-smmu-context-fault", domain);
>> +	if (IS_ERR_VALUE(ret)) {
>> +		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
>> +			cfg->irptndx, irq);
>> +		cfg->irptndx = INVALID_IRPTNDX;
>> +		return ret;
>> +	}
>
> This changes the driver behaviour, so we'll request an IRQ for the domain
> *every* time a master is successfuly added to the domain, as opposed to
> the first time a master is added (when we can do the lazy init).

Woops, you're absolutely right. Good catch.

>
> Maybe we could rework the code so that it looks like:
>
>   dom_smmu = ACCESS_ONCE(&smmu_domain->smmu);

Why do we need an ACCESS_ONCE here? I thought the purpose of ACCESS_ONCE
was to prevent the compiler from optimizing away the access (like a
variable being pulled out of a for-loop because it's not modified within
the loop (but could be modified on another thread)), but since we
haven't accessed smmu_domain->smmu before this point and your proposed
re-check below will be on the other side of a spinlock how could the
compiler optimize it away?

>
>   if (!dom_smmu) {
> 	/* Take spinlock and re-check the smmu */
> 	/* Initialise domain */
> 	/* Drop lock */
> 	/* Request IRQ */
>   }
>
>   if (dom_smmu != smmu) {
> 	/* Fail attach */
>   }
>
>   /* Add master to domain */
>
> Do you think that would work?

Besides my one question due to my lack of compiler optimization brain
power looks good to me.


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
