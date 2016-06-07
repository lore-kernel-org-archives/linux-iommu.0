From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v10 8/8] iommu/arm-smmu: get/put the msi cookie
Date: Tue,  7 Jun 2016 15:59:22 +0000
Message-ID: <1465315162-5888-9-git-send-email-eric.auger@redhat.com>
References: <1465315162-5888-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465315162-5888-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

For IOMMU_DOMAIN_UNMANAGED type we now also get the msi
cookie in both arm-smmu and arm-smmu-v3. This initializes
resources for MSI doorbell mapping.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 drivers/iommu/arm-smmu-v3.c | 16 ++++++++++++----
 drivers/iommu/arm-smmu.c    | 15 +++++++++++----
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8eb002e..17a20a7 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -22,6 +22,7 @@
 
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
+#include <linux/msi-iommu.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
@@ -1412,15 +1413,21 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		return NULL;
 
 	if (type == IOMMU_DOMAIN_DMA &&
-	    iommu_get_dma_cookie(&smmu_domain->domain)) {
-		kfree(smmu_domain);
-		return NULL;
-	}
+	    iommu_get_dma_cookie(&smmu_domain->domain))
+		goto err;
+
+	if (type == IOMMU_DOMAIN_UNMANAGED &&
+		iommu_get_msi_cookie(&smmu_domain->domain))
+		goto err;
+
 	smmu_domain->domain.msi_geometry = msi_geometry;
 
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
 	return &smmu_domain->domain;
+err:
+	kfree(smmu_domain);
+	return NULL;
 }
 
 static int arm_smmu_bitmap_alloc(unsigned long *map, int span)
@@ -1446,6 +1453,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
+	iommu_put_msi_cookie(domain);
 	iommu_put_dma_cookie(domain);
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9755a1b..867910b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -30,6 +30,7 @@
 
 #include <linux/delay.h>
 #include <linux/dma-iommu.h>
+#include <linux/msi-iommu.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -1052,10 +1053,12 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		return NULL;
 
 	if (type == IOMMU_DOMAIN_DMA &&
-	    iommu_get_dma_cookie(&smmu_domain->domain)) {
-		kfree(smmu_domain);
-		return NULL;
-	}
+	    iommu_get_dma_cookie(&smmu_domain->domain))
+		goto err;
+
+	if (type == IOMMU_DOMAIN_UNMANAGED &&
+		iommu_get_msi_cookie(&smmu_domain->domain))
+		goto err;
 
 	smmu_domain->domain.msi_geometry = msi_geometry;
 
@@ -1063,6 +1066,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	spin_lock_init(&smmu_domain->pgtbl_lock);
 
 	return &smmu_domain->domain;
+err:
+	kfree(smmu_domain);
+	return NULL;
 }
 
 static void arm_smmu_domain_free(struct iommu_domain *domain)
@@ -1073,6 +1079,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	 * Free the domain resources. We assume that all devices have
 	 * already been detached.
 	 */
+	iommu_put_msi_cookie(domain);
 	iommu_put_dma_cookie(domain);
 	arm_smmu_destroy_domain_context(domain);
 	kfree(smmu_domain);
-- 
1.9.1
