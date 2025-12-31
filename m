Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2561215F7D
	for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767189726; cv=none; b=sSZ5D2ARMOk4PCZQ0R8Jg9mbUMXb4TrR4XTcHnlEYhgvilgTr73U9TlIPP62i2QManl1bUNkq6xtFs5QWeY+dtEykdDSOIvU2m0k6iJCHVzXg+bZo8QLHqAOOkplcBPlT+AQExk4CYZes+Llu5lKFlfXJzIOygF9sFIZY8IpAXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767189726; c=relaxed/simple;
	bh=4Hf8qGAfIDnMbElA9BV7uSYKEWjXXxN6zt+BgVtPhAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0zBUtq0TfMSltIlcqCZTDDgCHXpERwD+/pNSMYcRM19CFKYMzPzOQcJc0QulXJGV0y8SO4rG1t8/YDQ0JtBiY7HJrwygQCv7+rMHEM5wq87QmaPnNmiSODXCgUXcNF18tz6DqW4vzCeTjeSXJC/iwTib6V954TQKJ48yfo6y0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JO2JH8s2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JO2JH8s2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477985aea2bso9411965e9.3
        for <iommu@lists.linux.dev>; Wed, 31 Dec 2025 06:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767189722; x=1767794522; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF3B5IdjLDGAw+kMK0g4LlwArvDLn5Kmbe4r9Q45hmQ=;
        b=JO2JH8s2dWeb0R9yZAs+pPTaPxr6Yu6vclfDURqjgaZlziF5urfbA1td0Wv7FufnMN
         zsmj4HSfLj96+S9XL7Dr/h/SyklPAiXjuAxIvh3XjLfmea3I/ZgUrM+ljUcc4uxDyN2n
         XHXeMxIWYZPuwGrqnnODgz+WFMLQV0U/4tWA9MKDOfO/5DtbQCpXhV8fuDkm3L+B+KQl
         UBdNeJGyrn5aF8Mp01czxITNby1oNcfUxG9C7Nl0P6wIVa5v9hi0FZUiGJB7iENqFBkA
         CL/prMWgkFX0U5mWOzHnolbzsIappWie6Wq4S4x1KG0XLq+Dx+EvEQlOL5/iJRGJs/yA
         aBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767189722; x=1767794522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kF3B5IdjLDGAw+kMK0g4LlwArvDLn5Kmbe4r9Q45hmQ=;
        b=v1DR7zCQx5dxSzuina9tWELU9EYXpCE6obXozpnyDj1gPr3lHrx3CHvFoI9SdzH+NH
         bLzfxjgOeWIdOu1CMZ0HOZ+ouHqMrrhncAM29c79d9FMbjKWtb+UmTDRdrQAIyQesrOU
         L5xe5TmWu4b3hhdIOx86iQ29RZzMB67NlyPc+oNx4RrqVTvD9firQbjgtx+8RVGVDaq3
         8QNyDsTOHn5UZsd/Nxrk2hl/eo9qxbp3eYbjUqyrgFPz7tXimw5fTxZqGGgQe7PJEwF4
         nR4XVzQRX39RBdKQa/gNEJNh3w0NAKbb9LA0vFCF5AZKGRZK8USG1yZ64LdqOK+/AXcZ
         dRsw==
X-Forwarded-Encrypted: i=1; AJvYcCVaXJe+TrOE9HBbvz5OSXlhj4IKKRm7FJlC2oavkT30mr3Cwfj7WYZKaS5oz9Ohnio/RZ8ZTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvFLoNhCfS3yGoeZDnP3CFU1Gi2LB7rhPZljABEUqgvkM47DjH
	b2NrP7nu7W6jvta/3PVqnGAn4Jsa4OnBTniIuQYjS2Ucnn0fr71oBhwPmop1IDsbEnI=
