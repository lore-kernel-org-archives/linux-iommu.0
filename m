From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v2 7/8] iommu/vt-d: Implement add_reserved_regions callback
Date: Fri,  4 Nov 2016 11:24:05 +0000
Message-ID: <1478258646-3117-8-git-send-email-eric.auger@redhat.com>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1478258646-3117-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Implement the add_reserved_regions callback by registering
the [FEE0_0000h - FEF0_000h] 1MB range as a reserved region
(MSI address space).

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---

RFC v1 -> RFC v2:
- fix intel_iommu_add_reserved_regions name
- use IOAPIC_RANGE_START and IOAPIC_RANGE_END defines
- return if the MSI region is already registered;
---
 drivers/iommu/intel-iommu.c | 48 +++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a4407ea..d07dbb4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5173,6 +5173,27 @@ static void intel_iommu_remove_device(struct device *dev)
 	iommu_device_unlink(iommu->iommu_dev, dev);
 }
 
+static int intel_iommu_add_reserved_regions(struct iommu_domain *domain,
+					    struct device *device)
+{
+	struct iommu_reserved_region *region;
+	size_t msi_length = IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1;
+
+	iommu_reserved_region_for_each(region, domain) {
+		if (region->start == IOAPIC_RANGE_START &&
+		    region->length == msi_length)
+			return 0;
+	}
+	region = kzalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+
+	region->start  = IOAPIC_RANGE_START;
+	region->length = msi_length;
+	list_add_tail(&region->list, &domain->reserved_regions);
+	return 0;
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev)
 {
@@ -5282,19 +5303,20 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
 #endif /* CONFIG_INTEL_IOMMU_SVM */
 
 static const struct iommu_ops intel_iommu_ops = {
-	.capable	= intel_iommu_capable,
-	.domain_alloc	= intel_iommu_domain_alloc,
-	.domain_free	= intel_iommu_domain_free,
-	.attach_dev	= intel_iommu_attach_device,
-	.detach_dev	= intel_iommu_detach_device,
-	.map		= intel_iommu_map,
-	.unmap		= intel_iommu_unmap,
-	.map_sg		= default_iommu_map_sg,
-	.iova_to_phys	= intel_iommu_iova_to_phys,
-	.add_device	= intel_iommu_add_device,
-	.remove_device	= intel_iommu_remove_device,
-	.device_group   = pci_device_group,
-	.pgsize_bitmap	= INTEL_IOMMU_PGSIZES,
+	.capable		= intel_iommu_capable,
+	.domain_alloc		= intel_iommu_domain_alloc,
+	.domain_free		= intel_iommu_domain_free,
+	.attach_dev		= intel_iommu_attach_device,
+	.detach_dev		= intel_iommu_detach_device,
+	.map			= intel_iommu_map,
+	.unmap			= intel_iommu_unmap,
+	.map_sg			= default_iommu_map_sg,
+	.iova_to_phys		= intel_iommu_iova_to_phys,
+	.add_device		= intel_iommu_add_device,
+	.remove_device		= intel_iommu_remove_device,
+	.add_reserved_regions	= intel_iommu_add_reserved_regions,
+	.device_group		= pci_device_group,
+	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
 static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
-- 
1.9.1
