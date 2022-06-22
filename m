Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E068CC43334
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 01:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D53C8464B;
	Wed, 22 Jun 2022 01:33:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D53C8464B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a0Hqp/rk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gCUtKJP_s-40; Wed, 22 Jun 2022 01:33:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2997584647;
	Wed, 22 Jun 2022 01:33:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2997584647
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E65FEC0039;
	Wed, 22 Jun 2022 01:33:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08E2FC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 01:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D80EF8464A
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 01:33:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D80EF8464A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5DD5VHSzc-mz for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 01:33:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E622484647
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E622484647
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 01:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655861621; x=1687397621;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=pJdqvRBiCPlK7UZbaNKlDRpZsDkk8unk6mQOBeFOpcY=;
 b=a0Hqp/rkqcKsiCJky+apcVHp1qRUA4MKpDIuwf2YiymDioNN2YH1uWdw
 JSSzI+EDyhyUE7/UXQT6tYKEaPzbznriortKMLSDlipAS7TVBb6t/1eOv
 V1SjJ1vK80VkLynarRmh0K+iz/Zpd0YcpBYIZhVFPG4+waFeEu2Yd4Daa
 F9Vjk6EgMQ1Z+VuPl1dEzd3h4mU4S/Kt5WR7p66GccIBD83IgPSFJan3t
 bmUNvJPOgQZFxXsjHFV1mY5qMzT4X7bzjh2CHD/EdHlCjV0+8AWsJiKsX
 bQ4nT0HUiiZWNIJFdMQ86nVETCwA5JfIh0Vzthp03ftO56o4mKNp6UyjG g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260714369"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="260714369"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 18:33:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; d="scan'208";a="833848950"
Received: from xzhan99-mobl1.ccr.corp.intel.com (HELO [10.249.172.26])
 ([10.249.172.26])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2022 18:33:38 -0700
Message-ID: <3f8d1656-dea5-6525-07f9-6dfe5f2aaf23@linux.intel.com>
Date: Wed, 22 Jun 2022 09:33:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] iommu: Make .release_device optional
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1655822151.git.robin.murphy@arm.com>
 <bda9d3eb4527eac8f6544a15067e2529cca54a2e.1655822151.git.robin.murphy@arm.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <bda9d3eb4527eac8f6544a15067e2529cca54a2e.1655822151.git.robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

