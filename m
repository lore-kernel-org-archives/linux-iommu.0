Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F005C433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 13:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 434814018B;
	Wed,  9 Feb 2022 13:53:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EZ-p7_V6DxEQ; Wed,  9 Feb 2022 13:53:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C9A0401A2;
	Wed,  9 Feb 2022 13:53:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6CEFC001A;
	Wed,  9 Feb 2022 13:53:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD986C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC938401A2
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:53:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CrSrRsHJ14-a for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 13:53:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id D11784018B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:53:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 089BB1FB;
 Wed,  9 Feb 2022 05:53:00 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AE473F70D;
 Wed,  9 Feb 2022 05:52:56 -0800 (PST)
Message-ID: <290a89f0-8318-6130-468c-6412add62cfb@arm.com>
Date: Wed, 9 Feb 2022 13:52:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 08/10] iommu: Remove unused argument in
 is_attach_deferred
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Ben Skeggs <bskeggs@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-9-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220208012559.1121729-9-baolu.lu@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

On 2022-02-08 01:25, Lu Baolu wrote:
> The is_attach_deferred iommu_ops callback is a device op. The domain
> argument is unnecessary and never used. Remove it to make code clean.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   include/linux/iommu.h         |  2 +-
>   drivers/iommu/amd/amd_iommu.h |  3 +--
>   drivers/iommu/amd/iommu.c     |  3 +--
>   drivers/iommu/amd/iommu_v2.c  |  2 +-
>   drivers/iommu/intel/iommu.c   |  3 +--
>   drivers/iommu/iommu.c         | 15 ++++++---------
>   6 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index eb2684f95018..47ca7eca5d7b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -269,7 +269,7 @@ struct iommu_ops {
>   	void (*put_resv_regions)(struct device *dev, struct list_head *list);
>   
>   	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
> -	bool (*is_attach_deferred)(struct iommu_domain *domain, struct device *dev);
> +	bool (*is_attach_deferred)(struct device *dev);
>   
>   	/* Per device IOMMU features */
>   	bool (*dev_has_feat)(struct device *dev, enum iommu_dev_features f);
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 416815a525d6..3b2f06b7aca6 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -116,8 +116,7 @@ void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
>   
>   
>   extern bool translation_pre_enabled(struct amd_iommu *iommu);
> -extern bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
> -					 struct device *dev);
> +extern bool amd_iommu_is_attach_deferred(struct device *dev);
>   extern int __init add_special_device(u8 type, u8 id, u16 *devid,
>   				     bool cmd_line);
>   
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 461f1844ed1f..37f2fbb4b129 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2215,8 +2215,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>   	list_add_tail(&region->list, head);
>   }
>   
> -bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
> -				  struct device *dev)
> +bool amd_iommu_is_attach_deferred(struct device *dev)
>   {
>   	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>   
> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
> index 58da08cc3d01..7c94ec05d289 100644
> --- a/drivers/iommu/amd/iommu_v2.c
> +++ b/drivers/iommu/amd/iommu_v2.c
> @@ -537,7 +537,7 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
>   	ret = NOTIFY_DONE;
>   
>   	/* In kdump kernel pci dev is not initialized yet -> send INVALID */
> -	if (amd_iommu_is_attach_deferred(NULL, &pdev->dev)) {
> +	if (amd_iommu_is_attach_deferred(&pdev->dev)) {
>   		amd_iommu_complete_ppr(pdev, iommu_fault->pasid,
>   				       PPR_INVALID, tag);
>   		goto out;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 2b5f4e57a8bb..80f1294be634 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5052,8 +5052,7 @@ intel_iommu_dev_disable_feat(struct device *dev, enum iommu_dev_features feat)
>   	}
>   }
>   
> -static bool intel_iommu_is_attach_deferred(struct iommu_domain *domain,
> -					   struct device *dev)
> +static bool intel_iommu_is_attach_deferred(struct device *dev)
>   {
>   	return attach_deferred(dev);

Seems like there's no need to wrap this now?

Robin.

>   }
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de593a9cc09c..3dff30ddebdd 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -825,13 +825,12 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
>   	return ret;
>   }
>   
> -static bool iommu_is_attach_deferred(struct iommu_domain *domain,
> -				     struct device *dev)
> +static bool iommu_is_attach_deferred(struct device *dev)
>   {
>   	const struct iommu_ops *ops = dev_iommu_ops(dev);
>   
>   	if (ops->is_attach_deferred)
> -		return ops->is_attach_deferred(domain, dev);
> +		return ops->is_attach_deferred(dev);
>   
>   	return false;
>   }
> @@ -888,7 +887,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>   
>   	mutex_lock(&group->mutex);
>   	list_add_tail(&device->list, &group->devices);
> -	if (group->domain  && !iommu_is_attach_deferred(group->domain, dev))
> +	if (group->domain  && !iommu_is_attach_deferred(dev))
>   		ret = __iommu_attach_device(group->domain, dev);
>   	mutex_unlock(&group->mutex);
>   	if (ret)
> @@ -1743,7 +1742,7 @@ static int iommu_group_do_dma_attach(struct device *dev, void *data)
>   	struct iommu_domain *domain = data;
>   	int ret = 0;
>   
> -	if (!iommu_is_attach_deferred(domain, dev))
> +	if (!iommu_is_attach_deferred(dev))
>   		ret = __iommu_attach_device(domain, dev);
>   
>   	return ret;
> @@ -2018,9 +2017,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
>   
>   int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>   {
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> -	if (ops->is_attach_deferred && ops->is_attach_deferred(domain, dev))
> +	if (iommu_is_attach_deferred(dev))
>   		return __iommu_attach_device(domain, dev);
>   
>   	return 0;
> @@ -2029,7 +2026,7 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>   static void __iommu_detach_device(struct iommu_domain *domain,
>   				  struct device *dev)
>   {
> -	if (iommu_is_attach_deferred(domain, dev))
> +	if (iommu_is_attach_deferred(dev))
>   		return;
>   
>   	if (unlikely(domain->ops->detach_dev == NULL))
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
