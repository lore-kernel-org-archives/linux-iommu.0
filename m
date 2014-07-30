From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3] iommu/arm-smmu: avoid calling request_irq in atomic
	context
Date: Wed, 30 Jul 2014 17:57:21 +0100
Message-ID: <20140730165721.GJ8989@arm.com>
References: <1406657475-1232-1-git-send-email-mitchelh@codeaurora.org>
	<20140730153114.GG8989@arm.com>
	<vnkwd2cmbxi3.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <vnkwd2cmbxi3.fsf-Yf+dfxj6toJBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org>
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

On Wed, Jul 30, 2014 at 05:51:48PM +0100, Mitchel Humpherys wrote:
> On Wed, Jul 30 2014 at 08:31:14 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Tue, Jul 29, 2014 at 07:11:15PM +0100, Mitchel Humpherys wrote:
> >> Changelog:
> >> 
> >>   - v3: rework irq request code to avoid requesting the irq every
> >>         time a master is added to the domain
> >>   - v2: return error code from request_irq on failure
> >> ---
> >>  drivers/iommu/arm-smmu.c | 73 +++++++++++++++++++++++++++---------------------
> >>  1 file changed, 41 insertions(+), 32 deletions(-)
> >
> > I think this is correct, but we can do some cleanup now that you've moved
> > all the locking into the conditional. Messy diff below, which would be much
> > nicer sqaushed into your patch.
> >
> > What do you reckon?
> 
> Much cleaner, thanks. Just one question below.

[...]

> > @@ -902,7 +907,22 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >  
> >  	ACCESS_ONCE(smmu_domain->smmu) = smmu;
> >  	arm_smmu_init_context_bank(smmu_domain);
> > +	spin_unlock_irqrestore(&smmu_domain->lock, flags);
> > +
> > +	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> > +	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> > +			  "arm-smmu-context-fault", smmu_domain);
> > +	if (IS_ERR_VALUE(ret)) {
> > +		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
> > +			cfg->irptndx, irq);
> > +		cfg->irptndx = INVALID_IRPTNDX;
> 
> We want to return ret here due to the request_irq failure, right?

Actually, no, and it's a subtle change introduced by this fix. Before, we
would partially tear-down the domain here by freeing the cbndx but actually,
that's racy as hell. The moment we drop the lock another device can attach
successfully to the domain we've set, so we can't safely tear things down at
that point. The best bet is to continue with the warning -- you end up with
a domain without a context interrupt, but that's not fatal to the driver.

If we returned an error, I can't think of a safe way to reset the domain.

Will