On 2022/6/21 23:14, Robin Murphy wrote:
> Many drivers do nothing meaningful for .release_device, and it's neatly
> abstracted to just two callsites in the core code, so let's make it
> optional to implement.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/fsl_pamu_domain.c | 5 -----
>   drivers/iommu/iommu.c           | 6 ++++--
>   drivers/iommu/msm_iommu.c       | 5 -----
>   drivers/iommu/sun50i-iommu.c    | 3 ---
>   drivers/iommu/tegra-gart.c      | 5 -----
>   drivers/iommu/tegra-smmu.c      | 3 ---
>   6 files changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index 94b4589dc67c..011f9ab7f743 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -447,15 +447,10 @@ static struct iommu_device *fsl_pamu_probe_device(struct device *dev)
>   	return &pamu_iommu;
>   }
>   
> -static void fsl_pamu_release_device(struct device *dev)
> -{
> -}
> -
>   static const struct iommu_ops fsl_pamu_ops = {
>   	.capable	= fsl_pamu_capable,
>   	.domain_alloc	= fsl_pamu_domain_alloc,
>   	.probe_device	= fsl_pamu_probe_device,
> -	.release_device	= fsl_pamu_release_device,
>   	.device_group   = fsl_pamu_device_group,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>   		.attach_dev	= fsl_pamu_attach_device,
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 06d6989f07f6..8b4fc7e62b99 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -259,7 +259,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   	return 0;
>   
>   out_release:
> -	ops->release_device(dev);
> +	if (ops->release_device)
> +		ops->release_device(dev);
>   
>   out_module_put:
>   	module_put(ops->owner);
> @@ -337,7 +338,8 @@ void iommu_release_device(struct device *dev)
>   	iommu_device_unlink(dev->iommu->iommu_dev, dev);
>   
>   	ops = dev_iommu_ops(dev);
> -	ops->release_device(dev);
> +	if (ops->release_device)
> +		ops->release_device(dev);
>   
>   	iommu_group_remove_device(dev);
>   	module_put(ops->owner);
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index f09aedfdd462..428919a474c1 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -394,10 +394,6 @@ static struct iommu_device *msm_iommu_probe_device(struct device *dev)
>   	return &iommu->iommu;
>   }
>   
> -static void msm_iommu_release_device(struct device *dev)
> -{
> -}
> -
>   static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   {
>   	int ret = 0;
> @@ -677,7 +673,6 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
>   static struct iommu_ops msm_iommu_ops = {
>   	.domain_alloc = msm_iommu_domain_alloc,
>   	.probe_device = msm_iommu_probe_device,
> -	.release_device = msm_iommu_release_device,
>   	.device_group = generic_device_group,
>   	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
>   	.of_xlate = qcom_iommu_of_xlate,
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index c54ab477b8fd..a84c63518773 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -738,8 +738,6 @@ static struct iommu_device *sun50i_iommu_probe_device(struct device *dev)
>   	return &iommu->iommu;
>   }
>   
> -static void sun50i_iommu_release_device(struct device *dev) {}
> -
>   static struct iommu_group *sun50i_iommu_device_group(struct device *dev)
>   {
>   	struct sun50i_iommu *iommu = sun50i_iommu_from_dev(dev);
> @@ -764,7 +762,6 @@ static const struct iommu_ops sun50i_iommu_ops = {
>   	.domain_alloc	= sun50i_iommu_domain_alloc,
>   	.of_xlate	= sun50i_iommu_of_xlate,
>   	.probe_device	= sun50i_iommu_probe_device,
> -	.release_device	= sun50i_iommu_release_device,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>   		.attach_dev	= sun50i_iommu_attach_device,
>   		.detach_dev	= sun50i_iommu_detach_device,
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index a6700a40a6f8..e5ca3cf1a949 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -246,10 +246,6 @@ static struct iommu_device *gart_iommu_probe_device(struct device *dev)
>   	return &gart_handle->iommu;
>   }
>   
> -static void gart_iommu_release_device(struct device *dev)
> -{
> -}
> -
>   static int gart_iommu_of_xlate(struct device *dev,
>   			       struct of_phandle_args *args)
>   {
> @@ -273,7 +269,6 @@ static void gart_iommu_sync(struct iommu_domain *domain,
>   static const struct iommu_ops gart_iommu_ops = {
>   	.domain_alloc	= gart_iommu_domain_alloc,
>   	.probe_device	= gart_iommu_probe_device,
> -	.release_device	= gart_iommu_release_device,
>   	.device_group	= generic_device_group,
>   	.pgsize_bitmap	= GART_IOMMU_PGSIZES,
>   	.of_xlate	= gart_iommu_of_xlate,
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 1fea68e551f1..2a8de975fe63 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -864,8 +864,6 @@ static struct iommu_device *tegra_smmu_probe_device(struct device *dev)
>   	return &smmu->iommu;
>   }
>   
> -static void tegra_smmu_release_device(struct device *dev) {}
> -
>   static const struct tegra_smmu_group_soc *
>   tegra_smmu_find_group(struct tegra_smmu *smmu, unsigned int swgroup)
>   {
> @@ -966,7 +964,6 @@ static int tegra_smmu_of_xlate(struct device *dev,
>   static const struct iommu_ops tegra_smmu_ops = {
>   	.domain_alloc = tegra_smmu_domain_alloc,
>   	.probe_device = tegra_smmu_probe_device,
> -	.release_device = tegra_smmu_release_device,
>   	.device_group = tegra_smmu_device_group,
>   	.of_xlate = tegra_smmu_of_xlate,
>   	.pgsize_bitmap = SZ_4K,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
