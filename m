Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30EB175A93
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317982; cv=none; b=p0cL7V8LsEO9aW14/+2XH4CMgXaioHQoeIf9h9nMeEYyGLzA/4PiHzE1XdpTOUHYrq4OenxYlJoxDWmFolHa99nM8IrCBTH0eve4YxNVk/iTn/xYcd/+2P5f+HKaEJbMAqUNl9EgwHaPxTLedcEMK8ubZDZMdlmm60/YgFSHm9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317982; c=relaxed/simple;
	bh=Oj/7ehc0cCCCDQU/7pS4vL4fF7AXLJnL/YyNxYgW3Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEVaGulSccxCh9sSHv3LWr1nVjKuP0PGMzZ4kY9xeJND6f3rcsu1rDyEaVYbuMPUGkMCAaadKsuq90AmxY0U7lwsk5u5O3rxMNZwXVL62u5UlFxI/IGp9a2/E4DTF5TwYiyXImaxZARKhISCjx4mZN0Ou2PYaCdEa4iZe64kk0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D9Mu/2d1; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D9Mu/2d1"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cd7aab92dfso118245685a.0
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 05:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773317980; x=1773922780; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0lXptsQPO/2bR1nDOk4C8coAYtgdswQIgAW2nY2lBKk=;
        b=D9Mu/2d1rI3rO/NLHwvfL6+MnJBWcR9td1nnToy+ohlP1Jpv17K5jc/zLs5tZC3dV2
         7AyA6wxy7epVHAWeGPKEME2GTDuUrGLPxgl4V4ZGMYB5o+gCil+ut6ALpBedTS0SwWVm
         NbrOoLhw+dOXe5JMZR2CGUrO7nGHY/RxgZpuuwIPKKW7FuJh/Y2qTIMbEzutooYF66Gf
         OAzZC5DsYXrsUVg3B/Zj6UU8ESCVUXT0DB4Zfe7iRgZxxwrZlUe5Ipqixu89NGmjgUh8
         FdV4nvKbTx4BRGDh78Z2+SpCk9wQCyNYfBtG53QwIacYNx/mbYMpg8q+yoMh4QdVaY67
         GOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317980; x=1773922780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lXptsQPO/2bR1nDOk4C8coAYtgdswQIgAW2nY2lBKk=;
        b=tfdn6ODv5hYnkx3Gv+bbu5Z+OkHSzvDIpJHnWoKKYeHjR74LkqaxGntYiQ0FQxLVtL
         hkCFmby9BAZRrRuaQrdcvourP9TxTXw4oNKvFQ4JUZ9imzhcI34j1MAQ0DjfvM7A1ELd
         n/yHZAwnT9AAe51pzPxuvYnD2EJEmcF2w1yaWhPQAUnYWTeib0aRqPOMaBP8ux3kM9A9
         KtMTFVoY/94Ze1GXfcIjZfZ1tVCvN7lq55nmElAQwSyc2h8xAuShVGKo+jUjYlbzAv8O
         hhxUANjZjLnqETR3l1JbiUQBTkIlpAQximo9/ozmIym9edr+qGmshMGM7Gbrfls/mGMt
         S/uw==
X-Forwarded-Encrypted: i=1; AJvYcCUtOT84ve0rq0weUYCmT22BlB2tR5jawAPqs7QnNjiVOpQSVtq708lQGQXOfBW8Mi8t6axS/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YytZVI9dmhJKJ2hjKWd1HaAHLl2ARpFkoju1vdFIbehVLAELIRY
	qHDSwNjt1kX21BMmPR48M6BC66f4wig28pc52fIFtM3jYp3HWrFJBrWPy6Vmh4OAJ9g=
