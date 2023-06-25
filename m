Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00862A
	for <iommu@lists.linux.dev>; Sun, 25 Jun 2023 02:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687660884; x=1719196884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TAows7OAcmxGvx49AoU/i5mLwi1QDRE6TshwUYSLvtg=;
  b=LEORrxKNvRgrzriKP60mat8G6WEEjdUe5R0sMe8em9ycE2xqCMuyaC69
   cwD7csxa+8xN05T2vzyePHnHQJjKg/szK0m35v3Ev3TmJskhJ0NK1BkG3
   01dWWqV66fVRxlxttqb5k+xX/PetDLrd+62AJetXpYUBElr7ZxEf//7y0
   F56/dS5tFq+D7ulbFeVvyLCmcJI8LaLvZ72njeex5f0CeGONgV4FFVk4Z
   zNb3+nciYbKB3TcX1bU9tIqX2rbBnDGzWBF+DFIV/JQYV7LApWt6B+qk/
   OHznf3CaQNB2O+8qE/D66BfYnp5wWIwyMeyhgHiggXwVpC6f0zy4W3Kd3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="391148607"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="391148607"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 19:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="860285839"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="860285839"
Received: from cascade.sh.intel.com ([10.239.48.162])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jun 2023 19:41:20 -0700
From: Jingqi Liu <Jingqi.liu@intel.com>
To: iommu@lists.linux.dev,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Tian,
	Kevin <kevin.tian@intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org,
	Jingqi Liu <Jingqi.liu@intel.com>
Subject: [PATCH] iommu/vt-d: debugfs: Increment the reference count of page table page
Date: Sun, 25 Jun 2023 10:28:08 +0800
Message-Id: <20230625022808.42942-1-Jingqi.liu@intel.com>
X-Mailer: git-send-email 2.21.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There may be a race with iommu_unmap() interface when traversing a page
table.

When debugfs traverses an IOMMU page table, iommu_unmap() may clear
entries and free the page table pages pointed to by the entries.
So debugfs may read invalid or freed pages.

To avoid this, increment the refcount of a page table page before
traversing the page, and decrement its refcount after traversing it.

Signed-off-by: Jingqi Liu <Jingqi.liu@intel.com>
---
 drivers/iommu/intel/debugfs.c | 36 +++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 1f925285104e..d228e1580aec 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -333,9 +333,41 @@ static void pgtable_walk_level(struct seq_file *m, struct dma_pte *pde,
 		path[level] = pde->val;
 		if (dma_pte_superpage(pde) || level == 1)
 			dump_page_info(m, start, path);
-		else
-			pgtable_walk_level(m, phys_to_virt(dma_pte_addr(pde)),
+		else {
+			struct page *pg;
+			u64 pte_addr;
+
+			/*
+			 * The entry references a Page-Directory Table
+			 * or a Page Table.
+			 */
+retry:
+			pte_addr = dma_pte_addr(pde);
+			pg = pfn_to_page(pte_addr >> PAGE_SHIFT);
+			if (!get_page_unless_zero(pg))
+				/*
+				 * If this page has a refcount of zero,
+				 * it has been freed, or will be freed.
+				 */
+				continue;
+
+			/* Check if the value of the entry is changed. */
+			if (pde->val != path[level]) {
+				put_page(pg);
+
+				if (!dma_pte_present(pde))
+					/* The entry is invalid. Skip it. */
+					continue;
+
+				/* The entry has been updated. */
+				path[level] = pde->val;
+				goto retry;
+			}
+
+			pgtable_walk_level(m, phys_to_virt(pte_addr),
 					   level - 1, start, path);
+			put_page(pg);
+		}
 		path[level] = 0;
 	}
 }
-- 
2.21.3

