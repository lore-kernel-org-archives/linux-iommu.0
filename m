From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/7] iommu/amd: Ignore page-mode 7 in free_sub_pt()
Date: Fri,  9 Nov 2018 12:07:08 +0100
Message-ID: <20181109110712.12469-4-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109110712.12469-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The page-mode 7 is a special one as it marks a final PTE to
a page with an intermediary size.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c       | 4 ++++
 drivers/iommu/amd_iommu_types.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1186571f77e1..49b5d3115e56 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1372,6 +1372,7 @@ static struct page *free_sub_pt(unsigned long root, int mode,
 {
 	switch (mode) {
 	case PAGE_MODE_NONE:
+	case PAGE_MODE_7_LEVEL:
 		break;
 	case PAGE_MODE_1_LEVEL:
 		freelist = free_pt_page(root, freelist);
@@ -1403,6 +1404,9 @@ static void free_pagetable(struct protection_domain *domain)
 	unsigned long root = (unsigned long)domain->pt_root;
 	struct page *freelist = NULL;
 
+	BUG_ON(domain->mode < PAGE_MODE_NONE ||
+	       domain->mode > PAGE_MODE_6_LEVEL);
+
 	free_sub_pt(root, domain->mode, freelist);
 
 	free_page_list(freelist);
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index e2b342e65a7b..eae0741f72dc 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -269,6 +269,7 @@
 #define PAGE_MODE_4_LEVEL 0x04
 #define PAGE_MODE_5_LEVEL 0x05
 #define PAGE_MODE_6_LEVEL 0x06
+#define PAGE_MODE_7_LEVEL 0x07
 
 #define PM_LEVEL_SHIFT(x)	(12 + ((x) * 9))
 #define PM_LEVEL_SIZE(x)	(((x) < 6) ? \
-- 
2.17.1
