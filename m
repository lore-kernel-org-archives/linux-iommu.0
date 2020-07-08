Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC39C433E0
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 23:16:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103AE20708
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 23:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103AE20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF050886FB;
	Wed,  8 Jul 2020 23:16:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xi4iVwTxz873; Wed,  8 Jul 2020 23:16:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A7E42885D4;
	Wed,  8 Jul 2020 23:16:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88444C0893;
	Wed,  8 Jul 2020 23:16:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5653C016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 23:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D3D7587EA7
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 23:16:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H6hZL8oklfQS for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 23:16:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id A440987EA6
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 23:16:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 147CB31B;
 Wed,  8 Jul 2020 16:16:20 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0FB23F71E;
 Wed,  8 Jul 2020 16:16:19 -0700 (PDT)
Subject: Re: [PATCH] dma-pool: use single atomic pool for both DMA zones
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, David Rientjes <rientjes@google.com>
References: <20200707122804.21262-1-nsaenzjulienne@suse.de>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <3ee7f5ec-46e3-6d36-820b-011e359e759d@arm.com>
Date: Wed, 8 Jul 2020 18:16:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707122804.21262-1-nsaenzjulienne@suse.de>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

Hi,

On 7/7/20 7:28 AM, Nicolas Saenz Julienne wrote:
> When allocating atomic DMA memory for a device, the dma-pool core
> queries __dma_direct_optimal_gfp_mask() to check which atomic pool to
> use. It turns out the GFP flag returned is only an optimistic guess.
> The pool selected might sometimes live in a zone higher than the
> device's view of memory.
> 
> As there isn't a way to grantee a mapping between a device's DMA
> constraints and correct GFP flags this unifies both DMA atomic pools.
> The resulting pool is allocated in the lower DMA zone available, if any,
> so as for devices to always get accessible memory while having the
> flexibility of using dma_pool_kernel for the non constrained ones.

With the follow-on patch "dma-pool: Do not allocate pool memory from 
CMA" everything seems to be working fine now.

tested-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks for fixing this!


> 
> Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>   kernel/dma/pool.c | 47 +++++++++++++++++++----------------------------
>   1 file changed, 19 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 8cfa01243ed2..883f7a583969 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -13,10 +13,11 @@
>   #include <linux/slab.h>
>   #include <linux/workqueue.h>
>   
> +#define GFP_ATOMIC_POOL_DMA	(IS_ENABLED(CONFIG_ZONE_DMA) ? GFP_DMA : \
> +				 IS_ENABLED(CONFIG_ZONE_DMA32) ? GFP_DMA32 : 0)
> +
>   static struct gen_pool *atomic_pool_dma __ro_after_init;
>   static unsigned long pool_size_dma;
> -static struct gen_pool *atomic_pool_dma32 __ro_after_init;
> -static unsigned long pool_size_dma32;
>   static struct gen_pool *atomic_pool_kernel __ro_after_init;
>   static unsigned long pool_size_kernel;
>   
> @@ -42,16 +43,13 @@ static void __init dma_atomic_pool_debugfs_init(void)
>   		return;
>   
>   	debugfs_create_ulong("pool_size_dma", 0400, root, &pool_size_dma);
> -	debugfs_create_ulong("pool_size_dma32", 0400, root, &pool_size_dma32);
>   	debugfs_create_ulong("pool_size_kernel", 0400, root, &pool_size_kernel);
>   }
>   
>   static void dma_atomic_pool_size_add(gfp_t gfp, size_t size)
>   {
> -	if (gfp & __GFP_DMA)
> +	if (gfp & GFP_ATOMIC_POOL_DMA)
>   		pool_size_dma += size;
> -	else if (gfp & __GFP_DMA32)
> -		pool_size_dma32 += size;
>   	else
>   		pool_size_kernel += size;
>   }
> @@ -132,12 +130,11 @@ static void atomic_pool_resize(struct gen_pool *pool, gfp_t gfp)
>   
>   static void atomic_pool_work_fn(struct work_struct *work)
>   {
> -	if (IS_ENABLED(CONFIG_ZONE_DMA))
> -		atomic_pool_resize(atomic_pool_dma,
> -				   GFP_KERNEL | GFP_DMA);
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32))
> -		atomic_pool_resize(atomic_pool_dma32,
> -				   GFP_KERNEL | GFP_DMA32);
> +	gfp_t dma_gfp = GFP_ATOMIC_POOL_DMA;
> +
> +	if (dma_gfp)
> +		atomic_pool_resize(atomic_pool_dma, GFP_KERNEL | dma_gfp);
> +
>   	atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
>   }
>   
> @@ -168,6 +165,7 @@ static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
>   
>   static int __init dma_atomic_pool_init(void)
>   {
> +	gfp_t dma_gfp = GFP_ATOMIC_POOL_DMA;
>   	int ret = 0;
>   
>   	/*
> @@ -185,18 +183,13 @@ static int __init dma_atomic_pool_init(void)
>   						    GFP_KERNEL);
>   	if (!atomic_pool_kernel)
>   		ret = -ENOMEM;
> -	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> +
> +	if (dma_gfp) {
>   		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
> -						GFP_KERNEL | GFP_DMA);
> +							 GFP_KERNEL | dma_gfp);
>   		if (!atomic_pool_dma)
>   			ret = -ENOMEM;
>   	}
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
> -		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
> -						GFP_KERNEL | GFP_DMA32);
> -		if (!atomic_pool_dma32)
> -			ret = -ENOMEM;
> -	}
>   
>   	dma_atomic_pool_debugfs_init();
>   	return ret;
> @@ -206,14 +199,12 @@ postcore_initcall(dma_atomic_pool_init);
>   static inline struct gen_pool *dev_to_pool(struct device *dev)
>   {
>   	u64 phys_mask;
> -	gfp_t gfp;
> -
> -	gfp = dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
> -					  &phys_mask);
> -	if (IS_ENABLED(CONFIG_ZONE_DMA) && gfp == GFP_DMA)
> -		return atomic_pool_dma;
> -	if (IS_ENABLED(CONFIG_ZONE_DMA32) && gfp == GFP_DMA32)
> -		return atomic_pool_dma32;
> +
> +	if (atomic_pool_dma &&
> +	    dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
> +					&phys_mask))
> +			return atomic_pool_dma;
> +
>   	return atomic_pool_kernel;
>   }
>   
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
