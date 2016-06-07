From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v10 1/8] iommu: Add iommu_domain_msi_geometry and DOMAIN_ATTR_MSI_GEOMETRY
Date: Tue,  7 Jun 2016 15:59:15 +0000
Message-ID: <1465315162-5888-2-git-send-email-eric.auger@redhat.com>
References: <1465315162-5888-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465315162-5888-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com, yehuday@marvell.com
List-Id: iommu@lists.linux-foundation.org

Introduce a new DOMAIN_ATTR_MSI_GEOMETRY domain attribute. It enables
to query the aperture of the IOVA window dedicated to MSIs and
test whether the MSIs must be mapped with the IOMMU-MSI API.

x86 IOMMUs will typically expose an MSI aperture matching the 1MB
region [FEE0_0000h - FEF0_000h] corresponding to the the APIC
configuration space and no support of the IOMMU-MSI API.

On ARM, the support of the IOMMU-MSI API will be advertised. Aperture
will refect the setting performed with the IOMMU-MSI API.

A helper function is added to allow testing if the aperture is valid.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>

---
v8 -> v9:
- rename programmable into iommu_msi_supported
- add iommu_domain_msi_aperture_valid

v8: creation
- deprecates DOMAIN_ATTR_MSI_MAPPING flag
---
 drivers/iommu/iommu.c |  5 +++++
 include/linux/iommu.h | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3000051..feab3cc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1496,6 +1496,7 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 			  enum iommu_attr attr, void *data)
 {
 	struct iommu_domain_geometry *geometry;
+	struct iommu_domain_msi_geometry *msi_geometry;
 	bool *paging;
 	int ret = 0;
 	u32 *count;
@@ -1506,6 +1507,10 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 		*geometry = domain->geometry;
 
 		break;
+	case DOMAIN_ATTR_MSI_GEOMETRY:
+		msi_geometry  = data;
+		*msi_geometry = domain->msi_geometry;
+		break;
 	case DOMAIN_ATTR_PAGING:
 		paging  = data;
 		*paging = (domain->pgsize_bitmap != 0UL);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 664683a..1b553ee 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -52,6 +52,12 @@ struct iommu_domain_geometry {
 	bool force_aperture;       /* DMA only allowed in mappable range? */
 };
 
+struct iommu_domain_msi_geometry {
+	dma_addr_t aperture_start; /* First address used for MSI IOVA    */
+	dma_addr_t aperture_end;   /* Last address used for MSI IOVA     */
+	bool iommu_msi_supported;  /* Is MSI mapping supported?		 */
+};
+
 /* Domain feature flags */
 #define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
 #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
@@ -83,6 +89,7 @@ struct iommu_domain {
 	iommu_fault_handler_t handler;
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
+	struct iommu_domain_msi_geometry msi_geometry;
 	void *iova_cookie;
 };
 
@@ -108,6 +115,7 @@ enum iommu_cap {
 
 enum iommu_attr {
 	DOMAIN_ATTR_GEOMETRY,
+	DOMAIN_ATTR_MSI_GEOMETRY,
 	DOMAIN_ATTR_PAGING,
 	DOMAIN_ATTR_WINDOWS,
 	DOMAIN_ATTR_FSL_PAMU_STASH,
@@ -328,6 +336,12 @@ extern struct iommu_group *pci_device_group(struct device *dev);
 /* Generic device grouping function */
 extern struct iommu_group *generic_device_group(struct device *dev);
 
+static inline bool iommu_domain_msi_aperture_valid(struct iommu_domain *domain)
+{
+	return (domain->msi_geometry.aperture_end >
+		domain->msi_geometry.aperture_start);
+}
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
-- 
1.9.1
