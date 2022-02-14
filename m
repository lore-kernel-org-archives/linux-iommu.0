Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71189C4332F
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 12:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0807D82538;
	Mon, 14 Feb 2022 12:09:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VXtr7n3BmO4W; Mon, 14 Feb 2022 12:09:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D8C7482422;
	Mon, 14 Feb 2022 12:09:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0FCCC0011;
	Mon, 14 Feb 2022 12:09:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CA10C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:09:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 22E2882433
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:09:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LmyhMBgHAAe2 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 12:09:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 134C282422
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 12:09:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E8861396;
 Mon, 14 Feb 2022 04:09:46 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A6763F718;
 Mon, 14 Feb 2022 04:09:41 -0800 (PST)
Message-ID: <43f2fc07-19ea-53a4-af86-a9192a950c96@arm.com>
Date: Mon, 14 Feb 2022 12:09:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v1 1/8] iommu: Add iommu_group_replace_domain()
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
 <20220106022053.2406748-2-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220106022053.2406748-2-baolu.lu@linux.intel.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Stuart Yoder <stuyoder@gmail.com>,
 kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dmitry Osipenko <digetx@gmail.com>, Li Yang <leoyang.li@nxp.com>,
 Will Deacon <will@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 linux-kernel@vger.kernel.org
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

On 2022-01-06 02:20, Lu Baolu wrote:
> Expose an interface to replace the domain of an iommu group for frameworks
> like vfio which claims the ownership of the whole iommu group.

But if the underlying point is the new expectation that 
iommu_{attach,detach}_device() operate on the device's whole group where 
relevant, why should we invent some special mechanism for VFIO to be 
needlessly inconsistent?

I said before that it's trivial for VFIO to resolve a suitable device if 
it needs to; by now I've actually written the patch ;)

https://gitlab.arm.com/linux-arm/linux-rm/-/commit/9f37d8c17c9b606abc96e1f1001c0b97c8b93ed5

Robin.

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   include/linux/iommu.h | 10 ++++++++++
>   drivers/iommu/iommu.c | 37 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 408a6d2b3034..66ebce3d1e11 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -677,6 +677,9 @@ void iommu_device_unuse_dma_api(struct device *dev);
>   int iommu_group_set_dma_owner(struct iommu_group *group, void *owner);
>   void iommu_group_release_dma_owner(struct iommu_group *group);
>   bool iommu_group_dma_owner_claimed(struct iommu_group *group);
> +int iommu_group_replace_domain(struct iommu_group *group,
> +			       struct iommu_domain *old,
> +			       struct iommu_domain *new);
>   
>   #else /* CONFIG_IOMMU_API */
>   
> @@ -1090,6 +1093,13 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>   {
>   	return false;
>   }
> +
> +static inline int
> +iommu_group_replace_domain(struct iommu_group *group, struct iommu_domain *old,
> +			   struct iommu_domain *new)
> +{
> +	return -ENODEV;
> +}
>   #endif /* CONFIG_IOMMU_API */
>   
>   /**
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 72a95dea688e..ab8ab95969f5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3431,3 +3431,40 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>   	return user;
>   }
>   EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
> +
> +/**
> + * iommu_group_replace_domain() - Replace group's domain
> + * @group: The group.
> + * @old: The previous attached domain. NULL for none.
> + * @new: The new domain about to be attached.
> + *
> + * This is to support backward compatibility for vfio which manages the dma
> + * ownership in iommu_group level.
> + */
> +int iommu_group_replace_domain(struct iommu_group *group,
> +			       struct iommu_domain *old,
> +			       struct iommu_domain *new)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&group->mutex);
> +	if (!group->owner || group->domain != old) {
> +		ret = -EPERM;
> +		goto unlock_out;
> +	}
> +
> +	if (old)
> +		__iommu_detach_group(old, group);
> +
> +	if (new) {
> +		ret = __iommu_attach_group(new, group);
> +		if (ret && old)
> +			__iommu_attach_group(old, group);
> +	}
> +
> +unlock_out:
> +	mutex_unlock(&group->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_group_replace_domain);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
