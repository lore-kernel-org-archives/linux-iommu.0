From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/2] iommu/s390: Fix IOMMU groups
Date: Thu, 27 Apr 2017 17:28:24 +0200
Message-ID: <1493306905-32334-2-git-send-email-joro@8bytes.org>
References: <1493306905-32334-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1493306905-32334-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Currently the s390 iommu driver allocates an iommu-group for
every device that is added. But that is wrong, as there is
only one dma-table per pci-root-bus. Make all devices behind
one dma-table share one iommu-group.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 arch/s390/include/asm/pci.h |  7 +++++++
 arch/s390/pci/pci.c         | 10 +++++++++-
 drivers/iommu/s390-iommu.c  | 43 ++++++++++++++++++++++++++++++++-----------
 3 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 4e31866..045665d 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -8,6 +8,7 @@
 
 #include <linux/pci.h>
 #include <linux/mutex.h>
+#include <linux/iommu.h>
 #include <asm-generic/pci.h>
 #include <asm/pci_clp.h>
 #include <asm/pci_debug.h>
@@ -123,6 +124,8 @@ struct zpci_dev {
 	unsigned long	iommu_pages;
 	unsigned int	next_bit;
 
+	struct iommu_group *group;	/* IOMMU group for all devices behind this zdev */
+
 	char res_name[16];
 	struct zpci_bar_struct bars[PCI_BAR_COUNT];
 
@@ -173,6 +176,10 @@ static inline bool zdev_enabled(struct zpci_dev *zdev)
 int clp_enable_fh(struct zpci_dev *, u8);
 int clp_disable_fh(struct zpci_dev *);
 
+/* IOMMU Interface */
+int zpci_init_iommu(struct zpci_dev *zdev);
+void zpci_destroy_iommu(struct zpci_dev *zdev);
+
 #ifdef CONFIG_PCI
 /* Error handling and recovery */
 void zpci_event_error(void *);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 364b9d8..3178e4d 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -754,6 +754,7 @@ void pcibios_remove_bus(struct pci_bus *bus)
 
 	zpci_exit_slot(zdev);
 	zpci_cleanup_bus_resources(zdev);
+	zpci_destroy_iommu(zdev);
 	zpci_free_domain(zdev);
 
 	spin_lock(&zpci_list_lock);
@@ -825,11 +826,15 @@ int zpci_create_device(struct zpci_dev *zdev)
 	if (rc)
 		goto out;
 
+	rc = zpci_init_iommu(zdev);
+	if (rc)
+		goto out_free;
+
 	mutex_init(&zdev->lock);
 	if (zdev->state == ZPCI_FN_STATE_CONFIGURED) {
 		rc = zpci_enable_device(zdev);
 		if (rc)
-			goto out_free;
+			goto out_iommu;
 	}
 	rc = zpci_scan_bus(zdev);
 	if (rc)
@@ -846,6 +851,9 @@ int zpci_create_device(struct zpci_dev *zdev)
 out_disable:
 	if (zdev->state == ZPCI_FN_STATE_ONLINE)
 		zpci_disable_device(zdev);
+out_iommu:
+	zpci_destroy_iommu(zdev);
+
 out_free:
 	zpci_free_domain(zdev);
 out:
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 179e636..cad3ad0 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -163,22 +163,22 @@ static void s390_iommu_detach_device(struct iommu_domain *domain,
 	}
 }
 
-static int s390_iommu_add_device(struct device *dev)
+static struct iommu_group *s390_iommu_device_group(struct device *dev)
 {
-	struct iommu_group *group;
-	int rc;
+	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
 
-	group = iommu_group_get(dev);
-	if (!group) {
-		group = iommu_group_alloc();
-		if (IS_ERR(group))
-			return PTR_ERR(group);
-	}
+	return zdev->group;
+}
+
+static int s390_iommu_add_device(struct device *dev)
+{
+	struct iommu_group *group = iommu_group_get_for_dev(dev);
+	if (IS_ERR(group))
+		return PTR_ERR(group);
 
-	rc = iommu_group_add_device(group, dev);
 	iommu_group_put(group);
 
-	return rc;
+	return 0;
 }
 
 static void s390_iommu_remove_device(struct device *dev)
@@ -333,6 +333,26 @@ static size_t s390_iommu_unmap(struct iommu_domain *domain,
 	return size;
 }
 
+int zpci_init_iommu(struct zpci_dev *zdev)
+{
+	int rc = 0;
+
+	zdev->group = iommu_group_alloc();
+
+	if (IS_ERR(zdev->group)) {
+		rc = PTR_ERR(zdev->group);
+		zdev->group = NULL;
+	}
+
+	return rc;
+}
+
+void zpci_destroy_iommu(struct zpci_dev *zdev)
+{
+	iommu_group_put(zdev->group);
+	zdev->group = NULL;
+}
+
 static struct iommu_ops s390_iommu_ops = {
 	.capable = s390_iommu_capable,
 	.domain_alloc = s390_domain_alloc,
@@ -344,6 +364,7 @@ static size_t s390_iommu_unmap(struct iommu_domain *domain,
 	.iova_to_phys = s390_iommu_iova_to_phys,
 	.add_device = s390_iommu_add_device,
 	.remove_device = s390_iommu_remove_device,
+	.device_group = s390_iommu_device_group,
 	.pgsize_bitmap = S390_IOMMU_PGSIZES,
 };
 
-- 
1.9.1
