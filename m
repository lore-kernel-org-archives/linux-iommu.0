From: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/9] iommu/arm-smmu: Calculate SMMU_CB_BASE from smmu
	register values
Date: Fri, 27 Sep 2013 13:05:21 +0200
Message-ID: <20130927110521.GO3315@alberich>
References: <1380234982-1677-1-git-send-email-andreas.herrmann@calxeda.com>
	<1380234982-1677-3-git-send-email-andreas.herrmann@calxeda.com>
	<20130927095157.GA9057@mudshark.cambridge.arm.com>
	<20130927102359.GL3315@alberich>
	<20130927105153.GG9057@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130927105153.GG9057-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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

On Fri, Sep 27, 2013 at 06:51:53AM -0400, Will Deacon wrote:
> On Fri, Sep 27, 2013 at 11:23:59AM +0100, Andreas Herrmann wrote:
> > On Fri, Sep 27, 2013 at 05:51:57AM -0400, Will Deacon wrote:
> > > Hi Andreas,
> > > 
> > > On Thu, Sep 26, 2013 at 11:36:14PM +0100, Andreas Herrmann wrote:
> > > > Currently it is derived from smmu resource size.  In case of a
> > > > mismatchin between the two calculations trust DT more than register
> > > > values and overwrite cb_base.
> > > 
> > > I thought the driver already favoured the DT?
> > > 
> > > > @@ -1702,12 +1704,23 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
> > > >  
> > > >  	/* Check that we ioremapped enough */
> > > >  	size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
> > > > -	size *= (smmu->pagesize << 1);
> > > > +	size *= smmu->pagesize;
> > > > +	smmu->cb_base = smmu->base + size;
> > > > +	size *= 2;
> > > > +
> > > >  	if (smmu->size < size)
> > > >  		dev_warn(smmu->dev,
> > > >  			 "device is 0x%lx bytes but only mapped 0x%lx!\n",
> > > >  			 size, smmu->size);
> > > >  
> > > > +	t = (unsigned long) smmu->base + (smmu->size >> 1);
> > > > +	if ((unsigned long)smmu->cb_base != t) {
> > > > +		dev_warn(smmu->dev, "address space mismatch, "
> > > > +			"overwriting cb_base (old: 0x%lx, new: 0x%lx)\n",
> > > > +			(unsigned long) smmu->cb_base, t);
> > > > +		smmu->cb_base = (void *) t;
> > > > +	}
> > > > +
> > > 
> > > I expect I'm just being slow here (only one coffee in), but I can't see what
> > > this gets us over the current use of resource_size (which goes and uses the
> > > DT).
> > 
> > On balance it adds a warning if there is an inconsistency between the
> > resource size and the relevant registers describing the SMMU address
> > space.
> 
> Well, we should already print the "device is 0x%lx bytes but only mapped
> 0x%lx!" message, which I think is enough to go and figure out what happened.

No, you can map a larger region and still wrongly calculate cb_base
w/o this warning.
So the required check is something like

         /* Check for mismatch between SMMU address space size and size of mapped region */
         size = 1 << (((id >> ID1_NUMPAGENDXB_SHIFT) & ID1_NUMPAGENDXB_MASK) + 1);
         size *= (smmu->pagesize << 1);
         if (smmu->size != size)
                 dev_warn(smmu->dev,
                          "SMMU_GLOBAL_SIZE (0x%lx) differs from mapped "
			  region size (0x%lx)!\n", size, smmu->size);



Andreas
