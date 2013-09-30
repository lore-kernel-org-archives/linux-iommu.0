From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Clear global and context bank fault
	status registers
Date: Mon, 30 Sep 2013 19:17:16 +0200
Message-ID: <20130930171716.GX3315@alberich>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
	<1380234982-1677-6-git-send-email-andreas.herrmann@calxeda.com>
	<20130927085255.GC8319@mudshark.cambridge.arm.com>
	<20130930135401.GV3315@alberich> <20130930135621.GW3315@alberich>
	<20130930160615.GG26036@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130930160615.GG26036-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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

On Mon, Sep 30, 2013 at 12:06:15PM -0400, Will Deacon wrote:
> On Mon, Sep 30, 2013 at 02:56:21PM +0100, Andreas Herrmann wrote:
> > 
> > After reset these registers have unknown values.
> > This might cause problems when evaluating SMMU_GFSR and/or SMMU_CB_FSR
> > in handlers for combined interrupts.
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c |   27 ++++++++++++++++++++-------
> >  1 file changed, 20 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 579b6f8..cbbf597 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -631,6 +631,12 @@ static irqreturn_t arm_smmu_global_fault(int irq, void *dev)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > +static void arm_smmu_clear_cb_fsr(struct arm_smmu_device *smmu, u8 cbndx)
> > +{
> > +	void __iomem *cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, cbndx);
> > +	writel_relaxed(FSR_FAULT, cb_base + ARM_SMMU_CB_FSR);
> > +}
> 
> Hmm, why not just stick this in arm_smmu_init_context_bank...

Because we should clear the FSR before we call request_irq.
Otherwise we might handle interrupts although the context bank is not
enabled.

Moving request_irq after arm_smmu_init_context_bank is not optimal
either. (We should have configured the context interrupt before
translation is enabled. Otherwise it's possible to miss a fault.)

> >  static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
> >  {
> >  	u32 reg;
> > @@ -838,6 +844,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
> >  		root_cfg->irptndx = root_cfg->cbndx;
> >  	}
> >  
> > +	arm_smmu_clear_cb_fsr(smmu, root_cfg->cbndx);
> 
> ... then move that function call here instead of where it currently is?

See above.

> >  	irq = smmu->irqs[smmu->num_global_irqs + root_cfg->irptndx];
> >  	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
> >  			  "arm-smmu-context-fault", domain);
> > @@ -1564,7 +1571,11 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >  	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
> >  	void __iomem *sctlr_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB_SCTLR;
> >  	int i = 0;
> > -	u32 scr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
> > +	u32 val;
> 
> I guess we have to dilute the meaning of the variable, but perhaps `reg' is
> slightly more indicative than `val'?

Will change that.

> Do you plan to post all your patches as a new series (it's hard to keep
> track of what to pick)?

Yes.


Andreas
