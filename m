Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D4DC433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 19:55:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFC3611CA
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 19:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADFC3611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74E8480D92;
	Tue, 19 Oct 2021 19:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bnE1T6BNsgkc; Tue, 19 Oct 2021 19:54:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4FB2680D82;
	Tue, 19 Oct 2021 19:54:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26C8EC0011;
	Tue, 19 Oct 2021 19:54:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A2BFC000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 19:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4AF42401FA
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 19:54:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0nA4jFuz8eSk for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 19:54:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B66F400E7
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 19:54:56 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id j190so13629762pgd.0
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :mime-version; bh=A+EPnMRUGrF6Vs71If9DkzpAJR3LQtSXNsDxyesNnEs=;
 b=dH7oAZrQH1ZCuu/9CrSS/NmdpotodTMaNbqjmGjHuzE7UCGimCH5Cvpo9gmhTA+J1H
 S+jCxywty2QnJe7SUiOy7YHHyZCrLrqaMopVURvAZrGI83wMHhBnsvSwI3ubTDzEaTbb
 xdGwHKLNfzU22dckWjopostqjU/Nst2NNW30S65/VaIp/m3b83Vf8DK2M7J81VLDPpcH
 EE8eisSvHkz7eHVECB+mnfOVVE0l5vqRYP9l7slcmMhmiVS9Kgowr6rTZuTq1CVJnY1s
 JLlm1gOxCfAR58dGKr4SgWR+itcDRXnYgIc2FFDkogEawgCF7cdgzkuAozyxLcmbrrwu
 f+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:mime-version;
 bh=A+EPnMRUGrF6Vs71If9DkzpAJR3LQtSXNsDxyesNnEs=;
 b=8SYftDD4XI4DpyEsFDlNKo+qBocZKc8Y9zizkuID+sA64LYrj4W5Go353lxcqmLMBM
 ERHWSmTc/7H4F5ptTg1zvEm5xYVIiuoo6beFzGDTyrKimaK+4+hY4k0iHq0S2GApvnOx
 UOVvjtbrgPiLVzs5jq6PAAkeayGXiDDTACNl+nzq3AyNcLVScIp6hYkNrNMH9QLx103a
 ApwQW0Xq4UndGj4q2jOLLdNxelFulRJNvUaAKHVWfaPYOw02/1gx4oMN+qVAiuwCCBfj
 SaGSqv8eHW2gr9o5SJ2LQbUuTdGO1zZuezAHoY5Z/w40pOltcthGeLEQcpwyBP89U4Js
 /RNw==
X-Gm-Message-State: AOAM533PhfSVxfTcRrOLOJiO1mdyC0uxpFClew2TJYO1Jr1ZWF8lP6q6
 NlNC2WY+LidhxBxtA2fcqGp0bf7nE8HkNQ==
X-Google-Smtp-Source: ABdhPJzEMMbxlghxvH6MzZsmzAhMrkUWi8tOx7xGKYVwhEasnjbJFX/xac/FXE2IOVoP924lt9wbIg==
X-Received: by 2002:a62:1596:0:b0:44c:f7b3:df74 with SMTP id
 144-20020a621596000000b0044cf7b3df74mr1900333pfv.60.1634673295453; 
 Tue, 19 Oct 2021 12:54:55 -0700 (PDT)
Received: from [2620:15c:17:3:346:b4cf:84da:678d]
 ([2620:15c:17:3:346:b4cf:84da:678d])
 by smtp.gmail.com with ESMTPSA id y1sm54149pfo.104.2021.10.19.12.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 12:54:54 -0700 (PDT)
Date: Tue, 19 Oct 2021 12:54:54 -0700 (PDT)
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/4] dma-direct: factor out dma_set_{de,en}crypted helpers
In-Reply-To: <20211019122916.2468032-2-hch@lst.de>
Message-ID: <b63b1097-9110-5474-9754-a12be7dc1f4f@google.com>
References: <20211019122916.2468032-1-hch@lst.de>
 <20211019122916.2468032-2-hch@lst.de>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 19 Oct 2021, Christoph Hellwig wrote:

