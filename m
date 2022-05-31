Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE042C433EF
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 18:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66A3D41C3C;
	Tue, 31 May 2022 18:24:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RKiuGTQlXJsf; Tue, 31 May 2022 18:23:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E70C641936;
	Tue, 31 May 2022 18:23:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA6C4C0039;
	Tue, 31 May 2022 18:23:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F4180C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4A9061290
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oE9NjsCvX11K for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 18:23:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id E861C6128D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 18:23:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3012523A;
 Tue, 31 May 2022 11:23:56 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D3183F766;
 Tue, 31 May 2022 11:23:54 -0700 (PDT)
Message-ID: <8a86ff8b-ea16-4004-82e4-d20e46501c75@arm.com>
Date: Tue, 31 May 2022 19:23:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 01/10] dmapool: remove checks for dev == NULL
Content-Language: en-GB
To: Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <7f6f9ff5-cdb9-e386-988d-fa013538dee7@cybernetics.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7f6f9ff5-cdb9-e386-988d-fa013538dee7@cybernetics.com>
Cc: Tony Lindgren <tony@atomide.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, iommu@lists.linux-foundation.org,
 Keith Busch <kbusch@kernel.org>, kernel-team@fb.com
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

On 2022-05-31 19:12, Tony Battersby wrote:
> dmapool originally tried to support pools without a device because
> dma_alloc_coherent() supports allocations without a device.  But nobody
> ended up using dma pools without a device, so the current checks in
> dmapool.c for pool->dev == NULL are both insufficient and causing bloat.
> Remove them.

Furthermore, dma_pool_create() already dereferences the dev argument 
unconditionally, so there's no way we could possibly get as far as these 
checks even if a caller did ever pass NULL.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
> ---
>   mm/dmapool.c | 42 +++++++++++-------------------------------
>   1 file changed, 11 insertions(+), 31 deletions(-)
> 
> diff --git a/mm/dmapool.c b/mm/dmapool.c
> index a7eb5d0eb2da..0f89de408cbe 100644
> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
> @@ -275,7 +275,7 @@ void dma_pool_destroy(struct dma_pool *pool)
>   	mutex_lock(&pools_reg_lock);
>   	mutex_lock(&pools_lock);
>   	list_del(&pool->pools);
> -	if (pool->dev && list_empty(&pool->dev->dma_pools))
> +	if (list_empty(&pool->dev->dma_pools))
>   		empty = true;
>   	mutex_unlock(&pools_lock);
>   	if (empty)
> @@ -284,12 +284,8 @@ void dma_pool_destroy(struct dma_pool *pool)
>   
>   	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
>   		if (is_page_busy(page)) {
> -			if (pool->dev)
> -				dev_err(pool->dev, "%s %s, %p busy\n", __func__,
> -					pool->name, page->vaddr);
> -			else
> -				pr_err("%s %s, %p busy\n", __func__,
> -				       pool->name, page->vaddr);
> +			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
> +				pool->name, page->vaddr);
>   			/* leak the still-in-use consistent memory */
>   			list_del(&page->page_list);
>   			kfree(page);
> @@ -351,12 +347,8 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
>   		for (i = sizeof(page->offset); i < pool->size; i++) {
>   			if (data[i] == POOL_POISON_FREED)
>   				continue;
> -			if (pool->dev)
> -				dev_err(pool->dev, "%s %s, %p (corrupted)\n",
> -					__func__, pool->name, retval);
> -			else
> -				pr_err("%s %s, %p (corrupted)\n",
> -					__func__, pool->name, retval);
> +			dev_err(pool->dev, "%s %s, %p (corrupted)\n",
> +				__func__, pool->name, retval);
>   
>   			/*
>   			 * Dump the first 4 bytes even if they are not
> @@ -411,12 +403,8 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
>   	page = pool_find_page(pool, dma);
>   	if (!page) {
>   		spin_unlock_irqrestore(&pool->lock, flags);
> -		if (pool->dev)
> -			dev_err(pool->dev, "%s %s, %p/%pad (bad dma)\n",
> -				__func__, pool->name, vaddr, &dma);
> -		else
> -			pr_err("%s %s, %p/%pad (bad dma)\n",
> -			       __func__, pool->name, vaddr, &dma);
> +		dev_err(pool->dev, "%s %s, %p/%pad (bad dma)\n",
> +			__func__, pool->name, vaddr, &dma);
>   		return;
>   	}
>   
> @@ -426,12 +414,8 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
>   #ifdef	DMAPOOL_DEBUG
>   	if ((dma - page->dma) != offset) {
>   		spin_unlock_irqrestore(&pool->lock, flags);
> -		if (pool->dev)
> -			dev_err(pool->dev, "%s %s, %p (bad vaddr)/%pad\n",
> -				__func__, pool->name, vaddr, &dma);
> -		else
> -			pr_err("%s %s, %p (bad vaddr)/%pad\n",
> -			       __func__, pool->name, vaddr, &dma);
> +		dev_err(pool->dev, "%s %s, %p (bad vaddr)/%pad\n",
> +			__func__, pool->name, vaddr, &dma);
>   		return;
>   	}
>   	{
> @@ -442,12 +426,8 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
>   				continue;
>   			}
>   			spin_unlock_irqrestore(&pool->lock, flags);
> -			if (pool->dev)
> -				dev_err(pool->dev, "%s %s, dma %pad already free\n",
> -					__func__, pool->name, &dma);
> -			else
> -				pr_err("%s %s, dma %pad already free\n",
> -				       __func__, pool->name, &dma);
> +			dev_err(pool->dev, "%s %s, dma %pad already free\n",
> +				__func__, pool->name, &dma);
>   			return;
>   		}
>   	}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
