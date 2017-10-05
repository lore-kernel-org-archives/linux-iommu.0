From: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH] iommu/vt-d: only attempt to cleanup svm page request irq if one assigned
Date: Thu,  5 Oct 2017 16:30:03 -0700
Message-ID: <20171005233003.12153-1-jsnitsel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Only try to clean up the svm page request irq if one has
been assigned. Also clear pr_irq in the error path if irq request
fails.

Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/intel-svm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index f6697e55c2d4..003b4a4d4b78 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -129,6 +129,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 		pr_err("IOMMU: %s: Failed to request IRQ for page request queue\n",
 		       iommu->name);
 		dmar_free_hwirq(irq);
+		iommu->pr_irq = 0;
 		goto err;
 	}
 	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
@@ -144,9 +145,11 @@ int intel_svm_finish_prq(struct intel_iommu *iommu)
 	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
 	dmar_writeq(iommu->reg + DMAR_PQA_REG, 0ULL);
 
-	free_irq(iommu->pr_irq, iommu);
-	dmar_free_hwirq(iommu->pr_irq);
-	iommu->pr_irq = 0;
+	if (iommu->pr_irq) {
+		free_irq(iommu->pr_irq, iommu);
+		dmar_free_hwirq(iommu->pr_irq);
+		iommu->pr_irq = 0;
+	}
 
 	free_pages((unsigned long)iommu->prq, PRQ_ORDER);
 	iommu->prq = NULL;
-- 
2.13.0.rc0.45.ge2cb6ab84
