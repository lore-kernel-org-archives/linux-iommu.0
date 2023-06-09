Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81EC17741
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 13:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9423C433D2;
	Fri,  9 Jun 2023 13:57:48 +0000 (UTC)
Date: Fri, 9 Jun 2023 14:57:45 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Vlastimil Babka <vbabka@suse.cz>
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
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 01/17] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from
 ARCH_DMA_MINALIGN
Message-ID: <ZIMv2SQnM+qSOI4M@arm.com>
References: <20230531154836.1366225-1-catalin.marinas@arm.com>
 <20230531154836.1366225-2-catalin.marinas@arm.com>
 <dfacd429-31c4-872f-d0ac-447abf65d0f9@suse.cz>
 <ZIMsoZp0cKWHfGwr@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIMsoZp0cKWHfGwr@arm.com>

On Fri, Jun 09, 2023 at 02:44:01PM +0100, Catalin Marinas wrote:
> On Fri, Jun 09, 2023 at 02:32:57PM +0200, Vlastimil Babka wrote:
> > On 5/31/23 17:48, Catalin Marinas wrote:
> > > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > > index 0ee20b764000..3288a1339271 100644
> > > --- a/include/linux/dma-mapping.h
> > > +++ b/include/linux/dma-mapping.h
> > > @@ -545,7 +545,7 @@ static inline int dma_set_min_align_mask(struct device *dev,
> > >  
> > >  static inline int dma_get_cache_alignment(void)
> > >  {
> > > -#ifdef ARCH_DMA_MINALIGN
> > > +#ifdef ARCH_HAS_DMA_MINALIGN
> > >  	return ARCH_DMA_MINALIGN;
> > >  #endif
> > >  	return 1;
> > > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > > index 6b3e155b70bf..50dcf9cfbf62 100644
> > > --- a/include/linux/slab.h
> > > +++ b/include/linux/slab.h
> > > @@ -235,12 +235,20 @@ void kmem_dump_obj(void *object);
> > >   * alignment larger than the alignment of a 64-bit integer.
> > >   * Setting ARCH_DMA_MINALIGN in arch headers allows that.
> > >   */
> > > -#if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
> > > +#ifdef ARCH_DMA_MINALIGN
> > > +#define ARCH_HAS_DMA_MINALIGN
> > > +#if ARCH_DMA_MINALIGN > 8 && !defined(ARCH_KMALLOC_MINALIGN)
> > >  #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
> > > -#define KMALLOC_MIN_SIZE ARCH_DMA_MINALIGN
> > > -#define KMALLOC_SHIFT_LOW ilog2(ARCH_DMA_MINALIGN)
> > > +#endif
> > >  #else
> > > +#define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
> > > +#endif
> > 
> > It seems weird to make slab.h responsible for this part, especially for
> > #define ARCH_HAS_DMA_MINALIGN, which dma-mapping.h consumes. Maybe it would
> > be difficult to do differently due to some dependency hell, but minimally I
> > don't see dma-mapping.h including slab.h so the result is
> > include-order-dependent? Maybe it's included transitively, but then it's
> > fragile and would be better to do explicitly?
> 
> True, there's a risk that it doesn't get included with some future
> header refactoring.
> 
> What about moving ARCH_DMA_MINALIGN to linux/cache.h? Alternatively, I
> could create a new linux/dma-minalign.h file but I feel since this is
> about caches, having it in cache.h makes more sense. asm/cache.h is also
> where most archs define the constant (apart from mips, sh, microblaze).

Something like this (still compiling):

diff --git a/include/linux/cache.h b/include/linux/cache.h
index 5da1bbd96154..9900d20b76c2 100644
--- a/include/linux/cache.h
+++ b/include/linux/cache.h
@@ -98,4 +98,10 @@ struct cacheline_padding {
 #define CACHELINE_PADDING(name)
 #endif
 
+#ifdef ARCH_DMA_MINALIGN
+#define ARCH_HAS_DMA_MINALIGN
+#else
+#define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
+#endif
+
 #endif /* __LINUX_CACHE_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index c41019289223..e13050eb9777 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_DMA_MAPPING_H
 #define _LINUX_DMA_MAPPING_H
 
+#include <linux/cache.h>
 #include <linux/sizes.h>
 #include <linux/string.h>
 #include <linux/device.h>
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 50dcf9cfbf62..9bdfb042d93d 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -12,6 +12,7 @@
 #ifndef _LINUX_SLAB_H
 #define	_LINUX_SLAB_H
 
+#include <linux/cache.h>
 #include <linux/gfp.h>
 #include <linux/overflow.h>
 #include <linux/types.h>
@@ -235,14 +236,10 @@ void kmem_dump_obj(void *object);
  * alignment larger than the alignment of a 64-bit integer.
  * Setting ARCH_DMA_MINALIGN in arch headers allows that.
  */
-#ifdef ARCH_DMA_MINALIGN
-#define ARCH_HAS_DMA_MINALIGN
-#if ARCH_DMA_MINALIGN > 8 && !defined(ARCH_KMALLOC_MINALIGN)
+#if defined(ARCH_HAS_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8 && \
+	!defined(ARCH_KMALLOC_MINALIGN)
 #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
 #endif
-#else
-#define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
-#endif
 
 #ifndef ARCH_KMALLOC_MINALIGN
 #define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)

-- 
Catalin
