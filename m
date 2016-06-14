From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 5/7] iommu/arm-smmu: Implement of_xlate() for SMMUv3
Date: Tue, 14 Jun 2016 17:11:59 +0100
Message-ID: <57602CCF.1060603@arm.com>
References: <cover.1464966939.git.robin.murphy@arm.com>
 <55aa94e099f00fd586077c45d4c4fd1c010981d9.1464966939.git.robin.murphy@arm.com>
 <20160614150757.GB16531@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160614150757.GB16531-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 14/06/16 16:07, Will Deacon wrote:
> On Fri, Jun 03, 2016 at 06:15:40PM +0100, Robin Murphy wrote:
>> Now that we can properly describe the mapping between PCI RIDs and
>> stream IDs via "iommu-map", and have it fed it to the driver
>> automatically via of_xlate(), rework the SMMUv3 driver to benefit from
>> that. Initially, this just gets rid of the misuse of the "iommus"
>> binding without changing the driver's existing level of functionality,
>> but does at least pave the way to extending it more easily in future.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>
>> v2: New.
>>
>>   drivers/iommu/arm-smmu-v3.c | 119 +++++++++++++++++++++++++++-----------------
>>   1 file changed, 73 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 94b68213c50d..7631639cc209 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -30,6 +30,7 @@
>>   #include <linux/msi.h>
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>> +#include <linux/of_iommu.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/pci.h>
>>   #include <linux/platform_device.h>
>> @@ -638,6 +639,12 @@ struct arm_smmu_domain {
>>   	struct iommu_domain		domain;
>>   };
>>
>> +/* SMMU private data for each master */
>> +struct arm_smmu_master_data {
>> +	struct arm_smmu_device		*smmu;
>> +	u32				sid;
>> +};
>
> Hmm, we already have this information in arm_smmu_group so I'd rather
> avoid the duplication if we can.

For of_xlate() to work at all, we need to associate the IDs with their 
device long before groups are even available (because the device is only 
partially constructed), so at a bare minimum we need something to carry 
the data through until we see it again in add_device, where we can 
allocate a group.

>> @@ -1804,23 +1790,41 @@ static int arm_smmu_add_device(struct device *dev)
>>   {
>>   	int i, ret;
>>   	u32 sid, *sids;
>> -	struct pci_dev *pdev;
>>   	struct iommu_group *group;
>> +	struct device_node *np;
>>   	struct arm_smmu_group *smmu_group;
>> -	struct arm_smmu_device *smmu;
>> +	struct arm_smmu_device *smmu = NULL;
>> +	struct arm_smmu_master_data *data = dev->archdata.iommu;
>>
>> -	/* We only support PCI, for now */
>> -	if (!dev_is_pci(dev))
>> +	if (!data)
>>   		return -ENODEV;
>>
>> -	pdev = to_pci_dev(dev);
>> +	np = (struct device_node *)data->smmu;
>> +	smmu = data->smmu = arm_smmu_get_by_node(np);
>> +	of_node_put(np);
>> +	if (!smmu)
>> +		return -ENODEV;
>
> Why can't we continue to use the group here?

I don't follow; at this point we've still not even allocated/found a 
group for this device yet. The code a few dozen lines later that takes 
the IDs and stashes them in the groupdata once it _does_ exist is 
unchanged in this patch, all that's changing is how those IDs got here 
in the first place.

Robin.

>
> Will
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
