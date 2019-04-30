From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH] iommu/vt-d: Fix leak in intel_pasid_alloc_table on error path
Date: Tue, 30 Apr 2019 09:30:04 +0200
Message-ID: <20190430073004.10528-1-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org
List-Id: iommu@lists.linux-foundation.org

If alloc_pages_node() fails, pasid_table is leaked. Free it.

Fixes: cc580e41260db ("iommu/vt-d: Per PCI device pasid table interfaces")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/intel-pasid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 03b12d2ee213..2fefeafda437 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -154,8 +154,10 @@ int intel_pasid_alloc_table(struct device *dev)
 	order = size ? get_order(size) : 0;
 	pages = alloc_pages_node(info->iommu->node,
 				 GFP_KERNEL | __GFP_ZERO, order);
-	if (!pages)
+	if (!pages) {
+		kfree(pasid_table);
 		return -ENOMEM;
+	}
 
 	pasid_table->table = page_address(pages);
 	pasid_table->order = order;
-- 
2.20.1
