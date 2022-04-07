Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBE9C433F5
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 10:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7CBBD400CC;
	Thu,  7 Apr 2022 10:18:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xlCQwQsCMMkx; Thu,  7 Apr 2022 10:18:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3655B40124;
	Thu,  7 Apr 2022 10:18:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09FA6C001D;
	Thu,  7 Apr 2022 10:18:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E270C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 10:18:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA76560E2B
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 10:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IF8FdDgT0g3G for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 10:18:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id D66FD60D5C
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 10:18:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1C1023A;
 Thu,  7 Apr 2022 03:18:28 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A21383F5A1;
 Thu,  7 Apr 2022 03:18:27 -0700 (PDT)
Message-ID: <53c7ef1d-1835-2994-c2d2-6382f53599fa@arm.com>
Date: Thu, 7 Apr 2022 11:18:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] iommu: remove the put_resv_regions method
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
 Sven Peter <sven@svenpeter.dev>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Yong Wu <yong.wu@mediatek.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org
References: <20220407062608.711392-1-hch@lst.de>
 <20220407062608.711392-4-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220407062608.711392-4-hch@lst.de>
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

On 2022-04-07 07:26, Christoph Hellwig wrote:
> All drivers that implement get_resv_regions just use
> generic_put_resv_regions to implement the put side.  Remove the
> indirections and document the allocations constraints.

Unfortunately we need to keep this one for now, as the belated IORT RMR 
support will finally be the first real user[1][2].

Robin.

