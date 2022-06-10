Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBDFC43334
	for <iommu@archiver.kernel.org>; Fri, 10 Jun 2022 07:16:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CE86A4017A;
	Fri, 10 Jun 2022 07:16:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VR524XdbgkEV; Fri, 10 Jun 2022 07:16:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2D0C740C6E;
	Fri, 10 Jun 2022 07:16:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04471C0039;
	Fri, 10 Jun 2022 07:16:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5316C002D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 07:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF7B5611C3
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 07:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RZOzqD7RO1tW for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jun 2022 07:16:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A06DE611BC
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jun 2022 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654845385; x=1686381385;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=y9gOk8nKuLvO9MuJM128hE/YVKafAr7qvgjxLQMoq2E=;
 b=nFahWmGSDZHI0GbDka2UqcKJmRvpla0ZdSJ8bsftyecNJ72jma0LmIb0
 92IBRBAsW248PBB1Yiktq1TL2Z4YL0ReZsIFB4lJaiMLSW64izl0lE9d4
 WrAq1swaa/qCf5GVAn/bhLB61Gb9BMpPPc2TB5YAvMzOfumuKIfZXcoEZ
 seoAUstbx0GYpXjMB2I2dVuuo9LwUxZ5QXqtr67tCc7BT6uf3j3fFWlZ8
 ls9zGyj1YadWzGWPR2dDY5EnAUYgHgiYef4gKrpPya9jA/0SrRGMnWcX0
 3LoB0dBRjqI+U32UAb1wTQVXuuQA1Zw/ZrdAnilXAgEH89Eq8NOpaKNzI w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="266311840"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="266311840"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2022 00:16:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; d="scan'208";a="637988807"
Received: from chengxu1-mobl2.ccr.corp.intel.com (HELO [10.249.169.148])
 ([10.249.169.148])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2022 00:16:20 -0700
Message-ID: <a78c5bd0-a9f2-2a6d-3099-8d03c123fa93@linux.intel.com>
Date: Fri, 10 Jun 2022 15:16:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 04/11] iommu: Add sva iommu_domain support
Content-Language: en-US
To: "Raj, Ashok" <ashok.raj@intel.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-5-baolu.lu@linux.intel.com>
 <20220609202540.GD33363@araj-dh-work>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220609202540.GD33363@araj-dh-work>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/6/10 04:25, Raj, Ashok wrote:
> Hi Baolu

Hi Ashok,

> 
> some minor nits.

Thanks for your comments.

