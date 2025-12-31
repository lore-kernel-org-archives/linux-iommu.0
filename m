Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6326CE04
	for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767192044; cv=none; b=L+NFIDDsdvXb5PxIt933ByrAop4b/P3M2ErNLKsfOYcy/yfwpwtjDvyuSyXnHB26Qhvg07jt40YLmvLWFJ4xdkEAw8XdJ1Q+wjttBlcW2l2/dqJVFhIAFgzKIixXUz+cC9NlC4N1xKRMqQW2ndleMM9PiatEZKlUkdIYTfPWxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767192044; c=relaxed/simple;
	bh=uCJpKbQgK1JDZeWrhG0sD4sWy8cW8kDi8pCaSJxqzWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XnRn1bmc6ui9Q64xSbU+NFxUmlnra8bhT92vgMPgsLE9xeaNhdHK8I7vOgC8VVyjFG03Wb7TnbbpZGvLTuZ4keFw3VVtLItRLSK9bdU5cXngpPTv9Pmt8/XsZ0HoHinSFzliB9rMTXPsx0D44fxAD3IofSgai6nqMYvJChCBS1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDERpxxv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDERpxxv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767192041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0eNh1PwPkp66fDhwYL8c44iVldZ6MxzxhBv6XJLUek=;
	b=HDERpxxvpZ16olNTd6QLpq73Awqnw5dRWTOR76RV1UuLBRgsws7CIsIblbN4ZEpQaRgAkW
	MefHiem0jiigZlMiGVM8zhbdO6Mxt7Ov+lsmR4cdkv7MEJB7ZX6RC+ZW2yZ4CQuEsSnjRF
	SOX+ElHtx1Hc5HAnT4gOSpMlO/YCH3I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-iNktQz01N362Hn58CMFRBA-1; Wed, 31 Dec 2025 09:40:40 -0500
X-MC-Unique: iNktQz01N362Hn58CMFRBA-1
X-Mimecast-MFC-AGG-ID: iNktQz01N362Hn58CMFRBA_1767192039
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4775d110fabso93392445e9.1
        for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 06:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767192039; x=1767796839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0eNh1PwPkp66fDhwYL8c44iVldZ6MxzxhBv6XJLUek=;
        b=UkYxdJAlfqHpJrQg/vbDr9+Ao2BCXUNDvBIwS7soL2N364vS7UTTxEVJhtTozR5v/Z
         FhgH/CnOl+Nuscuz942yCySWot/8hocfU96NeFDdZxZ7n4jHEs7oX/V21jV6U8EvSQZ9
         AosXo6UzZW8UVx/3qRkKXs1T2oeiF6Xei785Acyz8AGNlTw6ssg0Ka55AniV3C+wIVVr
         +t50K8guFAtAsvgVOfjPWpWO1YF55WVGbPNQgXUOFvxrWEkCIXvrpmicWJ4uoWPaI5Gj
         2Wzt0iearOQ0Rh/TTSSbpKTd+Vi72yPacLgMBkk6KuSP8xABJXlWH9mdayP/GkZvZxlI
         oS+A==
X-Forwarded-Encrypted: i=1; AJvYcCXgHGM6vxzCNfFI6VUHabCm1Mn0X1fKteFlOkL5ntfeQYtpuY87jyaWIwZ0X7P7v4fUUo2k9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx49xjrntVKite2CWXdykvXWE4A/4o4OOY5Ihi3/bsHuNEVTAY4
	REPEUFQFIpkCqwqQXuU0XHT94/L4z9S0jrg9Gn7ok94Ef7cOWSmOdeLJL4V3X1twU7JzFKFlBaC
	RkbmFXuMKQX17qAixJRBCXuELlP4t+Gl/TyhQNAmLkfzhs3WeO4+1h8yu
X-Gm-Gg: AY/fxX7k+RZHXS7m3WxXe0kDILI4CYeKVO7L+TSWwzi4iC9M/P4A3seMExKVgIPvelg
	dFHevQDvGp+FdQvFJ6sLE1B1DyrxoGRzc8czHiPokdU+tcA5JOTSKbvoVo+c0Wzw4vx2pUUdLWj
	3pswlIKRZ+9U+OaME0YpAKb1/bHRSG7XUtnvurakhqdQiocfnWEWUThhlvGlQvsWQJE9A8mbKYM
	ZDgCFPKEjKW6F2ykcYg70G/0EakX8rUIfg+jU2jZ5oRj5/lzd1/kld4SC6SuxWXjvr7jF7jmkBP
	7vf/P40QTwDzzI3pr6T7BFTLc15oKJKobwDw1/Zfbhlw4tBcr80474mqQedjpAxHjBhyBKO9Hnt
	c9FZm0IcvNWIz9lKHKvumXoCF5MQs/M/UBA==
