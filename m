From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 6/6] iommu/arm-smmu: Make use of phandle iterators in
 device-tree parsing
Date: Tue, 29 Mar 2016 18:22:16 +0100
Message-ID: <20160329172216.GM6745@arm.com>
References: <1458669509-7178-1-git-send-email-joro@8bytes.org>
 <1458669509-7178-7-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1458669509-7178-7-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Tue, Mar 22, 2016 at 06:58:29PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Remove the usage of of_parse_phandle_with_args() and replace
> it by the phandle-iterator implementation so that we can
> parse out all of the potentially present 128 stream-ids.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 59ee4b8..413bd64 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -48,7 +48,7 @@
>  #include "io-pgtable.h"
>  
>  /* Maximum number of stream IDs assigned to a single device */
> -#define MAX_MASTER_STREAMIDS		MAX_PHANDLE_ARGS
> +#define MAX_MASTER_STREAMIDS		128
>  
>  /* Maximum number of context banks per SMMU */
>  #define ARM_SMMU_MAX_CBS		128
> @@ -349,6 +349,12 @@ struct arm_smmu_domain {
>  	struct iommu_domain		domain;
>  };
>  
> +struct arm_smmu_phandle_args {
> +	struct device_node *np;
> +	int args_count;
> +	uint32_t args[MAX_MASTER_STREAMIDS];
> +};
> +
>  static struct iommu_ops arm_smmu_ops;
>  
>  static DEFINE_SPINLOCK(arm_smmu_devices_lock);
> @@ -458,7 +464,7 @@ static int insert_smmu_master(struct arm_smmu_device *smmu,
>  
>  static int register_smmu_master(struct arm_smmu_device *smmu,
>  				struct device *dev,
> -				struct of_phandle_args *masterspec)
> +				struct arm_smmu_phandle_args *masterspec)
>  {
>  	int i;
>  	struct arm_smmu_master *master;
> @@ -1716,7 +1722,8 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  	struct arm_smmu_device *smmu;
>  	struct device *dev = &pdev->dev;
>  	struct rb_node *node;
> -	struct of_phandle_args masterspec;
> +	struct of_phandle_iterator it;
> +	struct arm_smmu_phandle_args masterspec;
>  	int num_irqs, i, err;
>  
>  	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
> @@ -1777,9 +1784,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  
>  	i = 0;
>  	smmu->masters = RB_ROOT;
> -	while (!of_parse_phandle_with_args(dev->of_node, "mmu-masters",
> -					   "#stream-id-cells", i,
> -					   &masterspec)) {
> +
> +	of_for_each_phandle(&it, err, dev->of_node,
> +			    "mmu-masters", "#stream-id-cells", 0) {
> +		int count = of_phandle_iterator_args(&it, masterspec.args,
> +						     MAX_MASTER_STREAMIDS);
> +		masterspec.np		= of_node_get(it.node);
> +		masterspec.args_count	= count;
> +
>  		err = register_smmu_master(smmu, dev, &masterspec);
>  		if (err) {
>  			dev_err(dev, "failed to add master %s\n",
> @@ -1789,6 +1801,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  
>  		i++;
>  	}
> +
> +	if (i == 0)
> +		goto out_put_masters;

I'm confused by this hunk. If i == 0, then we shouldn't have registered
any masters and therefore out_put_masters won't have anything to do.

In fact, I'm not completely clear on how the of_node refcounting interacts
with your iterators. Does the iterator put the node after you call the
"next" function, or does it increment each thing exactly once?

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
