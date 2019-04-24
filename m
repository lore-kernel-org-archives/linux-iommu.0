From: Tom Murphy <tmurphy@arista.com>
Subject: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
Date: Wed, 24 Apr 2019 17:50:51 +0100
Message-ID: <20190424165051.13614-1-tmurphy@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

check if there is a not-present cache present and flush it if there is.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index f7cdd2ab7f11..91fe5cb10f50 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1637,6 +1637,11 @@ static int iommu_map_page(struct protection_domain *dom,
 
 	update_domain(dom);
 
+	if (unlikely(amd_iommu_np_cache && !dom->updated)) {
+		domain_flush_pages(dom, bus_addr, page_size);
+		domain_flush_complete(dom);
+	}
+
 	/* Everything flushed out, free pages now */
 	free_page_list(freelist);
 
-- 
2.17.1
