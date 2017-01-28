From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V7 07/11] iommu: of: Handle IOMMU lookup failure with
	deferred probing or error
Date: Sat, 28 Jan 2017 15:03:59 -0600
Message-ID: <20170128210359.GE20550@bhelgaas-glaptop.roam.corp.google.com>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
	<1485188293-20263-8-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1485188293-20263-8-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 23, 2017 at 09:48:09PM +0530, Sricharan R wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> 
> Failures to look up an IOMMU when parsing the DT iommus property need to
> be handled separately from the .of_xlate() failures to support deferred
> probing.
> 
> The lack of a registered IOMMU can be caused by the lack of a driver for
> the IOMMU, the IOMMU device probe not having been performed yet, having
> been deferred, or having failed.
> 
> The first case occurs when the device tree describes the bus master and
> IOMMU topology correctly but no device driver exists for the IOMMU yet
> or the device driver has not been compiled in. Return NULL, the caller
> will configure the device without an IOMMU.
> 
> The second and third cases are handled by deferring the probe of the bus
> master device which will eventually get reprobed after the IOMMU.
> 
> The last case is currently handled by deferring the probe of the bus
> master device as well. A mechanism to either configure the bus master
> device without an IOMMU or to fail the bus master device probe depending
> on whether the IOMMU is optional or mandatory would be a good
> enhancement.
> 
> Signed-off-by: Laurent Pichart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ...

> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 349bd1d..9529d6c 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -23,6 +23,7 @@
>  #include <linux/of.h>
>  #include <linux/of_iommu.h>
>  #include <linux/of_pci.h>
> +#include <linux/pci.h>

Why do we need this?

>  #include <linux/slab.h>
>  
>  static const struct of_device_id __iommu_of_table_sentinel
> @@ -223,7 +224,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  			ops = ERR_PTR(err);
>  	}
>  
> -	return IS_ERR(ops) ? NULL : ops;
> +	return ops;
>  }
>  
>  static int __init of_iommu_init(void)
> @@ -234,7 +235,7 @@ static int __init of_iommu_init(void)
>  	for_each_matching_node_and_match(np, matches, &match) {
>  		const of_iommu_init_fn init_fn = match->data;
>  
> -		if (init_fn(np))
> +		if (init_fn && init_fn(np))
>  			pr_err("Failed to initialise IOMMU %s\n",
>  				of_node_full_name(np));
>  	}
