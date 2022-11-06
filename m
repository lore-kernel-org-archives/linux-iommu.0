Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A6BA25
	for <iommu@lists.linux.dev>; Sun,  6 Nov 2022 22:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4456C43148;
	Sun,  6 Nov 2022 22:02:30 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ard Biesheuvel <ardb@kernel.org>,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Alasdair Kergon <agk@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Joerg Roedel <joro@8bytes.org>,
	Mark Brown <broonie@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-mm@kvack.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 11/13] crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
Date: Sun,  6 Nov 2022 22:01:41 +0000
Message-Id: <20221106220143.2129263-12-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106220143.2129263-1-catalin.marinas@arm.com>
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc()
alignment. This will ensure that the static alignment of various
structures or members of those structures( e.g. __ctx[] in struct
aead_request) is safe for DMA. Note that sizeof such structures becomes
aligned to ARCH_DMA_MINALIGN and kmalloc() will honour such alignment,
so there is no confusion for the compiler.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ard Biesheuvel <ardb@kernel.org>
---

I know Herbert NAK'ed this patch but I'm still keeping it here
temporarily, until we agree on some refactoring at the crypto code. FTR,
I don't think there's anything wrong with this patch since kmalloc()
will return ARCH_DMA_MINALIGN-aligned objects if the sizeof such objects
is a multiple of ARCH_DMA_MINALIGN (side-effect of
CRYPTO_MINALIGN_ATTR).

 include/linux/crypto.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 2324ab6f1846..654b9c355575 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -167,7 +167,7 @@
  * maintenance for non-coherent DMA (cache invalidation in particular) does not
  * affect data that may be accessed by the CPU concurrently.
  */
-#define CRYPTO_MINALIGN ARCH_KMALLOC_MINALIGN
+#define CRYPTO_MINALIGN ARCH_DMA_MINALIGN
 
 #define CRYPTO_MINALIGN_ATTR __attribute__ ((__aligned__(CRYPTO_MINALIGN)))
 
