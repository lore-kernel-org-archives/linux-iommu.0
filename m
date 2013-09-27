From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/9] iommu/arm-smmu: Check for num_context_irqs > 0 to
	avoid divide by zero exception
Date: Fri, 27 Sep 2013 11:03:48 +0200
Message-ID: <20130927090348.GF3315@alberich>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
	<1380234982-1677-5-git-send-email-andreas.herrmann@calxeda.com>
	<20130927084154.GB8319@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130927084154.GB8319-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 27, 2013 at 04:41:54AM -0400, Will Deacon wrote:
> On Thu, Sep 26, 2013 at 11:36:16PM +0100, Andreas Herrmann wrote:
> > With the right (or wrong;-) definition of v1 SMMU node in DTB it is
> > possible to trigger a division by zero in arm_smmu_init_domain_context
> > (if number of context irqs is 0):
> > 
> >        if (smmu->version == 1) {
> >                root_cfg->irptndx = atomic_inc_return(&smmu->irptndx);
> >  =>            root_cfg->irptndx %= smmu->num_context_irqs;
> >        } else {
> > 
> > Avoid this by checking for num_context_irqs > 0 when probing
> > for SMMU devices.
> > 
> > Rationale: Assuming that at least one context bank for non-secure
> > usage is provided per SMMU, it follows (from ARM SMMU Architecture
> > Spec) that at least one context interrupt must be available.
> 
> One problem with this reasoning is that the interrupt line might just not be
> wired up to the GIC, despite existing on the SMMU. Still, we needn't solve
> that now (let's wait for somebody to build it first...).
> 
> > Also remove the line of code that derived num_context_irqs from
> > num_irqs and num_global_irqs. If DT is wrong and interrupt property
> > contains less interrupts than num_global_irqs this would set
> > num_context_irqs to a big u32 value which most likely causes trouble
> > in other parts of the driver.
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 4307fbc..de9dd60 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -1822,7 +1822,11 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
> >  			 num_irqs, smmu->num_global_irqs);
> >  		smmu->num_global_irqs = num_irqs;
> >  	}
> > -	smmu->num_context_irqs = num_irqs - smmu->num_global_irqs;
> 
> Why are you deleting this line?

Because I felt it's redundant in some cases and erroneously I thought
it could be bogus if num_irqs < num_global_irqs.
Of course the latter is wrong, as num_global_irqs is corrected two
lines above.

Now I think it's always redundant. num_context_irqs is only
incremented here

               if (num_irqs > smmu->num_global_irqs)
                        smmu->num_context_irqs++;

So either it is still 0 (and no fixup required for num_irqs <
num_global_irqs) or it contains already a positive value based on
(num_irqs - num_global_irqs).

But maybe I've missed something.
(At least I need to fix the commit message wrt to this removal.)

> > +
> > +	if (!smmu->num_context_irqs) {
> > +		dev_err(dev, "no context interrupt specified in DT\n");
> 
> I'd avoid mentioning "DT" in the log message, just in case this ever starts
> probing from something else.

Ok, will fix this.


Andreas
