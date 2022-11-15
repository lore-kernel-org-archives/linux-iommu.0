Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A96AD5B
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 15:26:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84BF01576;
	Tue, 15 Nov 2022 07:27:04 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B9CD3F587;
	Tue, 15 Nov 2022 07:26:57 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robdclark@gmail.com,
	yong.wu@mediatek.com
Subject: [PATCH 9/9] iommu/io-pgtable: Remove map/unmap
Date: Tue, 15 Nov 2022 15:26:43 +0000
Message-Id: <a5a3cbf95c3279982e378cc43dad830322a59868.1668100209.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1668100209.git.robin.murphy@arm.com>
References: <cover.1668100209.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With all users now calling {map,unmap}_pages, retire the redundant
single-page callbacks.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/io-pgtable.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 1f068dfdb140..1b7a44b35616 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -150,9 +150,7 @@ struct io_pgtable_cfg {
 /**
  * struct io_pgtable_ops - Page table manipulation API for IOMMU drivers.
  *
- * @map:          Map a physically contiguous memory region.
  * @map_pages:    Map a physically contiguous range of pages of the same size.
- * @unmap:        Unmap a physically contiguous memory region.
  * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
  * @iova_to_phys: Translate iova to physical address.
  *
@@ -160,13 +158,9 @@ struct io_pgtable_cfg {
  * the same names.
  */
 struct io_pgtable_ops {
-	int (*map)(struct io_pgtable_ops *ops, unsigned long iova,
-		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
 	int (*map_pages)(struct io_pgtable_ops *ops, unsigned long iova,
 			 phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			 int prot, gfp_t gfp, size_t *mapped);
-	size_t (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
-			size_t size, struct iommu_iotlb_gather *gather);
 	size_t (*unmap_pages)(struct io_pgtable_ops *ops, unsigned long iova,
 			      size_t pgsize, size_t pgcount,
 			      struct iommu_iotlb_gather *gather);
-- 
2.36.1.dirty

