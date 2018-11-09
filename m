From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/7] iommu/amd: Introduce free_sub_pt() function
Date: Fri,  9 Nov 2018 12:07:07 +0100
Message-ID: <20181109110712.12469-3-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109110712.12469-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The function is a more generic version of free_pagetable()
and will be used to free only specific sub-trees of a
page-table.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2655bd91af93..1186571f77e1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1367,12 +1367,10 @@ DEFINE_FREE_PT_FN(l4, free_pt_l3)
 DEFINE_FREE_PT_FN(l5, free_pt_l4)
 DEFINE_FREE_PT_FN(l6, free_pt_l5)
 
-static void free_pagetable(struct protection_domain *domain)
+static struct page *free_sub_pt(unsigned long root, int mode,
+				struct page *freelist)
 {
-	unsigned long root = (unsigned long)domain->pt_root;
-	struct page *freelist = NULL;
-
-	switch (domain->mode) {
+	switch (mode) {
 	case PAGE_MODE_NONE:
 		break;
 	case PAGE_MODE_1_LEVEL:
@@ -1397,6 +1395,16 @@ static void free_pagetable(struct protection_domain *domain)
 		BUG();
 	}
 
+	return freelist;
+}
+
+static void free_pagetable(struct protection_domain *domain)
+{
+	unsigned long root = (unsigned long)domain->pt_root;
+	struct page *freelist = NULL;
+
+	free_sub_pt(root, domain->mode, freelist);
+
 	free_page_list(freelist);
 }
 
-- 
2.17.1
