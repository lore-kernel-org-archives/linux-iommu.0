From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 02/10] iommu/vt-d: Alloc domain for a mediated device
Date: Tue, 24 Jul 2018 10:09:58 +0800
Message-ID: <5B568A76.6080503@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
	<1532239773-15325-3-git-send-email-baolu.lu@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439CA1432@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439CA1432-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On 07/23/2018 12:44 PM, Liu, Yi L wrote:
>> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
>> Sent: Sunday, July 22, 2018 2:09 PM
>>
>> The PASID-granular 2nd level address translation makes it possible to isolate and
>> protect a mediated device exposed by a real device which support PCI PASID
> "support" -> "supports"

Sure.

>
>> features. This patch adds support to allocate a domain for a mediated device. A
>> default pasid value will be allocated as well for the mediated device. This will be used
> This is not accurate, it is "a default pasid value will be allocated for the domain, and the
> mdev will be configed to use this pasid when it is added to this domain"

Looks better. Thank you.

Best regards,
Lu Baolu

>
> Regards,
> Yi Liu
>
>> by the mediated device attached to this domain for non-SVM DMA transactions.
>>
>> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>  drivers/iommu/intel-iommu.c | 17 ++++++++++++++++-  include/linux/intel-iommu.h
>> |  5 +++++
>>  2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
>> fc3ac1c..3ede34a 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1926,6 +1926,9 @@ static void domain_exit(struct dmar_domain *domain)
>>  	domain_remove_dev_info(domain);
>>  	rcu_read_unlock();
>>
>> +	if (domain->default_pasid > 0)
>> +		intel_pasid_free_id(domain->default_pasid);
>> +
>>  	/* destroy iovas */
>>  	put_iova_domain(&domain->iovad);
>>
>> @@ -2519,11 +2522,23 @@ static struct dmar_domain
>> *dmar_insert_one_dev_info(struct intel_iommu *iommu,
>>  		}
>>  	}
>>
>> +	if (dev && dev_is_mdev(dev) && domain->default_pasid <= 0) {
>> +		int max = intel_pasid_get_dev_max_id(dev_mdev_parent(dev));
>> +
>> +		domain->default_pasid = intel_pasid_alloc_id(domain, PASID_MIN,
>> +							     max, GFP_KERNEL);
>> +		if (domain->default_pasid < 0) {
>> +			free_devinfo_mem(info);
>> +			return NULL;
>> +		}
>> +	}
>> +
>>  	spin_lock_irqsave(&device_domain_lock, flags);
>>  	if (dev)
>>  		found = find_domain(dev);
>>
>> -	if (!found) {
>> +	/* A mediated device never has an DMA alias. Ignore searching. */
>> +	if (!found && !dev_is_mdev(dev)) {
>>  		struct device_domain_info *info2;
>>  		info2 = dmar_search_domain_by_dev_info(iommu->segment, bus,
>> devfn);
>>  		if (info2) {
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h index
>> 7efc632..9f5dcf6 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -423,6 +423,11 @@ struct dmar_domain {
>>  					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
>>  	u64		max_addr;	/* maximum mapped address */
>>
>> +	int		default_pasid;	/*
>> +					 * The default pasid used for non-SVM
>> +					 * traffic on mediated devices.
>> +					 */
>> +
>>  	struct iommu_domain domain;	/* generic domain data structure for
>>  					   iommu core */
>>  };
>> --
>> 2.7.4
>
