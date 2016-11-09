From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 05/16] drivers: iommu: arm-smmu: convert struct device
	of_node to fwnode usage
Date: Wed, 9 Nov 2016 14:43:18 +0000
Message-ID: <7ab465a8-f1ae-91ef-12fd-50f498af3d6e@arm.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
	<20161109141948.19244-6-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161109141948.19244-6-lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 09/11/16 14:19, Lorenzo Pieralisi wrote:
> Current ARM SMMU driver rely on the struct device.of_node pointer for
> device look-up and iommu_ops retrieval.
> 
> In preparation for ACPI probing enablement, convert the driver to use
> the struct device.fwnode member for device and iommu_ops look-up so that
> the driver infrastructure can be used also on systems that do not
> associate an of_node pointer to a struct device (eg ACPI), making the
> device look-up and iommu_ops retrieval firmware agnostic.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> Tested-by: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Tested-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

> ---
>  drivers/iommu/arm-smmu.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 8f72814..8a3c2a4 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1379,13 +1379,14 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>  
>  static int arm_smmu_match_node(struct device *dev, void *data)
>  {
> -	return dev->of_node == data;
> +	return dev->fwnode == data;
>  }
>  
> -static struct arm_smmu_device *arm_smmu_get_by_node(struct device_node *np)
> +static
> +struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
>  {
>  	struct device *dev = driver_find_device(&arm_smmu_driver.driver, NULL,
> -						np, arm_smmu_match_node);
> +						fwnode, arm_smmu_match_node);
>  	put_device(dev);
>  	return dev ? dev_get_drvdata(dev) : NULL;
>  }
> @@ -1403,7 +1404,7 @@ static int arm_smmu_add_device(struct device *dev)
>  		if (ret)
>  			goto out_free;
>  	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
> -		smmu = arm_smmu_get_by_node(to_of_node(fwspec->iommu_fwnode));
> +		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
>  	} else {
>  		return -ENODEV;
>  	}
> @@ -2007,7 +2008,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	of_iommu_set_ops(dev->of_node, &arm_smmu_ops);
> +	fwnode_iommu_set_ops(dev->fwnode, &arm_smmu_ops);
>  	platform_set_drvdata(pdev, smmu);
>  	arm_smmu_device_reset(smmu);
>  
> 
