Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D75C433EF
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 01:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F07C860C12;
	Fri, 13 May 2022 01:39:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bW6xj8dEVrtM; Fri, 13 May 2022 01:39:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CDF49608A5;
	Fri, 13 May 2022 01:39:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A147BC0039;
	Fri, 13 May 2022 01:39:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82FD2C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 01:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A8DF608A5
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 01:39:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ceckN9bBQu-7 for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 01:39:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC89160C0A
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 01:39:36 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 11DBE62107;
 Fri, 13 May 2022 01:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE77C385B8;
 Fri, 13 May 2022 01:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652405975;
 bh=W35uWjUG1O6fXtH+TbvlRcplXMfTEbaTeezWYwjpnhs=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=KwdIFkm2hPKErCfdMH4zzYXGuY6RR5jAi7812KnaR64+duu+Ce0s4TnHr47O36AR6
 Gyqmg3FhN1VegdSdqWGTjEnJ/4wK7qThd8rn84t9CgNr9XCOC2tpkfqNMdCal27YyX
 qf2mRxlkgXIIW1MeOE0aYtS1jbkeHoSlgGzMwNgQmlmA9n2Ohp5Bijmosmr6AJZy4Z
 fGMujrI1cf+U4SjFHP9IIGzypnnrqGCdXnh5Q5gGdYdIWb5LqkwlfcGMObWHJyEost
 bg7dWgaHij98vhwCua2itu4joEKubsQ7H1gumkfbcmi7OqT22eYgl2M+38h6VsbY9V
 KMHFAkS5roIJg==
Date: Thu, 12 May 2022 18:39:34 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] swiotlb: use the right nslabs value in
 swiotlb_init_remap
In-Reply-To: <20220511125805.1377025-3-hch@lst.de>
Message-ID: <alpine.DEB.2.22.394.2205121839220.3842@ubuntu-linux-20-04-desktop>
References: <20220511125805.1377025-1-hch@lst.de>
 <20220511125805.1377025-3-hch@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Conor.Dooley@microchip.com
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

On Wed, 11 May 2022, Christoph Hellwig wrote:
> default_nslabs should only be used to initialize nslabs, after that we
> need to use the local variable that can shrink when allocations or the
> remap don't succeed.
> 
> Fixes: 6424e31b1c05 ("swiotlb: remove swiotlb_init_with_tbl and swiotlb_init_late_with_tbl")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  kernel/dma/swiotlb.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 3e992a308c8a1..113e1e8aaca37 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -234,7 +234,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  {
>  	struct io_tlb_mem *mem = &io_tlb_default_mem;
>  	unsigned long nslabs = default_nslabs;
> -	size_t alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
> +	size_t alloc_size;
>  	size_t bytes;
>  	void *tlb;
>  
> @@ -249,7 +249,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  	 * memory encryption.
>  	 */
>  retry:
> -	bytes = PAGE_ALIGN(default_nslabs << IO_TLB_SHIFT);
> +	bytes = PAGE_ALIGN(nslabs << IO_TLB_SHIFT);
>  	if (flags & SWIOTLB_ANY)
>  		tlb = memblock_alloc(bytes, PAGE_SIZE);
>  	else
> @@ -269,12 +269,13 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  		goto retry;
>  	}
>  
> +	alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
>  	mem->slots = memblock_alloc(alloc_size, PAGE_SIZE);
>  	if (!mem->slots)
>  		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
>  		      __func__, alloc_size, PAGE_SIZE);
>  
> -	swiotlb_init_io_tlb_mem(mem, __pa(tlb), default_nslabs, false);
> +	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
>  	mem->force_bounce = flags & SWIOTLB_FORCE;
>  
>  	if (flags & SWIOTLB_VERBOSE)
> -- 
> 2.30.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