[1] 
https://lore.kernel.org/linux-iommu/20220404124209.1086-6-shameerali.kolothum.thodi@huawei.com/
[2] 
https://lore.kernel.org/linux-iommu/20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com/

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/amd/iommu.c                   |  1 -
>   drivers/iommu/apple-dart.c                  |  1 -
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  1 -
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       |  1 -
>   drivers/iommu/intel/iommu.c                 |  1 -
>   drivers/iommu/iommu.c                       | 20 +-------------------
>   drivers/iommu/mtk_iommu.c                   |  1 -
>   drivers/iommu/virtio-iommu.c                |  5 ++---
>   include/linux/iommu.h                       |  4 ----
>   9 files changed, 3 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a1ada7bff44e61..7011b46022dcbb 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2279,7 +2279,6 @@ const struct iommu_ops amd_iommu_ops = {
>   	.probe_finalize = amd_iommu_probe_finalize,
>   	.device_group = amd_iommu_device_group,
>   	.get_resv_regions = amd_iommu_get_resv_regions,
> -	.put_resv_regions = generic_iommu_put_resv_regions,
>   	.is_attach_deferred = amd_iommu_is_attach_deferred,
>   	.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
>   	.def_domain_type = amd_iommu_def_domain_type,
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index decafb07ad0831..a45ad9ade0dba6 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -771,7 +771,6 @@ static const struct iommu_ops apple_dart_iommu_ops = {
>   	.of_xlate = apple_dart_of_xlate,
>   	.def_domain_type = apple_dart_def_domain_type,
>   	.get_resv_regions = apple_dart_get_resv_regions,
> -	.put_resv_regions = generic_iommu_put_resv_regions,
>   	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>   		.attach_dev	= apple_dart_attach_dev,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 36461fb46d436c..1ea184bbf750a6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2847,7 +2847,6 @@ static struct iommu_ops arm_smmu_ops = {
>   	.device_group		= arm_smmu_device_group,
>   	.of_xlate		= arm_smmu_of_xlate,
>   	.get_resv_regions	= arm_smmu_get_resv_regions,
> -	.put_resv_regions	= generic_iommu_put_resv_regions,
>   	.dev_enable_feat	= arm_smmu_dev_enable_feature,
>   	.dev_disable_feat	= arm_smmu_dev_disable_feature,
>   	.sva_bind		= arm_smmu_sva_bind,
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 568cce590ccc13..41da1275689ebd 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1589,7 +1589,6 @@ static struct iommu_ops arm_smmu_ops = {
>   	.device_group		= arm_smmu_device_group,
>   	.of_xlate		= arm_smmu_of_xlate,
>   	.get_resv_regions	= arm_smmu_get_resv_regions,
> -	.put_resv_regions	= generic_iommu_put_resv_regions,
>   	.def_domain_type	= arm_smmu_def_domain_type,
>   	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>   	.owner			= THIS_MODULE,
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index df5c62ecf942b8..cafe50cb484cd5 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4875,7 +4875,6 @@ const struct iommu_ops intel_iommu_ops = {
>   	.probe_finalize		= intel_iommu_probe_finalize,
>   	.release_device		= intel_iommu_release_device,
>   	.get_resv_regions	= intel_iommu_get_resv_regions,
> -	.put_resv_regions	= generic_iommu_put_resv_regions,
>   	.device_group		= intel_iommu_device_group,
>   	.dev_enable_feat	= intel_iommu_dev_enable_feat,
>   	.dev_disable_feat	= intel_iommu_dev_disable_feat,
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 6ce73f35c43aac..2e1f7d1cf74793 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2584,31 +2584,13 @@ void iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   }
>   
>   void iommu_put_resv_regions(struct device *dev, struct list_head *list)
> -{
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> -	if (ops->put_resv_regions)
> -		ops->put_resv_regions(dev, list);
> -}
> -
> -/**
> - * generic_iommu_put_resv_regions - Reserved region driver helper
> - * @dev: device for which to free reserved regions
> - * @list: reserved region list for device
> - *
> - * IOMMU drivers can use this to implement their .put_resv_regions() callback
> - * for simple reservations. Memory allocated for each reserved region will be
> - * freed. If an IOMMU driver allocates additional resources per region, it is
> - * going to have to implement a custom callback.
> - */
> -void generic_iommu_put_resv_regions(struct device *dev, struct list_head *list)
>   {
>   	struct iommu_resv_region *entry, *next;
>   
>   	list_for_each_entry_safe(entry, next, list, list)
>   		kfree(entry);
>   }
> -EXPORT_SYMBOL(generic_iommu_put_resv_regions);
> +EXPORT_SYMBOL(iommu_put_resv_regions);
>   
>   struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
>   						  size_t length, int prot,
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6fd75a60abd678..d970fd301e8f31 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -688,7 +688,6 @@ static const struct iommu_ops mtk_iommu_ops = {
>   	.device_group	= mtk_iommu_device_group,
>   	.of_xlate	= mtk_iommu_of_xlate,
>   	.get_resv_regions = mtk_iommu_get_resv_regions,
> -	.put_resv_regions = generic_iommu_put_resv_regions,
>   	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
>   	.owner		= THIS_MODULE,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 25be4b822aa07f..36385b3deb8981 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -964,7 +964,7 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
>   	return &viommu->iommu;
>   
>   err_free_dev:
> -	generic_iommu_put_resv_regions(dev, &vdev->resv_regions);
> +	iommu_put_resv_regions(dev, &vdev->resv_regions);
>   	kfree(vdev);
>   
>   	return ERR_PTR(ret);
> @@ -989,7 +989,7 @@ static void viommu_release_device(struct device *dev)
>   
>   	vdev = dev_iommu_priv_get(dev);
>   
> -	generic_iommu_put_resv_regions(dev, &vdev->resv_regions);
> +	iommu_put_resv_regions(dev, &vdev->resv_regions);
>   	kfree(vdev);
>   }
>   
> @@ -1013,7 +1013,6 @@ static struct iommu_ops viommu_ops = {
>   	.release_device		= viommu_release_device,
>   	.device_group		= viommu_device_group,
>   	.get_resv_regions	= viommu_get_resv_regions,
> -	.put_resv_regions	= generic_iommu_put_resv_regions,
>   	.of_xlate		= viommu_of_xlate,
>   	.owner			= THIS_MODULE,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a2d3562a501d3e..fed4c09e8e7cfe 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -198,7 +198,6 @@ struct iommu_iotlb_gather {
>    *                  group and attached to the groups domain
>    * @device_group: find iommu group for a particular device
>    * @get_resv_regions: Request list of reserved regions for a device
> - * @put_resv_regions: Free list of reserved regions for a device
>    * @of_xlate: add OF master IDs to iommu grouping
>    * @is_attach_deferred: Check if domain attach should be deferred from iommu
>    *                      driver init to device driver init (default no)
> @@ -229,7 +228,6 @@ struct iommu_ops {
>   
>   	/* Request/Free a list of reserved regions for a device */
>   	void (*get_resv_regions)(struct device *dev, struct list_head *list);
> -	void (*put_resv_regions)(struct device *dev, struct list_head *list);
>   
>   	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
>   	bool (*is_attach_deferred)(struct device *dev);
> @@ -445,8 +443,6 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
>   
>   extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
>   extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
> -extern void generic_iommu_put_resv_regions(struct device *dev,
> -					   struct list_head *list);
>   extern void iommu_set_default_passthrough(bool cmd_line);
>   extern void iommu_set_default_translated(bool cmd_line);
>   extern bool iommu_default_passthrough(void);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
