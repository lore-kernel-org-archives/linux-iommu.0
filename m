Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5995BA3F;
	Sun, 21 Jul 2024 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721548162; cv=none; b=bhz9dJgD1I/Gpdyh52aAo0jtMnqQkPQzzTut7U3oIkmgatci249wi5hzvL7z43kvnYnBgQt9wbsyktlaw5D8/zbUavyqN5lhLFjPiaNXvL5Nkc/5tUXl4woGJ3RkZQCSR1IFuceLrnUEmWX0+S8k/AkQsxcdgJefqcOMS/F4oVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721548162; c=relaxed/simple;
	bh=5Z19JHFET8ZrHz0xwjTTuC4gqk1oHKwhYiNj2IYN5hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHVTP3xL28DY1GIKQn3uHISs4YAmI0AiLO/Lfn4oBI3nT202uYl1um5HBjEhaPGMh4L9okNT8p2iSE9EHHeMEuHwZ5SGoqlUBjEZ9g5piHzbCnHb6RbT8O+H7srJGkqWX7ImFq2j8hFvl0QJ7MzDIeLQpCdrzX5fCIiUQQdDWXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMpILDh1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMpILDh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B3BC4AF0D;
	Sun, 21 Jul 2024 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721548162;
	bh=5Z19JHFET8ZrHz0xwjTTuC4gqk1oHKwhYiNj2IYN5hQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMpILDh1Jc9r9nnn8tFjUYlztpFtg4HarQ5ZnDsR5uaWrba4lh3j6xv1GUPc3ejvY
	 QvLNZVFzL7PL3vELeFotYaTgggSG4C1FkH78nI9stfN1Gplz4xsAiEoouE8tg95hr5
	 KjgXf9Dc5aU4Skq0qvTV9xz1jumUcBY9eS+SLHu8//voy9T8fkIJJAK0gsJBBAgaZ4
	 QDOwb+vPm5Sv97V+eJkXBmjIXPefCD/j88mTUd1I+CZcK7n5Yl50GgddUaU4ne8vi2
	 VU+FFAXBcAXpn8UAismqtEBxuMJSlesKAs93rgAfLp+xOXjSg9akNA47Qn+mv3CZnu
	 BXAVkkTkvaUfg==
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 1/2] dma: call unconditionally to unmap_page and unmap_sg callbacks
Date: Sun, 21 Jul 2024 10:49:10 +0300
Message-ID: <e3b08c7d8e2cf7f67b6aec9a98d296ee9af56066.1721547902.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721547902.git.leon@kernel.org>
References: <cover.1721547902.git.leon@kernel.org>
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
is dummy DMA ops interface, while the use of this interface is to fail
the operation. In such case, there won't be any call to ->unmap_page()/unmap_sg()
at all.

This patch removes the existence checks of ->unmap_page()/unmap_sg()
and calls to it directly to create symmetrical interface to
->map_page()/map_sg().

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/dummy.c   | 23 +++++++++++++++++++++++
 kernel/dma/mapping.c |  4 ++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/dummy.c b/kernel/dma/dummy.c
index b492d59ac77e..842deabae667 100644
--- a/kernel/dma/dummy.c
+++ b/kernel/dma/dummy.c
@@ -18,6 +18,17 @@ static dma_addr_t dma_dummy_map_page(struct device *dev, struct page *page,
 	return DMA_MAPPING_ERROR;
 }
 
+static void dma_dummy_unmap_page(struct device *dev, dma_addr_t dma_handle,
+				 size_t size, enum dma_data_direction dir,
+				 unsigned long attrs)
+{
+	/*
+	 * Dummy ops doesn't support map_page, so unmap_page should never be
+	 * called.
+	 */
+	WARN_ON_ONCE(true);
+}
+
 static int dma_dummy_map_sg(struct device *dev, struct scatterlist *sgl,
 		int nelems, enum dma_data_direction dir,
 		unsigned long attrs)
@@ -25,6 +36,16 @@ static int dma_dummy_map_sg(struct device *dev, struct scatterlist *sgl,
 	return -EINVAL;
 }
 
+static void dma_dummy_unmap_sg(struct device *dev, struct scatterlist *sgl,
+			       int nelems, enum dma_data_direction dir,
+			       unsigned long attrs)
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
@@ -33,6 +54,8 @@ static int dma_dummy_supported(struct device *hwdev, u64 mask)
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

