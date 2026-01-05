Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671D32470F
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767589037; cv=none; b=ZIQrg2d7hv/EszbFp5JIeRU8pb9yW85YQhHJ20vEBtmH/RIDHmRGzkBBjuzddlkDQ4J96Mr3mZAbQXKL1TZbJ4ibnD/qtVinrraPT4ROQZb2kipLa9UwcGeRGgUBaLg8gSwoH03/C4jlQILzy/8YW5bZXRPKVVs97AxUybkXa2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767589037; c=relaxed/simple;
	bh=wdM/b8hJbUaslNLfaUyaSG8t8yHTFzri8J0kMFatf2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Acz3kkG9GWqQzyk8r5JRklfAJ3Tz1ncZ2GK2M6WHwMV2GRn8dHePukH0zzDJ8Tl3fkr1ok0ni+sefPF+clOx3yb5hfbnyJMpOdueF0nYxFLlrbe75K/jUdcEOq2JAF+G47zN3KPqesy6hsGJrW5hc+pGqM1pCVFuHtgfpaWX4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QNeRHaKq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QNeRHaKq"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso12303350a91.1
        for <iommu@lists.linux.dev>; Sun, 04 Jan 2026 20:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767589034; x=1768193834; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EOEgCzmZP0GTJHcnce/bEe96Bif2a5t1CJ7MWxViYzU=;
        b=QNeRHaKqeWuGTF7FVCNp0douRxrlUPraONKNzZqjXV2dkZzJEXixtJxHr6OQFRUgmh
         bx/2HcDjvKACwVkj9FBUpRIncffw+LTniW3FZSMe33PWbHSfZm7XjC25lphRBNlYbWxD
         SKll6lT8a56y59SB9kSgISbir3WPv6ErM66NvU2Z5hZWG+oYMoK+sQ4yvmhHh5UxVnpk
         Hg+m1kft6oMJsEdLUV0awENUDuMbnSM4rz6qDULqBYA0nahwqyEMZG1mReyxD8j725ep
         k2qcrj4QumcO7uNa5ynHkpKLzY+K6lOZ+EbStyP7oqA/O6W+jRjaxsiW3GuIiJkkLMXw
         Ueyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767589034; x=1768193834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOEgCzmZP0GTJHcnce/bEe96Bif2a5t1CJ7MWxViYzU=;
        b=uFIKc0mmNVik1/oU5m6ZFXbeHwmmCVVCwsDDJDasRLfM+y50FA+LVo3SCczdoa1ykm
         7R/LiZhvBZv0VkeDLYSgPTSywXF8pGWukU4EkKf7MsxCBaHcwW0TtLOoYicb/JkFknk4
         WLcU1ZuCZ8B81JHhcgDP0R4S2SFbP01YCXfk8E/Jnja/Ro4MF3My+KNP1AVK99zEWBBv
         Fwla3Nvdgnn45yLVlf8gEgSrpMpG22NggBUofTMpEVnbt0nIr7OaCOV3g3E7iuEpAzCS
         RzwF8T9KAyIdkK+/wWWxyreCVKFH0dsTgj/gyG7Wj0J/orEM/23ZwXoABbHPCw9g7Opy
         /P/w==
X-Forwarded-Encrypted: i=1; AJvYcCV0feoVvkaz7f37BdO+EMxQQfuywod7mLC7vPP5vAPeKFGlYczd/Pm3/q76Dzcgs1bPZglkjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIMAQhUXPqoRHYeVQEf2kuD2GNRIx3Ad774GubrfuKU74RiAsc
	c/5xQi1osDQR/hDiRz2GvhfFuCYECZ6O7q9FB71mkvyTSzbE50VnsFck37UEnOWYyv0=
X-Gm-Gg: AY/fxX5K1SOf2+vkZ4tb0+kUkpMZtQlLh+8nHcbJ0NOG+Lwubf8srQcSQauZJxva2uA
	d8KcxDIVkuWltQlU0hJQgcAnW8iDPTVX4tAx0e+NL6eZ6fGdW8SbNnjyH/fdddPZ2CC6BA3cS8B
	27ucku0ytD1BowHvwruS2FfJXTd2G+5g4VfURjOWA1e1CVqvk/a8KH5A0msfckOiasiEWl4IEMQ
	n9guedxnzD8s8JtNevWVq33I67it9d3LTBQYbClwcHwDAbUg7G7Nx6F2kmGf6gmDcwS0UEVWlBm
	BE35ZLR4cwmpsU132kgw+RAw6QMSvT4Pxx6ZLQPGnrkYtX+Kxw/1ljjlTpb1st/yFlagludJ/Ot
	Q/aqgibuccZnqdQyi0IsLYIuPQx87AuyVDgScOA8V1DzILztLxmgTIzyvHx7MhLdRdVsHUyplmA
	XFaUpUMAtmLtbQwQgISMAhxA==
X-Google-Smtp-Source: AGHT+IECK/LcBFPZYYyRh4cCx6nIWU2Vivu4V4Wo0++VXRb6DotO+ATVsJPLekWH+2yfoIoKe3qHow==
X-Received: by 2002:a17:90b:278d:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-34e921f0439mr39742351a91.35.1767589033897;
        Sun, 04 Jan 2026 20:57:13 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476ec31dsm4899585a91.3.2026.01.04.20.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 20:57:13 -0800 (PST)
Date: Mon, 5 Jan 2026 10:27:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Petr Tesarik <ptesarik@suse.com>, Leon Romanovsky <leon@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, 
	"Enrico Weigelt, metux IT consult" <info@metux.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH RFC 15/13] gpio: virtio: reorder fields to reduce struct
 padding
Message-ID: <w6to6itartzrxgapaj6dys2q3yqqoz3zetpb5bejnjb4heof2c@jkhmal3chyn2>
References: <cover.1767089672.git.mst@redhat.com>
 <55e9351282f530e2302e11497c6339c4a2e74471.1767112757.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e9351282f530e2302e11497c6339c4a2e74471.1767112757.git.mst@redhat.com>

On 30-12-25, 11:40, Michael S. Tsirkin wrote:
> Reorder struct virtio_gpio_line fields to place the DMA buffers (req/res)
> last. This eliminates the need for __dma_from_device_aligned_end padding
> after the DMA buffer, since struct tail padding naturally protects it,
> making the struct a bit smaller.
> 
> Size reduction estimation when ARCH_DMA_MINALIGN=128:
> - request is 8 bytes
> - response is 2 bytes
> - removing _end saves up to 128-6=122 bytes padding to align rxlen field
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/gpio/gpio-virtio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
