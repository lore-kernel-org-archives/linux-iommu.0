Return-Path: <SRS0=ms/0=4M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1582DC38BF9
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 21:53:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD79222C2
	for <iommu@archiver.kernel.org>; Mon, 24 Feb 2020 21:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD79222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8FA638608B;
	Mon, 24 Feb 2020 21:53:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id saBsCgj+bzEC; Mon, 24 Feb 2020 21:53:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C099285BBA;
	Mon, 24 Feb 2020 21:53:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E416C07FF;
	Mon, 24 Feb 2020 21:53:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 085C0C0177
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 21:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ED59786D82
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 21:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lMvZVkGcT2YS for <iommu@lists.linux-foundation.org>;
 Mon, 24 Feb 2020 21:53:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4F57C8707A
 for <iommu@lists.linux-foundation.org>; Mon, 24 Feb 2020 21:53:30 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Feb 2020 13:53:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; d="scan'208";a="226126679"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga007.jf.intel.com with ESMTP; 24 Feb 2020 13:53:28 -0800
Date: Mon, 24 Feb 2020 13:53:28 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/5] dma-direct: provide a arch_dma_clear_uncached hook
Message-ID: <20200224215327.GB11565@iweiny-DESK2.sc.intel.com>
References: <20200224194446.690816-1-hch@lst.de>
 <20200224194446.690816-5-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200224194446.690816-5-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Cc: Jonas Bonn <jonas@southpole.se>, Mark Rutland <mark.rutland@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
 linux-arch@vger.kernel.org, Stafford Horne <shorne@gmail.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Mon, Feb 24, 2020 at 11:44:44AM -0800, Christoph Hellwig wrote:
> This allows the arch code to reset the page tables to cached access when
> freeing a dma coherent allocation that was set to uncached using
> arch_dma_set_uncached.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/Kconfig                    | 7 +++++++
>  include/linux/dma-noncoherent.h | 1 +
>  kernel/dma/direct.c             | 2 ++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 090cfe0c82a7..c26302f90c96 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -255,6 +255,13 @@ config ARCH_HAS_SET_DIRECT_MAP
>  config ARCH_HAS_DMA_SET_UNCACHED
>  	bool
>  
> +#
> +# Select if the architectures provides the arch_dma_clear_uncached symbol
> +# to undo an in-place page table remap for uncached access.
> +#
> +config ARCH_HAS_DMA_CLEAR_UNCACHED
> +	bool
> +
>  # Select if arch init_task must go in the __init_task_data section
>  config ARCH_TASK_STRUCT_ON_STACK
>  	bool
> diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
> index 1a4039506673..b59f1b6be3e9 100644
> --- a/include/linux/dma-noncoherent.h
> +++ b/include/linux/dma-noncoherent.h
> @@ -109,5 +109,6 @@ static inline void arch_dma_prep_coherent(struct page *page, size_t size)
>  #endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
>  
>  void *arch_dma_set_uncached(void *addr, size_t size);
> +void arch_dma_clear_uncached(void *addr, size_t size);
>  
>  #endif /* _LINUX_DMA_NONCOHERENT_H */
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index f01a8191fd59..a8560052a915 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -219,6 +219,8 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
>  
>  	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr))
>  		vunmap(cpu_addr);
> +	else if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
> +		arch_dma_clear_uncached(cpu_addr, size);

Isn't using arch_dma_clear_uncached() before patch 5 going to break
bisectability?

Ira

>  
>  	dma_free_contiguous(dev, dma_direct_to_page(dev, dma_addr), size);
>  }
> -- 
> 2.24.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
