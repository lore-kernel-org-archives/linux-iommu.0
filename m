From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 08/11] iommu/msm: Make use of iommu_device_register
	interface
Date: Fri, 10 Feb 2017 14:35:39 +0000
Message-ID: <5bda5842-45b4-fc3c-7eea-351e4c2261b1@arm.com>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
	<1486639981-32368-9-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486639981-32368-9-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/02/17 11:32, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Register the MSM IOMMUs to the iommu core and add sysfs
> entries for that driver.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/msm_iommu.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/msm_iommu.h |  3 ++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index b09692b..30795cb 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -371,6 +371,58 @@ static int msm_iommu_domain_config(struct msm_priv *priv)
>  	return 0;
>  }
>  
> +/* Must be called under msm_iommu_lock */
> +static struct msm_iommu_dev *find_iommu_for_dev(struct device *dev)
> +{
> +	struct msm_iommu_dev *iommu, *ret = NULL;
> +	struct msm_iommu_ctx_dev *master;
> +
> +	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {
> +		master = list_first_entry(&iommu->ctx_list,
> +					  struct msm_iommu_ctx_dev,
> +					  list);
> +		if (master->of_node == dev->of_node) {
> +			ret = iommu;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int msm_iommu_add_device(struct device *dev)
> +{
> +	struct msm_iommu_dev *iommu;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&msm_iommu_lock, flags);
> +
> +	iommu = find_iommu_for_dev(dev);
> +	if (iommu)
> +		iommu_device_link(&iommu->iommu, dev);
> +	else
> +		ret = -ENODEV;
> +
> +	spin_unlock_irqrestore(&msm_iommu_lock, flags);
> +
> +	return ret;
> +}
> +
> +static void msm_iommu_remove_device(struct device *dev)
> +{
> +	struct msm_iommu_dev *iommu;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&msm_iommu_lock, flags);
> +
> +	iommu = find_iommu_for_dev(dev);
> +	if (iommu)
> +		iommu_device_unlink(&iommu->iommu, dev);
> +
> +	spin_unlock_irqrestore(&msm_iommu_lock, flags);
> +}
> +
>  static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  {
>  	int ret = 0;
> @@ -646,6 +698,8 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
>  	.unmap = msm_iommu_unmap,
>  	.map_sg = default_iommu_map_sg,
>  	.iova_to_phys = msm_iommu_iova_to_phys,
> +	.add_device = msm_iommu_add_device,
> +	.remove_device = msm_iommu_remove_device,
>  	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
>  	.of_xlate = qcom_iommu_of_xlate,
>  };
> @@ -653,6 +707,7 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
>  static int msm_iommu_probe(struct platform_device *pdev)
>  {
>  	struct resource *r;
> +	resource_size_t ioaddr;
>  	struct msm_iommu_dev *iommu;
>  	int ret, par, val;
>  
> @@ -696,6 +751,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(iommu->base);
>  		goto fail;
>  	}
> +	ioaddr = r->start;
>  
>  	iommu->irq = platform_get_irq(pdev, 0);
>  	if (iommu->irq < 0) {
> @@ -737,6 +793,23 @@ static int msm_iommu_probe(struct platform_device *pdev)
>  	}
>  
>  	list_add(&iommu->dev_node, &qcom_iommu_devices);
> +
> +	ret = iommu_device_sysfs_add(&iommu->iommu, iommu->dev, NULL,
> +				     "msm-smmu.%pa", &ioaddr);
> +	if (ret) {
> +		pr_err("Could not add msm-smmu at %pa to sysfs\n", &ioaddr);
> +		goto fail;
> +	}

Nit: there's a bit of inconsistency with printing errors between the
various drivers (for both _sysfs_add and _register). I reckon if we want
error messages we may as well just fold them into the helper functions.

> +
> +	iommu_device_set_ops(&iommu->iommu, &msm_iommu_ops);
> +	iommu_device_set_fwnode(&iommu->iommu, &pdev->dev.of_node->fwnode);
> +
> +	ret = iommu_device_register(&iommu->iommu);
> +	if (ret) {
> +		pr_err("Could not register msm-smmu at %pa\n", &ioaddr);
> +		goto fail;
> +	}

I think there's a corresponding unregister missing for
msm_iommu_remove() here (and similarly in the ARM SMMU drivers, looking
back). I know it's not strictly a problem at the moment, but I do now
have IOMMU-drivers-as-modules working on top of the probe deferral
series... ;)

Robin.

> +
>  	of_iommu_set_ops(pdev->dev.of_node, &msm_iommu_ops);
>  
>  	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
> diff --git a/drivers/iommu/msm_iommu.h b/drivers/iommu/msm_iommu.h
> index 4ca25d5..ae92d27 100644
> --- a/drivers/iommu/msm_iommu.h
> +++ b/drivers/iommu/msm_iommu.h
> @@ -19,6 +19,7 @@
>  #define MSM_IOMMU_H
>  
>  #include <linux/interrupt.h>
> +#include <linux/iommu.h>
>  #include <linux/clk.h>
>  
>  /* Sharability attributes of MSM IOMMU mappings */
> @@ -68,6 +69,8 @@ struct msm_iommu_dev {
>  	struct list_head dom_node;
>  	struct list_head ctx_list;
>  	DECLARE_BITMAP(context_map, IOMMU_MAX_CBS);
> +
> +	struct iommu_device iommu;
>  };
>  
>  /**
> 
