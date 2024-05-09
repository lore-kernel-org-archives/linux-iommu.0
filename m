Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847314830B;
	Thu,  9 May 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240985; cv=none; b=FOVyS56dFLSGGcizZF98eSETto72Mj/6nXR79nq+DDvLFOrjqi9psqr0xMGXOy9kPD9AMGXIdnNu2CFT04QfoKqtc5o4edRKOLSw4vnTNP0NfRK1Oln1SY2yLKcqcIh9INgNVo2evxZ8o8kVoBz/3MApEHFGX6FxYJlPxSI6M2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240985; c=relaxed/simple;
	bh=XwjQRiMTAg/84BTvf/RpSGn4fZ4AJjKPZy2KIBZ5+gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3cxIR+Fe30odET9G07muf3pDnIkL0b0AITmaXeRK8biYrmYxKCDzc58TrFNrozEabtX7Jy1QIBeMVGYRMsAa9z1LajH+oLFOgJZi44PhaHffMKE/xi2BgkUM25oNwISkyRzuiQPqhqh/ML/BoJw4lVHoP0t4TUtGPgKFTU7d2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293CAC116B1;
	Thu,  9 May 2024 07:49:43 +0000 (UTC)
Date: Thu, 9 May 2024 08:49:40 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, isaacmanjarres@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Set SG_DMA_SWIOTLB flag for dma-direct
Message-ID: <ZjyAFE4Fk_r7KnDA@arm.com>
References: <20240506052955.GA4923@lst.de>
 <CABdmKX1XNTtoPTvfsJRobim8pHdDjPsKx=qVovVZDh5GEbKCfQ@mail.gmail.com>
 <20240506160244.GA16248@lst.de>
 <CABdmKX1n98+bw+1kewz=wdqq2Nbpaxao_Lx-Gq8oKGNUEP4ytQ@mail.gmail.com>
 <20240506161906.GA17237@lst.de>
 <CABdmKX3s_HnxciDA3XGM8Qj0kLY8OWENg+ifexrON4VYVbuLsA@mail.gmail.com>
 <20240507054314.GA31814@lst.de>
 <CABdmKX3PgcXaRUH3L7OV+POMiMd5L6pEF4fLXYPgfmQUNu_trg@mail.gmail.com>
 <Zju0JOx_ij1qH-34@arm.com>
 <CABdmKX3LANk-0ThrQ86ay5EnToM38gVH3oddBUnXq=9cmS0gCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdmKX3LANk-0ThrQ86ay5EnToM38gVH3oddBUnXq=9cmS0gCQ@mail.gmail.com>

On Wed, May 08, 2024 at 01:14:41PM -0700, T.J. Mercier wrote:
> On Wed, May 8, 2024 at 10:19 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, May 07, 2024 at 01:07:25PM -0700, T.J. Mercier wrote:
> > > On Mon, May 6, 2024 at 10:43 PM Christoph Hellwig <hch@lst.de> wrote:
> > > > On Mon, May 06, 2024 at 09:39:53AM -0700, T.J. Mercier wrote:
> > > > > > You should not check, you simply must handle it by doing the proper
> > > > > > DMA API based ownership management.
> > > > >
> > > > > That doesn't really work for uncached buffers.
> > > >
> > > > What uncached buffers?
> > >
> > > For example these ones:
> > > https://android.googlesource.com/kernel/common/+/refs/heads/android-mainline/drivers/dma-buf/heaps/system_heap.c#141
> > >
> > > Vendors have their own drivers that also export uncached buffers in a
> > > similar way.
[...]
> > I think in general buffer sharing with multiple dma_map_*() calls on the
> > same buffer and DMA_ATTR_SKIP_CPU_SYNC is incompatible with bouncing,
> > irrespective of the kmalloc() minalign series. If you do this for a
> > 32-bit device and one of the pages is outside the ZONE_DMA32 range,
> > you'd get a similar behaviour.
> >
> > From the kmalloc() minumum alignment perspective, it makes sense to skip
> > the bouncing if DMA_ATTR_SKIP_CPU_SYNC is passed. We also skip the
> > bouncing if the direction is DMA_TO_DEVICE or the device is fully
> > coherent.
> >
> > A completely untested patch below. It doesn't solve other problems with
> > bouncing you may have with your out of tree patches and, as Christoph
> > said, checking in your driver whether the DMA address is a swiotlb
> > buffer is completely wrong.
> 
> This is where I must be missing something. Is the main opposition that
> the *driver* is checking for swiotlb use (instead of inside the DMA
> API)?

I see the swiotlb use as some internal detail of the DMA API
implementation that should not leak outside this framework.

> Because it sounds like we agree it's a bad idea to attempt
> bouncing + DMA_ATTR_SKIP_CPU_SYNC.

It's not necessarily the DMA_ATTR_SKIP_CPU_SYNC but rather the usage
model of sharing a buffer between multiple devices. The DMA API is
mostly tailored around CPU <-> single device ownership and the bouncing
works fine. When sharing the same buffer with multiple devices, calling
dma_map_*() on a buffer can potentially create multiple copies of the
original CPU buffer. It may be fine _if_ the devices don't communicate
between themselves using such buffer, otherwise the model is broken
(sync or no sync). The additional issue with DMA_ATTR_SKIP_CPU_SYNC is
when you use it on subsequent dma_map_*() calls assuming that the sync
was already done on the first dma_map_*() call but with bouncing it's
another dma location (ignoring the Android specific patches).

I think we should prevent bouncing if DMA_ATTR_SKIP_CPU_SYNC is passed.
However, this is not sufficient with a proper use of the DMA API since
the first dma_map_*() without this attribute can still do the bouncing.
IMHO what we need is a DMA_ATTR_NO_BOUNCE or DMA_ATTR_SHARED that will
be used on the first map and potentially on subsequent calls in
combination with DMA_ATTR_SKIP_CPU_SYNC (though we could use the latter
to imply "shared"). The downside is that mapping may fail if the
coherent mask is too narrow.

Anyway, the definitive answer should come from the DMA API maintainers.

> This code looks like it almost gets there, but it'd still reach
> swiotlb_map (instead of DMA_MAPPING_ERROR) with DMA_ATTR_SKIP_CPU_SYNC
> set for force_bounce or if the dma_capable check fails.

My quick patch was mainly to ensure the kmalloc() alignment patches do
not make the situation worse.

-- 
Catalin
