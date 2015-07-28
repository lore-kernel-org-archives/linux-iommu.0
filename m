From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/5] iommu/amd: Use swiotlb in passthrough mode
Date: Tue, 28 Jul 2015 16:58:50 +0200
Message-ID: <1438095531-26777-5-git-send-email-joro@8bytes.org>
References: <1438095531-26777-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438095531-26777-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

In passthrough mode (iommu=pt) all devices are identity
mapped. If a device does not support 64bit DMA it might
still need remapping. Make sure swiotlb is initialized to
provide this remapping.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6d3dae9..e29baa6 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2282,12 +2282,10 @@ static int amd_iommu_add_device(struct device *dev)
 
 	/* Domains are initialized for this device - have a look what we ended up with */
 	domain = iommu_get_domain_for_dev(dev);
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
 		dev_data->passthrough = true;
-		dev->archdata.dma_ops = &nommu_dma_ops;
-	} else {
+	else
 		dev->archdata.dma_ops = &amd_iommu_dma_ops;
-	}
 
 out:
 	iommu_completion_wait(iommu);
@@ -2852,8 +2850,8 @@ int __init amd_iommu_init_api(void)
 
 int __init amd_iommu_init_dma_ops(void)
 {
+	swiotlb        = iommu_pass_through ? 1 : 0;
 	iommu_detected = 1;
-	swiotlb = 0;
 
 	amd_iommu_stats_init();
 
-- 
1.9.1