> 
> On Tue, Jun 07, 2022 at 09:49:35AM +0800, Lu Baolu wrote:
>> The sva iommu_domain represents a hardware pagetable that the IOMMU
>> hardware could use for SVA translation. This adds some infrastructure
>> to support SVA domain in the iommu common layer. It includes:
>>
>> - Extend the iommu_domain to support a new IOMMU_DOMAIN_SVA domain
>>    type. The IOMMU drivers that support SVA should provide the sva
>>    domain specific iommu_domain_ops.
>> - Add a helper to allocate an SVA domain. The iommu_domain_free()
>>    is still used to free an SVA domain.
>> - Add helpers to attach an SVA domain to a device and the reverse
>>    operation.
>>
>> Some buses, like PCI, route packets without considering the PASID value.
>> Thus a DMA target address with PASID might be treated as P2P if the
>> address falls into the MMIO BAR of other devices in the group. To make
>> things simple, the attach/detach interfaces only apply to devices
>> belonging to the singleton groups, and the singleton is immutable in
>> fabric i.e. not affected by hotplug.
>>
>> The iommu_attach/detach_device_pasid() can be used for other purposes,
>> such as kernel DMA with pasid, mediation device, etc.
>>
>> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> ---
>>   include/linux/iommu.h | 45 ++++++++++++++++++++-
>>   drivers/iommu/iommu.c | 93 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 136 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 3fbad42c0bf8..9173c5741447 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -64,6 +64,9 @@ struct iommu_domain_geometry {
>>   #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>>   #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>>   
>> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
> 
> s/from CPU/with CPU

Sure.

> 
>> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
> 
> Do you mean general CPU VA? or Host CPU VA, I'm reading the latter as 2nd
> stage?

Host CPU VA. In the near future, we will add another flag _GUEST_VA, so
that the shared page table types are distiguished.

> 
>> +
>>   /*
>>    * This are the possible domain-types
>>    *
>> @@ -86,15 +89,24 @@ struct iommu_domain_geometry {
>>   #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>>   				 __IOMMU_DOMAIN_DMA_API |	\
>>   				 __IOMMU_DOMAIN_DMA_FQ)
>> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
>> +				 __IOMMU_DOMAIN_HOST_VA)
> 
> Doesn't shared automatically mean CPU VA? Do we need another flag?

Yes. Shared means CPU VA, but there're many types. Besides above two, we
also see the shared KVM/EPT.

> 
>>   
>>   struct iommu_domain {
>>   	unsigned type;
>>   	const struct iommu_domain_ops *ops;
>>   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
>> -	iommu_fault_handler_t handler;
>> -	void *handler_token;
>>   	struct iommu_domain_geometry geometry;
>>   	struct iommu_dma_cookie *iova_cookie;
>> +	union {
>> +		struct {	/* IOMMU_DOMAIN_DMA */
>> +			iommu_fault_handler_t handler;
>> +			void *handler_token;
>> +		};
>> +		struct {	/* IOMMU_DOMAIN_SVA */
>> +			struct mm_struct *mm;
>> +		};
>> +	};
>>   };
>>   
>>   static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>> @@ -262,6 +274,8 @@ struct iommu_ops {
>>    * struct iommu_domain_ops - domain specific operations
>>    * @attach_dev: attach an iommu domain to a device
>>    * @detach_dev: detach an iommu domain from a device
>> + * @set_dev_pasid: set an iommu domain to a pasid of device
>> + * @block_dev_pasid: block pasid of device from using iommu domain
>>    * @map: map a physically contiguous memory region to an iommu domain
>>    * @map_pages: map a physically contiguous set of pages of the same size to
>>    *             an iommu domain.
>> @@ -282,6 +296,10 @@ struct iommu_ops {
>>   struct iommu_domain_ops {
>>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>>   	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
>> +	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
>> +			     ioasid_t pasid);
>> +	void (*block_dev_pasid)(struct iommu_domain *domain, struct device *dev,
>> +				ioasid_t pasid);
>>   
>>   	int (*map)(struct iommu_domain *domain, unsigned long iova,
>>   		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
>> @@ -679,6 +697,12 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
>>   void iommu_group_release_dma_owner(struct iommu_group *group);
>>   bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>>   
>> +struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>> +					    struct mm_struct *mm);
>> +int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
>> +			      ioasid_t pasid);
>> +void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>> +			       ioasid_t pasid);
>>   #else /* CONFIG_IOMMU_API */
>>   
>>   struct iommu_ops {};
>> @@ -1052,6 +1076,23 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>>   {
>>   	return false;
>>   }
>> +
>> +static inline struct iommu_domain *
>> +iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
>> +					    struct device *dev, ioasid_t pasid)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
>> +					     struct device *dev, ioasid_t pasid)
>> +{
>> +}
>>   #endif /* CONFIG_IOMMU_API */
>>   
>>   /**
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index d1ec855b1f72..e92391dcce33 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/module.h>
>>   #include <linux/cc_platform.h>
>>   #include <trace/events/iommu.h>
>> +#include <linux/sched/mm.h>
>>   
>>   static struct kset *iommu_group_kset;
>>   static DEFINE_IDA(iommu_group_ida);
>> @@ -39,6 +40,7 @@ struct iommu_group {
>>   	struct kobject kobj;
>>   	struct kobject *devices_kobj;
>>   	struct list_head devices;
>> +	struct xarray pasid_array;
>>   	struct mutex mutex;
>>   	void *iommu_data;
>>   	void (*iommu_data_release)(void *iommu_data);
>> @@ -666,6 +668,7 @@ struct iommu_group *iommu_group_alloc(void)
>>   	mutex_init(&group->mutex);
>>   	INIT_LIST_HEAD(&group->devices);
>>   	INIT_LIST_HEAD(&group->entry);
>> +	xa_init(&group->pasid_array);
>>   
>>   	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
>>   	if (ret < 0) {
>> @@ -1961,6 +1964,8 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>>   
>>   void iommu_domain_free(struct iommu_domain *domain)
>>   {
>> +	if (domain->type == IOMMU_DOMAIN_SVA)
>> +		mmdrop(domain->mm);
>>   	iommu_put_dma_cookie(domain);
>>   	domain->ops->free(domain);
>>   }
>> @@ -3277,3 +3282,91 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>>   	return user;
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>> +
>> +struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
>> +					    struct mm_struct *mm)
>> +{
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>> +	struct iommu_domain *domain;
>> +
>> +	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
>> +	if (!domain)
>> +		return NULL;
>> +
>> +	domain->type = IOMMU_DOMAIN_SVA;
>> +	mmgrab(mm);
>> +	domain->mm = mm;
>> +
>> +	return domain;
>> +}
>> +
>> +static bool iommu_group_immutable_singleton(struct iommu_group *group,
>> +					    struct device *dev)
>> +{
>> +	int count;
>> +
>> +	mutex_lock(&group->mutex);
>> +	count = iommu_group_device_count(group);
>> +	mutex_unlock(&group->mutex);
>> +
>> +	if (count != 1)
>> +		return false;
>> +
>> +	/*
>> +	 * The PCI device could be considered to be fully isolated if all
>> +	 * devices on the path from the device to the host-PCI bridge are
>> +	 * protected from peer-to-peer DMA by ACS.
>> +	 */
>> +	if (dev_is_pci(dev))
>> +		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
>> +					    REQ_ACS_FLAGS);
> 
> Does this comprehend RCiEP devices? Since they are optional even if ACS is
> lacking.

