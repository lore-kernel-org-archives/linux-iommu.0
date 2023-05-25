Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDF0156E7
	for <iommu@lists.linux.dev>; Thu, 25 May 2023 14:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9805DC433EF;
	Thu, 25 May 2023 14:31:37 +0000 (UTC)
Date: Thu, 25 May 2023 15:31:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 00/15] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN to
 8
Message-ID: <ZG9xRjpdezVr5sjx@arm.com>
References: <20230524171904.3967031-1-catalin.marinas@arm.com>
 <20230525133138.000014b4@Huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525133138.000014b4@Huawei.com>

On Thu, May 25, 2023 at 01:31:38PM +0100, Jonathan Cameron wrote:
> On Wed, 24 May 2023 18:18:49 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Another version of the series reducing the kmalloc() minimum alignment
> > on arm64 to 8 (from 128). Other architectures can easily opt in by
> > defining ARCH_KMALLOC_MINALIGN as 8 and selecting
> > DMA_BOUNCE_UNALIGNED_KMALLOC.
> > 
> > The first 10 patches decouple ARCH_KMALLOC_MINALIGN from
> > ARCH_DMA_MINALIGN and, for arm64, limit the kmalloc() caches to those
> > aligned to the run-time probed cache_line_size(). On arm64 we gain the
> > kmalloc-{64,192} caches.
> > 
> > The subsequent patches (11 to 15) further reduce the kmalloc() caches to
> > kmalloc-{8,16,32,96} if the default swiotlb is present by bouncing small
> > buffers in the DMA API.
> 
> I think IIO_DMA_MINALIGN needs to switch to ARCH_DMA_MINALIGN as well.
> 
> It's used to force static alignement of buffers with larger structures,
> to make them suitable for non coherent DMA, similar to your other cases.

Ah, I forgot that you introduced that macro. However, at a quick grep, I
don't think this forced alignment always works as intended (irrespective
of this series). Let's take an example:

struct ltc2496_driverdata {
	/* this must be the first member */
	struct ltc2497core_driverdata common_ddata;
	struct spi_device *spi;

	/*
	 * DMA (thus cache coherency maintenance) may require the
	 * transfer buffers to live in their own cache lines.
	 */
	unsigned char rxbuf[3] __aligned(IIO_DMA_MINALIGN);
	unsigned char txbuf[3];
};

The rxbuf is aligned to IIO_DMA_MINALIGN, the structure and its size as
well but txbuf is at an offset of 3 bytes from the aligned
IIO_DMA_MINALIGN. So basically any cache maintenance on rxbuf would
corrupt txbuf. You need rxbuf to be the only resident of a
cache line, therefore the next member needs such alignment as well.

With this series and SWIOTLB enabled, however, if you try to transfer 3
bytes, they will be bounced, so the missing alignment won't matter much.

-- 
Catalin
