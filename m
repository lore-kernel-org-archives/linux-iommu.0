Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D9CC433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 19:13:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE33B6128D;
	Tue, 22 Mar 2022 19:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sEKs4z9h7dfm; Tue, 22 Mar 2022 19:13:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B2BB260AEC;
	Tue, 22 Mar 2022 19:13:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8885BC0012;
	Tue, 22 Mar 2022 19:13:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5A9CC000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 19:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0AF960DCB
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 19:13:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5bhAmdz_VuJQ for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 19:13:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id DCCD960AEC
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 19:13:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2582A152B;
 Tue, 22 Mar 2022 12:13:05 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A77613F66F;
 Tue, 22 Mar 2022 12:13:02 -0700 (PDT)
Message-ID: <485b20e0-595c-bc8c-8fbe-119f19e1a8e0@arm.com>
Date: Tue, 22 Mar 2022 19:12:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 10/11] iommu/arm-smmu-v3: Reserve any RMR regions
 associated with a dev
Content-Language: en-GB
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-11-shameerali.kolothum.thodi@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220221154344.2126-11-shameerali.kolothum.thodi@huawei.com>
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
 will@kernel.org, wanghuiqiang@huawei.com
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

On 2022-02-21 15:43, Shameer Kolothum wrote:
> Get ACPI IORT RMR regions associated with a dev reserved
> so that there is a unity mapping for them in SMMU.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index dee3197474b7..ef2972483fd7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2759,6 +2759,7 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>   {
>   	struct iommu_resv_region *region;
>   	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   
>   	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
>   					 prot, IOMMU_RESV_SW_MSI);
> @@ -2768,6 +2769,16 @@ static void arm_smmu_get_resv_regions(struct device *dev,
>   	list_add_tail(&region->list, head);
>   
>   	iommu_dma_get_resv_regions(dev, head);
> +	iommu_dma_get_rmrs(fwspec->iommu_fwnode, dev, head);
> +}
> +
> +static void arm_smmu_put_resv_regions(struct device *dev,
> +				      struct list_head *head)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	iommu_dma_put_rmrs(fwspec->iommu_fwnode, head);
> +	generic_iommu_put_resv_regions(dev, head);
>   }

Tying in with my comment on patch #5, this should be a common 
iommu_dma_put_resv_regions() helper.

Thanks,
Robin.

>   static bool arm_smmu_dev_has_feature(struct device *dev,
> @@ -2865,7 +2876,7 @@ static struct iommu_ops arm_smmu_ops = {
>   	.enable_nesting		= arm_smmu_enable_nesting,
>   	.of_xlate		= arm_smmu_of_xlate,
>   	.get_resv_regions	= arm_smmu_get_resv_regions,
> -	.put_resv_regions	= generic_iommu_put_resv_regions,
> +	.put_resv_regions	= arm_smmu_put_resv_regions,
>   	.dev_has_feat		= arm_smmu_dev_has_feature,
>   	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
>   	.dev_enable_feat	= arm_smmu_dev_enable_feature,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