Yes. It's already been covered by pci_acs_enabled().

/**
  * pci_acs_enabled - test ACS against required flags for a given device
  * @pdev: device to test
  * @acs_flags: required PCI ACS flags
  *
  * Return true if the device supports the provided flags.  Automatically
  * filters out flags that are not implemented on multifunction devices.
  *
  * Note that this interface checks the effective ACS capabilities of the
  * device rather than the actual capabilities.  For instance, most single
  * function endpoints are not required to support ACS because they have no
  * opportunity for peer-to-peer access.  We therefore return 'true'
  * regardless of whether the device exposes an ACS capability.  This makes
  * it much easier for callers of this function to ignore the actual type
  * or topology of the device when testing ACS support.
  */
bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)


> 
>> +
>> +	/*
>> +	 * Otherwise, the device came from DT/ACPI, assume it is static and
>> +	 * then singleton can know from the device count in the group.
>> +	 */
>> +	return true;
>> +}
>> +
>> +int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
>> +			      ioasid_t pasid)
>> +{
>> +	struct iommu_group *group;
>> +	int ret = -EBUSY;
>> +	void *curr;
>> +
>> +	if (!domain->ops->set_dev_pasid)
>> +		return -EOPNOTSUPP;
>> +
>> +	group = iommu_group_get(dev);
>> +	if (!group || !iommu_group_immutable_singleton(group, dev)) {
>> +		iommu_group_put(group);
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&group->mutex);
>> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
>> +	if (curr)
>> +		goto out_unlock;
>> +	ret = domain->ops->set_dev_pasid(domain, dev, pasid);
>> +	if (ret)
>> +		xa_erase(&group->pasid_array, pasid);
>> +out_unlock:
>> +	mutex_unlock(&group->mutex);
>> +	iommu_group_put(group);
>> +
>> +	return ret;
>> +}
>> +
>> +void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>> +			       ioasid_t pasid)
>> +{
>> +	struct iommu_group *group = iommu_group_get(dev);
>> +
>> +	mutex_lock(&group->mutex);
>> +	domain->ops->block_dev_pasid(domain, dev, pasid);
>> +	xa_erase(&group->pasid_array, pasid);
>> +	mutex_unlock(&group->mutex);
>> +
>> +	iommu_group_put(group);
>> +}
>> -- 
>> 2.25.1
>>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
