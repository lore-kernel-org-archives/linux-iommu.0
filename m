From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 2/8] iommu/vt-d: Add multiple domains per device query
Date: Mon, 26 Nov 2018 10:10:46 +0800
Message-ID: <36911a68-ee47-20b7-c2a7-7a9c8d4d88f5@linux.intel.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-3-baolu.lu@linux.intel.com>
 <929c8ce3-94f5-bcd5-89ff-71758b808b50@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <929c8ce3-94f5-bcd5-89ff-71758b808b50@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yi.y.sun@intel.com, jacob.jun.pan@intel.com, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 11/23/18 6:49 PM, Auger Eric wrote:
> Hi,
> 
> On 11/5/18 8:34 AM, Lu Baolu wrote:
>> Add the response to IOMMU_DEV_ATTR_AUXD_CAPABILITY capability query
>> through iommu_get_dev_attr().
> 
> commit title: Advertise auxiliary domain capability?

Yes. I should make it consistent. Thanks.

>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 38 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 5e149d26ea9b..298f7a3fafe8 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -5167,6 +5167,24 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
>>   	return phys;
>>   }
>>   
>> +static inline bool scalable_mode_support(void)
>> +{
>> +	struct dmar_drhd_unit *drhd;
>> +	struct intel_iommu *iommu;
>> +	bool ret = true;
>> +
>> +	rcu_read_lock();
>> +	for_each_active_iommu(iommu, drhd) {
>> +		if (!sm_supported(iommu)) {
>> +			ret = false;
>> +			break;
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +
>> +	return ret;
>> +}
>> +
>>   static bool intel_iommu_capable(enum iommu_cap cap)
>>   {
>>   	if (cap == IOMMU_CAP_CACHE_COHERENCY)
>> @@ -5331,6 +5349,25 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
>>   }
>>   #endif /* CONFIG_INTEL_IOMMU_SVM */
>>   
>> +static int intel_iommu_get_dev_attr(struct device *dev,
>> +				    enum iommu_dev_attr attr, void *data)
>> +{
>> +	int ret = 0;
>> +	bool *auxd_capable;
> nit: could be local to the case as other cases may use other datatypes.

I have thought about this. Making it local to the case needs extra "{}".
That's the reason I put it here. We can change it later when we need
other datatypes.

>> +
>> +	switch (attr) {
>> +	case IOMMU_DEV_ATTR_AUXD_CAPABILITY:
>> +		auxd_capable = data;
>> +		*auxd_capable = scalable_mode_support();
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   const struct iommu_ops intel_iommu_ops = {
>>   	.capable		= intel_iommu_capable,
>>   	.domain_alloc		= intel_iommu_domain_alloc,
>> @@ -5345,6 +5382,7 @@ const struct iommu_ops intel_iommu_ops = {
>>   	.get_resv_regions	= intel_iommu_get_resv_regions,
>>   	.put_resv_regions	= intel_iommu_put_resv_regions,
>>   	.device_group		= pci_device_group,
>> +	.get_dev_attr		= intel_iommu_get_dev_attr,
>>   	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>>   };
>>   
>>
> Thanks
> 
> Eric
> 
> 

Best regards,
Lu Baolu
