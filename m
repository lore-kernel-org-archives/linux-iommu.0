Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A178F40
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085541; cv=none; b=CscIAHKbB0gBmFcfe6XQINbH7foc1Cdz1zVvWNoBeX8Vb/EFgMx+k9k/DAM4MLcLeeBaPibcTuJ8NcvE2mmEcQeKX3ky+RK9GAedxNoY3GYodlfkA5ONidoaUvrp0H1n8RyKzevQcF3m1yoFZspPjPXghKwXrDoX0OFeDlkkCkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085541; c=relaxed/simple;
	bh=upzio2kGFiY7BDBlUw8c648KlV2ZsOsYlfXCLHKkvas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OD3NIro26B2mkVHKwGotEuLaFLZB54bXrSWS50nwGUCYGbkn1mlbDu303MsEhEzE3bZz5YrmaO/Iku5KFKW73G1g4Q5mLKztcF/czUsfFKTmP/VQjehLa7lP0Yp/BYzm5IWUDCKppHUVcA/mz3nOspGzSGe+CtNa7O44MexlvGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kdd6eJfB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kdd6eJfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A0EC4CEEF;
	Wed,  9 Jul 2025 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752085541;
	bh=upzio2kGFiY7BDBlUw8c648KlV2ZsOsYlfXCLHKkvas=;
	h=From:To:Cc:Subject:Date:From;
	b=Kdd6eJfBk97JKT4/vHp/qx10LaDBdvaFoYPma4pE6E/6ko0WJESU7HGtG+/GPpcsQ
	 hzdefZsvNdemY812DCN2gQ5RtxmcuAuM2ncsfZt6DHLSc3uti3dZqpyUcI1h9vvaEj
	 InIfbaQkrJ80rU/cBDphUawtt6YE/emFBjsUn5sEalaWG2ss5Vz4t6DIncKQcFZLij
	 pwWX9wvYN8sbGgMkRIp5vihHjwlfqVX8ZMA0/P8VY7wpTTonErn4cwgn68Bbn1P6Ef
	 widAmtpZ2LxoKZgUSLAlFLWh5ilWc5QT+bqDzHh+0vmxtCS0cR6yM6oIihOl6xGDUR
	 ZgtJp2OnzdquA==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] dma-mapping: properly calculate offset in the page
Date: Wed,  9 Jul 2025 21:25:22 +0300
Message-ID: <4f1d25f73d1a035fe5a7c9ff3818bfb0f16d3f88.1752085358.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Fix typo of offset calculation of dma_map_phys() function.
In addition, reduce scope of rarely used variables.

Fixes: ec7352735abf ("dma-mapping: export new dma_*map_phys() interface")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20250709233953.7afb7a8a@canb.auug.org.au
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/mapping.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 29e8594a725a..8d29ff76aa4d 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -156,9 +156,6 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-	struct page *page = phys_to_page(phys);
-	size_t offset = offset_in_page(page);
-	bool is_pfn_valid = true;
 	dma_addr_t addr;
 
 	BUG_ON(!valid_dma_direction(dir));
@@ -172,6 +169,10 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 	else if (use_dma_iommu(dev))
 		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
 	else {
+		struct page *page = phys_to_page(phys);
+		size_t offset = offset_in_page(phys);
+		bool is_pfn_valid = true;
+
 		if (IS_ENABLED(CONFIG_DMA_API_DEBUG))
 			is_pfn_valid = pfn_valid(PHYS_PFN(phys));
 
-- 
2.50.0

