From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v10 6/8] iommu/msi-iommu: iommu_msi_domain
Date: Tue,  7 Jun 2016 15:59:20 +0000
Message-ID: <1465315162-5888-7-git-send-email-eric.auger@redhat.com>
References: <1465315162-5888-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465315162-5888-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

This function checks whether
- the device belongs to a non default iommu domain
- this iommu domain requires the MSI address to be mapped.

If those conditions are met, the function returns the iommu domain
to be used for mapping the MSI doorbell; else it returns NULL.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v8 -> v9:
- use iommu_msi_supported

v7 -> v8:
- renamed  iommu_msi_mapping_desc_to_domain to iommu_msi_domain
- the function now takes a struct device *
- use DOMAIN_ATTR_MSI_GEOMETRY attribute
---
 drivers/iommu/msi-iommu.c | 17 +++++++++++++++++
 include/linux/msi-iommu.h | 14 ++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/iommu/msi-iommu.c b/drivers/iommu/msi-iommu.c
index 57017cb..41a5823 100644
--- a/drivers/iommu/msi-iommu.c
+++ b/drivers/iommu/msi-iommu.c
@@ -248,3 +248,20 @@ unlock:
 	}
 }
 EXPORT_SYMBOL_GPL(iommu_msi_put_doorbell_iova);
+
+struct iommu_domain *iommu_msi_domain(struct device *dev)
+{
+	struct iommu_domain *d = iommu_get_domain_for_dev(dev);
+	struct iommu_domain_msi_geometry msi_geometry;
+
+	if (!d || (d->type == IOMMU_DOMAIN_DMA))
+		return NULL;
+
+	iommu_domain_get_attr(d, DOMAIN_ATTR_MSI_GEOMETRY, &msi_geometry);
+	if (!msi_geometry.iommu_msi_supported)
+		return NULL;
+
+	return d;
+}
+EXPORT_SYMBOL_GPL(iommu_msi_domain);
+
diff --git a/include/linux/msi-iommu.h b/include/linux/msi-iommu.h
index 1cd115f..114bd69 100644
--- a/include/linux/msi-iommu.h
+++ b/include/linux/msi-iommu.h
@@ -81,6 +81,15 @@ int iommu_msi_get_doorbell_iova(struct iommu_domain *domain,
  */
 void iommu_msi_put_doorbell_iova(struct iommu_domain *domain, phys_addr_t addr);
 
+/**
+ * iommu_msi_domain: in case the device is upstream to an IOMMU and this IOMMU
+ * translates the MSI transaction, returns the iommu domain the MSI doorbell
+ * address must be mapped in; else returns NULL.
+ *
+ * @dev: device handle
+ */
+struct iommu_domain *iommu_msi_domain(struct device *dev);
+
 #else
 
 static inline int
@@ -100,5 +109,10 @@ static inline int iommu_msi_get_doorbell_iova(struct iommu_domain *domain,
 static inline void iommu_msi_put_doorbell_iova(struct iommu_domain *domain,
 					       phys_addr_t addr) {}
 
+static inline struct iommu_domain *iommu_msi_domain(struct device *dev)
+{
+	return NULL;
+}
+
 #endif	/* CONFIG_IOMMU_MSI */
 #endif	/* __MSI_IOMMU_H */
-- 
1.9.1
