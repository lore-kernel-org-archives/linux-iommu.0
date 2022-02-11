Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B3DC433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Feb 2022 01:34:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D3CF5408C1;
	Fri, 11 Feb 2022 01:34:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q5-8J5Vb3us7; Fri, 11 Feb 2022 01:34:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 740524055F;
	Fri, 11 Feb 2022 01:34:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C11CC001A;
	Fri, 11 Feb 2022 01:34:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 743FCC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 01:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F6BB40491
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 01:34:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2bDHHkXHq6GO for <iommu@lists.linux-foundation.org>;
 Fri, 11 Feb 2022 01:34:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A93740448
 for <iommu@lists.linux-foundation.org>; Fri, 11 Feb 2022 01:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644543281; x=1676079281;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=+BVql9j+nSKuX06ape3W050amhEw94XEN/hSBH7FZEM=;
 b=ETUDbAAJVcnEjOB0icdqWdm36jndrkW/FSYmWXIt2KwydsZPL7WwGjyK
 8fNjuJpH8vnAuimHpSZWJ+TOz2u72Fy6LWIYx32n/rJHMtJjdOLLdpt5U
 tXbESuj+6XaYMb2FWvqS5fhCi/8+ZlBkkRf7bbdwvOyHiV5ROOODiX8wJ
 4RhpDsUM49NsvuAo7zq7gdit013wmj66YrOv0RLmFcJJu5QHMLdTYsG1f
 pwr/HetXKECxMwDD70tKVCzEPppm+YXQOInLYRbZcunzn++Dk0d+uqbIZ
 xbgdROz/gk/TGLnejxwCcP0JdFt54LCv5shFwCZwxwhbz81astyLwN2jN g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249581588"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="249581588"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 17:34:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="679360603"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2022 17:34:34 -0800
Message-ID: <532a9259-a1f4-dc1e-acfe-8ac2c6de71b9@linux.intel.com>
Date: Fri, 11 Feb 2022 09:33:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] iommu: Remove trivial ops->capable implementations
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <8413578c6f8a7cf75530b00cba8f10f5b88f8517.1644495614.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <8413578c6f8a7cf75530b00cba8f10f5b88f8517.1644495614.git.robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On 2/10/22 8:29 PM, Robin Murphy wrote:
> Implementing ops->capable to always return false is pointless since it's
> the default behaviour anyway. Clean up the unnecessary implementations.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Spinning this out of my bus ops stuff (currently 30 patches and
> counting...) since it would be better off alongside Baolu's cleanup
> series to avoid conflicts, and I want to depend on those patches for
> dev_iommu_ops() anyway.
> 
>   drivers/iommu/msm_iommu.c  | 6 ------
>   drivers/iommu/tegra-gart.c | 6 ------
>   drivers/iommu/tegra-smmu.c | 6 ------
>   3 files changed, 18 deletions(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 06bde6b66732..22061ddbd5df 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -558,11 +558,6 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
>   	return ret;
>   }
>   
> -static bool msm_iommu_capable(enum iommu_cap cap)
> -{
> -	return false;
> -}
> -
>   static void print_ctx_regs(void __iomem *base, int ctx)
>   {
>   	unsigned int fsr = GET_FSR(base, ctx);
> @@ -672,7 +667,6 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
>   }
>   
>   static struct iommu_ops msm_iommu_ops = {
> -	.capable = msm_iommu_capable,
>   	.domain_alloc = msm_iommu_domain_alloc,
>   	.domain_free = msm_iommu_domain_free,
>   	.attach_dev = msm_iommu_attach_dev,
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 6a358f92c7e5..bbd287d19324 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -238,11 +238,6 @@ static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
>   	return pte & GART_PAGE_MASK;
>   }
>   
> -static bool gart_iommu_capable(enum iommu_cap cap)
> -{
> -	return false;
> -}
> -
>   static struct iommu_device *gart_iommu_probe_device(struct device *dev)
>   {
>   	if (!dev_iommu_fwspec_get(dev))
> @@ -276,7 +271,6 @@ static void gart_iommu_sync(struct iommu_domain *domain,
>   }
>   
>   static const struct iommu_ops gart_iommu_ops = {
> -	.capable	= gart_iommu_capable,
>   	.domain_alloc	= gart_iommu_domain_alloc,
>   	.domain_free	= gart_iommu_domain_free,
>   	.attach_dev	= gart_iommu_attach_dev,
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index e900e3c46903..43df44f918a1 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -272,11 +272,6 @@ static void tegra_smmu_free_asid(struct tegra_smmu *smmu, unsigned int id)
>   	clear_bit(id, smmu->asids);
>   }
>   
> -static bool tegra_smmu_capable(enum iommu_cap cap)
> -{
> -	return false;
> -}
> -
>   static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
>   {
>   	struct tegra_smmu_as *as;
> @@ -967,7 +962,6 @@ static int tegra_smmu_of_xlate(struct device *dev,
>   }
>   
>   static const struct iommu_ops tegra_smmu_ops = {
> -	.capable = tegra_smmu_capable,
>   	.domain_alloc = tegra_smmu_domain_alloc,
>   	.domain_free = tegra_smmu_domain_free,
>   	.attach_dev = tegra_smmu_attach_dev,

Looks good to me.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
