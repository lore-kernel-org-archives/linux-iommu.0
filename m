From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC 1/3] iommu/arm-smmu: Add support to opt-in to stalling
Date: Thu, 5 Jan 2017 12:08:57 +0000
Message-ID: <20170105120857.GB21952@leverpostej>
References: <1483479056-15202-1-git-send-email-robdclark@gmail.com>
 <1483479056-15202-2-git-send-email-robdclark@gmail.com>
 <20170105115528.GG679@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170105115528.GG679@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Rob Clark <robdclark@gmail.com>, iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, Sricharan R <sricharan@codeaurora.org>, Jordan Crouse <jcrouse@codeaurora.org>, robh@kernel.org, devicetree@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 05, 2017 at 11:55:29AM +0000, Will Deacon wrote:
> On Tue, Jan 03, 2017 at 04:30:54PM -0500, Rob Clark wrote:
> > TODO maybe we want two options, one to enable stalling, and 2nd to punt
> > handling to wq?  I haven't needed to use mm APIs from fault handler yet
> > (although it is something that I think we'll want some day).  Perhaps
> > stalling support is limited to just letting driver dump some extra
> > debugging information otherwise.  Threaded handling probably only useful
> > with stalling, but inverse may not always be true.
> 
> I'd actually like to see this stuck on a worker thread, because I think
> that's more generally useful and I don't want to have a situation where
> sometimes the IOMMU fault notifier is run in IRQ context and sometimes it's
> not.
> 
> > 
> > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > ---
> >  .../devicetree/bindings/iommu/arm,smmu.txt         |  3 ++
> >  drivers/iommu/arm-smmu.c                           | 42 ++++++++++++++++++----
> >  2 files changed, 39 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > index ef465b0..5f405a6 100644
> > --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> > @@ -68,6 +68,9 @@ conditions.
> >                    aliases of secure registers have to be used during
> >                    SMMU configuration.
> >  
> > +- arm,smmu-enable-stall : Enable stall mode to stall memory transactions
> > +                  and resume after fault is handled

The wording here seems to describe a policy rather than a property.

Can you elaborate on when/why this is required/preferred/valid?

> >  static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
> > @@ -824,6 +852,8 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
> >  
> >  	/* SCTLR */
> >  	reg = SCTLR_CFIE | SCTLR_CFRE | SCTLR_AFE | SCTLR_TRE | SCTLR_M;
> > +	if (smmu->options & ARM_SMMU_OPT_ENABLE_STALL)
> > +		reg |= SCTLR_CFCFG;
> 
> I wonder if this should also be predicated on the compatible string, so
> that the "arm,smmu-enable-stall" property is ignored (with a warning) if
> the compatible string isn't specific enough to identify an implementation
> with the required SS behaviour? On the other hand, it feels pretty
> redundant and a single "stalling works" property is all we need.

Can you elaborate on what "stalling works" entails? Is that just the SS
bit behaviour? are there integration or endpoint-specific things that we
need to care about?

Thanks,
Mark.
