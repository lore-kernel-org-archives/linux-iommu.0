Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B392D02F
	for <iommu@lists.linux.dev>; Fri, 24 Nov 2023 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="akRBPCrw"
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 4BEDA66073A9;
	Fri, 24 Nov 2023 14:24:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700835879;
	bh=P2Akoyi7R760kelnQSl1WATVJZukdG8kK6nY6xuG6Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=akRBPCrwBvEGUUdx0VWTjBJo38llxmpul3Q6sqQnlHuCI0FGqaDIHMa64mT1ArINi
	 lC3h1x0ko5RknlKSq5iC84oXYLvd0CwCFEp0zAHYiMtFIDbYnBSHc5MDmA7W+E1Yte
	 EEW9S+XROkZlbt0Hv+ntHoMiDScmEM3660M7gL0737JvKnogplUsicS/YPD8xj3sG/
	 wqlEMkgo+/Ac2FIZKqHEhIIjU01sGO3oplKCRLEy8fGm1Du+Y7F3CV2MUDuiZZExB8
	 SyYevV+KTHpC2CowWlBrat3G+qYXLkhCpjS/CZczWqOKNr9Uw6HoGIDQm6FForlNTb
	 70Xi9NG1JjOYg==
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	kernel@collabora.com,
	Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v3 1/2] iommu: Allow passing custom allocators to pgtable drivers
Date: Fri, 24 Nov 2023 15:24:33 +0100
Message-ID: <20231124142434.1577550-2-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124142434.1577550-1-boris.brezillon@collabora.com>
References: <20231124142434.1577550-1-boris.brezillon@collabora.com>
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

It might also be valuable for other aspects of GPU and similar
use-cases, like fine-grained memory accounting and resource limiting.

We will extend the Arm LPAE format to support custom allocators in a
separate commit.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
v3:
- Add Robin R-b
- Move caps definition around
- Add extra constraints to the ->alloc() callback documentation
v2:
- Add Steven R-b
- Expand on possible use-cases for custom allocators
- Add a caps fields to io_pgtable_init_fns so we can simplify the
  check_custom_allocator() logic (Robin Murphy)
---
 drivers/iommu/io-pgtable.c | 23 +++++++++++++++++++++++
 include/linux/io-pgtable.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index b843fcd365d2..8841c1487f00 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -34,6 +34,26 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #endif
 };
 
+static int check_custom_allocator(enum io_pgtable_fmt fmt,
+				  struct io_pgtable_cfg *cfg)
+{
+	/* No custom allocator, no need to check the format. */
+	if (!cfg->alloc && !cfg->free)
+		return 0;
+
+	/* When passing a custom allocator, both the alloc and free
+	 * functions should be provided.
+	 */
+	if (!cfg->alloc || !cfg->free)
+		return -EINVAL;
+
+	/* Make sure the format supports custom allocators. */
+	if (io_pgtable_init_table[fmt]->caps & IO_PGTABLE_CAP_CUSTOM_ALLOCATOR)
+		return 0;
+
+	return -EINVAL;
+}
+
 struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
 					    struct io_pgtable_cfg *cfg,
 					    void *cookie)
@@ -44,6 +64,9 @@ struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
 	if (fmt >= IO_PGTABLE_NUM_FMTS)
 		return NULL;
 
+	if (check_custom_allocator(fmt, cfg))
+		return NULL;
+
 	fns = io_pgtable_init_table[fmt];
 	if (!fns)
 		return NULL;
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 25142a0e2fc2..86cf1f7ae389 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -100,6 +100,30 @@ struct io_pgtable_cfg {
 	const struct iommu_flush_ops	*tlb;
 	struct device			*iommu_dev;
 
+	/**
+	 * @alloc: Custom page allocator.
+	 *
+	 * Optional hook used to allocate page tables. If this function is NULL,
+	 * @free must be NULL too.
+	 *
+	 * Memory returned should be zeroed and suitable for dma_map_single() and
+	 * virt_to_phys().
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
@@ -241,16 +265,26 @@ io_pgtable_tlb_add_page(struct io_pgtable *iop,
 		iop->cfg.tlb->tlb_add_page(gather, iova, granule, iop->cookie);
 }
 
+/**
+ * enum io_pgtable_caps - IO page table backend capabilities.
+ */
+enum io_pgtable_caps {
+	/** @IO_PGTABLE_CAP_CUSTOM_ALLOCATOR: Backend accepts custom page table allocators. */
+	IO_PGTABLE_CAP_CUSTOM_ALLOCATOR = BIT(0),
+};
+
 /**
  * struct io_pgtable_init_fns - Alloc/free a set of page tables for a
  *                              particular format.
  *
  * @alloc: Allocate a set of page tables described by cfg.
  * @free:  Free the page tables associated with iop.
+ * @caps:  Combination of @io_pgtable_caps flags encoding the backend capabilities.
  */
 struct io_pgtable_init_fns {
 	struct io_pgtable *(*alloc)(struct io_pgtable_cfg *cfg, void *cookie);
 	void (*free)(struct io_pgtable *iop);
+	u32 caps;
 };
 
 extern struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns;
-- 
2.42.0

