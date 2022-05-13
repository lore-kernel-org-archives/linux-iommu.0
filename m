Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBD1C433EF
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 01:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5C4F41691;
	Fri, 13 May 2022 01:44:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PAqRE-ZzST0F; Fri, 13 May 2022 01:44:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 712A540A04;
	Fri, 13 May 2022 01:44:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4383BC0039;
	Fri, 13 May 2022 01:44:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B736C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 01:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8A4D81765
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 01:44:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 50T18H8kh5xN for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 01:44:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 342F7814AB
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 01:44:33 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7E50B620EA;
 Fri, 13 May 2022 01:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910EBC385B8;
 Fri, 13 May 2022 01:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652406271;
 bh=ZS0DQzDVQRw+WyZX8h4DFNWCJCmiIgGiFZJt0lgwi0Q=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=HfYksHVbntV+wgGN0VNX9EmrK8S41HUKC7cNTFH1O/07u0e3kTAlwTatr1+Gyv6M8
 /GmqcFTbKgB07jBYxiSlJcnHbgLjdNgTTk1GZVrIxxt3SNHehw+QVRKVTdfRZP8J2F
 HEOm8R5uwSQI1EqLv1bT+NaX++rQJEIN3UrC8b3wpwMe29SUluH6LjfKTJzVMsQqUm
 awkKp/NwkHraiUJ5vPWk898WNy2Jiujt3gOJXnKBJSth9leZJdqiBgBX3nwQRmFerO
 nIGWazHqK0GsyQCdVwbhSGJgfRdK4ATT/erXQGSQDcKrJ1ZBKMAOCZ0YKGNe2Hv1z8
 jsvo4HlZWqVDA==
Date: Thu, 12 May 2022 18:44:30 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] swiotlb: use the right nslabs-derived sizes in
 swiotlb_init_late
In-Reply-To: <20220511125805.1377025-4-hch@lst.de>
Message-ID: <alpine.DEB.2.22.394.2205121844221.3842@ubuntu-linux-20-04-desktop>
References: <20220511125805.1377025-1-hch@lst.de>
 <20220511125805.1377025-4-hch@lst.de>
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
> nslabs can shrink when allocations or the remap don't succeed, so make
> sure to use it for all sizing.  For that remove the bytes value that
> can get stale and replace it with local calculations and a boolean to
> indicate if the originally requested size could not be allocated.
> 
> Fixes: 6424e31b1c05 ("swiotlb: remove swiotlb_init_with_tbl and swiotlb_init_late_with_tbl")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  kernel/dma/swiotlb.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 113e1e8aaca37..d6e62a6a42ceb 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -297,9 +297,9 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  {
>  	struct io_tlb_mem *mem = &io_tlb_default_mem;
>  	unsigned long nslabs = ALIGN(size >> IO_TLB_SHIFT, IO_TLB_SEGSIZE);
> -	unsigned long bytes;
>  	unsigned char *vstart = NULL;
>  	unsigned int order;
> +	bool retried = false;
>  	int rc = 0;
>  
>  	if (swiotlb_force_disable)
> @@ -308,7 +308,6 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  retry:
>  	order = get_order(nslabs << IO_TLB_SHIFT);
>  	nslabs = SLABS_PER_PAGE << order;
> -	bytes = nslabs << IO_TLB_SHIFT;
>  
>  	while ((SLABS_PER_PAGE << order) > IO_TLB_MIN_SLABS) {
>  		vstart = (void *)__get_free_pages(gfp_mask | __GFP_NOWARN,
> @@ -316,16 +315,13 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  		if (vstart)
>  			break;
>  		order--;
> +		nslabs = SLABS_PER_PAGE << order;
> +		retried = true;
>  	}
>  
>  	if (!vstart)
>  		return -ENOMEM;
>  
> -	if (order != get_order(bytes)) {
> -		pr_warn("only able to allocate %ld MB\n",
> -			(PAGE_SIZE << order) >> 20);
> -		nslabs = SLABS_PER_PAGE << order;
> -	}
>  	if (remap)
>  		rc = remap(vstart, nslabs);
>  	if (rc) {
> @@ -334,9 +330,15 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  		nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
>  		if (nslabs < IO_TLB_MIN_SLABS)
>  			return rc;
> +		retried = true;
>  		goto retry;
>  	}
>  
> +	if (retried) {
> +		pr_warn("only able to allocate %ld MB\n",
> +			(PAGE_SIZE << order) >> 20);
> +	}
> +
>  	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>  		get_order(array_size(sizeof(*mem->slots), nslabs)));
>  	if (!mem->slots) {
> @@ -344,7 +346,8 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
>  		return -ENOMEM;
>  	}
>  
> -	set_memory_decrypted((unsigned long)vstart, bytes >> PAGE_SHIFT);
> +	set_memory_decrypted((unsigned long)vstart,
> +			     (nslabs << IO_TLB_SHIFT) >> PAGE_SHIFT);
>  	swiotlb_init_io_tlb_mem(mem, virt_to_phys(vstart), nslabs, true);
>  
>  	swiotlb_print_info();
> -- 
> 2.30.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
