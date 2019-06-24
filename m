Return-Path: <SRS0=0Jvo=UX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A6BC48BE9
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 14:23:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A9A208E4
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 14:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A9A208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 60CF2FA3;
	Mon, 24 Jun 2019 14:23:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A74B8FA2
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 14:23:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id DC4847FB
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 14:23:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4151B344;
	Mon, 24 Jun 2019 07:23:12 -0700 (PDT)
Received: from [10.1.32.158] (unknown [10.1.32.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C9083F71E;
	Mon, 24 Jun 2019 07:23:10 -0700 (PDT)
Subject: Re: [PATCH 1/7] arm-nommu: remove the partial DMA_ATTR_NON_CONSISTENT
	support
To: Christoph Hellwig <hch@lst.de>, Vineet Gupta <vgupta@synopsys.com>
References: <20190614144431.21760-1-hch@lst.de>
	<20190614144431.21760-2-hch@lst.de>
From: Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <a017e704-c6c4-7718-7f8b-eb8a0eced14d@arm.com>
Date: Mon, 24 Jun 2019 15:23:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614144431.21760-2-hch@lst.de>
Content-Language: en-US
Cc: Jonas Bonn <jonas@southpole.se>, linux-xtensa@linux-xtensa.org,
	linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
	linux-kernel@vger.kernel.org,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
	Stafford Horne <shorne@gmail.com>, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 6/14/19 3:44 PM, Christoph Hellwig wrote:
> The arm-nommu DMA code supports DMA_ATTR_NON_CONSISTENT allocations, but
> does not provide a cache_sync operation.  This means any user of it
> will never be able to actually transfer cache ownership and thus cause
> coherency bugs.

By the way, Documentation/DMA-attributes.txt doesn't specify cache_sync() as
requirement for DMA_ATTR_NON_CONSISTENT it only states that it is responsibility
of the driver to have all the correct and necessary sync points.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/mm/dma-mapping-nommu.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
> index f304b10e23a4..bc003df45546 100644
> --- a/arch/arm/mm/dma-mapping-nommu.c
> +++ b/arch/arm/mm/dma-mapping-nommu.c
> @@ -39,18 +39,7 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
>  				 unsigned long attrs)
>  
>  {
> -	void *ret;
> -
> -	/*
> -	 * Try generic allocator first if we are advertised that
> -	 * consistency is not required.
> -	 */
> -
> -	if (attrs & DMA_ATTR_NON_CONSISTENT)
> -		return dma_direct_alloc_pages(dev, size, dma_handle, gfp,
> -				attrs);
> -
> -	ret = dma_alloc_from_global_coherent(size, dma_handle);
> +	void *ret = dma_alloc_from_global_coherent(size, dma_handle);
>  
>  	/*
>  	 * dma_alloc_from_global_coherent() may fail because:
> @@ -70,16 +59,9 @@ static void arm_nommu_dma_free(struct device *dev, size_t size,
>  			       void *cpu_addr, dma_addr_t dma_addr,
>  			       unsigned long attrs)
>  {
> -	if (attrs & DMA_ATTR_NON_CONSISTENT) {
> -		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
> -	} else {
> -		int ret = dma_release_from_global_coherent(get_order(size),
> -							   cpu_addr);
> -
> -		WARN_ON_ONCE(ret == 0);
> -	}
> +	int ret = dma_release_from_global_coherent(get_order(size), cpu_addr);
>  
> -	return;
> +	WARN_ON_ONCE(ret == 0);
>  }
>  
>  static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
> 

FWIW:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>

Cheers
Vladimir
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
