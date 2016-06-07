From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v10 2/8] iommu/arm-smmu: initialize the msi geometry and advertise iommu-msi support
Date: Tue,  7 Jun 2016 15:59:16 +0000
Message-ID: <1465315162-5888-3-git-send-email-eric.auger@redhat.com>
References: <1465315162-5888-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465315162-5888-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

On ARM, MSI write transactions from device upstream to the smmu
are conveyed through the iommu. Therefore target physical addresses
must be mapped and DOMAIN_ATTR_MSI_GEOMETRY advertises the support of
the IOMMU-MSI API.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v8 -> v9:
- reword the title and patch description

v7 -> v8:
- use DOMAIN_ATTR_MSI_GEOMETRY

v4 -> v5:
- don't handle fsl_pamu_domain anymore
- handle arm-smmu-v3
---
 drivers/iommu/arm-smmu-v3.c | 2 ++
 drivers/iommu/arm-smmu.c    | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 94b6821..8eb002e 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1397,6 +1397,7 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
+	struct iommu_domain_msi_geometry msi_geometry = {0, 0, true};
 
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
@@ -1415,6 +1416,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		kfree(smmu_domain);
 		return NULL;
 	}
+	smmu_domain->domain.msi_geometry = msi_geometry;
 
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9345a3f..9755a1b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1038,6 +1038,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
+	struct iommu_domain_msi_geometry msi_geometry = {0, 0, true};
 
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
@@ -1056,6 +1057,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
+	smmu_domain->domain.msi_geometry = msi_geometry;
+
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
 
-- 
1.9.1
