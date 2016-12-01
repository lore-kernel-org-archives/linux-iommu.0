From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 02/10] iommu/of: Prepare for deferred IOMMU configuration
Date: Thu, 1 Dec 2016 11:29:17 +0000
Message-ID: <20161201112917.GA9680@red-moon>
References: <1480465344-11862-1-git-send-email-sricharan@codeaurora.org>
 <1480465344-11862-3-git-send-email-sricharan@codeaurora.org>
 <20161130161723.GA9042@red-moon>
 <c89825aa-c75f-8493-fe92-7cc97f525bc7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c89825aa-c75f-8493-fe92-7cc97f525bc7@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Sricharan R <sricharan@codeaurora.org>, will.deacon@arm.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 30, 2016 at 04:42:27PM +0000, Robin Murphy wrote:
> On 30/11/16 16:17, Lorenzo Pieralisi wrote:
> > Sricharan, Robin,
> > 
> > I gave this series a go on ACPI and apart from an SMMU v3 fix-up
> > it seems to work, more thorough testing required though.
> > 
> > A key question below.
> > 
> > On Wed, Nov 30, 2016 at 05:52:16AM +0530, Sricharan R wrote:
> >> From: Robin Murphy <robin.murphy@arm.com>
> >>
> >> IOMMU configuration represents unchanging properties of the hardware,
> >> and as such should only need happen once in a device's lifetime, but
> >> the necessary interaction with the IOMMU device and driver complicates
> >> exactly when that point should be.
> >>
> >> Since the only reasonable tool available for handling the inter-device
> >> dependency is probe deferral, we need to prepare of_iommu_configure()
> >> to run later than it is currently called (i.e. at driver probe rather
> >> than device creation), to handle being retried, and to tell whether a
> >> not-yet present IOMMU should be waited for or skipped (by virtue of
> >> having declared a built-in driver or not).
> >>
> >> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >> ---
> >>  drivers/iommu/of_iommu.c | 30 +++++++++++++++++++++++++++++-
> >>  1 file changed, 29 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> >> index ee49081..349bd1d 100644
> >> --- a/drivers/iommu/of_iommu.c
> >> +++ b/drivers/iommu/of_iommu.c
> >> @@ -104,12 +104,20 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
> >>  	int err;
> >>  
> >>  	ops = iommu_get_instance(fwnode);
> >> -	if (!ops || !ops->of_xlate)
> >> +	if ((ops && !ops->of_xlate) ||
> >> +	    (!ops && !of_match_node(&__iommu_of_table, iommu_spec->np)))
> > 
> > IIUC of_match_node() here is there to check there is a driver compiled
> > in for this device_node (aka compatible string in OF world), correct ?
> 
> Yes - specifically, it's checking the magic table for a matching
> IOMMU_OF_DECLARE entry.
> 
> > If that's the case (and I think that's what Sricharan was referring to
> > in his ACPI query) I need to cook-up something on the ACPI side to
> > emulate the OF linker table behaviour (or anyway to detect a driver is
> > actually in the kernel), it is not that difficult but it is key to know,
> > I will give it some thought to make it as clean as possible.
> 
> I didn't think this would be a concern for ACPI, since IORT works much
> the same way the current of_iommu_init_fn/of_platform_device_create()
> bodges in drivers so for DT. If you can only discover SMMUs from IORT,
> then iort_init_platform_devices() will have already created every SMMU
> that's going to exist before discovering other devices from wherever
> they come from, thus you could never get into the situation of probing a
> device without its SMMU being ready (if it's ever going to be). Is that
> not right?

It is right, my point and question is: we are probing a device and we
have to know whether it is worth deferring its IOMMU DMA setup. On DT,
through of_match_node(&__iommu_of_table, iommu_device_node) we check at
once that:

1 - A device for the IOMMU exists

AND

2 - A driver for the IOMMU is compiled in the kernel

Is this correct ? As you said (1) is not a concern on ACPI IORT (because
we create the IOMMU device before _any_ other device so either the IOMMU
device is there or it will never be by the time master devices are
probed), but for (2) I need to slightly change how the IORT linker entry
work to make sure we can detect a driver is actually compiled in the
kernel, it is easy, I was just asking if my understanding was correct
and I think that was what Sricharan was referring to in his query.

I will put together a patch, again, it is a simple tweak.

Thanks !
Lorenzo

> Robin.
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> >>  		return NULL;
> >>  
> >>  	err = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
> >>  	if (err)
> >>  		return ERR_PTR(err);
> >> +	/*
> >> +	 * The otherwise-empty fwspec handily serves to indicate the specific
> >> +	 * IOMMU device we're waiting for, which will be useful if we ever get
> >> +	 * a proper probe-ordering dependency mechanism in future.
> >> +	 */
> >> +	if (!ops)
> >> +		return ERR_PTR(-EPROBE_DEFER);
> >>  
> >>  	err = ops->of_xlate(dev, iommu_spec);
> >>  	if (err)
> >> @@ -186,14 +194,34 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
> >>  					   struct device_node *master_np)
> >>  {
> >>  	const struct iommu_ops *ops;
> >> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> >>  
> >>  	if (!master_np)
> >>  		return NULL;
> >>  
> >> +	if (fwspec) {
> >> +		if (fwspec->ops)
> >> +			return fwspec->ops;
> >> +
> >> +		/* In the deferred case, start again from scratch */
> >> +		iommu_fwspec_free(dev);
> >> +	}
> >> +
> >>  	if (dev_is_pci(dev))
> >>  		ops = of_pci_iommu_init(to_pci_dev(dev), master_np);
> >>  	else
> >>  		ops = of_platform_iommu_init(dev, master_np);
> >> +	/*
> >> +	 * If we have reason to believe the IOMMU driver missed the initial
> >> +	 * add_device callback for dev, replay it to get things in order.
> >> +	 */
> >> +	if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
> >> +	    dev->bus && !dev->iommu_group) {
> >> +		int err = ops->add_device(dev);
> >> +
> >> +		if (err)
> >> +			ops = ERR_PTR(err);
> >> +	}
> >>  
> >>  	return IS_ERR(ops) ? NULL : ops;
> >>  }
> >> -- 
> >> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> >>
> 
