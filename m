Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C418C433F5
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 19:56:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1533E610CC
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 19:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1533E610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF92080E60;
	Tue, 19 Oct 2021 19:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5DzczeZBieH5; Tue, 19 Oct 2021 19:56:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AE9CB80E5E;
	Tue, 19 Oct 2021 19:56:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78D37C0011;
	Tue, 19 Oct 2021 19:56:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E25D4C000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 19:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C432E608A2
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 19:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JiUQ_gpz2_f0 for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 19:56:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3871E60886
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 19:56:38 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 nn3-20020a17090b38c300b001a03bb6c4ebso775559pjb.1
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :mime-version; bh=sXaDPJTeahUYIk+CGAHtmRCz/zpDD3WrAyJEEnUMlFI=;
 b=BlyiAnlaAUF4ci8E6u/338Y+b5O0GI9BdEJTAubVXVCWyMQ5lFHHYoLnCrJOEXVXfB
 +OzHUBvfRVAySssOG1znhz29vLlq93+DGB5gBL9M6Cv4QrRw7olCPoky39sfA4MoYrT2
 h2qGMvXAzQgk43IShkSwW9lQ1miu3TA38IB/kPUQdtNrz0Qvc+QwTANaH0V5eFtqhmAh
 YiFBBYTC6xzEbGzhXugu+/5DimVGa8oNjQgEagu3aII+JphYmi0d4XJ3DdjV1+hifwd2
 /2j66rRAOVQzcqtrQ/JZ2bUXFq7CzMyRlzsfSOzxK7OzVcX8+t7J3s8K4f8GSC6WpQuL
 zGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:mime-version;
 bh=sXaDPJTeahUYIk+CGAHtmRCz/zpDD3WrAyJEEnUMlFI=;
 b=ZFKEzikICcBuNtOuKTgykadwklFlnN5dFXr6n9pYXBbGLVpivgzwvNQwzeya2VcfB6
 PglP2qauxn3PXFExaK0qxDPk4WA053ymu3FImskINtv/tOnXhwHgPeMnr4y4Uj8n/pha
 KUzjF1YrfpKqjz3urCHRCB73HB5Rk3V7AHN11/xAUETBfs2CpHMXSOfmaRNLGNpFAVxp
 QDpIg/VpC9VjHj4ORtK9FVxaWuAcM9gnNYkRgEGN1Rjo7w9hBjb7sn76pZTa3Z1m2vpj
 aDqlrOrZ40tMuqWFMfzUl9n+qo1vtK7RvbmouLUzytg7J1zH9nfd/J6qSXEez2eeHriE
 iZ7w==
X-Gm-Message-State: AOAM531W9WmzU3Ky5jyhOULh0GmZhisAqz+qIukZDbVG+zIT26l2LQcJ
 +NIZ33uelTfsBxBQsfWmM7uJh5M5BqfJ9g==
X-Google-Smtp-Source: ABdhPJyBTCMwdYMuk5KchWqNK5GBeQ2ani/tR/E80rlbOZjiuYwtC2F+MLBp7BMI2tmL/VIlHk40GQ==
X-Received: by 2002:a17:903:22c9:b0:13e:ed56:70e2 with SMTP id
 y9-20020a17090322c900b0013eed5670e2mr35122385plg.19.1634673397425; 
 Tue, 19 Oct 2021 12:56:37 -0700 (PDT)
Received: from [2620:15c:17:3:346:b4cf:84da:678d]
 ([2620:15c:17:3:346:b4cf:84da:678d])
 by smtp.gmail.com with ESMTPSA id f21sm42786pfc.203.2021.10.19.12.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 12:56:36 -0700 (PDT)
Date: Tue, 19 Oct 2021 12:56:36 -0700 (PDT)
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/4] dma-direct: leak memory that can't be re-encrypted
In-Reply-To: <20211019122916.2468032-3-hch@lst.de>
Message-ID: <c116b963-1a53-bb5a-feab-2abaee6fd86@google.com>
References: <20211019122916.2468032-1-hch@lst.de>
 <20211019122916.2468032-3-hch@lst.de>
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

> We must never unencryped memory go back into the general page pool.
> So if we fail to set it back to encrypted when freeing DMA memory, leak
> the memory insted and warn the user.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/direct.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 96f02248e7fa2..6673f7aebf787 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -264,9 +264,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	return ret;
>  
>  out_encrypt_pages:
> -	/* If memory cannot be re-encrypted, it must be leaked */
> -	if (dma_set_encrypted(dev, page_address(page), size))
> +	if (dma_set_encrypted(dev, page_address(page), size)) {
> +		pr_warn_ratelimited(
> +			"leaking DMA memory that can't be re-encrypted\n");
>  		return NULL;
> +	}
>  out_free_pages:
>  	__dma_direct_free_pages(dev, page, size);
>  	return NULL;
> @@ -305,7 +307,11 @@ void dma_direct_free(struct device *dev, size_t size,
>  	    dma_free_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
>  		return;
>  
> -	dma_set_encrypted(dev, cpu_addr, 1 << page_order);
> +	if (dma_set_encrypted(dev, cpu_addr, 1 << page_order)) {
> +		pr_warn_ratelimited(
> +			"leaking DMA memory that can't be re-encrypted\n");
> +		return;
> +	}
>  
>  	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr))
>  		vunmap(cpu_addr);
> @@ -363,7 +369,10 @@ void dma_direct_free_pages(struct device *dev, size_t size,
>  	    dma_free_from_pool(dev, vaddr, size))
>  		return;
>  
> -	dma_set_encrypted(dev, vaddr, 1 << page_order);
> +	if (dma_set_encrypted(dev, vaddr, 1 << page_order)) {
> +		pr_warn_ratelimited(
> +			"leaking DMA memory that can't be re-encrypted\n");
> +	}

Is this actually leaking the memory?

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
