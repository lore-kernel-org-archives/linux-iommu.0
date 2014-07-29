From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] iommu/arm-smmu: avoid calling request_irq in atomic
	context
Date: Tue, 29 Jul 2014 11:31:19 +0100
Message-ID: <20140729103119.GC9245@arm.com>
References: <1406572692-27460-1-git-send-email-mitchelh@codeaurora.org>
	<20140728190327.GU15536@arm.com>
	<vnkwoaw9oxje.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <vnkwoaw9oxje.fsf-Yf+dfxj6toJBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 29, 2014 at 12:48:05AM +0100, Mitchel Humpherys wrote:
> On Mon, Jul 28 2014 at 12:03:27 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> >> @@ -1203,12 +1190,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >>  	}
> >>  	spin_unlock_irqrestore(&smmu_domain->lock, flags);
> >>  
> >> +	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> >> +	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> >> +			  "arm-smmu-context-fault", domain);
> >> +	if (IS_ERR_VALUE(ret)) {
> >> +		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
> >> +			cfg->irptndx, irq);
> >> +		cfg->irptndx = INVALID_IRPTNDX;
> >> +		return ret;
> >> +	}
> >
> > This changes the driver behaviour, so we'll request an IRQ for the domain
> > *every* time a master is successfuly added to the domain, as opposed to
> > the first time a master is added (when we can do the lazy init).
> 
> Woops, you're absolutely right. Good catch.
> 
> >
> > Maybe we could rework the code so that it looks like:
> >
> >   dom_smmu = ACCESS_ONCE(&smmu_domain->smmu);
> 
> Why do we need an ACCESS_ONCE here? I thought the purpose of ACCESS_ONCE
> was to prevent the compiler from optimizing away the access (like a
> variable being pulled out of a for-loop because it's not modified within
> the loop (but could be modified on another thread)), but since we
> haven't accessed smmu_domain->smmu before this point and your proposed
> re-check below will be on the other side of a spinlock how could the
> compiler optimize it away?

The issue is that we have a reader and a writer for the smmu pointer
operating concurrently. For that to work, we need single-copy atomicity
and we also need to suppress some GCC optimisations (for example, the case
where it can move an assignment clause from an else block before the if).

In this case, we're probably alright but I think we should keep this
ACCESS_ONCE and also add one to arm_smmu_init_domain_context on the
assignment side.

Will
