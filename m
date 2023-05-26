Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F44271F3
	for <iommu@lists.linux.dev>; Fri, 26 May 2023 16:29:34 +0000 (UTC)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QSVhg0zhhz67nhP;
	Sat, 27 May 2023 00:28:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 26 May
 2023 17:29:30 +0100
Date: Fri, 26 May 2023 17:29:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig
	<hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Arnd Bergmann
	<arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Will
 Deacon" <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, "Ard
 Biesheuvel" <ardb@kernel.org>, Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>, Mark Brown
	<broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <linux-mm@kvack.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 00/15] mm, dma, arm64: Reduce ARCH_KMALLOC_MINALIGN
 to 8
Message-ID: <20230526172930.000015f8@Huawei.com>
In-Reply-To: <20230526170740.000000df@Huawei.com>
References: <20230524171904.3967031-1-catalin.marinas@arm.com>
	<20230525133138.000014b4@Huawei.com>
	<ZG9xRjpdezVr5sjx@arm.com>
	<20230526170740.000000df@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Fri, 26 May 2023 17:07:40 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 25 May 2023 15:31:34 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > On Thu, May 25, 2023 at 01:31:38PM +0100, Jonathan Cameron wrote:  
> > > On Wed, 24 May 2023 18:18:49 +0100
> > > Catalin Marinas <catalin.marinas@arm.com> wrote:    
> > > > Another version of the series reducing the kmalloc() minimum alignment
> > > > on arm64 to 8 (from 128). Other architectures can easily opt in by
> > > > defining ARCH_KMALLOC_MINALIGN as 8 and selecting
> > > > DMA_BOUNCE_UNALIGNED_KMALLOC.
> > > > 
> > > > The first 10 patches decouple ARCH_KMALLOC_MINALIGN from
> > > > ARCH_DMA_MINALIGN and, for arm64, limit the kmalloc() caches to those
> > > > aligned to the run-time probed cache_line_size(). On arm64 we gain the
> > > > kmalloc-{64,192} caches.
> > > > 
> > > > The subsequent patches (11 to 15) further reduce the kmalloc() caches to
> > > > kmalloc-{8,16,32,96} if the default swiotlb is present by bouncing small
> > > > buffers in the DMA API.    
> > > 
> > > I think IIO_DMA_MINALIGN needs to switch to ARCH_DMA_MINALIGN as well.
> > > 
> > > It's used to force static alignement of buffers with larger structures,
> > > to make them suitable for non coherent DMA, similar to your other cases.    
> > 
> > Ah, I forgot that you introduced that macro. However, at a quick grep, I
> > don't think this forced alignment always works as intended (irrespective
> > of this series). Let's take an example:
> > 
> > struct ltc2496_driverdata {
> > 	/* this must be the first member */
> > 	struct ltc2497core_driverdata common_ddata;
> > 	struct spi_device *spi;
> > 
> > 	/*
> > 	 * DMA (thus cache coherency maintenance) may require the
> > 	 * transfer buffers to live in their own cache lines.
> > 	 */
> > 	unsigned char rxbuf[3] __aligned(IIO_DMA_MINALIGN);
> > 	unsigned char txbuf[3];
> > };
> > 
> > The rxbuf is aligned to IIO_DMA_MINALIGN, the structure and its size as
> > well but txbuf is at an offset of 3 bytes from the aligned
> > IIO_DMA_MINALIGN. So basically any cache maintenance on rxbuf would
> > corrupt txbuf.  
> 
> That was intentional (though possibly wrong if I've misunderstood
> the underlying issue).
> 
> For SPI controllers at least my understanding was that it is safe to
> assume that they won't trample on themselves.  The driver doesn't
> touch the buffers when DMA is in flight - to do so would indeed result
> in corruption.
> 
> So whilst we could end up with the SPI master writing stale data back
> to txbuf after the transfer it will never matter (as the value is unchanged).
> Any flushes in the other direction will end up flushing both rxbuf and
> txbuf anyway which is also harmless.

Adding missing detail.  As the driver never writes txbuf whilst any DMA
is going on, the second cache evict (to flush out any lines that have
crept back into cache after the flush - and write backs - pre DMA) will
find a clean line and will drop it without writing back - thus no corruption.



> 
> > You need rxbuf to be the only resident of a
> > cache line, therefore the next member needs such alignment as well.
> > 
> > With this series and SWIOTLB enabled, however, if you try to transfer 3
> > bytes, they will be bounced, so the missing alignment won't matter much.
> >   
> 
> Only on arm64?  If the above is wrong, it might cause trouble on
> some other architectures.
> 
> As a side note spi_write_then_read() goes through a bounce buffer dance
> to avoid using dma unsafe buffers. Superficially that looks to me like it might
> now end up with an undersized buffer and hence up bouncing which rather
> defeats the point of it.  It uses SMP_CACHE_BYTES for the size.
> 
> Jonathan
> 
> 

