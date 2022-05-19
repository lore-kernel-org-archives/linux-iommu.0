Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBD9C433EF
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 16:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE639612FC;
	Thu, 19 May 2022 16:34:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CBIzgtfZyDx4; Thu, 19 May 2022 16:34:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AE29560F6F;
	Thu, 19 May 2022 16:34:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75A44C0039;
	Thu, 19 May 2022 16:34:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD29EC002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 94D234012A
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:34:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ddad4CEKAyLi for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 16:34:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EC2941096
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:34:18 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id ay35so1591400wmb.5
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 09:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8qOSmNt42l/OCGmbno8l29QID+BV2mayim2UvNOvGqY=;
 b=yP/A3yGj0N6SZOh43a3pIa+w3fXBtI4hpdrWPhh1N5eoMB0juQ79P5JhtfFOB1cPz4
 NyeXJJ5soEpAtYrux2M/BQ2Ac1WFeeBS/ciip/G3DsrsjQ3YNsUZERK84YWLa9WhPGfj
 tSm0piD3Gd+IbH6nyV6lz+KNKPNSEy7KUmO8BxZ9e3WcKsYKWVdUqKAVIee1HNkBsdWh
 3ezgxe3NaXLZdEiL+/Zso4dYAfRu/q5EK0G2jqh7c/LRmG6ILsr4McjGh7DAhR6aS4Wv
 8vek315UWrjnBoPuPc10m0ZLRKnx50VS9cA6T8VXbOM2xDk0E3x8/XXVbb/hgkW2AXJi
 XCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8qOSmNt42l/OCGmbno8l29QID+BV2mayim2UvNOvGqY=;
 b=BuZszwHiRC1WFfWnaI1emRDm/PSTFT/AYfbUAoEklmulysn80F5o0JUe3tO8MlS6/J
 mnwXzdDUFAgjdyUOJRa2T9Dnlhg3MUMo6TVW9gn0jxgysinkc2BpGBLcGJ3eVIOD+A5t
 1x62FaDIaEJ02Rk3fP06mRDH9dUUMUphI80+pRpEjTJqWG17CvqTtWO1qB0Qxv+KPp56
 epU5jp0+6+oPSQCJU8R/e/Ap4VLo2r2T98CT++VXHzP99U9taBZwKRsIHoeZdQf6jWHv
 kNfGUsMj7CAwWP0F9mIUTJ17i9IrZ+AZl5CLUTmi3NRCIppSGsxd2RTIEK5CX39+0CvQ
 uS9g==
X-Gm-Message-State: AOAM533/E+d2iG9QAtk9hKecGCd5/cc9guQvXXeN/6rtVtBY/4BwPpOw
 9aUIXf3+z6emp2MG2JNVo2n9iQ==
X-Google-Smtp-Source: ABdhPJwx+pk3DrU/je8ol5nx1VFMLrX7Y5X1mNEYsN1r8kdtwAn5EVi/tyYU30OPWARo2XuK3rS/Bg==
X-Received: by 2002:a05:600c:204b:b0:394:4028:b0f9 with SMTP id
 p11-20020a05600c204b00b003944028b0f9mr4562624wmg.114.1652978056479; 
 Thu, 19 May 2022 09:34:16 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 p14-20020adfaa0e000000b0020d02ddf4d0sm32025wrd.69.2022.05.19.09.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 09:34:16 -0700 (PDT)
