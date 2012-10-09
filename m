From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC PATCH 4/5] amd_iommu: Split IOMMU group allocation and attach
Date: Mon, 08 Oct 2012 22:49:54 -0600
Message-ID: <20121009044954.16302.75951.stgit@bling.home>
References: <20121009044057.16302.44577.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20121009044057.16302.44577.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg.Roedel-5C7GfCeVMHo@public.gmane.org, florian-Q0TRQrZM+Zzk1uMJSBkQmQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add a WARN_ON to make it clear why we don't add dma_pdev->dev to the
group we're allocating.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/iommu/amd_iommu.c |   30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 3a00b5ce..7fa97a5 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -325,6 +325,24 @@ static struct pci_dev *get_isolation_root(struct pci_dev *pdev)
 	return dma_pdev;
 }
 
+static int use_pdev_iommu_group(struct pci_dev *pdev, struct device *dev)
+{
+	struct iommu_group *group = iommu_group_get(&pdev->dev);
+	int ret;
+
+	if (!group) {
+		group = iommu_group_alloc();
+		if (IS_ERR(group))
+			return PTR_ERR(group);
+
+		WARN_ON(&pdev->dev != dev);
+	}
+
+	ret = iommu_group_add_device(group, dev);
+	iommu_group_put(group);
+	return ret;
+}
+
 static int init_iommu_group(struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
@@ -353,18 +371,8 @@ static int init_iommu_group(struct device *dev)
 		dma_pdev = pci_dev_get(to_pci_dev(dev));
 
 	dma_pdev = get_isolation_root(dma_pdev);
-	group = iommu_group_get(&dma_pdev->dev);
+	ret = use_pdev_iommu_group(dma_pdev, dev);
 	pci_dev_put(dma_pdev);
-	if (!group) {
-		group = iommu_group_alloc();
-		if (IS_ERR(group))
-			return PTR_ERR(group);
-	}
-
-	ret = iommu_group_add_device(group, dev);
-
-	iommu_group_put(group);
-
 	return ret;
 }
 
