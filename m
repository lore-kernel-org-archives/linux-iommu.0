From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 5/9] iommu/vt-d: Per domain pasid table interfaces
Date: Wed, 2 May 2018 11:08:27 +0800
Message-ID: <5AE92BAB.3010705@linux.intel.com>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
	<1523934202-21669-6-git-send-email-baolu.lu@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439BE7516@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439BE7516-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Yi,

Thank you very much for reviewing my patches.

On 05/01/2018 05:22 PM, Liu, Yi L wrote:
>> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
>> Sent: Tuesday, April 17, 2018 11:03 AM
>>
>> This patch adds the interfaces for per domain pasid table
>> management. Currently we allocate one pasid table for all
>> devices under the scope of an IOMMU. It's insecure in the
>> cases where multiple devices under one single IOMMU unit
>> support PASID feature. With per domain pasid table, we can
>> achieve finer protection and isolation granularity.
>>
>> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Suggested-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>  drivers/iommu/intel-pasid.c | 75
>> +++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/iommu/intel-pasid.h |  4 +++
>>  include/linux/intel-iommu.h |  5 +++
>>  3 files changed, 84 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
>> index 0690f39..b8691a6 100644
>> --- a/drivers/iommu/intel-pasid.c
>> +++ b/drivers/iommu/intel-pasid.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/intel-iommu.h>
>>  #include <linux/iommu.h>
>>  #include <linux/memory.h>
>> +#include <linux/pci.h>
>>  #include <linux/spinlock.h>
>>
>>  #include "intel-pasid.h"
>> @@ -58,3 +59,77 @@ void *intel_pasid_lookup_id(int pasid)
>>
>>  	return p;
>>  }
>> +
>> +/*
>> + * Interfaces for per domain pasid table management:
>> + */
>> +int intel_pasid_alloc_table(struct device *dev, size_t entry_size,
>> +			    size_t entry_count)
>> +{
>> +	struct device_domain_info *info;
>> +	struct dmar_domain *domain;
>> +	struct page *pages;
>> +	int order;
>> +
>> +	info = dev->archdata.iommu;
>> +	if (WARN_ON(!info || !dev_is_pci(dev) ||
>> +		    !info->pasid_supported ||
>> +		    !info->domain))
>> +		return -EINVAL;
>> +
>> +	domain = info->domain;
>> +
>> +	if (entry_count > intel_pasid_max_id)
>> +		entry_count = intel_pasid_max_id;
>> +
>> +	order = get_order(entry_size * entry_count);
>> +	pages = alloc_pages_node(domain->nid, GFP_KERNEL | __GFP_ZERO, order);
>> +	if (!pages)
>> +		return -ENOMEM;
>> +
>> +	spin_lock(&pasid_lock);
>> +	if (domain->pasid_table) {
> Can the check be moved prior to the page allocation?

I chose allocation and then assignment with lock to avoid
race and possible page allocation failure.

>
>> +		__free_pages(pages, order);
>> +	} else {
>> +		domain->pasid_table	= page_address(pages);
>> +		domain->order		= order;
>> +		domain->max_pasid	= entry_count;
>> +	}
>> +	domain->pasid_users++;
>> +	spin_unlock(&pasid_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +void intel_pasid_free_table(struct device *dev)
>> +{
>> +	struct dmar_domain *domain;
>> +
>> +	domain = get_valid_domain_for_dev(dev);
>> +	if (!domain || !dev_is_pci(dev))
>> +		return;
>> +
>> +	spin_lock(&pasid_lock);
>> +	if (domain->pasid_table) {
>> +		domain->pasid_users--;
>> +		if (!domain->pasid_users) {
>> +			free_pages((unsigned long)domain->pasid_table,
>> +				   domain->order);
>> +			domain->pasid_table	= NULL;
>> +			domain->order		= 0;
>> +			domain->max_pasid	= 0;
>> +		}
>> +	}
>> +	spin_unlock(&pasid_lock);
>> +}
>> +
>> +void *intel_pasid_get_table(struct device *dev)
> Will intel_iommu_get_pasid_table() more accurate?

This function defines in intel-pasid.c. The name pattern for global
functions defined in this function is intel_pasid_xxx_xxxx().

>
> Regards,
> Yi Liu
>

Best regards,
Lu Baolu
