Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634A7C433FE
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 11:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 040D48174C;
	Thu, 21 Apr 2022 11:49:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YtEeRDO4adMw; Thu, 21 Apr 2022 11:49:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D19298149C;
	Thu, 21 Apr 2022 11:49:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FA4FC0033;
	Thu, 21 Apr 2022 11:49:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 498CFC002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4459D40272
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:49:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G-Yq5bfhqNqJ for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 11:49:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 145DA400E4
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:49:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F2B21FB;
 Thu, 21 Apr 2022 04:49:19 -0700 (PDT)
Received: from [10.57.41.251] (unknown [10.57.41.251])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACB8A3F5A1;
 Thu, 21 Apr 2022 04:49:16 -0700 (PDT)
Message-ID: <9cc46406-0f78-de27-fa0c-65d86ff05561@arm.com>
Date: Thu, 21 Apr 2022 12:49:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [Patch v2] iommu: arm-smmu: disable large page mappings for
 Nvidia arm-smmu
Content-Language: en-GB
To: Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
 vdumpa@nvidia.com, will@kernel.org, joro@8bytes.org, jonathanh@nvidia.com,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220421081504.24678-1-amhetre@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220421081504.24678-1-amhetre@nvidia.com>
Cc: Snikam@nvidia.com, Pritesh Raithatha <praithatha@nvidia.com>
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

On 2022-04-21 09:15, Ashish Mhetre wrote:
> Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
> entries to not be invalidated correctly. The problem is that the walk
> cache index generated for IOVA is not same across translation and
> invalidation requests. This is leading to page faults when PMD entry is
> released during unmap and populated with new PTE table during subsequent
> map request. Disabling large page mappings avoids the release of PMD
> entry and avoid translations seeing stale PMD entry in walk cache.
> Fix this by limiting the page mappings to PAGE_SIZE for Tegra194 and
> Tegra234 devices. This is recommended fix from Tegra hardware design
> team.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Co-developed-by: Pritesh Raithatha <praithatha@nvidia.com>
> Signed-off-by: Pritesh Raithatha <praithatha@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
> Changes in v2:
> - Using init_context() to override pgsize_bitmap instead of new function
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 30 ++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> index 01e9b50b10a1..87bf522b9d2e 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> @@ -258,6 +258,34 @@ static void nvidia_smmu_probe_finalize(struct arm_smmu_device *smmu, struct devi
>   			dev_name(dev), err);
>   }
>   
> +static int nvidia_smmu_init_context(struct arm_smmu_domain *smmu_domain,
> +				    struct io_pgtable_cfg *pgtbl_cfg,
> +				    struct device *dev)
> +{
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	const struct device_node *np = smmu->dev->of_node;
> +
> +	/*
> +	 * Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
> +	 * entries to not be invalidated correctly. The problem is that the walk
> +	 * cache index generated for IOVA is not same across translation and
> +	 * invalidation requests. This is leading to page faults when PMD entry
> +	 * is released during unmap and populated with new PTE table during
> +	 * subsequent map request. Disabling large page mappings avoids the
> +	 * release of PMD entry and avoid translations seeing stale PMD entry in
> +	 * walk cache.
> +	 * Fix this by limiting the page mappings to PAGE_SIZE on Tegra194 and
> +	 * Tegra234.
> +	 */
> +	if (of_device_is_compatible(np, "nvidia,tegra234-smmu") ||
> +	    of_device_is_compatible(np, "nvidia,tegra194-smmu")) {
> +		smmu->pgsize_bitmap = PAGE_SIZE;
> +		pgtbl_cfg->pgsize_bitmap = smmu->pgsize_bitmap;
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct arm_smmu_impl nvidia_smmu_impl = {
>   	.read_reg = nvidia_smmu_read_reg,
>   	.write_reg = nvidia_smmu_write_reg,
> @@ -268,10 +296,12 @@ static const struct arm_smmu_impl nvidia_smmu_impl = {
>   	.global_fault = nvidia_smmu_global_fault,
>   	.context_fault = nvidia_smmu_context_fault,
>   	.probe_finalize = nvidia_smmu_probe_finalize,
> +	.init_context = nvidia_smmu_init_context,
>   };
>   
>   static const struct arm_smmu_impl nvidia_smmu_single_impl = {
>   	.probe_finalize = nvidia_smmu_probe_finalize,
> +	.init_context = nvidia_smmu_init_context,
>   };
>   
>   struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
