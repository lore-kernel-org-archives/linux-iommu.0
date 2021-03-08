Return-Path: <SRS0=OBKs=IG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EA9C433DB
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 02:00:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03526514A
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 02:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03526514A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 79AF142C2B;
	Mon,  8 Mar 2021 02:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id To2dI5eo91nt; Mon,  8 Mar 2021 02:00:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 38B0E42C2D;
	Mon,  8 Mar 2021 02:00:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19265C000B;
	Mon,  8 Mar 2021 02:00:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2F66C0001
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 02:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C43C430D4
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 02:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cb1xFXcARGYs for <iommu@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 02:00:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E29F42C2B
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 02:00:44 +0000 (UTC)
IronPort-SDR: pxJXbRRmTIZTLRRXsIlV3teM/b7cHD7PuX6c/xhnu+tPTX6Ljy23wjL7mCtkvFJzrpyG+atJqK
 n+BNqdn9i8EA==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="175565840"
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; d="scan'208";a="175565840"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2021 18:00:42 -0800
IronPort-SDR: sK1D+za8aMtekdwKBO0Mr0g4ycJ1HzZFPFMqqifKm3QAakfU/iErWYeulIJNNrVwCOiPhkfVVd
 0Mc7nFaETi9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; d="scan'208";a="430181662"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 07 Mar 2021 18:00:37 -0800
Subject: Re: [PATCH] iommu/dma: Resurrect the "forcedac" option
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
References: <7eece8e0ea7bfbe2cd0e30789e0d46df573af9b0.1614961776.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <96ec7803-e687-2e12-c61c-4e0a12ea538b@linux.intel.com>
Date: Mon, 8 Mar 2021 09:51:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7eece8e0ea7bfbe2cd0e30789e0d46df573af9b0.1614961776.git.robin.murphy@arm.com>
Content-Language: en-US
Cc: will@kernel.org, linux-kernel@vger.kernel.org, murphyt7@tcd.ie,
 iommu@lists.linux-foundation.org, dwmw2@infradead.org
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

Hi Robin,

On 3/6/21 12:32 AM, Robin Murphy wrote:
> In converting intel-iommu over to the common IOMMU DMA ops, it quietly
> lost the functionality of its "forcedac" option. Since this is a handy
> thing both for testing and for performance optimisation on certain
> platforms, reimplement it under the common IOMMU parameter namespace.
> 
> For the sake of fixing the inadvertent breakage of the Intel-specific
> parameter, remove the dmar_forcedac remnants and hook it up as an alias
> while documenting the transition to the new common parameter.
> 
> Fixes: c588072bba6b ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 15 ++++++++-------
>   drivers/iommu/dma-iommu.c                       | 13 ++++++++++++-
>   drivers/iommu/intel/iommu.c                     |  5 ++---
>   include/linux/dma-iommu.h                       |  2 ++
>   4 files changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 04545725f187..835f810f2f26 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1869,13 +1869,6 @@
>   			bypassed by not enabling DMAR with this option. In
>   			this case, gfx device will use physical address for
>   			DMA.
> -		forcedac [X86-64]
> -			With this option iommu will not optimize to look
> -			for io virtual address below 32-bit forcing dual
> -			address cycle on pci bus for cards supporting greater
> -			than 32-bit addressing. The default is to look
> -			for translation below 32-bit and if not available
> -			then look in the higher range.
>   		strict [Default Off]
>   			With this option on every unmap_single operation will
>   			result in a hardware IOTLB flush operation as opposed
> @@ -1964,6 +1957,14 @@
>   		nobypass	[PPC/POWERNV]
>   			Disable IOMMU bypass, using IOMMU for PCI devices.
>   
> +	iommu.forcedac=	[ARM64, X86] Control IOVA allocation for PCI devices.
> +			Format: { "0" | "1" }
> +			0 - Try to allocate a 32-bit DMA address first, before
> +			  falling back to the full range if needed.
> +			1 - Allocate directly from the full usable range,
> +			  forcing Dual Address Cycle for PCI cards supporting
> +			  greater than 32-bit addressing.
> +
>   	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
>   			Format: { "0" | "1" }
>   			0 - Lazy mode.
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9ab6ee22c110..260bf3de1992 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -52,6 +52,17 @@ struct iommu_dma_cookie {
>   };
>   
>   static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
> +bool iommu_dma_forcedac __read_mostly;
> +
> +static int __init iommu_dma_forcedac_setup(char *str)
> +{
> +	int ret = kstrtobool(str, &iommu_dma_forcedac);
> +
> +	if (!ret && iommu_dma_forcedac)
> +		pr_info("Forcing DAC for PCI devices\n");
> +	return ret;
> +}
> +early_param("iommu.forcedac", iommu_dma_forcedac_setup);
>   
>   void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
>   		struct iommu_domain *domain)
> @@ -438,7 +449,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>   		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
>   
>   	/* Try to get PCI devices a SAC address */
> -	if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
> +	if (dma_limit > DMA_BIT_MASK(32) && !iommu_dma_forcedac && dev_is_pci(dev))
>   		iova = alloc_iova_fast(iovad, iova_len,
>   				       DMA_BIT_MASK(32) >> shift, false);
>   
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ee0932307d64..1c32522220bc 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -360,7 +360,6 @@ int intel_iommu_enabled = 0;
>   EXPORT_SYMBOL_GPL(intel_iommu_enabled);
>   
>   static int dmar_map_gfx = 1;
> -static int dmar_forcedac;
>   static int intel_iommu_strict;
>   static int intel_iommu_superpage = 1;
>   static int iommu_identity_mapping;
> @@ -451,8 +450,8 @@ static int __init intel_iommu_setup(char *str)
>   			dmar_map_gfx = 0;
>   			pr_info("Disable GFX device mapping\n");
>   		} else if (!strncmp(str, "forcedac", 8)) {
> -			pr_info("Forcing DAC for PCI devices\n");
> -			dmar_forcedac = 1;
> +			pr_warn("intel_iommu=forcedac deprecated; use iommu.forcedac instead\n");
> +			iommu_dma_forcedac = true;
>   		} else if (!strncmp(str, "strict", 6)) {
>   			pr_info("Disable batched IOTLB flush\n");
>   			intel_iommu_strict = 1;
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 706b68d1359b..13d1f4c14d7b 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -40,6 +40,8 @@ void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
>   		struct iommu_domain *domain);
>   
> +extern bool iommu_dma_forcedac;
> +
>   #else /* CONFIG_IOMMU_DMA */
>   
>   struct iommu_domain;
> 

Thanks for catching this.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
