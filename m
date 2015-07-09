From: leizhen <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 6/9] iommu/arm-smmu: to support probe deferral
Date: Thu, 9 Jul 2015 19:10:11 +0800
Message-ID: <559E5693.9060709@huawei.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
	<1436239822-14132-7-git-send-email-thunder.leizhen@huawei.com>
	<559D21F0.3080202@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <559D21F0.3080202-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2015/7/8 21:13, Robin Murphy wrote:
> On 07/07/15 04:30, Zhen Lei wrote:
>> For pci devices, only the root nodes have "iommus" property. So we
>> should traverse all of its sub nodes in of_xlate.
> 
> I don't really follow this description; only the host controller is described in DT - the devices behind it are probed dynamically and don't have nodes to traverse.

The devices behind host controller may have nodes, but have no "iommus" property.

I got this conclusion base on the original code as below:

	struct pci_bus *bus = pdev->bus;

	/* Walk up to the root bus */
	while (!pci_is_root_bus(bus))
		bus = bus->parent;

	/* Follow the "iommus" phandle from the host controller */
	of_node = of_parse_phandle(bus->bridge->parent->of_node, "iommus", 0);
	if (!of_node)
		return NULL;

> 
>> Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 119 +++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 89 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index d6e3494..c569539 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -30,6 +30,8 @@
>>   #include <linux/of_address.h>
>>   #include <linux/pci.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/of_iommu.h>
>> +#include <linux/of_platform.h>
>>
>>   #include "io-pgtable.h"
>>
>> @@ -1741,10 +1743,23 @@ static void __arm_smmu_release_pci_iommudata(void *data)
>>       kfree(data);
>>   }
>>
>> -static struct arm_smmu_device *arm_smmu_get_for_pci_dev(struct pci_dev *pdev)
>> +static struct arm_smmu_device *find_smmu_by_node(struct device_node *np)
>> +{
>> +    struct platform_device *pdev;
>> +
>> +    /* to ensure np is a smmu device node */
>> +    if (!of_iommu_get_ops(np))
>> +        return NULL;
>> +
>> +    pdev = of_find_device_by_node(np);
>> +    if (!pdev)
>> +        return NULL;
>> +
>> +    return platform_get_drvdata(pdev);
>> +}
>> +
>> +static struct device_node *arm_smmu_get_pci_dev_root(struct pci_dev *pdev)
>>   {
>> -    struct device_node *of_node;
>> -    struct arm_smmu_device *curr, *smmu = NULL;
>>       struct pci_bus *bus = pdev->bus;
>>
>>       /* Walk up to the root bus */
>> @@ -1752,21 +1767,7 @@ static struct arm_smmu_device *arm_smmu_get_for_pci_dev(struct pci_dev *pdev)
>>           bus = bus->parent;
>>
>>       /* Follow the "iommus" phandle from the host controller */
> 
> Either update comments to reflect what the new code does, or remove them along with the code they describe.

OK, I will remove it, thanks.

> 
>> -    of_node = of_parse_phandle(bus->bridge->parent->of_node, "iommus", 0);
>> -    if (!of_node)
>> -        return NULL;
>> -
>> -    /* See if we can find an SMMU corresponding to the phandle */
>> -    spin_lock(&arm_smmu_devices_lock);
>> -    list_for_each_entry(curr, &arm_smmu_devices, list) {
>> -        if (curr->dev->of_node == of_node) {
>> -            smmu = curr;
>> -            break;
>> -        }
>> -    }
>> -    spin_unlock(&arm_smmu_devices_lock);
>> -    of_node_put(of_node);
>> -    return smmu;
>> +    return bus->bridge->parent->of_node;
>>   }
>>
>>   static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
>> @@ -1779,27 +1780,21 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
>>       return sid < limit;
>>   }
>>
>> -static int arm_smmu_add_device(struct device *dev)
>> +static int arm_smmu_add_device(struct device *dev, u32 sid)
>>   {
>>       int i, ret;
>> -    u32 sid, *sids;
>> -    struct pci_dev *pdev;
>> +    u32 *sids;
>>       struct iommu_group *group;
>>       struct arm_smmu_group *smmu_group;
>>       struct arm_smmu_device *smmu;
>>
>> -    /* We only support PCI, for now */
>> -    if (!dev_is_pci(dev))
>> -        return -ENODEV;
>> -
>> -    pdev = to_pci_dev(dev);
>>       group = iommu_group_get_for_dev(dev);
>>       if (IS_ERR(group))
>>           return PTR_ERR(group);
>>
>>       smmu_group = iommu_group_get_iommudata(group);
>>       if (!smmu_group) {
>> -        smmu = arm_smmu_get_for_pci_dev(pdev);
>> +        smmu = dev->archdata.iommu;
>>           if (!smmu) {
>>               ret = -ENOENT;
>>               goto out_put_group;
>> @@ -1819,8 +1814,6 @@ static int arm_smmu_add_device(struct device *dev)
>>           smmu = smmu_group->smmu;
>>       }
>>
>> -    /* Assume SID == RID until firmware tells us otherwise */
>> -    pci_for_each_dma_alias(pdev, __arm_smmu_get_pci_sid, &sid);
>>       for (i = 0; i < smmu_group->num_sids; ++i) {
>>           /* If we already know about this SID, then we're done */
>>           if (smmu_group->sids[i] == sid)
>> @@ -1862,6 +1855,7 @@ out_put_group:
>>
>>   static void arm_smmu_remove_device(struct device *dev)
>>   {
>> +    dev->archdata.iommu = NULL;
>>       iommu_group_remove_device(dev);
>>   }
>>
>> @@ -1909,7 +1903,68 @@ out_unlock:
>>       return ret;
>>   }
>>
>> +static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>> +{
>> +    int ret;
>> +    struct arm_smmu_device *smmu;
>> +
>> +    /*
>> +     * We can sure that args->np is a smmu device node, because this
>> +     * function was called by of_xlate hook.
>> +     *
>> +     * And in arm_smmu_device_dt_probe:
>> +     *    platform_set_drvdata(pdev, smmu);
>> +     *    of_iommu_set_ops(smmu->dev->of_node, &arm_smmu_ops);
>> +     *
>> +     * It seems impossible return NULL in normal times.
>> +     */
>> +    smmu = find_smmu_by_node(args->np);
>> +    if (!smmu) {
>> +        dev_err(dev, "unknown error caused smmu driver crashed\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    if (!dev->archdata.iommu)
>> +        dev->archdata.iommu = smmu;
>> +
>> +    if (dev->archdata.iommu != smmu) {
>> +        dev_err(dev, "behinds more than one smmu\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* We only support PCI, for now */
>> +    if (!dev_is_pci(dev)) {
>> +        return -ENODEV;
>> +    } else {
>> +        u32 sid;
>> +        struct device_node *of_root;
>> +        struct pci_dev *pdev = NULL;
>> +
>> +        for_each_pci_dev(pdev) {
> 
> Given that we get here before the host controller's driver probe, is this really going to work? Either way, it looks very dodgy.

It will be a problem. See the next answer, I think it will be resolved. Based on the following reasoning:
1. if .add_device happened before .of_xlate, then this version have no problem. Because the old version worked well, so arm_smmu_get_pci_dev_root will work well too, we can base on current method find
all sub nodes(which should be processed in .add_device for the old version) of the host controller.

2. if .add_device happened after.of_xlate, because the function of the new .add_device is the same to the old .add_device, so it will work well as the old version.

I will send patch v3.

> 
>> +            of_root = arm_smmu_get_pci_dev_root(pdev);
>> +            if (of_root != dev->of_node)
>> +                continue;
>> +
>> +            /*
>> +             * Assume SID == RID until firmware tells us otherwise
>> +             */
>> +            pci_for_each_dma_alias(pdev,
>> +                    __arm_smmu_get_pci_sid, &sid);
>> +
>> +            pdev->dev.archdata.iommu = smmu;
>> +            ret = arm_smmu_add_device(dev, sid);
>> +            if (ret) {
>> +                dev_err(dev, "failed to add into SMMU\n");
>> +                return ret;
>> +            }
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static struct iommu_ops arm_smmu_ops = {
>> +    .of_xlate        = arm_smmu_of_xlate,
>>       .capable        = arm_smmu_capable,
>>       .domain_alloc        = arm_smmu_domain_alloc,
>>       .domain_free        = arm_smmu_domain_free,
>> @@ -1918,7 +1973,6 @@ static struct iommu_ops arm_smmu_ops = {
>>       .map            = arm_smmu_map,
>>       .unmap            = arm_smmu_unmap,
>>       .iova_to_phys        = arm_smmu_iova_to_phys,
>> -    .add_device        = arm_smmu_add_device,
> 
> It might not be an immediate concern, but I think subverting the normal add_device process this way also completely breaks any kind of device hotplug.

Yes, I had aslo worried about it.

I think we can resovle it like below:
.add_device        = arm_smmu_add_device

arm_smmu_add_device:
	/* We only support pci device hotplug */
	if (!dev_is_pci(dev))
		return -ENODEV;

	pdev = to_pci_dev(dev);
	root = arm_smmu_get_pci_dev_root(pdev);		//arm_smmu_get_pci_dev_root return value should be modified that: return bus->bridge->parent;
	if (!root.archdata.iommu)			//should add "root.archdata.iommu = smmu" in of_xlate
		return -ENODEV;

	//add this pci device to smmu

> 
>>       .remove_device        = arm_smmu_remove_device,
>>       .domain_get_attr    = arm_smmu_domain_get_attr,
>>       .domain_set_attr    = arm_smmu_domain_set_attr,
>> @@ -2626,6 +2680,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>>       spin_lock(&arm_smmu_devices_lock);
>>       list_add(&smmu->list, &arm_smmu_devices);
>>       spin_unlock(&arm_smmu_devices_lock);
>> +    platform_set_drvdata(pdev, smmu);
>> +    of_iommu_set_ops(smmu->dev->of_node, &arm_smmu_ops);
>> +
>>       return 0;
>>
>>   out_free_structures:
>> @@ -2697,6 +2754,8 @@ static void __exit arm_smmu_exit(void)
>>   subsys_initcall(arm_smmu_init);
>>   module_exit(arm_smmu_exit);
>>
>> +IOMMU_OF_DECLARE(arm_smmu_v3, "arm,smmu-v3", NULL);
>> +
>>   MODULE_DESCRIPTION("IOMMU API for ARM architected SMMUv3 implementations");
>>   MODULE_AUTHOR("Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>");
>>   MODULE_LICENSE("GPL v2");
>> -- 
>> 1.8.0
>>
>>
>> _______________________________________________
>> iommu mailing list
>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
> 
> 
> .
> 
