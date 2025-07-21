Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393B1E835B
	for <iommu@lists.linux.dev>; Mon, 21 Jul 2025 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078817; cv=none; b=KhSrsuX0f5Mfw3K0tg7xxnfpOPWv2J78EjdiyOZURkhAUpexDPhmx0vPpA3+LRy69oRiBdy1WW9dPTqZfMeeo89oLd552GlXpK5mWV9Qyrb4EOCmesQto28qtgCyF/AqvSNtQpaDXvYpWYUkQxNdtyxieb52wJElYa+tpDVu2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078817; c=relaxed/simple;
	bh=EsV+/sLaEQESpKLc56tddBb8VQ+rkH35Pls7FQ7kwh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J60/U/juxv9GY3X5lKGyEsyag9mp4CR6VVwJmo/fXy/KwzWClbBvwRBziJyYKELonKqyGD9UJrsg9YPvOh/I1OSNwwyPJxPi9T1Pe3Twoa7Q/C1ZP+efjHxdrOpJzDKe/aBud/hF6/9KNH9CQRlTRM4GstNS6KRNQfVnFSrCHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJW13T5b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJW13T5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9214C4CEED;
	Mon, 21 Jul 2025 06:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753078816;
	bh=EsV+/sLaEQESpKLc56tddBb8VQ+rkH35Pls7FQ7kwh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJW13T5bfvckM7lb2LPBcVJu1gaMChk0fH5MsBnL4wwaUG8+L+kX7A+KZe/EfYR/K
	 ZRDKCf+hl3tEg0KRMYZjLr8XiesA6bTJWaNpd/AhMh5DOuhlS2F6Qu8yhrvXHVUosz
	 U6GwP2CUDzTWsUnH3XOPKbcznJcdhYdilg5nTsMwLuhcR2VVXdNCX89hhbq7bEJmEy
	 8RZrBDK3zGE3vzfR66F07ttRDxklD/on9TR831q+AwNg4jaPt6Q/kfAwmsA0iWdphO
	 Odb70iB/6h6vVVVg1lkzE8whXPCcBpGO8KFyMG8H5zsXPxLo1dMa36GTRnG//jfgzX
	 AELADALTJziug==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	iommu@lists.linux.dev
Subject: [PATCH v2 2/2] dma-mapping: convert dummy ops to physical address mapping
Date: Mon, 21 Jul 2025 09:19:46 +0300
Message-ID: <196844ca71ac4e9a60ebf78cd05e0b3882fd59bd.1753078569.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753078569.git.leon@kernel.org>
References: <cover.1753078569.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Change dma_dummy_map_page and dma_dummy_unmap_page routines
to accept physical address and rename them.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/dummy.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/dummy.c b/kernel/dma/dummy.c
index 92de80e5b057e..dcc4c619b1389 100644
--- a/kernel/dma/dummy.c
+++ b/kernel/dma/dummy.c
@@ -11,17 +11,16 @@ static int dma_dummy_mmap(struct device *dev, struct vm_area_struct *vma,
 	return -ENXIO;
 }
 
-static dma_addr_t dma_dummy_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
+static dma_addr_t dma_dummy_map_phys(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	return DMA_MAPPING_ERROR;
 }
-static void dma_dummy_unmap_page(struct device *dev, dma_addr_t dma_handle,
+static void dma_dummy_unmap_phys(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	/*
-	 * Dummy ops doesn't support map_page, so unmap_page should never be
+	 * Dummy ops doesn't support map_phys, so unmap_phys should never be
 	 * called.
 	 */
 	WARN_ON_ONCE(true);
@@ -51,8 +50,8 @@ static int dma_dummy_supported(struct device *hwdev, u64 mask)
 
 const struct dma_map_ops dma_dummy_ops = {
 	.mmap                   = dma_dummy_mmap,
-	.map_page               = dma_dummy_map_page,
-	.unmap_page             = dma_dummy_unmap_page,
+	.map_phys               = dma_dummy_map_phys,
+	.unmap_phys             = dma_dummy_unmap_phys,
 	.map_sg                 = dma_dummy_map_sg,
 	.unmap_sg               = dma_dummy_unmap_sg,
 	.dma_supported          = dma_dummy_supported,
-- 
2.50.1

