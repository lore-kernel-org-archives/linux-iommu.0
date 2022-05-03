Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA09C433EF
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 18:07:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8724481463;
	Tue,  3 May 2022 18:07:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id keolqDGK3p84; Tue,  3 May 2022 18:07:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9868A8143F;
	Tue,  3 May 2022 18:07:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A08BC0039;
	Tue,  3 May 2022 18:07:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDAE4C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3DA481444
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:07:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ccjyZ9__17-s for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 18:07:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2DEE98143F
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:07:55 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id i27so34948758ejd.9
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CAlYiIhh6pgNH2aA5Z1WYg+YY5VaTEuIKmdxG9INjP0=;
 b=Kh1WAjKn9+eoDulUuBkXOif8gJJyDVzvosxRo04NXHiWzAxo49XgCSb71PzbDS/+Jh
 gY//JhkQdnLdfiWgeNdqNuoCJ1p/SVZEsChjhDaT6jrzArLylfd/+nIiZBFzRAitVWvU
 EVh+YVCgJzObQhazQTV7X29ZQCAgZHg/fXcvggmB1KDYtT93t/YY0jWjKJcE/RBoeA+w
 Al4k1lkX3JbUU8dHDrtuHIr7drhMg0QxTd+gzfAadmNsMK9XlpgndsLZJtdJqCHQtIwS
 ozPBW+jKST3wAOfbWyvLxLh84Stnyn3WC5d5jmt26oyawsuvlNkRatwJZdVmQcDRe+L4
 153w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CAlYiIhh6pgNH2aA5Z1WYg+YY5VaTEuIKmdxG9INjP0=;
 b=1xJJ2MXWzGIRc44u9+J/mIfakrGRiLJEWKjTzfRJdZ6TQaioBeZrhh+y1VUUs9K+q1
 IZqngnOF938qDUW5NAYUYi3KoVXfoPgjs/5UtK/jAF8LiEAucuQPeB49IExdr/ZU8SpH
 ivrZjpvolkptAh0ouO7PulzbR6T8CMk5WjsfWRXiWZAcAtKbTiVV3Aa/loJwqlCO8yGA
 aM4tXSlzirEsjOvLdiOPMQzKxjUPzDpjLxd092yoUahcY3V1BYrc9J1vEstcoryYNzOc
 WIFiOrCCURNc7yqHCIsmaX2Y6CQ/yOFPf8dprYCe8F7QD/6LULcu+LQ/C0F/iJ0ZfSD2
 iUgA==
X-Gm-Message-State: AOAM533ky1YN2T88zLHYm1mHv00C3uVY7ZdvwHhPU+BPSPfYNRu9aMjs
 oo6mEo8uApLhAhY85qYLHDJkuQ==
X-Google-Smtp-Source: ABdhPJzhOeQPH/8j7gVM23B+jQ578rJRgDPkXcwX4cB7js1XoH0ZNbgdqXOgLT7NoLlHZxmSOokqZw==
X-Received: by 2002:a17:906:79c4:b0:6cf:5489:da57 with SMTP id
 m4-20020a17090679c400b006cf5489da57mr16263726ejo.48.1651601273400; 
 Tue, 03 May 2022 11:07:53 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 a1-20020aa7cf01000000b0042617ba6398sm7986163edy.34.2022.05.03.11.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 11:07:52 -0700 (PDT)
Date: Tue, 3 May 2022 19:07:27 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 03/12] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <YnFvX8IUwP2drNoj@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220502014842.991097-4-baolu.lu@linux.intel.com>
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

On Mon, May 02, 2022 at 09:48:33AM +0800, Lu Baolu wrote:
> Attaching an IOMMU domain to a PASID of a device is a generic operation
> for modern IOMMU drivers which support PASID-granular DMA address
> translation. Currently visible usage scenarios include (but not limited):
> 
>  - SVA (Shared Virtual Address)
>  - kernel DMA with PASID
>  - hardware-assist mediated device
> 
> This adds a pair of common domain ops for this purpose and adds helpers
> to attach/detach a domain to/from a {device, PASID}. Some buses, like
> PCI, route packets without considering the PASID value. Thus a DMA target
> address with PASID might be treated as P2P if the address falls into the
> MMIO BAR of other devices in the group. To make things simple, these
> interfaces only apply to devices belonging to the singleton groups, and
> the singleton is immutable in fabric i.e. not affected by hotplug.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

just a nit below

> ---
>  include/linux/iommu.h | 21 ++++++++++++
>  drivers/iommu/iommu.c | 76 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b8ffaf2cb1d0..ab36244d4e94 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -263,6 +263,8 @@ struct iommu_ops {
>   * struct iommu_domain_ops - domain specific operations
>   * @attach_dev: attach an iommu domain to a device
>   * @detach_dev: detach an iommu domain from a device
> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> + * @detach_dev_pasid: detach an iommu domain from a pasid of device
>   * @map: map a physically contiguous memory region to an iommu domain
>   * @map_pages: map a physically contiguous set of pages of the same size to
>   *             an iommu domain.
> @@ -283,6 +285,10 @@ struct iommu_ops {
>  struct iommu_domain_ops {
>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>  	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> +				struct device *dev, ioasid_t pasid);
> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> +				 struct device *dev, ioasid_t pasid);
>  
>  	int (*map)(struct iommu_domain *domain, unsigned long iova,
>  		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> @@ -678,6 +684,10 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
>  void iommu_group_release_dma_owner(struct iommu_group *group);
>  bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>  
> +int iommu_attach_device_pasid(struct iommu_domain *domain,
> +			      struct device *dev, ioasid_t pasid);
> +void iommu_detach_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid);
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> @@ -1051,6 +1061,17 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  {
>  	return false;
>  }
> +
> +static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
> +					    struct device *dev, ioasid_t pasid)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
> +					     struct device *dev, ioasid_t pasid)
> +{
> +}
>  #endif /* CONFIG_IOMMU_API */
>  
>  /**
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 29906bc16371..89c9d19ddb28 100644
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
> @@ -630,6 +631,7 @@ struct iommu_group *iommu_group_alloc(void)
>  	mutex_init(&group->mutex);
>  	INIT_LIST_HEAD(&group->devices);
>  	INIT_LIST_HEAD(&group->entry);
> +	xa_init(&group->pasid_array);
>  
>  	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
>  	if (ret < 0) {
> @@ -3190,3 +3192,77 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>  	return user;
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
> +
> +/*
> + * Use standard PCI bus topology and isolation features to check immutable
> + * singleton. Otherwise, assume the bus is static and then singleton can
> + * know from the device count in the group.
> + */

The comment doesn't really add anything that can't be directly understood
from the code.

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
> +int iommu_attach_device_pasid(struct iommu_domain *domain,
> +			      struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_group *group;
> +	int ret = -EINVAL;
> +	void *curr;
> +
> +	if (!domain->ops->attach_dev_pasid)
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
> +	ret = domain->ops->attach_dev_pasid(domain, dev, pasid);
> +	if (ret)
> +		xa_erase(&group->pasid_array, pasid);
> +out_unlock:
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	return ret;
> +}
> +
> +void iommu_detach_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_group *group = iommu_group_get(dev);
> +
> +	mutex_lock(&group->mutex);
> +	domain->ops->detach_dev_pasid(domain, dev, pasid);
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
