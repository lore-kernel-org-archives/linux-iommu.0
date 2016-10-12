From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v14 02/16] iommu: Introduce DOMAIN_ATTR_MSI_RESV
Date: Wed, 12 Oct 2016 13:22:10 +0000
Message-ID: <1476278544-3397-3-git-send-email-eric.auger@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, christoffer.dall@linaro.org, marc.zyngier@arm.com, robin.murphy@arm.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org
Cc: kvm@vger.kernel.org, drjones@redhat.com, linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, yehuday@marvell.com, Manish.Jaggi@caviumnetworks.com
List-Id: iommu@lists.linux-foundation.org

Introduce a new DOMAIN_ATTR_MSI_RESV domain attribute and associated
iommu_domain msi_resv field. It comprises the size and alignment
of the IOVA reserved window dedicated to MSI mapping. This attribute
only is supported when MSI must be IOMMU mapped.

This is the case on ARM.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>

---
v13 -> v14:
- new msi_resv type and name

v12 -> v13:
- reword the commit message

v8 -> v9:
- rename programmable into iommu_msi_supported
- add iommu_domain_msi_aperture_valid

v8: creation
- deprecates DOMAIN_ATTR_MSI_MAPPING flag
---
 include/linux/iommu.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 436dc21..aaeb598 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -52,6 +52,12 @@ struct iommu_domain_geometry {
 	bool force_aperture;       /* DMA only allowed in mappable range? */
 };
 
+/* MSI reserved IOVA window requirements */
+struct iommu_domain_msi_resv {
+	size_t size;		/* size in bytes	*/
+	size_t alignment;	/* byte alignment	*/
+};
+
 /* Domain feature flags */
 #define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
 #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
@@ -83,6 +89,7 @@ struct iommu_domain {
 	iommu_fault_handler_t handler;
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
+	struct iommu_domain_msi_resv msi_resv;
 	void *iova_cookie;
 };
 
@@ -108,6 +115,7 @@ enum iommu_cap {
 
 enum iommu_attr {
 	DOMAIN_ATTR_GEOMETRY,
+	DOMAIN_ATTR_MSI_RESV,
 	DOMAIN_ATTR_PAGING,
 	DOMAIN_ATTR_WINDOWS,
 	DOMAIN_ATTR_FSL_PAMU_STASH,
-- 
1.9.1
