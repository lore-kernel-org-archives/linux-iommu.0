Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF89C65C
	for <iommu@lists.linux.dev>; Thu,  6 Oct 2022 07:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uaC9T1WgmnsgD70Hk5lkBN0KME5ZmaHROPjEQ1vGLNM=; b=XzUVGnBFqNbcIhqfXt04d6DYBw
	VD750ACsMJkifLeBX76PlrbK3+f97JnZPj1juahtv4ELZSicE7d7BOFL6cpMe1yrWlG0JaJz9MTTx
	5yn97N6AUa5edqSg2pp7RrtJ9/K58wEigny6HtAPCGc57EUMsKfN+B+u91d6x5bH1rjCNRcz9Ujjs
	1P3a6HTCy5q4uZ/xBQUC8WNDgunQkEJ2wjZgsxu6aXPb0PMXb5Pf9F3Drvx3M0haHFhZ0euSQRnRL
	5gdCWTgjbZ9Vrsn34C5iw8KH6pp+wtcIPkzz9ixkSpSks/kQZ2+7VPwwKqLidpukIyUmmkCWtnSuB
	b6I21XIQ==;
Received: from [2001:4bb8:180:b914:9f51:af7e:d950:bc8d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogLcO-000USl-Ou; Thu, 06 Oct 2022 07:48:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Cc: Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 2/2] ARM/dma-mapping: remove the dma_coherent member of struct dev_archdata
Date: Thu,  6 Oct 2022 09:48:24 +0200
Message-Id: <20221006074824.521457-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221006074824.521457-1-hch@lst.de>
References: <20221006074824.521457-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Since commit ae626eb97376 ("ARM/dma-mapping: use dma-direct
unconditionally") only the dma_coherent flag in struct device is used,
so remove the now write only flag in struct dev_archdata.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/device.h | 1 -
 arch/arm/mm/dma-mapping.c     | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 8754c0f5fc904..c6beb1708c64b 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -9,7 +9,6 @@ struct dev_archdata {
 #ifdef CONFIG_ARM_DMA_USE_IOMMU
 	struct dma_iommu_mapping	*mapping;
 #endif
-	unsigned int dma_coherent:1;
 	unsigned int dma_ops_setup:1;
 };
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index bfc7476f14114..f60d6b4afe5df 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1775,10 +1775,8 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	 * here, but instead have to make sure we only set but never clear it
 	 * for now.
 	 */
-	if (coherent) {
-		dev->archdata.dma_coherent = true;
+	if (coherent)
 		dev->dma_coherent = true;
-	}
 
 	/*
 	 * Don't override the dma_ops if they have already been set. Ideally
-- 
2.30.2

