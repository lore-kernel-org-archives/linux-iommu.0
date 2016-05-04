From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v9 1/8] iommu: Add iommu_domain_msi_geometry and
	DOMAIN_ATTR_MSI_GEOMETRY
Date: Wed,  4 May 2016 11:40:00 +0000
Message-ID: <1462362007-2753-2-git-send-email-eric.auger@linaro.org>
References: <1462362007-2753-1-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1462362007-2753-1-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-qxv4g6HH51o@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
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

Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Suggested-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

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
index b9df141..71ed58f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1498,6 +1498,7 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 			  enum iommu_attr attr, void *data)
 {
 	struct iommu_domain_geometry *geometry;
+	struct iommu_domain_msi_geometry *msi_geometry;
 	bool *paging;
 	int ret = 0;
 	u32 *count;
@@ -1508,6 +1509,10 @@ int iommu_domain_get_attr(struct iommu_domain *domain,
 		*geometry = domain->geometry;
 
 		break;
+	case DOMAIN_ATTR_MSI_GEOMETRY:
+		msi_geometry  = data;
+		*msi_geometry = domain->msi_geometry;
+		break;
 	case DOMAIN_ATTR_PAGING:
 		paging  = data;
 		*paging = (domain->ops->pgsize_bitmap != 0UL);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 62a5eae..021b659 100644
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
@@ -82,6 +88,7 @@ struct iommu_domain {
 	iommu_fault_handler_t handler;
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
+	struct iommu_domain_msi_geometry msi_geometry;
 	void *iova_cookie;
 };
 
@@ -107,6 +114,7 @@ enum iommu_cap {
 
 enum iommu_attr {
 	DOMAIN_ATTR_GEOMETRY,
+	DOMAIN_ATTR_MSI_GEOMETRY,
 	DOMAIN_ATTR_PAGING,
 	DOMAIN_ATTR_WINDOWS,
 	DOMAIN_ATTR_FSL_PAMU_STASH,
@@ -329,6 +337,12 @@ extern struct iommu_group *pci_device_group(struct device *dev);
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
