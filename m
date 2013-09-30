From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 5/9] iommu/arm-smmu: Clear global and context bank fault
	status registers
Date: Mon, 30 Sep 2013 15:54:01 +0200
Message-ID: <20130930135401.GV3315@alberich>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
	<1380234982-1677-6-git-send-email-andreas.herrmann@calxeda.com>
	<20130927085255.GC8319@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130927085255.GC8319-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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

On Fri, Sep 27, 2013 at 04:52:56AM -0400, Will Deacon wrote:
> On Thu, Sep 26, 2013 at 11:36:17PM +0100, Andreas Herrmann wrote:
> > After reset these registers have unknown values.
> > This might cause problems when evaluating SMMU_GFSR and/or SMMU_CB_FSR
> > in handlers for combined interrupts.
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> <pedantry> Your capitalisation of fsr vs FSR is inconsistent </pedantry>
> 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index de9dd60..9d31ad9 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -642,6 +642,9 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
> >  	stage1 = root_cfg->cbar != CBAR_TYPE_S2_TRANS;
> >  	cb_base = ARM_SMMU_CB_BASE(smmu) + ARM_SMMU_CB(smmu, root_cfg->cbndx);
> >  
> > +	/* clear fsr */
> > +	writel_relaxed(0xffffffff, cb_base + ARM_SMMU_CB_FSR);
> 
> I think this is too late, since we've already requested the IRQ line for
> this context bank by the time we get here. There are two options (afaict):
> 
>  (1) Clear the CB FSRs during probe *and* during domain destruction
> 
>  (2) Delay request_irq until after the context bank has been initialised

I'd do kind of (2) and clear the FSR of that context bank before
request_irq is called.
 
> Also, rather than 0xffffffff, FSR_IGN | FSR_FAULT is probably clearer.

Yep.

> >  	/* CBAR */
> >  	reg = root_cfg->cbar;
> >  	if (smmu->version == 1)
> > @@ -1564,6 +1567,9 @@ static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >  	int i = 0;
> >  	u32 scr0 = readl_relaxed(gr0_base + ARM_SMMU_GR0_sCR0);
> >  
> > +	/* clear global FSRs */
> > +	writel(0xffffffff, gr0_base + ARM_SMMU_GR0_sGFSR);
> 
> For this guy, a read of the register and a write back is probably better than
> writing 1s to all the reserved bits.

Ok.

Andreas
