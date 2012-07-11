From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 10/27] iommu/amd: Introduce amd_iommu_init_dma routine
Date: Wed, 11 Jul 2012 15:38:55 +0200
Message-ID: <1342013952-10174-11-git-send-email-joerg.roedel@amd.com>
References: <1342013952-10174-1-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1342013952-10174-1-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This function will initialize everthing necessary so that
devices can do DMA. This includes dma_ops and iommu_ops.

Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 514556c..5311a88 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1627,8 +1627,6 @@ int __init amd_iommu_init_hardware(void)
 
 	enable_iommus();
 
-	amd_iommu_init_notifier();
-
 	register_syscore_ops(&amd_iommu_syscore_ops);
 
 	return ret;
@@ -1669,6 +1667,25 @@ static bool detect_ivrs(void)
 	return true;
 }
 
+static int amd_iommu_init_dma(void)
+{
+	int ret;
+
+	if (iommu_pass_through)
+		ret = amd_iommu_init_passthrough();
+	else
+		ret = amd_iommu_init_dma_ops();
+
+	if (ret)
+		return ret;
+
+	amd_iommu_init_api();
+
+	amd_iommu_init_notifier();
+
+	return 0;
+}
+
 /*
  * This is the core init function for AMD IOMMU hardware in the system.
  * This function is called from the generic x86 DMA layer initialization
@@ -1690,11 +1707,7 @@ static int __init amd_iommu_init(void)
 	if (ret)
 		goto free;
 
-	if (iommu_pass_through)
-		ret = amd_iommu_init_passthrough();
-	else
-		ret = amd_iommu_init_dma_ops();
-
+	ret = amd_iommu_init_dma();
 	if (ret)
 		goto free;
 
-- 
1.7.9.5
