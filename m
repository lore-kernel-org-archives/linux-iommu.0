Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA24C433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Dec 2021 16:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 011FD40342;
	Tue, 21 Dec 2021 16:51:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yBAL6dCzIECK; Tue, 21 Dec 2021 16:51:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 29043400C9;
	Tue, 21 Dec 2021 16:51:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED7C4C001E;
	Tue, 21 Dec 2021 16:51:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4DE1C0012
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 16:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B94EF60F33
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 16:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NtB3m1BIWOGR for <iommu@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 16:51:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADCA060F13
 for <iommu@lists.linux-foundation.org>; Tue, 21 Dec 2021 16:51:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3ABFED1;
 Tue, 21 Dec 2021 08:51:07 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 442DA3F718;
 Tue, 21 Dec 2021 08:51:01 -0800 (PST)
Message-ID: <dd797dcd-251a-1980-ca64-bb38e67a526f@arm.com>
Date: Tue, 21 Dec 2021 16:50:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 07/13] iommu: Add iommu_at[de]tach_device_shared() for
 multi-device groups
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
 <20211217063708.1740334-8-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211217063708.1740334-8-baolu.lu@linux.intel.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, kvm@vger.kernel.org,
 Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Diana Craciun <diana.craciun@oss.nxp.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Yang <leoyang.li@nxp.com>,
 Will Deacon <will@kernel.org>, Dmitry Osipenko <digetx@gmail.com>
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

On 2021-12-17 06:37, Lu Baolu wrote:
> The iommu_attach/detach_device() interfaces were exposed for the device
> drivers to attach/detach their own domains. The commit <426a273834eae>
> ("iommu: Limit iommu_attach/detach_device to device with their own group")
> restricted them to singleton groups to avoid different device in a group
> attaching different domain.
> 
> As we've introduced device DMA ownership into the iommu core. We can now
> introduce interfaces for muliple-device groups, and "all devices are in the
> same address space" is still guaranteed.
> 
> The iommu_attach/detach_device_shared() could be used when multiple drivers
> sharing the group claim the DMA_OWNER_PRIVATE_DOMAIN ownership. The first
> call of iommu_attach_device_shared() attaches the domain to the group.
> Other drivers could join it later. The domain will be detached from the
> group after all drivers unjoin it.

I don't see the point of this at all - if you really want to hide the 
concept of IOMMU groups away from drivers then just make 
iommu_{attach,detach}_device() do the right thing. At least the 
iommu_group_get_for_dev() plus iommu_{attach,detach}_group() API is 
clear - this proposal is the worst of both worlds, in that drivers still 
have to be just as aware of groups in order to know whether to call the 
_shared interface or not, except it's now entirely implicit and non-obvious.

Otherwise just add the housekeeping stuff to 
iommu_{attach,detach}_group() - there's no way we want *three* 
attach/detach interfaces all with different semantics.

It's worth taking a step back and realising that overall, this is really 
just a more generalised and finer-grained extension of what 426a273834ea 
already did for non-group-aware code, so it makes little sense *not* to 
integrate it into the existing interfaces.

Robin.

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>   include/linux/iommu.h | 13 +++++++
>   drivers/iommu/iommu.c | 79 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 92 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5ad4cf13370d..1bc03118dfb3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -703,6 +703,8 @@ int iommu_group_set_dma_owner(struct iommu_group *group, enum iommu_dma_owner ow
>   			      void *owner_cookie);
>   void iommu_group_release_dma_owner(struct iommu_group *group, enum iommu_dma_owner owner);
>   bool iommu_group_dma_owner_unclaimed(struct iommu_group *group);
> +int iommu_attach_device_shared(struct iommu_domain *domain, struct device *dev);
> +void iommu_detach_device_shared(struct iommu_domain *domain, struct device *dev);
>   
>   #else /* CONFIG_IOMMU_API */
>   
> @@ -743,11 +745,22 @@ static inline int iommu_attach_device(struct iommu_domain *domain,
>   	return -ENODEV;
>   }
>   
> +static inline int iommu_attach_device_shared(struct iommu_domain *domain,
> +					     struct device *dev)
> +{
> +	return -ENODEV;
> +}
> +
>   static inline void iommu_detach_device(struct iommu_domain *domain,
>   				       struct device *dev)
>   {
>   }
>   
> +static inline void iommu_detach_device_shared(struct iommu_domain *domain,
> +					      struct device *dev)
> +{
> +}
> +
>   static inline struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
>   {
>   	return NULL;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8bec71b1cc18..3ad66cb9bedc 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -50,6 +50,7 @@ struct iommu_group {
>   	struct list_head entry;
>   	enum iommu_dma_owner dma_owner;
>   	unsigned int owner_cnt;
> +	unsigned int attach_cnt;
>   	void *owner_cookie;
>   };
>   
> @@ -3512,3 +3513,81 @@ void iommu_device_release_dma_owner(struct device *dev, enum iommu_dma_owner own
>   	iommu_group_put(group);
>   }
>   EXPORT_SYMBOL_GPL(iommu_device_release_dma_owner);
> +
> +/**
> + * iommu_attach_device_shared() - Attach shared domain to a device
> + * @domain: The shared domain.
> + * @dev: The device.
> + *
> + * Similar to iommu_attach_device(), but allowed for shared-group devices
> + * and guarantees that all devices in an iommu group could only be attached
> + * by a same iommu domain. The caller should explicitly set the dma ownership
> + * of DMA_OWNER_PRIVATE_DOMAIN or DMA_OWNER_PRIVATE_DOMAIN_USER type before
> + * calling it and use the paired helper iommu_detach_device_shared() for
> + * cleanup.
> + */
> +int iommu_attach_device_shared(struct iommu_domain *domain, struct device *dev)
> +{
> +	struct iommu_group *group;
> +	int ret = 0;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return -ENODEV;
> +
> +	mutex_lock(&group->mutex);
> +	if (group->dma_owner != DMA_OWNER_PRIVATE_DOMAIN &&
> +	    group->dma_owner != DMA_OWNER_PRIVATE_DOMAIN_USER) {
> +		ret = -EPERM;
> +		goto unlock_out;
> +	}
> +
> +	if (group->attach_cnt) {
> +		if (group->domain != domain) {
> +			ret = -EBUSY;
> +			goto unlock_out;
> +		}
> +	} else {
> +		ret = __iommu_attach_group(domain, group);
> +		if (ret)
> +			goto unlock_out;
> +	}
> +
> +	group->attach_cnt++;
> +unlock_out:
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_attach_device_shared);
> +
> +/**
> + * iommu_detach_device_shared() - Detach a domain from device
> + * @domain: The domain.
> + * @dev: The device.
> + *
> + * The detach helper paired with iommu_attach_device_shared().
> + */
> +void iommu_detach_device_shared(struct iommu_domain *domain, struct device *dev)
> +{
> +	struct iommu_group *group;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return;
> +
> +	mutex_lock(&group->mutex);
> +	if (WARN_ON(!group->attach_cnt || group->domain != domain ||
> +		    (group->dma_owner != DMA_OWNER_PRIVATE_DOMAIN &&
> +		     group->dma_owner != DMA_OWNER_PRIVATE_DOMAIN_USER)))
> +		goto unlock_out;
> +
> +	if (--group->attach_cnt == 0)
> +		__iommu_detach_group(domain, group);
> +
> +unlock_out:
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +}
> +EXPORT_SYMBOL_GPL(iommu_detach_device_shared);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
