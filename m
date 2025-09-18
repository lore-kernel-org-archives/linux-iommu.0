Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34D130C61B;
	Thu, 18 Sep 2025 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204605; cv=none; b=GoukwDG2eYuz8TDUnGoYj9/MC33BFfRWdtWe9R2ANkPegqs/bf4H425b9vyQDEbYNxjRbIIRhTK/8X3E7moAsdNlymR79HLndVjqQ089anR9UdfeHCxfgau5pom4RhOX96M4gvV0GHeR9aro6PJsf9Buva4SSNK0DXWBGsn15uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204605; c=relaxed/simple;
	bh=ZvzOne7JVuKRt51UWjTla7x7wVEVuv97Aoq0lfqLgUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0Uwm/NV9I8fTUbAFKMBRSC3vQyXyTb0HM+S7NDfth3w71SMIg6yBBXc13VzwIpdM2nHbCozNXXJIUuIRGa0+7hWJU0KOn8pi1je1WTez4j0Efo+IzmWGjtjIrVQp3RhSVpfxBGROPngDsbkfI6v9XC4KhoNLaZoGOqV5C4AfYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2sUbafD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2sUbafD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01F1C4CEE7;
	Thu, 18 Sep 2025 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758204604;
	bh=ZvzOne7JVuKRt51UWjTla7x7wVEVuv97Aoq0lfqLgUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2sUbafDsMkWNheNKKvFdT0pthF4IgeoVmIjIo++piQ6FogpLWmh11dTZNVWb3Lgt
	 xVp0UuxUxSl+/XMTgvDsaAyPnd2xLvAzkXpBLbm5vCRv96x8WHPfJE+qiNWEth97mP
	 ++DZ3RgCBKBQkuqybTvt076vShyirPkNS59GSoA9yXyxPnHzGJEzNG8dO2TZw9CfZ8
	 X9bZOFqGSa2JOAjg4fXO6khWdhV9Kbgmm4YBoxToy/OHtelnqrqIRnZVosrpwLWJpK
	 Ujl4jM6AeazDmL80IJtF4LMtsDUun/4izas+/borBV4rJ/iv+dIbicjUwqa9UP2Va1
	 AojXJZ3AWcy9g==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	iommu@lists.linux.dev,
	Juergen Gross <jgross@suse.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Stefano Stabellini <sstabellini@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v4 2/6] dma-mapping: convert dummy ops to physical address mapping
Date: Thu, 18 Sep 2025 17:09:25 +0300
Message-ID: <9a1d5ba5f4e5c4ac1216253e35a4a6a7cb941802.1758203802.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758203802.git.leon@kernel.org>
References: <cover.1758203802.git.leon@kernel.org>
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

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

