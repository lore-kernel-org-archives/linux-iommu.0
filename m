Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCD2C43217
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 14:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F12114014D;
	Mon,  6 Dec 2021 14:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mr3nOlpREHWA; Mon,  6 Dec 2021 14:43:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 787104017D;
	Mon,  6 Dec 2021 14:43:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DC72C001E;
	Mon,  6 Dec 2021 14:43:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41CCFC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2282340184
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:43:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id stIt5vRVJvDP for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 14:43:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6EFBC4017D
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=H8O7gae/7jKTz6Pv+1iSjZYd7Qd7DnxmUXyM+8U+dIM=; b=UNJCb1d7mOdEesOfDstSorj96+
 eBSt8144FW19qOfV0eRnw6x25GJKhEy01pd3mRMnPOhRVvVgyLk+mqGG6ZgiO1Qb7I0XWTQ9I1sns
 wodeLbuHIIUokLEV3L35RPmoDIbi6IOWhYHsHWM9ONtBS7hBE7Z8Cx3xKEeKjRzoIEgXtt5/YBAEE
 8tAHZ4ckORHs4DGF5sYlT/lg2Xkx7R2WodloBj/P8xJn+uapjI2gvS/oGONMDXP07XwTLllhDq2jY
 xtLatAIcqi3JSEstEBoABHkDO5WwKzLoFtsTXHMtxnpmQEEPQIC7gLG/UCjE85+uCvjbc0t3uTutg
 q8XggXog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1muFCZ-004GDJ-Ri; Mon, 06 Dec 2021 14:42:47 +0000
Date: Mon, 6 Dec 2021 06:42:47 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 01/18] iommu: Add device dma ownership set/release
 interfaces
Message-ID: <Ya4hZ2F7MYusgmSB@infradead.org>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211206015903.88687-2-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Dec 06, 2021 at 09:58:46AM +0800, Lu Baolu wrote:
> >From the perspective of who is initiating the device to do DMA, device
> DMA could be divided into the following types:
> 
>         DMA_OWNER_DMA_API: Device DMAs are initiated by a kernel driver
> 			through the kernel DMA API.
>         DMA_OWNER_PRIVATE_DOMAIN: Device DMAs are initiated by a kernel
> 			driver with its own PRIVATE domain.
> 	DMA_OWNER_PRIVATE_DOMAIN_USER: Device DMAs are initiated by
> 			userspace.
> 
> Different DMA ownerships are exclusive for all devices in the same iommu
> group as an iommu group is the smallest granularity of device isolation
> and protection that the IOMMU subsystem can guarantee. This extends the
> iommu core to enforce this exclusion.
> 
> Basically two new interfaces are provided:
> 
>         int iommu_device_set_dma_owner(struct device *dev,
>                 enum iommu_dma_owner type, void *owner_cookie);
>         void iommu_device_release_dma_owner(struct device *dev,
>                 enum iommu_dma_owner type);
> 
> Although above interfaces are per-device, DMA owner is tracked per group
> under the hood. An iommu group cannot have different dma ownership set
> at the same time. Violation of this assumption fails
> iommu_device_set_dma_owner().
> 
> Kernel driver which does DMA have DMA_OWNER_DMA_API automatically set/
> released in the driver binding/unbinding process (see next patch).
> 
> Kernel driver which doesn't do DMA could avoid setting the owner type.
> Device bound to such driver is considered same as a driver-less device
> which is compatible to all owner types.
> 
> Userspace driver framework (e.g. vfio) should set
> DMA_OWNER_PRIVATE_DOMAIN_USER for a device before the userspace is allowed
> to access it, plus a owner cookie pointer to mark the user identity so a
> single group cannot be operated by multiple users simultaneously. Vice
> versa, the owner type should be released after the user access permission
> is withdrawn.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h | 36 +++++++++++++++++
>  drivers/iommu/iommu.c | 93 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 129 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index d2f3435e7d17..24676b498f38 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -162,6 +162,23 @@ enum iommu_dev_features {
>  	IOMMU_DEV_FEAT_IOPF,
>  };
>  
> +/**
> + * enum iommu_dma_owner - IOMMU DMA ownership
> + * @DMA_OWNER_NONE: No DMA ownership.
> + * @DMA_OWNER_DMA_API: Device DMAs are initiated by a kernel driver through
> + *			the kernel DMA API.
> + * @DMA_OWNER_PRIVATE_DOMAIN: Device DMAs are initiated by a kernel driver
> + *			which provides an UNMANAGED domain.
> + * @DMA_OWNER_PRIVATE_DOMAIN_USER: Device DMAs are initiated by userspace,
> + *			kernel ensures that DMAs never go to kernel memory.
> + */
> +enum iommu_dma_owner {
> +	DMA_OWNER_NONE,
> +	DMA_OWNER_DMA_API,
> +	DMA_OWNER_PRIVATE_DOMAIN,
> +	DMA_OWNER_PRIVATE_DOMAIN_USER,
> +};
> +
>  #define IOMMU_PASID_INVALID	(-1U)
>  
>  #ifdef CONFIG_IOMMU_API
> @@ -681,6 +698,10 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>  void iommu_sva_unbind_device(struct iommu_sva *handle);
>  u32 iommu_sva_get_pasid(struct iommu_sva *handle);
>  
> +int iommu_device_set_dma_owner(struct device *dev, enum iommu_dma_owner owner,
> +			       void *owner_cookie);
> +void iommu_device_release_dma_owner(struct device *dev, enum iommu_dma_owner owner);
> +
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> @@ -1081,6 +1102,21 @@ static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
>  {
>  	return NULL;
>  }
> +
> +static inline int iommu_device_set_dma_owner(struct device *dev,
> +					     enum iommu_dma_owner owner,
> +					     void *owner_cookie)
> +{
> +	if (owner != DMA_OWNER_DMA_API)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static inline void iommu_device_release_dma_owner(struct device *dev,
> +						  enum iommu_dma_owner owner)
> +{
> +}
>  #endif /* CONFIG_IOMMU_API */
>  
>  /**
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8b86406b7162..1de520a07518 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -48,6 +48,9 @@ struct iommu_group {
>  	struct iommu_domain *default_domain;
>  	struct iommu_domain *domain;
>  	struct list_head entry;
> +	enum iommu_dma_owner dma_owner;
> +	refcount_t owner_cnt;

owner_cnt is only manipulated under group->mutex, not need for a
refcount_t here, a plain unsigned int while do it and will also
simplify a fair bit of code as it avoid the need for atomic add/sub
and test operations.

> +static int __iommu_group_set_dma_owner(struct iommu_group *group,
> +				       enum iommu_dma_owner owner,
> +				       void *owner_cookie)
> +{

As pointed out last time, please move the group->mutex locking into
this helper, which makes it identical to the later added public
function.

> +static void __iommu_group_release_dma_owner(struct iommu_group *group,
> +					    enum iommu_dma_owner owner)
> +{

Same here.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
