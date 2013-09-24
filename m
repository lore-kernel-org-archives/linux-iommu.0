From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/7] iommu/arm-smmu: Calculate SMMU_CB_BASE from smmu
	register values
Date: Tue, 24 Sep 2013 20:07:20 +0200
Message-ID: <20130924180720.GV4845@alberich>
References: <1380035221-11576-1-git-send-email-andreas.herrmann@calxeda.com>
	<1380035221-11576-3-git-send-email-andreas.herrmann@calxeda.com>
	<20130924153457.GC20774@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130924153457.GC20774-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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

On Tue, Sep 24, 2013 at 11:34:57AM -0400, Will Deacon wrote:
> On Tue, Sep 24, 2013 at 04:06:56PM +0100, Andreas Herrmann wrote:
> > Currently it is derived from smmu resource size. If the resource size
> > is wrongly specified (e.g. too large) this leads to a miscalculation
> > and can cause undefined behaviour when context bank registers are
> > modified.
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/iommu/arm-smmu.c |    7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index 97b764b..f5a856e 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -207,7 +207,7 @@
> >  #define CBA2R_RW64_64BIT		(1 << 0)
> >  
> >  /* Translation context bank */
> > -#define ARM_SMMU_CB_BASE(smmu)		((smmu)->base + ((smmu)->size >> 1))
> > +#define ARM_SMMU_CB_BASE(smmu)		((smmu)->cb_base)
> >  #define ARM_SMMU_CB(smmu, n)		((n) * (smmu)->pagesize)
> >  
> >  #define ARM_SMMU_CB_SCTLR		0x0
> > @@ -339,6 +339,7 @@ struct arm_smmu_device {
> >  	struct device_node		*parent_of_node;
> >  
> >  	void __iomem			*base;
> > +	void __iomem			*cb_base;
> >  	unsigned long			size;
> >  	unsigned long			pagesize;
> >  
> > @@ -1701,7 +1702,9 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
> >  
> >  	/* Check that we ioremapped enough */
> >  	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
> > -	size *= (smmu->pagesize << 1);
> > +	size *= smmu->pagesize;
> > +	smmu->cb_base = smmu->base + size;
> > +	size *= 2;
> >  	if (smmu->size < size)
> >  		dev_warn(smmu->dev,
> >  			 "device is 0x%lx bytes but only mapped 0x%lx!\n",
> 
> Hmm, this is a tricky one. We know that we have an inconsistency (i.e. the
> DT and the hardware don't agree on the size of the device) but we warn and
> attempt to continue with the value from the DT. I don't think that trusting
> the hardware is the right thing to do in this case, since it's not possible
> to change so we should let the DT act as an override.

> In other words: if the device tree is wrong, go fix it.

Yes, I've found this issue with a wrong DT. With the original code
there was some weirdness when setting certain context bank
registers. (Identifying the root cause was not straight forward.)

I think it's somehow odd not to trust the hardware values in the first
place and to add (right from the beginning) a quirk for potential
implementation bugs. Are there already implementations that use wrong
register values that are required to determine the partitioning of the
SMMU address space?

If there is a mismatch it's hard to say which value is the correct
one. I think there are three options:
(1) just print a warning about the mismatch
(2) print a warning + override based on DT
(3) print a warning + override based on DT + have an option to switch
    off the override

So, what's your choice?


Andreas