Date: Thu, 19 May 2022 17:33:51 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Message-ID: <YoZxb26tYf8mmv87@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220519072047.2996983-4-baolu.lu@linux.intel.com>
X-TUID: Nkj467R+9Ewb
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, May 19, 2022 at 03:20:40PM +0800, Lu Baolu wrote:
> The iommu_sva_domain represents a hardware pagetable that the IOMMU
> hardware could use for SVA translation. This adds some infrastructure
> to support SVA domain in the iommu common layer. It includes:
> 
> - Add a new struct iommu_sva_domain and new IOMMU_DOMAIN_SVA domain
>   type.
> - Add a new domain ops pointer in iommu_ops. The IOMMU drivers that
>   support SVA should provide the callbacks.
> - Add helpers to allocate and free an SVA domain.
> - Add helpers to set an SVA domain to a device and the reverse
>   operation.
> 
> Some buses, like PCI, route packets without considering the PASID value.
> Thus a DMA target address with PASID might be treated as P2P if the
> address falls into the MMIO BAR of other devices in the group. To make
> things simple, the attach/detach interfaces only apply to devices
> belonging to the singleton groups, and the singleton is immutable in
> fabric i.e. not affected by hotplug.
> 
> The iommu_set/block_device_pasid() can be used for other purposes,
> such as kernel DMA with pasid, mediation device, etc. Hence, it is put
> in the iommu.c.
> 
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h         | 51 +++++++++++++++++++++++++
>  drivers/iommu/iommu-sva-lib.h | 15 ++++++++
>  drivers/iommu/iommu-sva-lib.c | 48 +++++++++++++++++++++++
>  drivers/iommu/iommu.c         | 71 +++++++++++++++++++++++++++++++++++
>  4 files changed, 185 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 0c358b7c583b..e8cf82d46ce1 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -64,6 +64,9 @@ struct iommu_domain_geometry {
>  #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
>  #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
>  
> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from CPU  */
> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual address */
> +
>  /*
>   * This are the possible domain-types
>   *
> @@ -86,6 +89,8 @@ struct iommu_domain_geometry {
>  #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
>  				 __IOMMU_DOMAIN_DMA_API |	\
>  				 __IOMMU_DOMAIN_DMA_FQ)
> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |	\
> +				 __IOMMU_DOMAIN_HOST_VA)
>  
>  struct iommu_domain {
>  	unsigned type;
> @@ -254,6 +259,7 @@ struct iommu_ops {
>  	int (*def_domain_type)(struct device *dev);
>  
>  	const struct iommu_domain_ops *default_domain_ops;
> +	const struct iommu_domain_ops *sva_domain_ops;
>  	unsigned long pgsize_bitmap;
>  	struct module *owner;
>  };
> @@ -262,6 +268,8 @@ struct iommu_ops {
>   * struct iommu_domain_ops - domain specific operations
>   * @attach_dev: attach an iommu domain to a device
>   * @detach_dev: detach an iommu domain from a device
> + * @set_dev_pasid: set an iommu domain to a pasid of device
> + * @block_dev_pasid: block pasid of device from using iommu domain
>   * @map: map a physically contiguous memory region to an iommu domain
>   * @map_pages: map a physically contiguous set of pages of the same size to
>   *             an iommu domain.
> @@ -282,6 +290,10 @@ struct iommu_ops {
>  struct iommu_domain_ops {
>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>  	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
> +	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
> +			     ioasid_t pasid);
> +	void (*block_dev_pasid)(struct iommu_domain *domain, struct device *dev,
> +				ioasid_t pasid);
>  
>  	int (*map)(struct iommu_domain *domain, unsigned long iova,
>  		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> @@ -677,6 +689,10 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
>  void iommu_group_release_dma_owner(struct iommu_group *group);
>  bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>  
> +int iommu_set_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			   ioasid_t pasid);
> +void iommu_block_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			      ioasid_t pasid);
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> @@ -1050,6 +1066,17 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  {
>  	return false;
>  }
> +
> +static inline int iommu_set_device_pasid(struct iommu_domain *domain,
> +					 struct device *dev, ioasid_t pasid)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void iommu_block_device_pasid(struct iommu_domain *domain,
> +					    struct device *dev, ioasid_t pasid)
> +{
> +}
>  #endif /* CONFIG_IOMMU_API */
>  
>  /**
> @@ -1075,4 +1102,28 @@ void iommu_debugfs_setup(void);
>  static inline void iommu_debugfs_setup(void) {}
>  #endif
>  
> +#ifdef CONFIG_IOMMU_SVA
> +struct iommu_domain *
> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm);
> +void iommu_sva_free_domain(struct iommu_domain *domain);
> +int iommu_sva_set_domain(struct iommu_domain *domain, struct device *dev,
> +			 ioasid_t pasid);
> +#else /* CONFIG_IOMMU_SVA */
> +static inline struct iommu_domain *
> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static inline void iommu_sva_free_domain(struct iommu_domain *domain)
> +{
> +}
> +
> +static inline int iommu_sva_set_domain(struct iommu_domain *domain,
> +				       struct device *dev, ioasid_t pasid)
> +{
> +	return -EINVAL;
> +}
> +#endif /* CONFIG_IOMMU_SVA */
> +
>  #endif /* __LINUX_IOMMU_H */
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> index 8909ea1094e3..1be21e6b93ec 100644
> --- a/drivers/iommu/iommu-sva-lib.h
> +++ b/drivers/iommu/iommu-sva-lib.h
> @@ -7,6 +7,7 @@
>  
>  #include <linux/ioasid.h>
>  #include <linux/mm_types.h>
> +#include <linux/iommu.h>
>  
>  int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
>  struct mm_struct *iommu_sva_find(ioasid_t pasid);
> @@ -16,6 +17,20 @@ struct device;
>  struct iommu_fault;
>  struct iopf_queue;
>  
> +struct iommu_sva_domain {
> +	struct iommu_domain	domain;
> +	struct mm_struct	*mm;
> +};
> +
> +#define to_sva_domain(d) container_of_safe(d, struct iommu_sva_domain, domain)

Is there a reason to use the 'safe' version of container_of()?  Callers of
to_sva_domain() don't check the return value before dereferencing it so
they would break anyway if someone passes an error pointer as domain.  I
think it matters because there is no other user of container_of_safe() in
the kernel (the only user, lustre, went away in 2018) so someone will want
to remove it.

Apart from that

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> +
> +static inline struct mm_struct *domain_to_mm(struct iommu_domain *domain)
> +{
> +	struct iommu_sva_domain *sva_domain = to_sva_domain(domain);
> +
> +	return sva_domain->mm;
> +}
> +
>  #ifdef CONFIG_IOMMU_SVA
>  int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
>  
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 106506143896..210c376f6043 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -69,3 +69,51 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>  	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_find);
> +
> +/*
> + * IOMMU SVA driver-oriented interfaces
> + */
> +struct iommu_domain *
> +iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
> +{
> +	struct iommu_sva_domain *sva_domain;
> +	struct iommu_domain *domain;
> +
> +	if (!bus->iommu_ops || !bus->iommu_ops->sva_domain_ops)
> +		return ERR_PTR(-ENODEV);
> +
> +	sva_domain = kzalloc(sizeof(*sva_domain), GFP_KERNEL);
> +	if (!sva_domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mmgrab(mm);
> +	sva_domain->mm = mm;
> +
> +	domain = &sva_domain->domain;
> +	domain->type = IOMMU_DOMAIN_SVA;
> +	domain->ops = bus->iommu_ops->sva_domain_ops;
> +
> +	return domain;
> +}
> +
> +void iommu_sva_free_domain(struct iommu_domain *domain)
> +{
> +	struct iommu_sva_domain *sva_domain = to_sva_domain(domain);
> +
> +	mmdrop(sva_domain->mm);
> +	kfree(sva_domain);
> +}
> +
> +int iommu_sva_set_domain(struct iommu_domain *domain, struct device *dev,
> +			 ioasid_t pasid)
> +{
> +	struct bus_type *bus = dev->bus;
> +
> +	if (!bus || !bus->iommu_ops || !bus->iommu_ops->sva_domain_ops)
> +		return -ENODEV;
> +
> +	if (domain->ops != bus->iommu_ops->sva_domain_ops)
> +		return -EINVAL;
> +
> +	return iommu_set_device_pasid(domain, dev, pasid);
> +}
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 9955f58bd08c..789816e4b9d6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -38,6 +38,7 @@ struct iommu_group {
>  	struct kobject kobj;
>  	struct kobject *devices_kobj;
>  	struct list_head devices;
> +	struct xarray pasid_array;
>  	struct mutex mutex;
>  	void *iommu_data;
>  	void (*iommu_data_release)(void *iommu_data);
> @@ -640,6 +641,7 @@ struct iommu_group *iommu_group_alloc(void)
>  	mutex_init(&group->mutex);
>  	INIT_LIST_HEAD(&group->devices);
>  	INIT_LIST_HEAD(&group->entry);
> +	xa_init(&group->pasid_array);
>  
>  	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
>  	if (ret < 0) {
> @@ -3251,3 +3253,72 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  	return user;
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
> +
> +static bool device_group_immutable_singleton(struct device *dev)
> +{
> +	struct iommu_group *group = iommu_group_get(dev);
> +	int count;
> +
> +	if (!group)
> +		return false;
> +
> +	mutex_lock(&group->mutex);
> +	count = iommu_group_device_count(group);
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	if (count != 1)
> +		return false;
> +
> +	/*
> +	 * The PCI device could be considered to be fully isolated if all
> +	 * devices on the path from the device to the host-PCI bridge are
> +	 * protected from peer-to-peer DMA by ACS.
> +	 */
> +	if (dev_is_pci(dev))
> +		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
> +					    REQ_ACS_FLAGS);
> +
> +	return true;
> +}
> +
> +int iommu_set_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			   ioasid_t pasid)
> +{
> +	struct iommu_group *group;
> +	int ret = -EBUSY;
> +	void *curr;
> +
> +	if (!domain->ops->set_dev_pasid)
> +		return -EOPNOTSUPP;
> +
> +	if (!device_group_immutable_singleton(dev))
> +		return -EINVAL;
> +
> +	group = iommu_group_get(dev);
> +	mutex_lock(&group->mutex);
> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
> +	if (curr)
> +		goto out_unlock;
> +	ret = domain->ops->set_dev_pasid(domain, dev, pasid);
> +	if (ret)
> +		xa_erase(&group->pasid_array, pasid);
> +out_unlock:
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	return ret;
> +}
> +
> +void iommu_block_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			      ioasid_t pasid)
> +{
> +	struct iommu_group *group = iommu_group_get(dev);
> +
> +	mutex_lock(&group->mutex);
> +	domain->ops->block_dev_pasid(domain, dev, pasid);
> +	xa_erase(&group->pasid_array, pasid);
> +	mutex_unlock(&group->mutex);
> +
> +	iommu_group_put(group);
> +}
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
