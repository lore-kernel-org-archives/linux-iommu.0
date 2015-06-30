From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 6/8] iommu/arm-smmu: add support for non-pci devices
Date: Tue, 30 Jun 2015 12:26:36 +0100
Message-ID: <55927CEC.4090900@arm.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
	<1435307584-9812-7-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1435307584-9812-7-git-send-email-thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 26/06/15 09:33, Zhen Lei wrote:
> Now, we only support a master with only one stream id. It will cover most
> hardware platforms and coding so easy.
>
> Please refer Documentation\devicetree\bindings\iommu\iommu.txt on how to
> bind device tree.
>
> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>   arch/arm64/include/asm/device.h |  2 +
>   drivers/iommu/arm-smmu-v3.c     | 88 +++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 87 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/device.h b/arch/arm64/include/asm/device.h
> index 243ef25..225e4f9 100644
> --- a/arch/arm64/include/asm/device.h
> +++ b/arch/arm64/include/asm/device.h
> @@ -20,6 +20,8 @@ struct dev_archdata {
>   	struct dma_map_ops *dma_ops;
>   #ifdef CONFIG_IOMMU_API
>   	void *iommu;			/* private IOMMU data */

There's already a perfectly good place to store driver-private data 
right here.

> +	struct device_node *of_smmu;
> +	u32 sid;

This looks far too specific to be in core code. It doesn't seem 
extensible for e.g. ACPI platform devices; it doesn't seem extensible 
for platform devices with multiple stream IDs e.g. PL330; it also 
doesn't seem (sensibly) extensible for IOMMUs with #iommu-cells > 1.

Just allocate an SMMU-private struct for this and stash it in 
archdata.iommu - that way we can change things as much as we like in the 
driver with zero churn in core code.

>   #endif
>   	bool dma_coherent;
>   };
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 483c918..87c3d9b 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -30,9 +30,14 @@
>   #include <linux/of_address.h>
>   #include <linux/pci.h>
>   #include <linux/platform_device.h>
> +#include <linux/amba/bus.h>
> +#include <linux/of_iommu.h>
>
>   #include "io-pgtable.h"
>
> +/* Maximum number of stream IDs assigned to a single device */
> +#define MAX_MASTER_STREAMIDS		1
> +
>   /* MMIO registers */
>   #define ARM_SMMU_IDR0			0x0
>   #define IDR0_ST_LVL_SHIFT		27
> @@ -608,6 +613,22 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
>   	return container_of(dom, struct arm_smmu_domain, domain);
>   }
>
> +static struct arm_smmu_device *find_smmu_for_device(struct device *dev)
> +{
> +	struct arm_smmu_device *smmu;
> +
> +	spin_lock(&arm_smmu_devices_lock);
> +	list_for_each_entry(smmu, &arm_smmu_devices, list) {
> +		if (smmu->dev->of_node == dev->archdata.of_smmu) {
> +			spin_unlock(&arm_smmu_devices_lock);
> +			return smmu;
> +		}
> +	}
> +	spin_unlock(&arm_smmu_devices_lock);
> +
> +	return NULL;
> +}
> +

This should be unnecessary with the right probe order, see below...

