From: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH 3/4] iommu/arm-smmu: Disable stalling faults for all
 endpoints
Date: Tue, 6 Dec 2016 17:00:25 -0700
Message-ID: <20161207000025.GB21862@jcrouse-lnx.qualcomm.com>
References: <1471525542-14969-1-git-send-email-will.deacon@arm.com>
 <1471525542-14969-4-git-send-email-will.deacon@arm.com>
 <CAF6AEGujUb37qagBZK1T13eAh=50zy0z5HpFF9FsuvkZZ7c5qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGujUb37qagBZK1T13eAh=50zy0z5HpFF9FsuvkZZ7c5qw@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Sricharan R <sricharan@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 06, 2016 at 06:30:21PM -0500, Rob Clark wrote:
> On Thu, Aug 18, 2016 at 9:05 AM, Will Deacon <will.deacon@arm.com> wrote:
> > Enabling stalling faults can result in hardware deadlock on poorly
> > designed systems, particularly those with a PCI root complex upstream of
> > the SMMU.
> >
> > Although it's not really Linux's job to save hardware integrators from
> > their own misfortune, it *is* our job to stop userspace (e.g. VFIO
> > clients) from hosing the system for everybody else, even if they might
> > already be required to have elevated privileges.
> >
> > Given that the fault handling code currently executes entirely in IRQ
> > context, there is nothing that can sensibly be done to recover from
> > things like page faults anyway, so let's rip this code out for now and
> > avoid the potential for deadlock.
> 
> Hi Will,
> 
> so, I'd like to re-introduce this feature, I *guess* as some sort of
> opt-in quirk (ie. disabled by default unless something in DT tells you
> otherwise??  But I'm open to suggestions.  I'm not entirely sure what
> hw was having problems due to this feature.)
> 
> On newer snapdragon devices we are using arm-smmu for the GPU, and
> halting the GPU so the driver's fault handler can dump some GPU state
> on faults is enormously helpful for debugging and tracking down where
> in the gpu cmdstream the fault was triggered.  In addition, we will
> eventually want the ability to update pagetables from fault handler
> and resuming the faulting transition.
> 
> Some additional comments below..
> 
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Matt Evans <matt.evans@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  drivers/iommu/arm-smmu.c | 34 +++++++---------------------------
> >  1 file changed, 7 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 4f49fe29f202..2db74ebc3240 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -686,8 +686,7 @@ static struct iommu_gather_ops arm_smmu_gather_ops = {
> >
> >  static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >  {
> > -       int flags, ret;
> > -       u32 fsr, fsynr, resume;
> > +       u32 fsr, fsynr;
> >         unsigned long iova;
> >         struct iommu_domain *domain = dev;
> >         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> > @@ -701,34 +700,15 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >         if (!(fsr & FSR_FAULT))
> >                 return IRQ_NONE;
> >
> > -       if (fsr & FSR_IGN)
> > -               dev_err_ratelimited(smmu->dev,
> > -                                   "Unexpected context fault (fsr 0x%x)\n",
> > -                                   fsr);
> > -
> >         fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
> > -       flags = fsynr & FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
> > -
> >         iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
> > -       if (!report_iommu_fault(domain, smmu->dev, iova, flags)) {
> > -               ret = IRQ_HANDLED;
> > -               resume = RESUME_RETRY;
> > -       } else {
> > -               dev_err_ratelimited(smmu->dev,
> > -                   "Unhandled context fault: iova=0x%08lx, fsynr=0x%x, cb=%d\n",
> > -                   iova, fsynr, cfg->cbndx);
> 
> I would like to decouple this dev_err_ratelimit() print from the
> RESUME_RETRY vs RESUME_TERMINATE behaviour.  I need the ability to
> indicate by return from my fault handler whether to resume or
> terminate.  But I already have my own ratelimted prints and would
> prefer not to spam dmesg twice.
> 
> I'm thinking about report_iommu_fault() returning:
> 
>   0 => RESUME_RETRY
>   -EFAULT => RESUME_TERMINATE but don't print
>   anything else (or specifically -ENOSYS?) => RESUME_TERMINATE and print
> 
> thoughts?
> 
> > -               ret = IRQ_NONE;
> > -               resume = RESUME_TERMINATE;
> > -       }
> > -
> > -       /* Clear the faulting FSR */
> > -       writel(fsr, cb_base + ARM_SMMU_CB_FSR);
> >
> > -       /* Retry or terminate any stalled transactions */
> > -       if (fsr & FSR_SS)
> > -               writel_relaxed(resume, cb_base + ARM_SMMU_CB_RESUME);
> 
> This might be a bug in qcom's implementation of the smmu spec, but
> seems like we don't have SS bit set, yet we still require RESUME reg
> to be written, otherwise gpu is perma-wedged.  Maybe topic for a
> separate quirk?  I'm not sure if writing RESUME reg on other hw when
> SS bit is not set is likely to cause problems?  If not I suppose we
> could just unconditionally write it.
> 
> Anyways, I'm not super-familiar w/ arm-smmu so suggestions welcome..
> in between debugging freedreno I'll try to put together some patches.

>From what I can tell we need SCTLR_CFCFG to make the stall happen otherwise
the operation just gets terminated immediately and *then* we get notification
but by then the system keeps going.

I think SCTLR_HUPCF helps control that behavior (i.e. we don't go off faulting
through eternity) but I don't know how it works.

>From my very unlearned understanding I think we do want to set CFCFG and then
stall and let the interrupt handler decide to retry/terminate.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
