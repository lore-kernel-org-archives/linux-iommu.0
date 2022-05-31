Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB32DC433F5
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 19:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AAD14191A;
	Tue, 31 May 2022 19:33:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xVTPu_WWk4no; Tue, 31 May 2022 19:33:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D9D8041913;
	Tue, 31 May 2022 19:33:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEE7DC0032;
	Tue, 31 May 2022 19:33:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9516CC002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 19:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D6FD612A2
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 19:33:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uoZP9aIkowbq for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 19:33:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 67BF660B38
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 19:33:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72B3723A;
 Tue, 31 May 2022 12:33:29 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDC683F766;
 Tue, 31 May 2022 12:33:27 -0700 (PDT)
Message-ID: <e5a97b61-6401-8a00-1088-5465a493a556@arm.com>
Date: Tue, 31 May 2022 20:33:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 08/10] dmapool: cleanup dma_pool_destroy
Content-Language: en-GB
To: Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <9b08ab7c-b80b-527d-9adf-7716b0868fbc@cybernetics.com>
 <30fd23ae-7035-5ce3-5643-89a5956f1e79@cybernetics.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <30fd23ae-7035-5ce3-5643-89a5956f1e79@cybernetics.com>
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

On 2022-05-31 19:22, Tony Battersby wrote:
> Remove a small amount of code duplication between dma_pool_destroy() and
> pool_free_page() in preparation for adding more code without having to
> duplicate it.  No functional changes.
> 
> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
> ---
>   mm/dmapool.c | 34 ++++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/dmapool.c b/mm/dmapool.c
> index 8749a9d7927e..58c11dcaa4e4 100644
> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
> @@ -250,14 +250,25 @@ static inline bool is_page_busy(struct dma_page *page)
>   	return page->in_use != 0;
>   }
>   
> -static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
> +static void pool_free_page(struct dma_pool *pool,
> +			   struct dma_page *page,
> +			   bool destroying_pool)
>   {
> +	void *vaddr = page->vaddr;
>   	dma_addr_t dma = page->dma;
>   
> +	if (destroying_pool && is_page_busy(page)) {
> +		dev_err(pool->dev,
> +			"dma_pool_destroy %s, %p busy\n",
> +			pool->name, vaddr);
> +		/* leak the still-in-use consistent memory */
> +	} else {
>   #ifdef	DMAPOOL_DEBUG
> -	memset(page->vaddr, POOL_POISON_FREED, pool->allocation);
> +		memset(vaddr, POOL_POISON_FREED, pool->allocation);
>   #endif
> -	dma_free_coherent(pool->dev, pool->allocation, page->vaddr, dma);
> +		dma_free_coherent(pool->dev, pool->allocation, vaddr, dma);
> +	}
> +
>   	list_del(&page->page_list);

If we're tearing down the whole pool, surely we can skip this as well? 
(Same for the second list in patch #9)

In fact I think it might make more sense to refactor in the opposite 
direction and just streamline this directly into dma_pool_destroy(), 
more like:

	list_for_each_entry_safe() {
		if (is_page_busy()) {
			dev_err();
		} else {
			dma_free_coherent();
		}
		kfree(page);
	}

>   	kfree(page);
>   }
> @@ -272,7 +283,7 @@ static void pool_free_page(struct dma_pool *pool, struct dma_page *page)
>    */
>   void dma_pool_destroy(struct dma_pool *pool)
>   {
> -	struct dma_page *page, *tmp;
> +	struct dma_page *page;

Nit: you bring this back again in patch #10, so we may as well leave the 
list_for_each_entry_safe() iterator in place until then as well, and 
save a bit of churn in this patch.

>   	bool empty = false;
>   
>   	if (unlikely(!pool))
> @@ -288,15 +299,10 @@ void dma_pool_destroy(struct dma_pool *pool)
>   		device_remove_file(pool->dev, &dev_attr_pools);
>   	mutex_unlock(&pools_reg_lock);
>   
> -	list_for_each_entry_safe(page, tmp, &pool->page_list, page_list) {
> -		if (is_page_busy(page)) {
> -			dev_err(pool->dev, "%s %s, %p busy\n", __func__,
> -				pool->name, page->vaddr);
> -			/* leak the still-in-use consistent memory */
> -			list_del(&page->page_list);
> -			kfree(page);
> -		} else
> -			pool_free_page(pool, page);
> +	while ((page = list_first_entry_or_null(&pool->page_list,
> +						struct dma_page,
> +						page_list))) {
> +		pool_free_page(pool, page, true);
>   	}
>   
>   	kfree(pool);
> @@ -469,7 +475,7 @@ void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t dma)
>   	page->offset = offset;
>   	/*
>   	 * Resist a temptation to do
> -	 *    if (!is_page_busy(page)) pool_free_page(pool, page);
> +	 *    if (!is_page_busy(page)) pool_free_page(pool, page, false);

Further to the above, even if we did retain a separate function, if an 
argument is hard-coded at the one single callsite, and the only 
reference to passing any other value is in a comment effectively saying 
"don't do this", do we really need to pretend it's an argument at all? ;)

FWIW I'd just reword the comment in more general terms, e.g. "Resist the 
temptation to free unused pages immediately..."

Thanks,
Robin.

>   	 * Better have a few empty pages hang around.
>   	 */
>   	spin_unlock_irqrestore(&pool->lock, flags);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
