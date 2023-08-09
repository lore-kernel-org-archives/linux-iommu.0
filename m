Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A2D1801E
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 12:17:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 7901B66071FA;
	Wed,  9 Aug 2023 13:17:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1691583469;
	bh=xrsJr8/Wzr/bxAh467gukIAWjJA0qC+z2qCOAesp6lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eMYmzQDtJIT9UIqCa1YkXi1htwVjleAcBfQcnJFANA/Lp/NKMvB0Nnk7hF4/087PS
	 SYEcsD2dZnC6CvCGIS7FDIf9cuck8WUo3lkKNEloZG4CP9czchlB76Q65QQrkaVjYm
	 4CEM3VUPnKOa1GXaeVIHzq7Eh4s+h4RKCRGYZsVqrQHIAETR7zgINZNhqBeQTWp0sX
	 XQvvUWi/Jx+hG+AJMZHNVBevwZ+zZDFZDTNcR2cYjSp4WEnDcS7WUr7srwS+Ez2yFc
	 hwPABz+fmD7BaImhweVi7cwmFysrOjs9FGNtV9GZHIBon267sYI03lwVrPvCXDVN/O
	 fDQpyhN4+mOLA==
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Clark <robdclark@gmail.com>,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 1/2] iommu: Allow passing custom allocators to pgtable drivers
Date: Wed,  9 Aug 2023 14:17:43 +0200
Message-ID: <20230809121744.2341454-2-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809121744.2341454-1-boris.brezillon@collabora.com>
References: <20230809121744.2341454-1-boris.brezillon@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be useful for GPU drivers who want to keep page tables in a
pool so they can:

- keep freed page tables in a free pool and speed-up upcoming page
  table allocations
- batch page table allocation instead of allocating one page at a time
- pre-reserve pages for page tables needed for map/unmap operations,
  to ensure map/unmap operations don't try to allocate memory in paths
  they're allowed to block or fail

We will extend the Arm LPAE format to support custom allocators in a
separate commit.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/iommu/io-pgtable.c | 19 +++++++++++++++++++
 include/linux/io-pgtable.h | 21 +++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index b843fcd365d2..f4caf630638a 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -34,6 +34,22 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #endif
 };
 
+static int check_custom_allocator(enum io_pgtable_fmt fmt,
+				  struct io_pgtable_cfg *cfg)
+{
+	/* When passing a custom allocator, both the alloc and free
+	 * functions should be provided.
+	 */
+	if ((cfg->alloc != NULL) != (cfg->free != NULL))
+		return -EINVAL;
+
+	/* No custom allocator, no need to check the format. */
+	if (!cfg->alloc)
+		return 0;
+
+	return -EINVAL;
+}
+
 struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
 					    struct io_pgtable_cfg *cfg,
 					    void *cookie)
@@ -44,6 +60,9 @@ struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
 	if (fmt >= IO_PGTABLE_NUM_FMTS)
 		return NULL;
 
+	if (check_custom_allocator(fmt, cfg))
+		return NULL;
+
 	fns = io_pgtable_init_table[fmt];
 	if (!fns)
 		return NULL;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 1b7a44b35616..80d05dcb0f4c 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -100,6 +100,27 @@ struct io_pgtable_cfg {
 	const struct iommu_flush_ops	*tlb;
 	struct device			*iommu_dev;
 
+	/**
+	 * @alloc: Custom page allocator.
+	 *
+	 * Optional hook used to allocate page tables. If this function is NULL,
+	 * @free must be NULL too.
+	 *
+	 * Not all formats support custom page allocators. Before considering
+	 * passing a non-NULL value, make sure the chosen page format supports
+	 * this feature.
+	 */
+	void *(*alloc)(void *cookie, size_t size, gfp_t gfp);
+
+	/**
+	 * @free: Custom page de-allocator.
+	 *
+	 * Optional hook used to free page tables allocated with the @alloc
+	 * hook. Must be non-NULL if @alloc is not NULL, must be NULL
+	 * otherwise.
+	 */
+	void (*free)(void *cookie, void *pages, size_t size);
+
 	/* Low-level data specific to the table format */
 	union {
 		struct {
-- 
2.41.0

