Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566972E3B10;
	Tue, 16 Sep 2025 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758007948; cv=none; b=ERiZOHycm8EQ02rD6BujWGaYj71AR+1rAp0ikCZHAvt3deXT3mknkoR4qo7lu3DI26+kny5ZoIVZA/B/o+tQdVx9kYeMB9nU7o81SJ3McQ66fsIO4Hh9teZI33FWMLu6PH6lea8DIFXQGkZK/y6Kn8lQ4p57Imwf9tmttPd27vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758007948; c=relaxed/simple;
	bh=SVYxxrO+Wiw9QRhQmJDc9G1iV7Y+Q+GC+uaaZIVFlE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWV77UOdpdBq/mkJ8xWqMBDeOeOjllny50m8D3ihr7HQmY06/9T1IwyXyqKQYI8nLti7V5pSAg9B6PFQFMLExvNTti7vZ7oCqVl/PD07CVzi0qFZpiCgB9II1V1TaSS5Vo3yGMhrOKOz7/TqoJfTsQepEMnnPHPP19LnD1HJq3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5l/YYnG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5l/YYnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F654C4CEF9;
	Tue, 16 Sep 2025 07:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758007946;
	bh=SVYxxrO+Wiw9QRhQmJDc9G1iV7Y+Q+GC+uaaZIVFlE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5l/YYnGeY5KmQe4DG4hjF78LVZ8OXOQ+pB82BBUmJn6edzLHgSuj2CWbR9tHQxuz
	 V+i2NLz/v8SB/2m9fmgh7Aayf1tH00ZDyW2uEyAVSZYOm01e1H2+8efBN6AHWQoxx+
	 cFMIiv6Uh4+Xl2Gd0lgkakm1LudKj5e8guvsK2h+fFY3lMpaM+oT5lVnMCPWb0ALfC
	 1KJroWeewgWN9weAh82UzGzikEEJFZFkZGjEoumsterOmHtgbHTVHFvm9ZGc1NjzEk
	 pJ3YP3SnB0PUJUy+TNkIYziVcZGcUIh2xoe3przgP0AhnQXr0IRZnYGJbOcMWn3vS4
	 SZgbnZULDbOuw==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 2/4] dma-mapping: convert dummy ops to physical address mapping
Date: Tue, 16 Sep 2025 10:32:05 +0300
Message-ID: <3b54fbe896086adc0f3fb90a2a1a2e3bb3ff9de4.1758006942.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758006942.git.leon@kernel.org>
References: <cover.1758006942.git.leon@kernel.org>
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
index 92de80e5b057e..16a51736a2a39 100644
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
+	 * Dummy ops doesn't support map_phys, so unmap_page should never be
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
2.51.0

