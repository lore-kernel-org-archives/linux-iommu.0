Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6128324B0C
	for <iommu@lists.linux.dev>; Mon,  5 Jan 2026 04:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767589006; cv=none; b=dorbO5uVxNr1PlwYJjXHuMY1tQA3P7UU45jj+cvg+3Wql1Z39Cnakl7wHKCpCor34513okdZocB+/sL7REhE8nA5cqWOum/GlIUUtWLRWkbBgVK8l4hABoRheJqsoX0HK02gEh4o3HWlFQNs/UmNNo37rmHTYqx0eYZVjDgkSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767589006; c=relaxed/simple;
	bh=jBwvhnDfidsek4dpH3nFNU7R+wPfEwm8oFGbdpxTVpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuSD/tr10xTMpsVeRK6CM+I2b80vs4KXOs4TX0lvaPUt0LpTwSWr9lxU569IU749erXbKlrkE3J+Fk2cyJwOCWaDpZnOJKAKtPxQlF0uvzh8zmOuuAHJsku0NakZva+rCyT0sBet6yV8xA81TYki3je6rcCnSSP5do43EgqJ+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oCgc1Ihs; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oCgc1Ihs"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7e2762ad850so14294247b3a.3
        for <iommu@lists.linux.dev>; Sun, 04 Jan 2026 20:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767589004; x=1768193804; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hFH3lNfVrL079RvxBKm1qFjwG/jqKdNHXIh3f8h06U=;
        b=oCgc1IhsBhBJnrwceWTMe0LuQ9Szsd0CHnYUjE66NDnzHfAjbuxfJXMWjT707SD7XX
         3KAOZR45HNsfeFhESzMAb8s4e1EyHYslXF16vDnGaVTyEMSOx33QnU6XgMHtIpxLYlHJ
         /1qHz1iJd/2/QUiD4NL02lHZePu+Au5kmAn8MZi/To7nsu8rLaMvEE55bnHbZtpgYvIR
         XxyzgPnGoxlVFrBeJr5PYq6kal6rClrh8Z+3QkL+ouH4U1IWDSU19sY0vjH5C9iingod
         lD+jE6LeaAVFxqyVpabGYOV3upzI4flq2esow+1qpZG3pazlrSrImPYX+n6GG+jWHHpi
         TnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767589004; x=1768193804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hFH3lNfVrL079RvxBKm1qFjwG/jqKdNHXIh3f8h06U=;
        b=MFqCCHOUkIi+F88rPvYDjJ+fzueJgDrwvdvuVr94U1eSg28+5W2XooDU5erJC370Zk
         u/Lcsgfbsx5WOq61W0FPVheJjRKkdQp7JbwikRaJ/KMIkRmnVdaornyh2vFNy/YeBE7K
         HhuaW/Vs140QjqBq6DMNhUpc/lm0PHFnffmE0cyOEMcc1ZndnwLr+4P4Z/54VUubD3st
         c/Al4El6d1plbvgABRn5V9n++abw5eEcAJfOmD+epIT5of0GjOszMxz/+lAJY9Uf3zA6
         mIYiSR010oU3jOVPxyZ+rYslt7jxM70YTcvURVrEd0DkEXd9NdF5lqhffpkPSo85zVV+
         ZuyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMynsxrYRCSrSZjLgQHi3bfVXhmdwPfvLD4/bD6NyF5o4OVPm6gsBCtQUoX7INFX2sRqFy1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3VlEykzSRMt2+9MXt3dRGTCS/fHXVi/Og1HXBiIMMEYFtRHDZ
	O4jeBmLD6Vf4pXkBKMOeam6KWmx7jBxiXoTwdysik8xmHennO4vb6MIJAZEB0mr6sxs=
X-Gm-Gg: AY/fxX5K5691OHNqRRVeHhqcVwI+7mkWUBXGzwbl74bOGvywLmNPSMrwkuwmtu0mdJj
	RqMHqT4BijXDCxZ3n0SSoV4tjPanQr1r1xXzHyC007GxgtuHU5KsvGSxMpTUULKqUkHXjSis0nI
	eMbmLKcA+xS27u4T20+Q2r5xwwxxzO7sgp4S7fF7K3mZx1L9gnMSMwkNTvQkKVKBHW8XJUgcd90
	ySn+9aiiX3I4Boi5WhvZs9agJnERQqg2SBvdX7XNUuh+PwFs4sgHfiNzF2tA/VCrf6UBfdjCzj+
	+GGjc0qaikw/Psl59Puhrl7Co6mLEaQAtmkWzL61Hj3m6g/jjcAZBuIpv//6Q1IWYGdyR5rsKwT
	2IjSNYfBo7EBc+5247pzoEPbACwqOmRSSMyz2gh/MrBueURVSNTBKmi6axIBO2T34/cxqatMwgz
	7h/2BhAbxai6Y=
X-Google-Smtp-Source: AGHT+IFZ00gScIfn7Z/S2C4S8PPgyPbUGX5mTMlgh0Rzf0TnKH5YXmLt4fA7cx6w6t8/JqVkxOTy2w==
X-Received: by 2002:a05:6a20:918e:b0:364:13aa:a526 with SMTP id adf61e73a8af0-376a9ce54bbmr44864432637.60.1767589003573;
        Sun, 04 Jan 2026 20:56:43 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7bd61b4csm40590900a12.18.2026.01.04.20.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 20:56:42 -0800 (PST)
Date: Mon, 5 Jan 2026 10:26:40 +0530
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
Subject: Re: [PATCH RFC 14/13] gpio: virtio: fix DMA alignment
Message-ID: <nyz6mnesozpu5u6p2mxrg37fwuj3sy7hjo2xkyepd3aybm7m52@7weoocg2pbs5>
References: <cover.1767089672.git.mst@redhat.com>
 <6f2f2a7a74141fa3ad92e001ee276c01ffe9ae49.1767112757.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f2f2a7a74141fa3ad92e001ee276c01ffe9ae49.1767112757.git.mst@redhat.com>

On 30-12-25, 11:40, Michael S. Tsirkin wrote:
> The res and ires buffers in struct virtio_gpio_line and struct
> vgpio_irq_line respectively are used for DMA_FROM_DEVICE via virtqueue_add_sgs().
> However, within these structs, even though these elements are tagged
> as ____cacheline_aligned, adjacent struct elements
> can share DMA cachelines on platforms where ARCH_DMA_MINALIGN >
> L1_CACHE_BYTES (e.g., arm64 with 128-byte DMA alignment but 64-byte
> cache lines).
> 
> The existing ____cacheline_aligned annotation aligns to L1_CACHE_BYTES
> which is now always sufficient for DMA alignment. For example,
> with L1_CACHE_BYTES = 32 and ARCH_DMA_MINALIGN = 128
>   - irq_lines[0].ires at offset 128
>   - irq_lines[1].type at offset 192
> both in same 128-byte DMA cacheline [128-256)
> 
> When the device writes to irq_lines[0].ires and the CPU concurrently
> modifies one of irq_lines[1].type/disabled/masked/queued flags,
> corruption can occur on non-cache-coherent platform.
> 
> Fix by using __dma_from_device_aligned_begin/end annotations on the
> DMA buffers. Drop ____cacheline_aligned - it's not required to isolate
> request and response, and keeping them would increase the memory cost.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/gpio/gpio-virtio.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
