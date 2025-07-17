Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BEF17B425
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734842; cv=none; b=X58sbUnAfWE6/3b4epjEQpW8GtWkcfDYpoOg9npo2E4Ppy/MehaCBOMIGftKHf0a+xIkUMyTQ5mSefJTFogp0O6rqmrSigV2F5djsqlHhOb2jBfswRk/mjIhuo1XNSpGrGZe2dVD/VWzpD3RjCOMSstxcbKhMBuIdTbSm4HAqxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734842; c=relaxed/simple;
	bh=EsV+/sLaEQESpKLc56tddBb8VQ+rkH35Pls7FQ7kwh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfkykebUYWOwm1WXXxT2ODQwum0qrUadIX7Jx630a+oqEX/E0yByk4ZiT8orDZLb+g/B1js55wBPzzv+R22CbBB5JyJg+M4gzIoetsbgWWWhqX6HtWjYxT24gXrSQGCYr6boTWc+c+CdOW43b+Z/YJ41I4x7t05W5mjAAkknJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hwl2cD/7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwl2cD/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70122C4CEE3;
	Thu, 17 Jul 2025 06:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752734842;
	bh=EsV+/sLaEQESpKLc56tddBb8VQ+rkH35Pls7FQ7kwh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hwl2cD/74DEWO41LXPEFQsnVo924OFDCfpiiQfzLXJVSKZ2l8y61U5QQnWQ5/zDHd
	 N3BQlui6Y0IRaFdc4hjA+rdorRZc8xDinEDb2n054vOLH0vLC09f3hbPPginCYyPpF
	 PpxqEvpeyvoHLcC4vy+BQJ+t/W1DNEvrxMmypKz4UvkMLzV2LzjDc607T6Asf1RrKW
	 c+fNcDvmaecRdh8vkSgjxpA+hQHKT8f2xJKYpCc26WnxXHiFMz59Vl4+V71QbaHobe
	 M87vtrkrNzTz+xak29c5uPv6w1ujY/2kxA+w3dPvitUGvATUcXK7uN2IOXnPeOe+z3
	 +MrhIhBenxG2w==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	iommu@lists.linux.dev
Subject: [PATCH 2/2] dma-mapping: convert dummy ops to physical address mapping
Date: Thu, 17 Jul 2025 09:47:10 +0300
Message-ID: <1b3b40bfa173f5c3eaa4c4712f16eb6922ccb849.1752734252.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752734252.git.leon@kernel.org>
References: <cover.1752734252.git.leon@kernel.org>
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

