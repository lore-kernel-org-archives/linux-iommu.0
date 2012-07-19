From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] iommu/amd: Fix hotplug with iommu=pt
Date: Thu, 19 Jul 2012 13:45:21 +0200
Message-ID: <1342698321-21720-2-git-send-email-joerg.roedel@amd.com>
References: <1342698321-21720-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1342698321-21720-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This did not work because devices are not put into the
pt_domain. Fix this.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6256263..3f365ab 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2254,6 +2254,18 @@ static int device_change_notifier(struct notifier_block *nb,
 
 		iommu_init_device(dev);
 
+		/*
+		 * dev_data is still NULL and
+		 * got initialized in iommu_init_device
+		 */
+		dev_data = get_dev_data(dev);
+
+		if (iommu_pass_through || dev_data->iommu_v2) {
+			dev_data->passthrough = true;
+			attach_device(dev, pt_domain);
+			break;
+		}
+
 		domain = domain_for_device(dev);
 
 		/* allocate a protection domain if a device is added */
@@ -2271,10 +2283,7 @@ static int device_change_notifier(struct notifier_block *nb,
 
 		dev_data = get_dev_data(dev);
 
-		if (!dev_data->passthrough)
-			dev->archdata.dma_ops = &amd_iommu_dma_ops;
-		else
-			dev->archdata.dma_ops = &nommu_dma_ops;
+		dev->archdata.dma_ops = &amd_iommu_dma_ops;
 
 		break;
 	case BUS_NOTIFY_DEL_DEVICE:
-- 
1.7.9.5
