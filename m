From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC v4 08/16] iommu/vt-d: Implement reserved region get/put callbacks
Date: Tue, 13 Dec 2016 20:30:26 +0000
Message-ID: <1481661034-3088-9-git-send-email-eric.auger@redhat.com>
References: <1481661034-3088-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1481661034-3088-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch registers the [0xfee00000 - 0xfeefffff] 1MB
MSI range as a reserved region. This will allow to report
that range in the iommu-group sysfs.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---

RFCv2 -> RFCv3:
- use get/put_resv_region callbacks.

RFC v1 -> RFC v2:
- fix intel_iommu_add_reserved_regions name
- use IOAPIC_RANGE_START and IOAPIC_RANGE_END defines
- return if the MSI region is already registered;
---
 drivers/iommu/intel-iommu.c | 50 +++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d8376c2..06c447a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5196,6 +5196,28 @@ static void intel_iommu_remove_device(struct device *dev)
 	iommu_device_unlink(iommu->iommu_dev, dev);
 }
 
+static void intel_iommu_get_resv_regions(struct device *device,
+					 struct list_head *head)
+{
+	struct iommu_resv_region *reg;
+
+	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
+				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
+				      0, IOMMU_RESV_NOMAP);
+	if (!reg)
+		return;
+	list_add_tail(&reg->list, head);
+}
+
+static void intel_iommu_put_resv_regions(struct device *dev,
+					 struct list_head *head)
+{
+	struct iommu_resv_region *entry, *next;
+
+	list_for_each_entry_safe(entry, next, head, list)
+		kfree(entry);
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev)
 {
@@ -5305,19 +5327,21 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
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
+	.get_resv_regions	= intel_iommu_get_resv_regions,
+	.put_resv_regions	= intel_iommu_put_resv_regions,
+	.device_group		= pci_device_group,
+	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
 };
 
 static void quirk_iommu_g4x_gfx(struct pci_dev *dev)
-- 
1.9.1
