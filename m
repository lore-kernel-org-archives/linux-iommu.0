Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D27AC433E3
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CF6206D7
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CF6206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8D8A2869F7;
	Tue, 28 Jul 2020 11:52:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cSMxAvdZnBwI; Tue, 28 Jul 2020 11:52:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4BF0F85A5A;
	Tue, 28 Jul 2020 11:52:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29F78C004F;
	Tue, 28 Jul 2020 11:52:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4991CC004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 11:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 06CD523799
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 11:52:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wmh44rgNO2Hp for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 11:52:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id 0ACD623735
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 11:52:36 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0344268B05; Tue, 28 Jul 2020 13:52:32 +0200 (CEST)
Date: Tue, 28 Jul 2020 13:52:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v4 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Message-ID: <20200728115231.GA793@lst.de>
References: <20200723131344.41472-1-song.bao.hua@hisilicon.com>
 <20200723131344.41472-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200723131344.41472-2-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: catalin.marinas@arm.com, Mike Rapoport <rppt@linux.ibm.com>,
 Steve Capper <steve.capper@arm.com>, robin.murphy@arm.com, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 prime.zeng@hisilicon.com, ganapatrao.kulkarni@cavium.com,
 Andrew Morton <akpm@linux-foundation.org>, huangdaode@huawei.com,
 will@kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org
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

On Fri, Jul 24, 2020 at 01:13:43AM +1200, Barry Song wrote:
> +config CMA_PERNUMA_SIZE_MBYTES
> +	int "Size in Mega Bytes for per-numa CMA areas"
> +	depends on NUMA
> +	default 16 if ARM64
> +	default 0
> +	help
> +	  Defines the size (in MiB) of the per-numa memory area for Contiguous
> +	  Memory Allocator. Every numa node will get a separate CMA with this
> +	  size. If the size of 0 is selected, per-numa CMA is disabled.

I'm still not a fan of the config option.  You can just hardcode the
value in CONFIG_CMDLINE based on the kernel parameter.  Also I wonder
if a way to expose this in the device tree might be useful, but people
more familiar with the device tree and the arm code will have to chime
in on that.

>  struct cma *dma_contiguous_default_area;
> +static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
>  
>  /*
>   * Default global CMA area size can be defined in kernel's .config.
> @@ -44,6 +51,8 @@ struct cma *dma_contiguous_default_area;
>   */
>  static const phys_addr_t size_bytes __initconst =
>  	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
> +static phys_addr_t pernuma_size_bytes __initdata =
> +	(phys_addr_t)CMA_SIZE_PERNUMA_MBYTES * SZ_1M;
>  static phys_addr_t  size_cmdline __initdata = -1;
>  static phys_addr_t base_cmdline __initdata;
>  static phys_addr_t limit_cmdline __initdata;
> @@ -69,6 +78,13 @@ static int __init early_cma(char *p)
>  }
>  early_param("cma", early_cma);
>  
> +static int __init early_pernuma_cma(char *p)
> +{
> +	pernuma_size_bytes = memparse(p, &p);
> +	return 0;
> +}
> +early_param("pernuma_cma", early_pernuma_cma);
> +
>  #ifdef CONFIG_CMA_SIZE_PERCENTAGE
>  
>  static phys_addr_t __init __maybe_unused cma_early_percent_memory(void)
> @@ -96,6 +112,33 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
>  
>  #endif
>  
> +void __init dma_pernuma_cma_reserve(void)
> +{
> +	int nid;
> +
> +	if (!pernuma_size_bytes)
> +		return;
> +
> +	for_each_node_state(nid, N_MEMORY) {
> +		int ret;
> +		char name[20];
> +
> +		snprintf(name, sizeof(name), "pernuma%d", nid);
> +		ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
> +						 0, false, name,
> +						 &dma_contiguous_pernuma_area[nid],
> +						 nid);

This adds a > 80 char line.

>  struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>  {
> +	int nid = dev_to_node(dev);
> +
>  	/* CMA can be used only in the context which permits sleeping */
>  	if (!gfpflags_allow_blocking(gfp))
>  		return NULL;
>  	if (dev->cma_area)
>  		return cma_alloc_aligned(dev->cma_area, size, gfp);
> -	if (size <= PAGE_SIZE || !dma_contiguous_default_area)
> +	if (size <= PAGE_SIZE)
>  		return NULL;
> +
> +	if ((nid != NUMA_NO_NODE) && !(gfp & (GFP_DMA | GFP_DMA32))) {

No need for the braces around the nid check.

> +		struct cma *cma = dma_contiguous_pernuma_area[nid];
> +		struct page *page;
> +
> +		if (cma) {
> +			page = cma_alloc_aligned(cma, size, gfp);
> +			if (page)
> +				return page;
> +		}
> +	}
> +
>  	return cma_alloc_aligned(dma_contiguous_default_area, size, gfp);

This seems to have lost the dma_contiguous_default_area NULL check.

> +	/* if dev has its own cma, free page from there */
> +	if (dev->cma_area) {
> +		if (cma_release(dev->cma_area, page, PAGE_ALIGN(size) >> PAGE_SHIFT))
> +			return;

Another overly long line.

> +	} else {
> +		/*
> +		 * otherwise, page is from either per-numa cma or default cma
> +		 */
> +		if (cma_release(dma_contiguous_pernuma_area[page_to_nid(page)],
> +					page, PAGE_ALIGN(size) >> PAGE_SHIFT))
> +			return;
> +
> +		if (cma_release(dma_contiguous_default_area, page,
> +					PAGE_ALIGN(size) >> PAGE_SHIFT))
> +			return;
> +	}

I'd introduce a count variable for the value of "PAGE_ALIGN(size) >>
PAGE_SHIFT" to clean al lthis up a bit.

Also please add a CONFIG_PERCPU_DMA_CMA config variable so that we
don't build this code for the vast majority of users that don't need it.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
