From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v8 08/18] iommu/vt-d: Implement reserved region get/put
	callbacks
Date: Wed, 11 Jan 2017 09:41:44 +0000
Message-ID: <1484127714-3263-9-git-send-email-eric.auger@redhat.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484127714-3263-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch registers the [FEE0_0000h - FEF0_000h] 1MB MSI
range as a reserved region and RMRR regions as direct regions.

This will allow to report those reserved regions in the
iommu-group sysfs.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

---
v6 -> v7:
- report RMRR regions as direct regions
- Due to the usage of rcu_read_lock, the rmrr reserved region
  allocation is done on rmrr allocation.
- use IOMMU_RESV_RESERVED

RFCv2 -> RFCv3:
- use get/put_resv_region callbacks.

RFC v1 -> RFC v2:
- fix intel_iommu_add_reserved_regions name
- use IOAPIC_RANGE_START and IOAPIC_RANGE_END defines
- return if the MSI region is already registered;
---
 drivers/iommu/intel-iommu.c | 92 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 74 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 8a18525..bce59a5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -440,6 +440,7 @@ struct dmar_rmrr_unit {
 	u64	end_address;		/* reserved end address */
 	struct dmar_dev_scope *devices;	/* target devices */
 	int	devices_cnt;		/* target device count */
+	struct iommu_resv_region *resv; /* reserved region handle */
 };
 
 struct dmar_atsr_unit {
@@ -4246,27 +4247,40 @@ static inline void init_iommu_pm_ops(void) {}
 int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 {
 	struct acpi_dmar_reserved_memory *rmrr;
+	int prot = DMA_PTE_READ|DMA_PTE_WRITE;
 	struct dmar_rmrr_unit *rmrru;
+	size_t length;
 
 	rmrru = kzalloc(sizeof(*rmrru), GFP_KERNEL);
 	if (!rmrru)
-		return -ENOMEM;
+		goto out;
 
 	rmrru->hdr = header;
 	rmrr = (struct acpi_dmar_reserved_memory *)header;
 	rmrru->base_address = rmrr->base_address;
 	rmrru->end_address = rmrr->end_address;
+
+	length = rmrr->end_address - rmrr->base_address + 1;
+	rmrru->resv = iommu_alloc_resv_region(rmrr->base_address, length, prot,
+					      IOMMU_RESV_DIRECT);
+	if (!rmrru->resv)
+		goto free_rmrru;
+
 	rmrru->devices = dmar_alloc_dev_scope((void *)(rmrr + 1),
 				((void *)rmrr) + rmrr->header.length,
 				&rmrru->devices_cnt);
-	if (rmrru->devices_cnt && rmrru->devices == NULL) {
-		kfree(rmrru);
-		return -ENOMEM;
-	}
+	if (rmrru->devices_cnt && rmrru->devices == NULL)
+		goto free_all;
 
 	list_add(&rmrru->list, &dmar_rmrr_units);
 
 	return 0;
+free_all:
+	kfree(rmrru->resv);
+free_rmrru:
+	kfree(rmrru);
+out:
+	return -ENOMEM;
 }
 
 static struct dmar_atsr_unit *dmar_find_atsr(struct acpi_dmar_atsr *atsr)
@@ -4480,6 +4494,7 @@ static void intel_iommu_free_dmars(void)
 	list_for_each_entry_safe(rmrru, rmrr_n, &dmar_rmrr_units, list) {
 		list_del(&rmrru->list);
 		dmar_free_dev_scope(&rmrru->devices, &rmrru->devices_cnt);
+		kfree(rmrru->resv);
 		kfree(rmrru);
 	}
 
@@ -5203,6 +5218,45 @@ static void intel_iommu_remove_device(struct device *dev)
 	iommu_device_unlink(iommu->iommu_dev, dev);
 }
 
+static void intel_iommu_get_resv_regions(struct device *device,
+					 struct list_head *head)
+{
+	struct iommu_resv_region *reg;
+	struct dmar_rmrr_unit *rmrr;
+	struct device *i_dev;
+	int i;
+
+	rcu_read_lock();
+	for_each_rmrr_units(rmrr) {
+		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
+					  i, i_dev) {
+			if (i_dev != device)
+				continue;
+
+			list_add_tail(&rmrr->resv->list, head);
+		}
+	}
+	rcu_read_unlock();
+
+	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
+				      IOAPIC_RANGE_END - IOAPIC_RANGE_START + 1,
+				      0, IOMMU_RESV_RESERVED);
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
+	list_for_each_entry_safe(entry, next, head, list) {
+		if (entry->type == IOMMU_RESV_RESERVED)
+			kfree(entry);
+	}
+}
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 #define MAX_NR_PASID_BITS (20)
 static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
@@ -5333,19 +5387,21 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
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
