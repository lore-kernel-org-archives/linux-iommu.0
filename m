From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] iommu/amd: Split init_iommu_group() from
	iommu_init_device()
Date: Fri, 19 Sep 2014 10:03:13 -0600
Message-ID: <20140919160312.14485.90453.stgit@gimli.home>
References: <20140919154944.14485.743.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140919154944.14485.743.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

For a PCI device, aliases from the IVRS table won't be populated
into dma_alias_devfn until after iommu_init_device() is called on
each device.  We therefore want to split init_iommu_group() to
be called from a separate loop immediately following.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # 3.17
---

 drivers/iommu/amd_iommu.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index ecb0109..5aff937 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -260,17 +260,13 @@ static bool check_device(struct device *dev)
 	return true;
 }
 
-static int init_iommu_group(struct device *dev)
+static void init_iommu_group(struct device *dev)
 {
 	struct iommu_group *group;
 
 	group = iommu_group_get_for_dev(dev);
-
-	if (IS_ERR(group))
-		return PTR_ERR(group);
-
-	iommu_group_put(group);
-	return 0;
+	if (!IS_ERR(group))
+		iommu_group_put(group);
 }
 
 static int __last_alias(struct pci_dev *pdev, u16 alias, void *data)
@@ -340,7 +336,6 @@ static int iommu_init_device(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct iommu_dev_data *dev_data;
 	u16 alias;
-	int ret;
 
 	if (dev->archdata.iommu)
 		return 0;
@@ -364,12 +359,6 @@ static int iommu_init_device(struct device *dev)
 		dev_data->alias_data = alias_data;
 	}
 
-	ret = init_iommu_group(dev);
-	if (ret) {
-		free_dev_data(dev_data);
-		return ret;
-	}
-
 	if (pci_iommuv2_capable(pdev)) {
 		struct amd_iommu *iommu;
 
@@ -455,6 +444,15 @@ int __init amd_iommu_init_devices(void)
 			goto out_free;
 	}
 
+	/*
+	 * Initialize IOMMU groups only after iommu_init_device() has
+	 * had a chance to populate any IVRS defined aliases.
+	 */
+	for_each_pci_dev(pdev) {
+		if (check_device(&pdev->dev))
+			init_iommu_group(&pdev->dev);
+	}
+
 	return 0;
 
 out_free:
@@ -2415,6 +2413,7 @@ static int device_change_notifier(struct notifier_block *nb,
 	case BUS_NOTIFY_ADD_DEVICE:
 
 		iommu_init_device(dev);
+		init_iommu_group(dev);
 
 		/*
 		 * dev_data is still NULL and
