Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5204C433E1
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 08:47:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88333207DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 08:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3m8yO83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88333207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5B90E86D1D;
	Fri, 21 Aug 2020 08:47:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CtYudZhJZliO; Fri, 21 Aug 2020 08:47:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9ACCE86CEF;
	Fri, 21 Aug 2020 08:47:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84B08C07FF;
	Fri, 21 Aug 2020 08:47:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99B73C0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 08:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8847286CEF
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 08:47:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8HXNExMtDMsu for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 08:47:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 105A086A29
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 08:47:29 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 61B5420720;
 Fri, 21 Aug 2020 08:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597999648;
 bh=swmC7UAXvWT1qPRy+nmc9swuccmpZt4xQ+XxVpcsw4o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s3m8yO83/JP46GlOofMZy8mYtCgS84V8pMCg79cDORut0LvOof7cy6AH5z6O2Xxaw
 I/WYJNMHujM65sbfFB3EPI1hcMkpSHIxz8O87NXIRciOLPxm1rKhYaHDjFhofKhh7d
 RNhKOvrWVZDPB9J2eaJ+DgiQXbx9IrqSP2FjESOU=
Date: Fri, 21 Aug 2020 09:47:17 +0100
From: Will Deacon <will@kernel.org>
To: Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v6 1/2] dma-contiguous: provide the ability to reserve
 per-numa CMA
Message-ID: <20200821084717.GA20255@willie-the-truck>
References: <20200821022615.28596-1-song.bao.hua@hisilicon.com>
 <20200821022615.28596-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200821022615.28596-2-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mike Rapoport <rppt@linux.ibm.com>, Steve Capper <steve.capper@arm.com>,
 catalin.marinas@arm.com, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, ganapatrao.kulkarni@cavium.com,
 Andrew Morton <akpm@linux-foundation.org>, huangdaode@huawei.com,
 robin.murphy@arm.com, hch@lst.de, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Aug 21, 2020 at 02:26:14PM +1200, Barry Song wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bdc1f33fd3d1..3f33b89aeab5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -599,6 +599,15 @@
>  			altogether. For more information, see
>  			include/linux/dma-contiguous.h
>  
> +	pernuma_cma=nn[MG]
> +			[ARM64,KNL]
> +			Sets the size of kernel per-numa memory area for
> +			contiguous memory allocations. A value of 0 disables
> +			per-numa CMA altogether. DMA users on node nid will
> +			first try to allocate buffer from the pernuma area
> +			which is located in node nid, if the allocation fails,
> +			they will fallback to the global default memory area.

What is the default behaviour if this option is not specified? Seems like
that should be mentioned here.

> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 847a9d1fa634..db7a37ed35eb 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -118,6 +118,16 @@ config DMA_CMA
>  	  If unsure, say "n".
>  
>  if  DMA_CMA
> +
> +config DMA_PERNUMA_CMA
> +	bool "Enable separate DMA Contiguous Memory Area for each NUMA Node"

I don't understand the need for this config option. If you have DMA_DMA and
you have NUMA, why wouldn't you want this enabled?

> +	help
> +	  Enable this option to get pernuma CMA areas so that devices like
> +	  ARM64 SMMU can get local memory by DMA coherent APIs.
> +
> +	  You can set the size of pernuma CMA by specifying "pernuma_cma=size"
> +	  on the kernel's command line.
> +
>  comment "Default contiguous memory area size:"
>  
>  config CMA_SIZE_MBYTES
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index cff7e60968b9..89b95f10e56d 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -69,6 +69,19 @@ static int __init early_cma(char *p)
>  }
>  early_param("cma", early_cma);
>  
> +#ifdef CONFIG_DMA_PERNUMA_CMA
> +
> +static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
> +static phys_addr_t pernuma_size_bytes __initdata;
> +
> +static int __init early_pernuma_cma(char *p)
> +{
> +	pernuma_size_bytes = memparse(p, &p);
> +	return 0;
> +}
> +early_param("pernuma_cma", early_pernuma_cma);
> +#endif
> +
>  #ifdef CONFIG_CMA_SIZE_PERCENTAGE
>  
>  static phys_addr_t __init __maybe_unused cma_early_percent_memory(void)
> @@ -96,6 +109,34 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
>  
>  #endif
>  
> +#ifdef CONFIG_DMA_PERNUMA_CMA
> +void __init dma_pernuma_cma_reserve(void)
> +{
> +	int nid;
> +
> +	if (!pernuma_size_bytes)
> +		return;

If this is useful (I assume it is), then I think we should have a non-zero
default value, a bit like normal CMA does via CMA_SIZE_MBYTES.

> +	for_each_node_state(nid, N_ONLINE) {

for_each_online_node() {

> +		int ret;
> +		char name[20];

20?

Ah, wait, this is copy-pasta from hugetlb_cma_reserve(). Can you factor out
the common parts at all?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
