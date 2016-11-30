From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 02/10] iommu/of: Prepare for deferred IOMMU configuration
Date: Wed, 30 Nov 2016 16:17:23 +0000
Message-ID: <20161130161723.GA9042@red-moon>
References: <1480465344-11862-1-git-send-email-sricharan@codeaurora.org>
	<1480465344-11862-3-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1480465344-11862-3-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Sricharan, Robin,

I gave this series a go on ACPI and apart from an SMMU v3 fix-up
it seems to work, more thorough testing required though.

A key question below.

On Wed, Nov 30, 2016 at 05:52:16AM +0530, Sricharan R wrote:
> From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> 
> IOMMU configuration represents unchanging properties of the hardware,
> and as such should only need happen once in a device's lifetime, but
> the necessary interaction with the IOMMU device and driver complicates
> exactly when that point should be.
> 
> Since the only reasonable tool available for handling the inter-device
> dependency is probe deferral, we need to prepare of_iommu_configure()
> to run later than it is currently called (i.e. at driver probe rather
> than device creation), to handle being retried, and to tell whether a
> not-yet present IOMMU should be waited for or skipped (by virtue of
> having declared a built-in driver or not).
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/of_iommu.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index ee49081..349bd1d 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -104,12 +104,20 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
>  	int err;
>  
>  	ops = iommu_get_instance(fwnode);
> -	if (!ops || !ops->of_xlate)
> +	if ((ops && !ops->of_xlate) ||
> +	    (!ops && !of_match_node(&__iommu_of_table, iommu_spec->np)))

IIUC of_match_node() here is there to check there is a driver compiled
in for this device_node (aka compatible string in OF world), correct ?
If that's the case (and I think that's what Sricharan was referring to
in his ACPI query) I need to cook-up something on the ACPI side to
emulate the OF linker table behaviour (or anyway to detect a driver is
actually in the kernel), it is not that difficult but it is key to know,
I will give it some thought to make it as clean as possible.

Thanks,
Lorenzo

>  		return NULL;
>  
>  	err = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
>  	if (err)
>  		return ERR_PTR(err);
> +	/*
> +	 * The otherwise-empty fwspec handily serves to indicate the specific
> +	 * IOMMU device we're waiting for, which will be useful if we ever get
> +	 * a proper probe-ordering dependency mechanism in future.
> +	 */
> +	if (!ops)
> +		return ERR_PTR(-EPROBE_DEFER);
>  
>  	err = ops->of_xlate(dev, iommu_spec);
>  	if (err)
> @@ -186,14 +194,34 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  					   struct device_node *master_np)
>  {
>  	const struct iommu_ops *ops;
> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>  
>  	if (!master_np)
>  		return NULL;
>  
> +	if (fwspec) {
> +		if (fwspec->ops)
> +			return fwspec->ops;
> +
> +		/* In the deferred case, start again from scratch */
> +		iommu_fwspec_free(dev);
> +	}
> +
>  	if (dev_is_pci(dev))
>  		ops = of_pci_iommu_init(to_pci_dev(dev), master_np);
>  	else
>  		ops = of_platform_iommu_init(dev, master_np);
> +	/*
> +	 * If we have reason to believe the IOMMU driver missed the initial
> +	 * add_device callback for dev, replay it to get things in order.
> +	 */
> +	if (!IS_ERR_OR_NULL(ops) && ops->add_device &&
> +	    dev->bus && !dev->iommu_group) {
> +		int err = ops->add_device(dev);
> +
> +		if (err)
> +			ops = ERR_PTR(err);
> +	}
>  
>  	return IS_ERR(ops) ? NULL : ops;
>  }
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
