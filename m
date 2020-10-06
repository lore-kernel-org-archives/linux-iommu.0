Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DB6C41604
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 07:46:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8847D20789
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 07:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8847D20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E28E1857A4;
	Tue,  6 Oct 2020 07:46:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I6O8HGI5Bheo; Tue,  6 Oct 2020 07:46:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DB2DD855FF;
	Tue,  6 Oct 2020 07:46:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B02DFC07FF;
	Tue,  6 Oct 2020 07:46:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5CD3C0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 07:46:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B1B5B203A4
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 07:46:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3JClSfTzVOot for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 07:46:38 +0000 (UTC)
X-Greylist: delayed 00:16:12 by SQLgrey-1.7.6
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn
 [202.108.3.166])
 by silver.osuosl.org (Postfix) with SMTP id BF9192011B
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 07:46:37 +0000 (UTC)
Received: from unknown (HELO localhost.localdomain)([123.123.27.212])
 by sina.com with ESMTP
 id 5F7C1BC50002D0C9; Tue, 6 Oct 2020 15:24:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 99691354919565
From: Hillf Danton <hdanton@sina.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/8] dma-direct: use __GFP_ZERO in dma_direct_alloc_pages
Date: Tue,  6 Oct 2020 15:24:45 +0800
Message-Id: <20201006072445.8020-1-hdanton@sina.com>
In-Reply-To: <20200930160917.1234225-5-hch@lst.de>
References: <20200930160917.1234225-1-hch@lst.de>
MIME-Version: 1.0
Cc: Hillf Danton <hdanton@sina.com>, linux-media@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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


On Wed, 30 Sep 2020 18:09:13 Christoph Hellwig wrote:
> 
> Prepare for supporting the DMA_ATTR_NO_KERNEL_MAPPING flag in
> dma_alloc_pages.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/direct.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index b5f20781d3a96f..b5d56810130b22 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -296,9 +296,10 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
>  {
>  	struct page *page;
> -	void *ret;
>  
>  	if (dma_should_alloc_from_pool(dev, gfp, 0)) {
> +		void *ret;
> +
>  		page = dma_alloc_from_pool(dev, size, &ret, gfp,
>  				dma_coherent_ok);
>  		if (!page)
> @@ -306,7 +307,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		goto done;
>  	}
>  
> -	page = __dma_direct_alloc_pages(dev, size, gfp);
> +	page = __dma_direct_alloc_pages(dev, size, gfp | __GFP_ZERO);
>  	if (!page)
>  		return NULL;
>  	if (PageHighMem(page)) {
> @@ -320,13 +321,11 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		goto out_free_pages;
>  	}
>  
> -	ret = page_address(page);
>  	if (force_dma_unencrypted(dev)) {
> -		if (set_memory_decrypted((unsigned long)ret,
> +		if (set_memory_decrypted((unsigned long)page_address(page),
>  				1 << get_order(size)))
>  			goto out_free_pages;
>  	}
> -	memset(ret, 0, size);

Not sure this works without changes in cma_alloc().

>  done:
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>  	return page;
> -- 
> 2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