X-Received: by 2002:a05:600c:1d29:b0:477:1af2:f40a with SMTP id 5b1f17b1804b1-47d1957f946mr504015505e9.17.1767192039249;
        Wed, 31 Dec 2025 06:40:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFftjQcUwvXMCaEXUnp/nGSfuL085M1yJ9YObPox1uDg3/ci/kM4qMkiO89pT6mz04eQEDKgA==
X-Received: by 2002:a05:600c:1d29:b0:477:1af2:f40a with SMTP id 5b1f17b1804b1-47d1957f946mr504014855e9.17.1767192038655;
        Wed, 31 Dec 2025 06:40:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2724fe8sm835831745e9.1.2025.12.31.06.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 06:40:38 -0800 (PST)
Date: Wed, 31 Dec 2025 09:40:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Petr Tesarik <ptesarik@suse.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 01/13] dma-mapping: add
 __dma_from_device_align_begin/end
Message-ID: <20251231092346-mutt-send-email-mst@kernel.org>
References: <cover.1767089672.git.mst@redhat.com>
 <ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
 <20251231150159.1779b585@mordecai>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251231150159.1779b585@mordecai>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uyNeAIWHrVcO-rZ22EVi1PMKiNpUL4dR0FIrKhKPFjk_1767192039
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 31, 2025 at 03:01:59PM +0100, Petr Tesarik wrote:
> On Tue, 30 Dec 2025 05:15:46 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > When a structure contains a buffer that DMA writes to alongside fields
> > that the CPU writes to, cache line sharing between the DMA buffer and
> > CPU-written fields can cause data corruption on non-cache-coherent
> > platforms.
> > 
> > Add __dma_from_device_aligned_begin/__dma_from_device_aligned_end
> > annotations to ensure proper alignment to prevent this:
> > 
> > struct my_device {
> > 	spinlock_t lock1;
> > 	__dma_from_device_aligned_begin char dma_buffer1[16];
> > 	char dma_buffer2[16];
> > 	__dma_from_device_aligned_end spinlock_t lock2;
> > };
> > 
> > When the DMA buffer is the last field in the structure, just
> > __dma_from_device_aligned_begin is enough - the compiler's struct
> > padding protects the tail:
> > 
> > struct my_device {
> > 	spinlock_t lock;
> > 	struct mutex mlock;
> > 	__dma_from_device_aligned_begin char dma_buffer1[16];
> > 	char dma_buffer2[16];
> > };
> 
> This works, but it's a bit hard to read. Can we reuse the
> __cacheline_group_{begin, end}() macros from <linux/cache.h>?
> Something like this:
> 
> #define __dma_from_device_group_begin(GROUP)			\
> 	__cacheline_group_begin(GROUP)				\
> 	____dma_from_device_aligned
> #define __dma_from_device_group_end(GROUP)			\
> 	__cacheline_group_end(GROUP)				\
> 	____dma_from_device_aligned
> 
> And used like this (the "rxbuf" group id was chosen arbitrarily):
> 
> struct my_device {
> 	spinlock_t lock1;
> 	__dma_from_device_group_begin(rxbuf);
> 	char dma_buffer1[16];
> 	char dma_buffer2[16];
> 	__dma_from_device_group_end(rxbuf);
> 	spinlock_t lock2;
> };
> 
> Petr T

Oh, that's a clever idea!

Will do! And GROUP is optional if there's only one group in a structure.


> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/dma-mapping.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index aa36a0d1d9df..47b7de3786a1 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -703,6 +703,16 @@ static inline int dma_get_cache_alignment(void)
> >  }
> >  #endif
> >  
> > +#ifdef ARCH_HAS_DMA_MINALIGN
> > +#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
> > +#else
> > +#define ____dma_from_device_aligned
> > +#endif
> > +/* Apply to the 1st field of the DMA buffer */
> > +#define __dma_from_device_aligned_begin ____dma_from_device_aligned
> > +/* Apply to the 1st field beyond the DMA buffer */
> > +#define __dma_from_device_aligned_end ____dma_from_device_aligned
> > +
> >  static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
> >  		dma_addr_t *dma_handle, gfp_t gfp)
> >  {

