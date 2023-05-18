Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE36182B8
	for <iommu@lists.linux.dev>; Thu, 18 May 2023 17:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10313C4339B;
	Thu, 18 May 2023 17:34:37 +0000 (UTC)
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
Subject: [PATCH v4 08/15] drivers/spi: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
Date: Thu, 18 May 2023 18:33:56 +0100
Message-Id: <20230518173403.1150549-9-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518173403.1150549-1-catalin.marinas@arm.com>
References: <20230518173403.1150549-1-catalin.marinas@arm.com>
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
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 39d94c850839..8d009275a59d 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -237,7 +237,7 @@ static int spidev_message(struct spidev_data *spidev,
 		/* Ensure that also following allocations from rx_buf/tx_buf will meet
 		 * DMA alignment requirements.
 		 */
-		unsigned int len_aligned = ALIGN(u_tmp->len, ARCH_KMALLOC_MINALIGN);
+		unsigned int len_aligned = ALIGN(u_tmp->len, ARCH_DMA_MINALIGN);
 
 		k_tmp->len = u_tmp->len;
 
