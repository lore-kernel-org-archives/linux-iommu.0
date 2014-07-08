From: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] iommu/amd: Fix for pasid initialization
Date: Tue, 8 Jul 2014 17:30:16 +0300
Message-ID: <1404829817-19584-1-git-send-email-oded.gabbay@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alexey Skidanov <Alexey.Skidanov-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Alexey Skidanov <Alexey.Skidanov-5C7GfCeVMHo@public.gmane.org>

The pasid wasn't properly initialized before caling to invalid PPR calback

Signed-off-by: Alexey Skidanov <Alexey.Skidanov-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 499b436..92fb77c 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -612,6 +612,7 @@ static int ppr_notifier(struct notifier_block *nb, unsigned long e, void *data)
 	fault->state     = pasid_state;
 	fault->tag       = tag;
 	fault->finish    = finish;
+	fault->pasid     = iommu_fault->pasid;
 	fault->flags     = iommu_fault->flags;
 	INIT_WORK(&fault->work, do_fault);
 
-- 
1.9.1