X-Gm-Gg: ATEYQzyYeY0jbnEqb+RyptbJSRtBKLwMefBKveSMOEAH5O5i21H+gT44yG260fHjB+v
	APQmIUF8X7Xr1L9KRbzHGmC33EoMgInlCTS/XrY0iUOm+xICbWV7q+HHVWgwzdoPnva+Y0B1zKa
	n7wEqfuLHJWJ7Ed/FMBBlfeV0HvnKibS2R8rH1EYFl7OTkZ0FOLDYE0MJbbDFvCniObp688YEm1
	ePZytJSnMp9OaH82qdpo/v2ERPOmqiBZ4EB9UKRDW2ZeEdEpcBfsJMOf1CKx+9CaI6d1TvB3CnG
	pRdEOoNxP6O5fwWnRc1dTM1ycodFGOyZJEdhRnGq5m/j6BPWE4+ZZQPzPSSqebHvs11QZohTv9l
	PwJBYHE4Fh2XyNodnJcZKR3pbKms9n9eP5Etq+EvNvndJwh4ckzzIHHVod2wh5V5sRuQlQrtetG
	VXXf1v7xx+2DVxoCRK5k/SJ28UVZEVgio+f7+81pGVDlhWYLqlvq3k2nut+jz4GiEemQAG3nuFo
	8XT1iKM
X-Received: by 2002:a05:620a:4041:b0:8c7:3ff0:d472 with SMTP id af79cd13be357-8cdaa7b6b03mr382866785a.15.1773317979843;
        Thu, 12 Mar 2026 05:19:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21346a0sm321675885a.34.2026.03.12.05.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:19:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0f0r-00000006esN-1WXU;
	Thu, 12 Mar 2026 09:19:37 -0300
Date: Thu, 12 Mar 2026 09:19:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Petr Tesarik <ptesarik@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev, linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 4/8] dma-mapping: Introduce DMA require coherency
 attribute
Message-ID: <20260312121937.GD1469476@ziepe.ca>
References: <20260311-dma-debug-overlap-v2-0-e00bc2ca346d@nvidia.com>
 <20260311-dma-debug-overlap-v2-4-e00bc2ca346d@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-dma-debug-overlap-v2-4-e00bc2ca346d@nvidia.com>

On Wed, Mar 11, 2026 at 09:08:47PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The mapping buffers which carry this attribute require DMA coherent system.
> This means that they can't take SWIOTLB path, can perform CPU cache overlap
> and doesn't perform cache flushing.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Documentation/core-api/dma-attributes.rst | 12 ++++++++++++
>  include/linux/dma-mapping.h               |  7 +++++++
>  include/trace/events/dma.h                |  3 ++-
>  kernel/dma/debug.c                        |  3 ++-
>  kernel/dma/mapping.c                      |  6 ++++++
>  5 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> index 48cfe86cc06d7..69d094f144c70 100644
> --- a/Documentation/core-api/dma-attributes.rst
> +++ b/Documentation/core-api/dma-attributes.rst
> @@ -163,3 +163,15 @@ data corruption.
>  
>  All mappings that share a cache line must set this attribute to suppress DMA
>  debug warnings about overlapping mappings.
> +
> +DMA_ATTR_REQUIRE_COHERENT
> +-------------------------
> +
> +The mapping buffers which carry this attribute require DMA coherent system. This means
> +that they can't take SWIOTLB path, can perform CPU cache overlap and doesn't perform
> +cache flushing.

DMA mapping requests with the DMA_ATTR_REQUIRE_COHERENT fail on any
system where SWIOTLB or cache management is required. This should only
be used to support uAPI designs that require continuous HW DMA
coherence with userspace processes, for example RDMA and DRM. At a
minimum the memory being mapped must be userspace memory from
pin_user_pages() or similar.

Drivers should consider using dma_mmap_pages() instead of this
interface when building their uAPIs, when possible.

It must never be used in an in-kernel driver that only works with
kernal memory.

> @@ -164,6 +164,9 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>  	if (WARN_ON_ONCE(!dev->dma_mask))
>  		return DMA_MAPPING_ERROR;
>  
> +	if (!dev_is_dma_coherent(dev) && (attrs & DMA_ATTR_REQUIRE_COHERENT))
> +		return DMA_MAPPING_ERROR;

This doesn't capture enough conditions.. is_swiotlb_force_bounce(),
dma_kmalloc_needs_bounce(), dma_capable(), etc all need to be blocked
too

So check it inside swiotlb_map() too, and maybe shift the above
into the existing branches:

        if (!dev_is_dma_coherent(dev) &&
            !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
                arch_sync_dma_for_device(phys, size, dir);

Jason
