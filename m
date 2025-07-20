Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE95C12B93
	for <iommu@lists.linux.dev>; Sun, 20 Jul 2025 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753004171; cv=none; b=DhG2JI0F6NRIFI+OSKKBh3mux153ab9fcn+xzHJhCEsYFXyrDZVtJrHwIZfxu6k0uzWoTn7Jt5HptjUVahUCOC9he1jgPZQnAn7HQLpuTLzWtOk6wlwhXqt6rcMgOgfB1T/9VHIWugx9F4E6aDZpSJdXHvCSc9UeYLk9mI1L/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753004171; c=relaxed/simple;
	bh=EsV+/sLaEQESpKLc56tddBb8VQ+rkH35Pls7FQ7kwh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8N/LCcVSkELrAnWZqwEPEhyOGAGl05tRGcwlEn2US3wlGknTKyAvXCGcETGBQL9fLUJKoVQTD/MfbdAmcXNwnXj7rBE7npEoF5gbdUnCpbyQx3tB+h/KXQ34V2Hj6K6ANgPrnuFYInLanvMCYMseYnFmE1qMPupDZ9jveJ283g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+6AxK9K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+6AxK9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13F0C4CEE7;
	Sun, 20 Jul 2025 09:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753004169;
	bh=EsV+/sLaEQESpKLc56tddBb8VQ+rkH35Pls7FQ7kwh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+6AxK9KKD5SzeuOWJ8HPRilZaPIOkdOYUGkPC+bZJs1lQon0HcjKa/n1ann7u9Mg
	 AcW7bmXF2xP41ujQJhVRfAMl6UfzcS0BqlAc/bYsveYhA3AwEUUNFs0yzqzqGMxzcg
	 kwXxZ0i4tYYizlbNPBeCYgzNN5n68ZRA/+cEZMylw5Wx3hgO8E4mRtorCPheeNpkf5
	 vC7h2JkwIC9OfFNAuCPmJ1tX9LV8MyRvOHhppdze9CPHmBPFaCJ3zWz9VOlyNtpYoW
	 gv/iMIgbOAIHtAByHkVniqxhSXgjAj3Imm02NF5g5dHpkLu7W51KYWHRqz8bBx9ple
	 fEzJKRp4FvxpA==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	iommu@lists.linux.dev
Subject: [PATCH v1 2/2] dma-mapping: convert dummy ops to physical address mapping
Date: Sun, 20 Jul 2025 12:35:27 +0300
Message-ID: <b64fcf6cb746ad98e9912e6f2ae14ac2d5722c02.1753003879.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753003879.git.leon@kernel.org>
References: <cover.1753003879.git.leon@kernel.org>
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

