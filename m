From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v13 01/15] iommu: Introduce DOMAIN_ATTR_MSI_GEOMETRY
Date: Thu,  6 Oct 2016 08:45:17 +0000
Message-ID: <1475743531-4780-2-git-send-email-eric.auger@redhat.com>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, yehuday@marvell.com, Manish.Jaggi@caviumnetworks.com
List-Id: iommu@lists.linux-foundation.org

Introduce a new DOMAIN_ATTR_MSI_GEOMETRY domain attribute. It enables
to query the aperture of the IOVA window dedicated to MSIs and
test whether the MSIs must be IOMMU mapped.

x86 IOMMUs will typically expose an MSI aperture matching the 1MB
region [FEE0_0000h - FEF0_000h] corresponding to the the APIC
configuration space and no support for MSI IOMMU mapping.

On ARM, the requirement to map MSIs will be reported by setting
iommu_msi_supported to true.

A helper function is added to allow testing if the aperture is valid.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>

---
v12 -> v13:
- reword the commit message

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
index 9a2f196..617cb2b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1485,6 +1485,7 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 			  enum iommu_attr attr, void *data)
 {
 	struct iommu_domain_geometry *geometry;
+	struct iommu_domain_msi_geometry *msi_geometry;
 	bool *paging;
 	int ret = 0;
 	u32 *count;
@@ -1495,6 +1496,10 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
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
index 436dc21..9f90735 100644
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
@@ -352,6 +360,12 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
 
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

