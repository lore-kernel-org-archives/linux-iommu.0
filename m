From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] iommu/s390: Add support for iommu_device handling
Date: Thu, 27 Apr 2017 17:28:25 +0200
Message-ID: <1493306905-32334-3-git-send-email-joro@8bytes.org>
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

Add support for the iommu_device_register interface to make
the s390 hardware iommus visible to the iommu core and in
sysfs.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 arch/s390/include/asm/pci.h |  1 +
 drivers/iommu/s390-iommu.c  | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 045665d..8c071af 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -124,6 +124,7 @@ struct zpci_dev {
 	unsigned long	iommu_pages;
 	unsigned int	next_bit;
 
+	struct iommu_device iommu_dev;  /* IOMMU core handle */
 	struct iommu_group *group;	/* IOMMU group for all devices behind this zdev */
 
 	char res_name[16];
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index cad3ad0..ec7f5e4 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -18,6 +18,8 @@
  */
 #define S390_IOMMU_PGSIZES	(~0xFFFUL)
 
+static struct iommu_ops s390_iommu_ops;
+
 struct s390_domain {
 	struct iommu_domain	domain;
 	struct list_head	devices;
@@ -173,10 +175,13 @@ static struct iommu_group *s390_iommu_device_group(struct device *dev)
 static int s390_iommu_add_device(struct device *dev)
 {
 	struct iommu_group *group = iommu_group_get_for_dev(dev);
+	struct zpci_dev *zdev = to_pci_dev(dev)->sysdata;
+
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
 	iommu_group_put(group);
+	iommu_device_link(&zdev->iommu_dev, dev);
 
 	return 0;
 }
@@ -203,6 +208,7 @@ static void s390_iommu_remove_device(struct device *dev)
 			s390_iommu_detach_device(domain, dev);
 	}
 
+	iommu_device_unlink(&zdev->iommu_dev, dev);
 	iommu_group_remove_device(dev);
 }
 
@@ -342,13 +348,37 @@ int zpci_init_iommu(struct zpci_dev *zdev)
 	if (IS_ERR(zdev->group)) {
 		rc = PTR_ERR(zdev->group);
 		zdev->group = NULL;
+		goto out_err;
 	}
 
+	rc = iommu_device_sysfs_add(&zdev->iommu_dev, NULL, NULL,
+				    "s390-iommu.%08x", zdev->fid);
+	if (rc)
+		goto out_group;
+
+	iommu_device_set_ops(&zdev->iommu_dev, &s390_iommu_ops);
+
+	rc = iommu_device_register(&zdev->iommu_dev);
+	if (rc)
+		goto out_sysfs;
+
+	return 0;
+
+out_sysfs:
+	iommu_device_sysfs_remove(&zdev->iommu_dev);
+
+out_group:
+	iommu_group_put(zdev->group);
+	zdev->group = NULL;
+
+out_err:
 	return rc;
 }
 
 void zpci_destroy_iommu(struct zpci_dev *zdev)
 {
+	iommu_device_unregister(&zdev->iommu_dev);
+	iommu_device_sysfs_remove(&zdev->iommu_dev);
 	iommu_group_put(zdev->group);
 	zdev->group = NULL;
 }
-- 
1.9.1