> Factor out helpers the make dealing with memory encryption a little less
> cumbersome.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/direct.c | 55 +++++++++++++++++++++------------------------
>  1 file changed, 25 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4c6c5e0635e34..96f02248e7fa2 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -75,6 +75,20 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>  		min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
>  }
>  
> +static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
> +{
> +	if (!force_dma_unencrypted(dev))
> +		return 0;
> +	return set_memory_decrypted((unsigned long)vaddr, 1 << get_order(size));
> +}
> +
> +static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
> +{
> +	if (!force_dma_unencrypted(dev))
> +		return 0;
> +	return set_memory_encrypted((unsigned long)vaddr, 1 << get_order(size));
> +}
> +
>  static void __dma_direct_free_pages(struct device *dev, struct page *page,
>  				    size_t size)
>  {
> @@ -216,12 +230,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  				__builtin_return_address(0));
>  		if (!ret)
>  			goto out_free_pages;
> -		if (force_dma_unencrypted(dev)) {
> -			err = set_memory_decrypted((unsigned long)ret,
> -						   1 << get_order(size));
> -			if (err)
> -				goto out_free_pages;
> -		}
> +		err = dma_set_decrypted(dev, ret, size);

Should be

	if (dma_set_decrypted(dev, ret, size))
		goto out_free_pages;

?  Otherwise we ignore the value?

>  		memset(ret, 0, size);
>  		goto done;
>  	}
> @@ -238,13 +247,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	}
>  
>  	ret = page_address(page);
> -	if (force_dma_unencrypted(dev)) {
> -		err = set_memory_decrypted((unsigned long)ret,
> -					   1 << get_order(size));
> -		if (err)
> -			goto out_free_pages;
> -	}
> -
> +	err = dma_set_decrypted(dev, ret, size);
> +	if (err)
> +		goto out_free_pages;
>  	memset(ret, 0, size);
>  
>  	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
> @@ -259,13 +264,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	return ret;
>  
>  out_encrypt_pages:
> -	if (force_dma_unencrypted(dev)) {
> -		err = set_memory_encrypted((unsigned long)page_address(page),
> -					   1 << get_order(size));
> -		/* If memory cannot be re-encrypted, it must be leaked */
> -		if (err)
> -			return NULL;
> -	}
> +	/* If memory cannot be re-encrypted, it must be leaked */
> +	if (dma_set_encrypted(dev, page_address(page), size))
> +		return NULL;
>  out_free_pages:
>  	__dma_direct_free_pages(dev, page, size);
>  	return NULL;
> @@ -304,8 +305,7 @@ void dma_direct_free(struct device *dev, size_t size,
>  	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>  		return;
>  
> -	if (force_dma_unencrypted(dev))
> -		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
> +	dma_set_encrypted(dev, cpu_addr, 1 << page_order);
>  
>  	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr))
>  		vunmap(cpu_addr);
> @@ -341,11 +341,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	}
>  
>  	ret = page_address(page);
> -	if (force_dma_unencrypted(dev)) {
> -		if (set_memory_decrypted((unsigned long)ret,
> -				1 << get_order(size)))
> -			goto out_free_pages;
> -	}
> +	if (dma_set_decrypted(dev, ret, size))
> +		goto out_free_pages;
>  	memset(ret, 0, size);
>  	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
>  	return page;
> @@ -366,9 +363,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>  	    dma_free_from_pool(dev, vaddr, size))
>  		return;
>  
> -	if (force_dma_unencrypted(dev))
> -		set_memory_encrypted((unsigned long)vaddr, 1 << page_order);
> -
> +	dma_set_encrypted(dev, vaddr, 1 << page_order);
>  	__dma_direct_free_pages(dev, page, size);
>  }
>  
> -- 
> 2.30.2
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
