Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9414B07B;
	Wed, 17 Jul 2024 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721219843; cv=none; b=JxjGiTM8+/hW2L6d4mpTHJKDaszS5Rv0RJHsGh1SFeY/8IgWrHdNi+aRB87k2bYtX/hSnH9eBLxJisRGhb4Ujs0w1yi0sYQnT8I7eBfxnW/oJVAnUjlpYSPzfhEV/3lNf+fN4wLZphI5z349F0/Y80UpL7xfoLV+c+ageVCm49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721219843; c=relaxed/simple;
	bh=UdgZiT7A9il+QprsMyU3VdpT957eeuVrd1d0/Tm9wF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoCnnJe0RbdgCCVWzedXBzFAewoGXa+/ASxI+E2okRY1ZXYJYDqoQlaTsR7I0pR+Hg/PZ+BWBpu40pWpzOg9sNiiIq6P1Hr7CUJ6Q9vYFgiSi3Tedh2AEDEuEpL1NoknFT85DldXnW762Agptxp8lu8KTzn2G90cQo3twi1OQuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9zr7XF+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9zr7XF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7029C4AF0F;
	Wed, 17 Jul 2024 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721219842;
	bh=UdgZiT7A9il+QprsMyU3VdpT957eeuVrd1d0/Tm9wF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9zr7XF+ZTHGNE7X65k38C8k9f0/i2G7y75FJ3JToLFYS7lMfsk3fzXLEySByKbfk
	 OE1R6sANlX7lyxaLz5b7qT4WSgajQ2z5/KbG1Fm7HMYyFMPewAQ777kkAgUmh0nkht
	 g38+GpAITpcJRpPVNmg0G6eYDnHT4iQlgS3OjiucQ18oxSSxt2Q7W+q4j/xYvCjGil
	 2eggFMCKI74WhNTqFHwwu743xM73p9smcfPTSaJx1x+bFf1mkcuYYZgE8mHh8Rs64y
	 c3py6bg3QZS5gtxYqtiwVowe+EWvrk39ylps0ndqk4bGUgOkTCgRG121bJBZCURex2
	 3q2lf9+NOeVcw==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 1/2] dma: call unconditionally to unmap_page and unmap_sg callbacks
Date: Wed, 17 Jul 2024 15:37:10 +0300
Message-ID: <f9f0e270c077c5a3225f114bf9f7df18a6f9693a.1721219730.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721219730.git.leon@kernel.org>
References: <cover.1721219730.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Almost all users of ->map_page()/map_sg() callbacks implement
->unmap_page()/unmap_sg() callbacks too. One user which doesn't do it,
is dummy DMA ops interface, and the use of this interface is to fail
the operation and in such case, there won't be any call to
->unmap_page()/unmap_sg().

This patch removes the existence checks of ->unmap_page()/unmap_sg()
and calls to it directly to create symmetrical interface to
->map_page()/map_sg().

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 kernel/dma/dummy.c   | 21 +++++++++++++++++++++
 kernel/dma/mapping.c |  4 ++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/dummy.c b/kernel/dma/dummy.c
index b492d59ac77e..92de80e5b057 100644
--- a/kernel/dma/dummy.c
+++ b/kernel/dma/dummy.c
@@ -17,6 +17,15 @@ static dma_addr_t dma_dummy_map_page(struct device *dev, struct page *page,
 {
 	return DMA_MAPPING_ERROR;
 }
+static void dma_dummy_unmap_page(struct device *dev, dma_addr_t dma_handle,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	/*
+	 * Dummy ops doesn't support map_page, so unmap_page should never be
+	 * called.
+	 */
+	WARN_ON_ONCE(true);
+}
 
 static int dma_dummy_map_sg(struct device *dev, struct scatterlist *sgl,
 		int nelems, enum dma_data_direction dir,
@@ -25,6 +34,16 @@ static int dma_dummy_map_sg(struct device *dev, struct scatterlist *sgl,
 	return -EINVAL;
 }
 
+static void dma_dummy_unmap_sg(struct device *dev, struct scatterlist *sgl,
+		int nelems, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	/*
+	 * Dummy ops doesn't support map_sg, so unmap_sg should never be called.
+	 */
+	WARN_ON_ONCE(true);
+}
+
 static int dma_dummy_supported(struct device *hwdev, u64 mask)
 {
 	return 0;
@@ -33,6 +52,8 @@ static int dma_dummy_supported(struct device *hwdev, u64 mask)
 const struct dma_map_ops dma_dummy_ops = {
 	.mmap                   = dma_dummy_mmap,
 	.map_page               = dma_dummy_map_page,
+	.unmap_page             = dma_dummy_unmap_page,
 	.map_sg                 = dma_dummy_map_sg,
+	.unmap_sg               = dma_dummy_unmap_sg,
 	.dma_supported          = dma_dummy_supported,
 };
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 81de84318ccc..6832fd6f0796 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -177,7 +177,7 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 	if (dma_map_direct(dev, ops) ||
 	    arch_dma_unmap_page_direct(dev, addr + size))
 		dma_direct_unmap_page(dev, addr, size, dir, attrs);
-	else if (ops->unmap_page)
+	else
 		ops->unmap_page(dev, addr, size, dir, attrs);
 	debug_dma_unmap_page(dev, addr, size, dir);
 }
@@ -291,7 +291,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 	if (dma_map_direct(dev, ops) ||
 	    arch_dma_unmap_sg_direct(dev, sg, nents))
 		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
-	else if (ops->unmap_sg)
+	else
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
 }
 EXPORT_SYMBOL(dma_unmap_sg_attrs);
-- 
2.45.2

