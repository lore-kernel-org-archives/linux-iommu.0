Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47FDC433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 00:20:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30B7960FB2;
	Tue, 25 Jan 2022 00:20:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S3sGGqN29ZJD; Tue, 25 Jan 2022 00:20:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BB95A607EC;
	Tue, 25 Jan 2022 00:20:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C47EC0039;
	Tue, 25 Jan 2022 00:20:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71E57C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 00:20:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4CAF184C55
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 00:20:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id El7TrVKYlSNg for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 00:20:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id F31C284B71
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 00:20:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BB891FB;
 Mon, 24 Jan 2022 16:20:33 -0800 (PST)
Received: from [10.57.68.26] (unknown [10.57.68.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E31B3F793;
 Mon, 24 Jan 2022 16:20:30 -0800 (PST)
Message-ID: <363b8f7d-5459-0d19-c1ac-a2c6bce9d26f@arm.com>
Date: Tue, 25 Jan 2022 00:20:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Ben Skeggs <bskeggs@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220124071103.2097118-7-baolu.lu@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>,
 Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>
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

On 2022-01-24 07:11, Lu Baolu wrote:
> The common iommu_ops is hooked to both device and domain. When a helper
> has both device and domain pointer, the way to get the iommu_ops looks
> messy in iommu core. This sorts out the way to get iommu_ops. The device
> related helpers go through device pointer, while the domain related ones
> go through domain pointer.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   include/linux/iommu.h |  8 ++++++++
>   drivers/iommu/iommu.c | 25 ++++++++++++++-----------
>   2 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index aa5486243892..111b3e9c79bb 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -385,6 +385,14 @@ static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
>   	};
>   }
>   
> +static inline const struct iommu_ops *dev_iommu_ops_get(struct device *dev)
> +{
> +	if (dev && dev->iommu && dev->iommu->iommu_dev)
> +		return dev->iommu->iommu_dev->ops;
> +
> +	return NULL;

This probably warrants at least a WARN, but it's arguable to just assume 
that valid ops must be installed if iommu_probe_device() has succeeded. 
The device ops are essentially for internal use within the IOMMU 
subsystem itself, so we should be able to trust ourselves not to misuse 
the helper.

> +}
> +
>   #define IOMMU_BUS_NOTIFY_PRIORITY		0
>   #define IOMMU_GROUP_NOTIFY_ADD_DEVICE		1 /* Device added */
>   #define IOMMU_GROUP_NOTIFY_DEL_DEVICE		2 /* Pre Device removed */
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 5230c6d90ece..6631e2ea44df 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -764,6 +764,7 @@ EXPORT_SYMBOL_GPL(iommu_group_set_name);
>   static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   					       struct device *dev)
>   {
> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>   	struct iommu_domain *domain = group->default_domain;
>   	struct iommu_resv_region *entry;
>   	struct list_head mappings;
> @@ -785,8 +786,8 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   		dma_addr_t start, end, addr;
>   		size_t map_size = 0;
>   
> -		if (domain->ops->apply_resv_region)
> -			domain->ops->apply_resv_region(dev, domain, entry);
> +		if (ops->apply_resv_region)
> +			ops->apply_resv_region(dev, domain, entry);

Strictly I think this was a domain op, as it was about reserving the 
IOVA range in the given DMA domain. Also taking the domain as an 
argument is a bit of a giveaway. However it's now just dead code either 
way since there are no remaining implementations, and no reason for any 
new ones.

>   
>   		start = ALIGN(entry->start, pg_size);
>   		end   = ALIGN(entry->start + entry->length, pg_size);
> @@ -831,8 +832,10 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   static bool iommu_is_attach_deferred(struct iommu_domain *domain,
>   				     struct device *dev)
>   {
> -	if (domain->ops->is_attach_deferred)
> -		return domain->ops->is_attach_deferred(domain, dev);
> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
> +
> +	if (ops->is_attach_deferred)
> +		return ops->is_attach_deferred(domain, dev);

Similarly if this takes a domain as its first argument then it's de 
facto a domain method. However, I'd concur that logically it *is* a 
device op, so let's drop that (unused) domain argument if we're cleaning up.

Maybe there's even an argument for factoring this out to a standard flag 
in dev_iommu rather than an op at all?

The others covered here look OK - we can blame PCI for page response 
being weirdly device-centric - however could we also convert all the 
feasible instances of dev->bus->iommu_ops to dev_iommu_ops() as well? 
(Subtly implying that I'm also not a fan of having "_get" in the name 
for a non-refcounted lookup...) Obviously iommu_probe_device() and 
iommmu_domain_alloc() still need bus ops at this point, but I'm working 
on that... :)

Thanks,
Robin.

>   	return false;
>   }
> @@ -1251,10 +1254,10 @@ int iommu_page_response(struct device *dev,
>   	struct iommu_fault_event *evt;
>   	struct iommu_fault_page_request *prm;
>   	struct dev_iommu *param = dev->iommu;
> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>   	bool has_pasid = msg->flags & IOMMU_PAGE_RESP_PASID_VALID;
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>   
> -	if (!domain || !domain->ops->page_response)
> +	if (!ops || !ops->page_response)
>   		return -ENODEV;
>   
>   	if (!param || !param->fault_param)
> @@ -1295,7 +1298,7 @@ int iommu_page_response(struct device *dev,
>   			msg->pasid = 0;
>   		}
>   
> -		ret = domain->ops->page_response(dev, evt, msg);
> +		ret = ops->page_response(dev, evt, msg);
>   		list_del(&evt->list);
>   		kfree(evt);
>   		break;
> @@ -1758,10 +1761,10 @@ static int __iommu_group_dma_attach(struct iommu_group *group)
>   
>   static int iommu_group_do_probe_finalize(struct device *dev, void *data)
>   {
> -	struct iommu_domain *domain = data;
> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>   
> -	if (domain->ops->probe_finalize)
> -		domain->ops->probe_finalize(dev);
> +	if (ops->probe_finalize)
> +		ops->probe_finalize(dev);
>   
>   	return 0;
>   }
> @@ -2020,7 +2023,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
>   
>   int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>   {
> -	const struct iommu_ops *ops = domain->ops;
> +	const struct iommu_ops *ops = dev_iommu_ops_get(dev);
>   
>   	if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
>   		return __iommu_attach_device(domain, dev);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
