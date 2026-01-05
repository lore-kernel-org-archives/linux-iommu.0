Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB58A3314D3
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606625; cv=none; b=rQfd1+W1+G860U/6MyWKnlsJ+LrgOg8V3BXCVmPPGF65XkEQGwBfyuwSuss1v0ML3opyuSRtHbE6A9b/RpXZzd5bz4ZXCcgArQ29eNtff/jZG8NVeneEnPezXnoH45R/SdF3laj6B+HvyrMEuZXlNnjysAD1gX7HxDLRLsYVQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606625; c=relaxed/simple;
	bh=FhA8UK+chCa+pd17hZ6IOPyBbup1JCfkMRjpIxTkHNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFgKhA0keo1XSYJ4HuGgVubifyuzwXCztyT18t0LmHMO8ZWrNtJBr5WN6b0dlBPTdK9vBtdJ02ydw8nJI8+zb9NYzAOVWCTDtV4m7BTdzN1fcnZ3XiIMZkePrKc/5krrlwjR/aZHNdjv7XqzzZHorClWHTEJDzd5z8p2TVLNZ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PRa4PKQd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PRa4PKQd"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47798089d30so8992845e9.1
        for <iommu@lists.linux.dev>; Mon, 05 Jan 2026 01:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767606621; x=1768211421; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHbyaIHmldcU+eqqgyAXM9nUM8TFQGdgTiHVbrY2G0o=;
        b=PRa4PKQdjVGXv0UG2/2cZIQQKHQJHJzVgRiZp1eBADZPJU4ROn/1aEubFdOAJpJbM1
         mA0aHO0RsEc6e7e5kojTWO6tjcljqqOCSYwrQtYPSW+j4r4adz5d4acXicXGUx9MAFIa
         Jp4BJQevDhaDNbZOL6luELyT5rnGwLZ24K9XkxkbMZOyWv2xoakirYkG2Ix2Ff//qE4y
         76OZOJEk3M+PQAvscz6clVauPAPY5Vy0yLrJw4EcaxfsGeRRlpAfqylxnn5b7x6yFWQP
         Z3fSJVxePSXTbUX8PHai0QZFj2hm9aYGsUdaW7Nhun5fc3prmOrrfUmbGabZqvt0ju5R
         jonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767606621; x=1768211421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FHbyaIHmldcU+eqqgyAXM9nUM8TFQGdgTiHVbrY2G0o=;
        b=ZmR6BMIf9uERn7WaKpiYp2Yh3Q3gSL8eT+aUtDFtB033/JQCXawHePQ5xAFRLK7SpL
         FZg1I8MUmdAPkz4pQkvwgtQ6qpLd5/UNnfwCouOxaq1knR1UD/7fMpWG9FXGP4icczOV
         DEl5ZoJyxvEWhHuhG83NH03GKy2HgD3s1JB8qgpY58cBGUJkX1xJKkduZGW9AN8Ma8jV
         IDZUmV6mkHpWHsbh+tgPZ5hR5+mj8jsUjHQ05MyS5CNptRcYSx1eCi2jhRndIAP8TBi9
         wJK+EFSIQNaW6Tj/v0BI6s21NgYdtyhE51UbhKLaOiqfAxisGTx4lKoHEG/2WoEjRcBF
         BSZA==
X-Forwarded-Encrypted: i=1; AJvYcCVG7fq0/fO21xjJLSyOuXZquQcVqUR9raPgY7+1kiG+hogJla6/Fvmmi09kUrRhWBL0SAxYGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyusnwx292rjGIJNSUjce7NrjqwRarsYBroatqYK4crbqoSAnr8
	qQbjyZ4VT3Ilej71EARamfbLs/2fDvgQZkW6NE4abpAqleIkjQL+Ch8rzlYGhHBGOuA=
