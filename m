Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D1BA25
	for <iommu@lists.linux.dev>; Sun,  6 Nov 2022 22:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6E9C433D6;
	Sun,  6 Nov 2022 22:02:22 +0000 (UTC)
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
Subject: [PATCH v3 09/13] drivers/usb: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
Date: Sun,  6 Nov 2022 22:01:39 +0000
Message-Id: <20221106220143.2129263-10-catalin.marinas@arm.com>
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
operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
alignment.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
index fbb087b728dc..e21d8d106977 100644
--- a/drivers/usb/core/buffer.c
+++ b/drivers/usb/core/buffer.c
@@ -34,13 +34,13 @@ void __init usb_init_pool_max(void)
 {
 	/*
 	 * The pool_max values must never be smaller than
-	 * ARCH_KMALLOC_MINALIGN.
+	 * ARCH_DMA_MINALIGN.
 	 */
-	if (ARCH_KMALLOC_MINALIGN <= 32)
+	if (ARCH_DMA_MINALIGN <= 32)
 		;			/* Original value is okay */
-	else if (ARCH_KMALLOC_MINALIGN <= 64)
+	else if (ARCH_DMA_MINALIGN <= 64)
 		pool_max[0] = 64;
-	else if (ARCH_KMALLOC_MINALIGN <= 128)
+	else if (ARCH_DMA_MINALIGN <= 128)
 		pool_max[0] = 0;	/* Don't use this pool */
 	else
 		BUILD_BUG();		/* We don't allow this */
