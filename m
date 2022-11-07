Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ED328E8
	for <iommu@lists.linux.dev>; Mon,  7 Nov 2022 09:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFD2C433C1;
	Mon,  7 Nov 2022 09:05:07 +0000 (UTC)
Date: Mon, 7 Nov 2022 09:05:04 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 11/13] crypto: Use ARCH_DMA_MINALIGN instead of
 ARCH_KMALLOC_MINALIGN
Message-ID: <Y2jKQOG/oKGXwCaZ@arm.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <20221106220143.2129263-12-catalin.marinas@arm.com>
 <Y2hr2gbucDzOYI5S@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2hr2gbucDzOYI5S@gondor.apana.org.au>

On Mon, Nov 07, 2022 at 10:22:18AM +0800, Herbert Xu wrote:
> On Sun, Nov 06, 2022 at 10:01:41PM +0000, Catalin Marinas wrote:
> > ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
> > operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc()
> > alignment. This will ensure that the static alignment of various
> > structures or members of those structures( e.g. __ctx[] in struct
> > aead_request) is safe for DMA. Note that sizeof such structures becomes
> > aligned to ARCH_DMA_MINALIGN and kmalloc() will honour such alignment,
> > so there is no confusion for the compiler.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > ---
> > 
> > I know Herbert NAK'ed this patch but I'm still keeping it here
> > temporarily, until we agree on some refactoring at the crypto code. FTR,
> > I don't think there's anything wrong with this patch since kmalloc()
> > will return ARCH_DMA_MINALIGN-aligned objects if the sizeof such objects
> > is a multiple of ARCH_DMA_MINALIGN (side-effect of
> > CRYPTO_MINALIGN_ATTR).
> 
> As I said before changing CRYPTO_MINALIGN doesn't do anything and
> that's why this patch is broken.

Well, it does ensure that the __alignof__ and sizeof structures like
crypto_alg and aead_request is still 128 after this change. A kmalloc()
of a size multiple of 128 returns a 128-byte aligned object. So the aim
is just to keep the current binary layout/alignment to 128 on arm64. In
theory, no functional change.

Of course, there are better ways to do it but I think the crypto code
should move away from ARCH_KMALLOC_MINALIGN and use something like
dma_get_cache_alignment() instead. The cra_alignmask should be specific
to the device and typically small values (or 0 if no alignment required
by the device). The DMA alignment is specific to the SoC and CPU, so
this should be handled elsewhere.

As I don't fully understand the crypto code, I had a naive attempt at
forcing a higher alignmask but it ended up in a kernel panic:

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 2324ab6f1846..6dc84c504b52 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -13,6 +13,7 @@
 #define _LINUX_CRYPTO_H
 
 #include <linux/atomic.h>
+#include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/bug.h>
@@ -696,7 +697,7 @@ static inline unsigned int crypto_tfm_alg_blocksize(struct crypto_tfm *tfm)
 
 static inline unsigned int crypto_tfm_alg_alignmask(struct crypto_tfm *tfm)
 {
-	return tfm->__crt_alg->cra_alignmask;
+	return tfm->__crt_alg->cra_alignmask | (dma_get_cache_alignment() - 1);
 }
 
 static inline u32 crypto_tfm_get_flags(struct crypto_tfm *tfm)

-- 
Catalin
