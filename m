From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 8/8] vfio/type1: Handle different mdev isolation type
Date: Mon, 26 Nov 2018 11:09:00 +0800
Message-ID: <0b951425-ea7f-3596-b4b5-f8e56072c765@linux.intel.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-9-baolu.lu@linux.intel.com>
 <e9822321-fca3-29bc-f5a1-c6297d2161ae@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e9822321-fca3-29bc-f5a1-c6297d2161ae@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: baolu.lu@linux.intel.com, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 11/23/18 10:23 PM, Auger Eric wrote:
> Hi Lu,
> 
> On 11/5/18 8:34 AM, Lu Baolu wrote:
>> This adds the support to determine the isolation type
>> of a mediated device group by checking whether it has
>> an iommu device. If an iommu device exists, an iommu
>> domain will be allocated and then attached to the iommu
>> device. Otherwise, keep the same behavior as it is.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 48 ++++++++++++++++++++++++++++-----
>>   1 file changed, 42 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 178264b330e7..eed26129f58c 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -1427,13 +1427,40 @@ static void vfio_iommu_detach_group(struct vfio_domain *domain,
>>   		iommu_detach_group(domain->domain, group->iommu_group);
>>   }
>>   
>> +static bool vfio_bus_is_mdev(struct bus_type *bus)
>> +{
>> +	struct bus_type *mdev_bus;
>> +	bool ret = false;
>> +
>> +	mdev_bus = symbol_get(mdev_bus_type);
>> +	if (mdev_bus) {
>> +		ret = (bus == mdev_bus);
>> +		symbol_put(mdev_bus_type);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int vfio_mdev_iommu_device(struct device *dev, void *data)
>> +{
>> +	struct device **old = data, *new;
>> +
>> +	new = vfio_mdev_get_iommu_device(dev);
>> +	if (*old && *old != new)
> if !new can't you return -EINVAL as well?

Yes, good catch.

>> +		return -EINVAL;
>> +
>> +	*old = new;
>> +
>> +	return 0;
>> +}
>> +
>>   static int vfio_iommu_type1_attach_group(void *iommu_data,
>>   					 struct iommu_group *iommu_group)
>>   {
>>   	struct vfio_iommu *iommu = iommu_data;
>>   	struct vfio_group *group;
>>   	struct vfio_domain *domain, *d;
>> -	struct bus_type *bus = NULL, *mdev_bus;
>> +	struct bus_type *bus = NULL;
>>   	int ret;
>>   	bool resv_msi, msi_remap;
>>   	phys_addr_t resv_msi_base;
>> @@ -1468,11 +1495,18 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>   	if (ret)
>>   		goto out_free;
>>   
>> -	mdev_bus = symbol_get(mdev_bus_type);
>> +	if (vfio_bus_is_mdev(bus)) {
>> +		struct device *iommu_device = NULL;
>>   
>> -	if (mdev_bus) {
>> -		if ((bus == mdev_bus) && !iommu_present(bus)) {
>> -			symbol_put(mdev_bus_type);
>> +		group->mdev_group = true;
>> +
>> +		/* Determine the isolation type */
>> +		ret = iommu_group_for_each_dev(iommu_group, &iommu_device,
>> +					       vfio_mdev_iommu_device);
>> +		if (ret)
>> +			goto out_free;
>> +
>> +		if (!iommu_device) {
>>   			if (!iommu->external_domain) {
>>   				INIT_LIST_HEAD(&domain->group_list);
>>   				iommu->external_domain = domain;
>> @@ -1482,9 +1516,11 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>   			list_add(&group->next,
>>   				 &iommu->external_domain->group_list);
>>   			mutex_unlock(&iommu->lock);
>> +
> extra new line

Yes.

>>   			return 0;
>>   		}
>> -		symbol_put(mdev_bus_type);
>> +
>> +		bus = iommu_device->bus;
>>   	}
>>   
>>   	domain->domain = iommu_domain_alloc(bus);
>>
> Thanks
> 
> Eric
> 

Best regards,
Lu Baolu