X-Gm-Gg: AY/fxX7cKrqUO1T3lKMSe7PbHPeP/dzFGp8RXWRVjp1pKYcSA3k2mbc9Mkgct4MtFOu
	bEj2MgCexUiu7Z7Tyq+2LjEyP3vwZywNforxoLLyzScWWvkNwjYAt+V7DQu2r7si6uVwzjakK4T
	BozuRjCdAqGwMgcUE9OaNDxMglAHJfZzkX7uByvJLuTzBex805fop7p2kGCrb4/tjE4gRtSpz3M
	7e2+0qCG64ofjxZ+bzyoBLcWNhekvAOjVjBcnbOMlgjCNsDhcfdvmIPsmkIprzHYke9M3j9+7O5
	VMsxwuDRQL+qVqUehElUDMf8Je22q6EylT58pUc+TDSrfRWc2PtXWbgP5q1xV1ipDpXa9Z5n4H5
	f1406ZpEk0NPAcd0/uUGdzhWIl3fBTi/n22ROzHPNPaogB2dBSOZU9Ou3pk98Ir75F8Ppw89u2P
	cGQzdl52LI57WDWzO0ofVlZlRRR+eqmiFsMZWCF/s4jWaFkW9oNYPVGhT8XANQ69tVseZPToTkr
	qglUtrGglVliTg=
X-Google-Smtp-Source: AGHT+IGnsRamZ5T2skVdNNSZv9niwK5H6wuQG4RJC9WMb4c0kDes0M5FONvR6OuiLsAxcMrzh8ZmXw==
X-Received: by 2002:a05:600c:1d1d:b0:477:a6f1:499d with SMTP id 5b1f17b1804b1-47d19574e09mr373374595e9.3.1767606620962;
        Mon, 05 Jan 2026 01:50:20 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7443c04csm28265855e9.1.2026.01.05.01.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:50:20 -0800 (PST)
Date: Mon, 5 Jan 2026 10:50:18 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Leon Romanovsky
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Bartosz Golaszewski
 <brgl@kernel.org>, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 03/15] dma-mapping: add DMA_ATTR_CPU_CACHE_CLEAN
Message-ID: <20260105105018.732dd009@mordecai>
In-Reply-To: <2d5d091f9d84b68ea96abd545b365dd1d00bbf48.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
	<2d5d091f9d84b68ea96abd545b365dd1d00bbf48.1767601130.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 03:23:01 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> When multiple small DMA_FROM_DEVICE or DMA_BIDIRECTIONAL buffers share a
> cacheline, and DMA_API_DEBUG is enabled, we get this warning:
> 	cacheline tracking EEXIST, overlapping mappings aren't supported.
> 
> This is because when one of the mappings is removed, while another one
> is active, CPU might write into the buffer.
> 
> Add an attribute for the driver to promise not to do this, making the
> overlapping safe, and suppressing the warning.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

LGTM. I'm not formally a reviewer, but FWIW:

Reviewed-by: Petr Tesarik <ptesarik@suse.com>

> ---
>  include/linux/dma-mapping.h | 7 +++++++
>  kernel/dma/debug.c          | 3 ++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 29ad2ce700f0..29973baa0581 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -79,6 +79,13 @@
>   */
>  #define DMA_ATTR_MMIO		(1UL << 10)
>  
> +/*
> + * DMA_ATTR_CPU_CACHE_CLEAN: Indicates the CPU will not dirty any cacheline
> + * overlapping this buffer while it is mapped for DMA. All mappings sharing
> + * a cacheline must have this attribute for this to be considered safe.
> + */
> +#define DMA_ATTR_CPU_CACHE_CLEAN	(1UL << 11)
> +
>  /*
>   * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
>   * be given to a device to use as a DMA source or target.  It is specific to a
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 138ede653de4..7e66d863d573 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -595,7 +595,8 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
>  	if (rc == -ENOMEM) {
>  		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
>  		global_disable = true;
> -	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> +	} else if (rc == -EEXIST &&
> +		   !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_CPU_CACHE_CLEAN)) &&
>  		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
>  		     is_swiotlb_active(entry->dev))) {
>  		err_printk(entry->dev, entry,