X-Gm-Gg: AY/fxX7oL5Bz3VKkyXPmaN1no4vUAlDs/TWKWyaKbNYzj3T5QflvBpY8hjrLowETq+1
	YzZdQU5OG/lVM2XP8sMgGnLnIqpJT0j53JGe0IZz4+6/a6swTjbdJcxlqV+OSaF2wgR4rIjxPQX
	TvcgXIF3J1CGGUYuqfnxabiMAXEV/jCldAetcolGSOH21TPlUm1VWjGcaFn+O2Az7oagctnfDUT
	kF9ans59cKsNN8KPREmeIX5HRs8VNb6As5cfv5S3pk17qt72fhE+MfvqOTFODAZZiGTS9tSyZB+
	8qJE+elP/OsWOn1ni09MOdcqih27PTcU0Tj57U66gC6iazMBdPSBf3usgByuPjaUrFS688Jmw1J
	cvG29feZvh0PkyJ4a/GIbeCaDwwP1arHGNZ3A5J/EeeYwlC3V9sSqsaNAQXVAWV0sHCYiksaJqG
	loaqUizwUmcUNhbk+kRzThfUSo6QSQERPqx/rGGcdlz31ybP1vLtV36jQPNCCB9F/hFSM1LcW1Q
	vQP
X-Google-Smtp-Source: AGHT+IE0s0lyU5FbbMJZMjZzb/JdJphgG95YZRZrXFcSa/kp+KRPaXRAnUQjMNNmxS+JnzgO7HwnTw==
X-Received: by 2002:a05:600c:4fc6:b0:47a:94fc:d063 with SMTP id 5b1f17b1804b1-47d19538e2cmr221697055e9.1.1767189721959;
        Wed, 31 Dec 2025 06:02:01 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2ebfsm73767887f8f.40.2025.12.31.06.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 06:02:01 -0800 (PST)
Date: Wed, 31 Dec 2025 15:01:59 +0100
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
 <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 01/13] dma-mapping: add
 __dma_from_device_align_begin/end
Message-ID: <20251231150159.1779b585@mordecai>
In-Reply-To: <ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
References: <cover.1767089672.git.mst@redhat.com>
	<ca12c790f6dee2ca0e24f16c0ebf3591867ddc4a.1767089672.git.mst@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 05:15:46 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> When a structure contains a buffer that DMA writes to alongside fields
> that the CPU writes to, cache line sharing between the DMA buffer and
> CPU-written fields can cause data corruption on non-cache-coherent
> platforms.
> 
> Add __dma_from_device_aligned_begin/__dma_from_device_aligned_end
> annotations to ensure proper alignment to prevent this:
> 
> struct my_device {
> 	spinlock_t lock1;
> 	__dma_from_device_aligned_begin char dma_buffer1[16];
> 	char dma_buffer2[16];
> 	__dma_from_device_aligned_end spinlock_t lock2;
> };
> 
> When the DMA buffer is the last field in the structure, just
> __dma_from_device_aligned_begin is enough - the compiler's struct
> padding protects the tail:
> 
> struct my_device {
> 	spinlock_t lock;
> 	struct mutex mlock;
> 	__dma_from_device_aligned_begin char dma_buffer1[16];
> 	char dma_buffer2[16];
> };

This works, but it's a bit hard to read. Can we reuse the
__cacheline_group_{begin, end}() macros from <linux/cache.h>?
Something like this:

#define __dma_from_device_group_begin(GROUP)			\
	__cacheline_group_begin(GROUP)				\
	____dma_from_device_aligned
#define __dma_from_device_group_end(GROUP)			\
	__cacheline_group_end(GROUP)				\
	____dma_from_device_aligned

And used like this (the "rxbuf" group id was chosen arbitrarily):

struct my_device {
	spinlock_t lock1;
	__dma_from_device_group_begin(rxbuf);
	char dma_buffer1[16];
	char dma_buffer2[16];
	__dma_from_device_group_end(rxbuf);
	spinlock_t lock2;
};

Petr T

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/linux/dma-mapping.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index aa36a0d1d9df..47b7de3786a1 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -703,6 +703,16 @@ static inline int dma_get_cache_alignment(void)
>  }
>  #endif
>  
> +#ifdef ARCH_HAS_DMA_MINALIGN
> +#define ____dma_from_device_aligned __aligned(ARCH_DMA_MINALIGN)
> +#else
> +#define ____dma_from_device_aligned
> +#endif
> +/* Apply to the 1st field of the DMA buffer */
> +#define __dma_from_device_aligned_begin ____dma_from_device_aligned
> +/* Apply to the 1st field beyond the DMA buffer */
> +#define __dma_from_device_aligned_end ____dma_from_device_aligned
> +
>  static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp)
>  {

