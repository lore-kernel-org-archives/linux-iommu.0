From: Xunlei Pang <xlpang@redhat.com>
Subject: [PATCH] iommu/vt-d: Fix the size calculation of pasid table
Date: Mon, 12 Sep 2016 10:49:11 +0800
Message-ID: <1473648551-10025-1-git-send-email-xlpang@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Xunlei Pang <xlpang@redhat.com>
List-Id: iommu@lists.linux-foundation.org

According to the vt-d spec, the size of pasid (state) entry is 8B
which equals 3 in power of 2, the number of pasid (state) entries
is (ecap_pss + 1) in power of 2.

Thus the right size of pasid (state) table in power of 2 should be
ecap_pss(iommu->ecap) plus "1+3=4" other than 7.

Signed-off-by: Xunlei Pang <xlpang@redhat.com>
---
 drivers/iommu/intel-svm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 8ebb353..cfa75c2 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -39,7 +39,7 @@ int intel_svm_alloc_pasid_tables(struct intel_iommu *iommu)
 	struct page *pages;
 	int order;
 
-	order = ecap_pss(iommu->ecap) + 7 - PAGE_SHIFT;
+	order = ecap_pss(iommu->ecap) + 4 - PAGE_SHIFT;
 	if (order < 0)
 		order = 0;
 
-- 
1.8.3.1
