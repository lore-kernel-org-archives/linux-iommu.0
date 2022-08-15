Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9212914
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 16:16:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3B691063;
	Mon, 15 Aug 2022 09:16:03 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19D003F70D;
	Mon, 15 Aug 2022 09:16:01 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: joro@8bytes.org,
	iommu@lists.linux.dev,
	subkhankulov@ispras.ru,
	khoroshilov@ispras.ru,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/io-pgtable-arm: Remove iommu_dev==NULL special case
Date: Mon, 15 Aug 2022 17:15:55 +0100
Message-Id: <e2095eeda305071cb56c2cb8ac8a82dc3bd4dcab.1660580155.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The special case to allow iommu_dev==NULL in __arm_lpae_alloc_pages() is
confusing to static checkers (and possibly readers in general), since
it's not obvious that that is only intended for the selftests. However
it only serves to get around the dev_to_node() call, and we can easily
fake up enough to make that work anyway, so let's simply remove this
consideration from the normal flow and punt the responsibility over to
the test harness itself.

Reported-by: Rustam Subkhankulov <subkhankulov@ispras.ru>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 94ff319ae8ac..873a92bbd80c 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -200,8 +200,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	void *pages;
 
 	VM_BUG_ON((gfp & __GFP_HIGHMEM));
-	p = alloc_pages_node(dev ? dev_to_node(dev) : NUMA_NO_NODE,
-			     gfp | __GFP_ZERO, order);
+	p = alloc_pages_node(dev_to_node(dev), gfp | __GFP_ZERO, order);
 	if (!p)
 		return NULL;
 
@@ -1343,12 +1342,17 @@ static int __init arm_lpae_do_selftests(void)
 	};
 
 	int i, j, pass = 0, fail = 0;
+	struct device dev;
 	struct io_pgtable_cfg cfg = {
 		.tlb = &dummy_tlb_ops,
 		.oas = 48,
 		.coherent_walk = true,
+		.iommu_dev = &dev,
 	};
 
+	/* __arm_lpae_alloc_pages() merely needs dev_to_node() to work */
+	set_dev_node(&dev, NUMA_NO_NODE);
+
 	for (i = 0; i < ARRAY_SIZE(pgsize); ++i) {
 		for (j = 0; j < ARRAY_SIZE(ias); ++j) {
 			cfg.pgsize_bitmap = pgsize[i];
-- 
2.36.1.dirty

