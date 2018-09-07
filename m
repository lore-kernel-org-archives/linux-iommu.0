From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Handle memory shortage on pasid table
 allocation
Date: Fri, 7 Sep 2018 13:02:42 +0800
Message-ID: <01578cfe-48c3-93bc-90a1-14971e3864f1@linux.intel.com>
References: <20180901062416.6107-1-baolu.lu@linux.intel.com>
 <20180906231313.GB90494@otc-nc-03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906231313.GB90494@otc-nc-03>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi Ashok,

On 09/07/2018 07:13 AM, Raj, Ashok wrote:
> On Sat, Sep 01, 2018 at 02:24:16PM +0800, Lu Baolu wrote:
>> Pasid table memory allocation could return failure due to memory
>> shortage. Limit the pasid table size to 1MiB because current 8MiB
>> contiguous physical memory allocation can be hard to come by. W/o
>> a PASID table, the device could continue to work with only shared
>> virtual memory impacted. So, let's go ahead with context mapping
>> even the memory allocation for pasid table failed.
>>
>> Fixes: cc580e41260d ("iommu/vt-d: Per PCI device pasid table interfaces")
> 
> Although this reduces the changes of failure, ideally we should remove
> any trace of ecs support. We officially have no products that support it
> officially, and our latest spec does deprecate ECS feature.

The spec update has been posted here.

https://lkml.org/lkml/2018/8/30/27

This is a fix for regression caused by cc580e41260d ("iommu/vt-d: Per
PCI device pasid table interfaces"), where the maximum of pasid table
was changed from 1MiB to 8MiB and stopping programming context entry
once the pasid table memory allocations is failed. This regression was
found on some internal pre-production devices.

Best regards,
Lu Baolu

> 
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Reported-and-tested-by: Pelton Kyle D <kyle.d.pelton@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 6 +++---
>>   drivers/iommu/intel-pasid.h | 2 +-
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 5f3f10cf9d9d..bedc801b06a0 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -2540,9 +2540,9 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>>   	if (dev && dev_is_pci(dev) && info->pasid_supported) {
>>   		ret = intel_pasid_alloc_table(dev);
>>   		if (ret) {
>> -			__dmar_remove_one_dev_info(info);
>> -			spin_unlock_irqrestore(&device_domain_lock, flags);
>> -			return NULL;
>> +			pr_warn("No pasid table for %s, pasid disabled\n",
>> +				dev_name(dev));
>> +			info->pasid_supported = 0;
>>   		}
>>   	}
>>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
>> index 1c05ed6fc5a5..1fb5e12b029a 100644
>> --- a/drivers/iommu/intel-pasid.h
>> +++ b/drivers/iommu/intel-pasid.h
>> @@ -11,7 +11,7 @@
>>   #define __INTEL_PASID_H
>>   
>>   #define PASID_MIN			0x1
>> -#define PASID_MAX			0x100000
>> +#define PASID_MAX			0x20000
>>   
>>   struct pasid_entry {
>>   	u64 val;
>> -- 
>> 2.17.1
>>
> 
