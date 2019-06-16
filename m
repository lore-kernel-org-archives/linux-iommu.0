Return-Path: <SRS0=mBvT=UP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A6C31E53
	for <iommu@archiver.kernel.org>; Sun, 16 Jun 2019 09:17:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B561920652
	for <iommu@archiver.kernel.org>; Sun, 16 Jun 2019 09:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhZZN4Zo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B561920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 797ADAB5;
	Sun, 16 Jun 2019 09:17:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C29612F
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 09:17:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
	[209.85.210.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C30D482F
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 09:17:29 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id 19so4010716pfa.4
	for <iommu@lists.linux-foundation.org>;
	Sun, 16 Jun 2019 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=WsOS9W6MkxWVUF6PRCv1rpiLrmIxWx7oq/nfwUHXQV4=;
	b=bhZZN4ZoB10Na0Ic8RGp22L9+faJUjyGlbtTqC3QZGcBGJuewiHIW8tipif4QS7JJa
	1nrwmgqclU0DIUK1lkjTTcUGhz54dyjqnkBu47eV2Gqxs1j6CHp1U+YLu4EAfw/CAjF1
	N4Mx0ailxADXlnEYbdKSlfJzz1zls4lLkPIdBQJTSClQ4r1iGVc+xfs0MQuBRfpvwO9k
	gu8vFQfMyie1SGDmstzys5iH9BtPM5Bh+9RYlpG24Inaj/skYMoNRLkXj6mCNXw8w51x
	eAcug1S/tqUfOOwe3BZd+VoHBqNwLp+FIOwyB1hK2SzoGYVonIeSrUcHAXxJsyxiRCAl
	RVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=WsOS9W6MkxWVUF6PRCv1rpiLrmIxWx7oq/nfwUHXQV4=;
	b=AzIfgRCzTgY3ojsrR+3vkkFBAmu23vkSYgWbNk70PcCfk0/ZuxkYDnhSfPXoYRHP70
	eXjWNEkPg4RAcHJS/01iuwNTzrYX4KeL5m/3YoOXRK+NeXbzTYTLhAP0H8R1nkPGvQGg
	6YPo19v5EN6VmD20nHw9MgQ6ZHKybwaU6dhyE3b7YRiUghu9mGXmSmE735FQI0Y0CBvV
	MyGRodSiI4Nrj7sxzvSs3baDG9NrLawftQjLmka6WtM2s8DvC81WbOcIEhjD6Qnu83Ds
	PgAo0ymbc/ZX3a7jJlbtPTGT2FIbBJJILSvHkSjYiHQME/mL/A3r0WgoW8QmCfZMCueH
	gCyg==
X-Gm-Message-State: APjAAAVyskKC2JNNyKSGqx8VnkCIcyn78OF9gnVJId6pI+DI7BnH/8wk
	6mgr/YWyzlS/DBB0fitlIMo=
X-Google-Smtp-Source: APXvYqzC4p9c3ZsPQStMlz2hbBAY7Gw8pOpqyBR6LQ5uQv6ZdwfBVqV2rU83/Y0doH7WTm6gXf728g==
X-Received: by 2002:a65:56c5:: with SMTP id w5mr43407043pgs.434.1560676649025; 
	Sun, 16 Jun 2019 02:17:29 -0700 (PDT)
Received: from localhost (g30.211-19-85.ppp.wakwak.ne.jp. [211.19.85.30])
	by smtp.gmail.com with ESMTPSA id
	q144sm10986713pfc.103.2019.06.16.02.17.27
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Sun, 16 Jun 2019 02:17:28 -0700 (PDT)
Date: Sun, 16 Jun 2019 18:17:24 +0900
From: Stafford Horne <shorne@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/7] openrisc: remove the partial DMA_ATTR_NON_CONSISTENT
	support
Message-ID: <20190616091724.GL2358@lianli.shorne-pla.net>
References: <20190614144431.21760-1-hch@lst.de>
	<20190614144431.21760-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190614144431.21760-4-hch@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Cc: Jonas Bonn <jonas@southpole.se>, linux-xtensa@linux-xtensa.org,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	linux-parisc@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
	Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	iommu@lists.linux-foundation.org, openrisc@lists.librecores.org,
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
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

On Fri, Jun 14, 2019 at 04:44:27PM +0200, Christoph Hellwig wrote:
> The openrisc DMA code supports DMA_ATTR_NON_CONSISTENT allocations, but
> does not provide a cache_sync operation.  This means any user of it
> will never be able to actually transfer cache ownership and thus cause
> coherency bugs.

The below looks good.  I am always happy to what looks like legacy copy & paste
cruft.

Acked-by: Stafford Horne <shorne@gmail.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/openrisc/kernel/dma.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
> index f79457cb3741..9f25fd0fbb5d 100644
> --- a/arch/openrisc/kernel/dma.c
> +++ b/arch/openrisc/kernel/dma.c
> @@ -98,15 +98,13 @@ arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  
>  	va = (unsigned long)page;
>  
> -	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0) {
> -		/*
> -		 * We need to iterate through the pages, clearing the dcache for
> -		 * them and setting the cache-inhibit bit.
> -		 */
> -		if (walk_page_range(va, va + size, &walk)) {
> -			free_pages_exact(page, size);
> -			return NULL;
> -		}
> +	/*
> +	 * We need to iterate through the pages, clearing the dcache for
> +	 * them and setting the cache-inhibit bit.
> +	 */
> +	if (walk_page_range(va, va + size, &walk)) {
> +		free_pages_exact(page, size);
> +		return NULL;
>  	}
>  
>  	return (void *)va;
> @@ -122,10 +120,8 @@ arch_dma_free(struct device *dev, size_t size, void *vaddr,
>  		.mm = &init_mm
>  	};
>  
> -	if ((attrs & DMA_ATTR_NON_CONSISTENT) == 0) {
> -		/* walk_page_range shouldn't be able to fail here */
> -		WARN_ON(walk_page_range(va, va + size, &walk));
> -	}
> +	/* walk_page_range shouldn't be able to fail here */
> +	WARN_ON(walk_page_range(va, va + size, &walk));
>  
>  	free_pages_exact(vaddr, size);
>  }
> -- 
> 2.20.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
