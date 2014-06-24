From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 3/3] iommu/fsl: Fix the error condition during iommu group
Date: Tue, 24 Jun 2014 19:27:17 +0530
Message-ID: <1403618237-26248-4-git-send-email-Varun.Sethi@freescale.com>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1403618237-26248-1-git-send-email-Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Earlier PTR_ERR was being returned even if group was set to null.
Now, we explicitly set an ERR_PTR value in case the group  pointer is
NULL.

Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu_domain.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 54060d1..af47648 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -1037,12 +1037,15 @@ root_bus:
 			group = get_shared_pci_device_group(pdev);
 	}
 
+	if (!group)
+		group = ERR_PTR(-ENODEV);
+
 	return group;
 }
 
 static int fsl_pamu_add_device(struct device *dev)
 {
-	struct iommu_group *group = NULL;
+	struct iommu_group *group = ERR_PTR(-ENODEV);
 	struct pci_dev *pdev;
 	const u32 *prop;
 	int ret, len;
@@ -1065,7 +1068,7 @@ static int fsl_pamu_add_device(struct device *dev)
 			group = get_device_iommu_group(dev);
 	}
 
-	if (!group || IS_ERR(group))
+	if (IS_ERR(group))
 		return PTR_ERR(group);
 
 	ret = iommu_group_add_device(group, dev);
-- 
1.7.9.5