>   /* Low-level queue manipulation functions */
>   static bool queue_full(struct arm_smmu_queue *q)
>   {
> @@ -1760,9 +1781,36 @@ static int arm_smmu_add_device(struct device *dev)
>   	struct arm_smmu_group *smmu_group;
>   	struct arm_smmu_device *smmu;
>
> -	/* We only support PCI, for now */
> -	if (!dev_is_pci(dev))
> -		return -ENODEV;
> +	if (!dev_is_pci(dev)) {
> +		smmu = find_smmu_for_device(dev);
> +		if (!smmu)
> +			return -ENODEV;
> +
> +		group = iommu_group_alloc();
> +		if (IS_ERR(group)) {
> +			dev_err(dev, "Failed to allocate IOMMU group\n");
> +			return PTR_ERR(group);
> +		}
> +
> +		ret = iommu_group_add_device(group, dev);
> +		if (ret)
> +			goto out_put_group;
> +
> +		smmu_group = kzalloc(sizeof(*smmu_group), GFP_KERNEL);
> +		if (!smmu_group) {
> +			ret = -ENOMEM;
> +			goto out_put_group;
> +		}
> +
> +		smmu_group->ste.valid = true;
> +		smmu_group->smmu = smmu;
> +		iommu_group_set_iommudata(group, smmu_group,
> +						__arm_smmu_release_iommudata);
> +
> +		sid = dev->archdata.sid;
> +
> +		goto handle_stream_id;
> +	}
>
>   	pdev = to_pci_dev(dev);
>   	group = iommu_group_get_for_dev(dev);
> @@ -1793,6 +1841,8 @@ static int arm_smmu_add_device(struct device *dev)
>
>   	/* Assume SID == RID until firmware tells us otherwise */
>   	pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid, &sid);
> +
> +handle_stream_id:

This is going to get messy quickly - how about breaking out the 
"platform device" and "PCI device" specifics above into their own 
functions that return the group and sid data to the common code here?

>   	for (i = 0; i < smmu_group->num_sids; ++i) {
>   		/* If we already know about this SID, then we're done */
>   		if (smmu_group->sids[i] == sid)
> @@ -1881,7 +1931,23 @@ out_unlock:
>   	return ret;
>   }
>
> +static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
> +{
> +	if (args->args_count > MAX_MASTER_STREAMIDS) {
> +		dev_err(dev,
> +			"reached maximum number (%d) of stream IDs for master device %s\n",
> +			MAX_MASTER_STREAMIDS, dev->of_node->name);
> +		return -ENOSPC;
> +	}
> +
> +	dev->archdata.of_smmu = args->np;
> +	dev->archdata.sid = args->args[0];
> +
> +	return 0;
> +}

This isn't going to work the way you expect: the way the binding is 
defined, a master with multiple stream IDs should look like so:

	iommus = <&smmu 0>, <&smmu 1>,...

so you'd get multiple calls, never hit the warning, and just end up with 
whichever ID came last.

Secondly, as mentioned above, it would be nicer to just associate the 
arm_smmu_device directly here and obviate the indirect lookup. That 
would depend on having correct probe ordering, but you need to enforce 
that anyway, since any add_device callbacks before the SMMU itself has 
been probed will break. Laurent's probe deferral series that Will 
pointed to is the ultimate goal, but for a stop-gap solution which works 
with the current code I'd suggest taking a look at patches 16 and 17 of 
Marek's Exynos SysMMU series[1]

Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.samsung-soc/45416

> +
>   static struct iommu_ops arm_smmu_ops = {
> +	.of_xlate		= arm_smmu_of_xlate,
>   	.capable		= arm_smmu_capable,
>   	.domain_alloc		= arm_smmu_domain_alloc,
>   	.domain_free		= arm_smmu_domain_free,
> @@ -2655,6 +2721,14 @@ static int __init arm_smmu_init(void)
>   	if (ret)
>   		return ret;
>
> +	if (!iommu_present(&platform_bus_type))
> +		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
> +
> +#ifdef CONFIG_ARM_AMBA
> +	if (!iommu_present(&amba_bustype))
> +		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
> +#endif
> +
>   	return bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
>   }
>
> @@ -2666,6 +2740,14 @@ static void __exit arm_smmu_exit(void)
>   subsys_initcall(arm_smmu_init);
>   module_exit(arm_smmu_exit);
>
> +static int arm_smmu_of_iommu_init(struct device_node *np)
> +{
> +	of_iommu_set_ops(np, &arm_smmu_ops);
> +
> +	return 0;
> +}
> +IOMMU_OF_DECLARE(arm_smmu_v3, "arm,smmu-v3", arm_smmu_of_iommu_init);
> +
>   MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>   MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
>   MODULE_LICENSE("GPL v2");
> --
> 1.8.0
>
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
