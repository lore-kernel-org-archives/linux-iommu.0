From: leizhen <thunder.leizhen@huawei.com>
Subject: Re: [PATCH v2 9/9] iommu/arm-smmu: add support for non-pci devices
Date: Thu, 9 Jul 2015 09:56:06 +0800
Message-ID: <559DD4B6.9000403@huawei.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
 <1436239822-14132-10-git-send-email-thunder.leizhen@huawei.com>
 <559D240F.2090002@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <559D240F.2090002@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <Will.Deacon@arm.com>, "huxinwei@huawei.com" <huxinwei@huawei.com>, iommu <iommu@lists.linux-foundation.org>, Zefan Li <lizefan@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On 2015/7/8 21:22, Robin Murphy wrote:
> On 07/07/15 04:30, Zhen Lei wrote:
>> This patch support a master with multiple stream IDs, but doesn't support a
>> master behinds more than one SMMUs.
> 
> This should probably include a binding documentation update to make it clear what values of #iommu-cells the driver supports in what circumstances, and that the cells themselves should contain raw
> stream IDs.

OK.

> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/arm-smmu-v3.c | 39 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 274d059..582cd1e 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -30,6 +30,7 @@
>>   #include <linux/of_address.h>
>>   #include <linux/pci.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/amba/bus.h>
>>   #include <linux/of_iommu.h>
>>   #include <linux/of_platform.h>
>>
>> @@ -1928,9 +1929,35 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>>           return -EINVAL;
>>       }
>>
>> -    /* We only support PCI, for now */
>>       if (!dev_is_pci(dev)) {
>> -        return -ENODEV;
>> +        int i;
>> +        struct iommu_group *group;
>> +
>> +        group = iommu_group_get(dev);
>> +        if (!group) {
>> +            group = iommu_group_alloc();
>> +            if (IS_ERR(group)) {
>> +                dev_err(dev, "failed to allocate IOMMU group\n");
>> +                return PTR_ERR(group);
>> +            }
>> +
>> +            ret = iommu_group_add_device(group, dev);
>> +            if (ret) {
>> +                dev_err(dev, "failed to add device into IOMMU group\n");
>> +                return PTR_ERR(group);
> 
> This leaks the group.

OK, I got it. Thanks.

> 
>> +            }
>> +        }
>> +        iommu_group_put(group);
>> +
>> +        for (i = 0; i < args->args_count; i++) {
> 
> I'm dubious of the value of looping here - having n>1 #iommu-cells per phandle means that every platform device behind one SMMU must have the same number of stream IDs, or you still have to have
> repeated phandles for every device with some greater multiple of n stream IDs each, but ruling out any device with <n. I'm not sure how realistic that is, and whether there's any real benefit beyond
> saving a handful of bytes in the DTB.

As you mentioned before, a master with two streamIDs can be written as below(This is also mentioned in Documentation\devicetree\bindings\iommu\iommu.txt):
#iommu-cells = <1>;
iommus = <&{/iommu} 23>, <&{/iommu} 24>;

On my hardware platform, a master only have one streamID. But I tested two cases:
#iommu-cells = <1>;
1. iommus = <&smmu0 good-sid>, <&smmu0 bad-sid>;
2. iommus = <&smmu0 bad-sid>, <&smmu0 good-sid>;
All of these two cases worked well.

Well, if each master contains two streamIDs(or more but equal), this for loop is needed.

> 
>> +            ret = arm_smmu_add_device(dev, args->args[i]);
>> +            if (ret) {
>> +                dev_err(dev,
>> +                    "failed to add sid=%d into SMMU\n",
>> +                    args->args[i]);
>> +                return ret;
>> +            }
>> +        }
>>       } else {
>>           u32 sid;
>>           struct device_node *of_root;
>> @@ -2725,6 +2752,14 @@ static int __init arm_smmu_init(void)
>>       if (ret)
>>           return ret;
>>
>> +    if (!iommu_present(&platform_bus_type))
>> +        bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
>> +
>> +#ifdef CONFIG_ARM_AMBA
>> +    if (!iommu_present(&amba_bustype))
>> +        bus_set_iommu(&amba_bustype, &arm_smmu_ops);
>> +#endif
>> +
>>       return bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
>>   }
>>
>> -- 
>> 1.8.0
>>
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
> 
> 
> .
> 
