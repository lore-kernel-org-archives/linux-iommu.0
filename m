From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V4 09/21] iommu/vt-d: Change
	iommu_enable/disable_translation to return void
Date: Fri, 11 Jul 2014 14:19:33 +0800
Message-ID: <1405059585-10620-10-git-send-email-jiang.liu@linux.intel.com>
References: <1405059585-10620-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1405059585-10620-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Simplify error handling path by changing iommu_{enable|disable}_translation
to return void.

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5d7383775bf1..0ba078bc0f32 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1389,7 +1389,7 @@ static void iommu_disable_protect_mem_regions(struct intel_iommu *iommu)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
 }
 
-static int iommu_enable_translation(struct intel_iommu *iommu)
+static void iommu_enable_translation(struct intel_iommu *iommu)
 {
 	u32 sts;
 	unsigned long flags;
@@ -1403,10 +1403,9 @@ static int iommu_enable_translation(struct intel_iommu *iommu)
 		      readl, (sts & DMA_GSTS_TES), sts);
 
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
-	return 0;
 }
 
-static int iommu_disable_translation(struct intel_iommu *iommu)
+static void iommu_disable_translation(struct intel_iommu *iommu)
 {
 	u32 sts;
 	unsigned long flag;
@@ -1420,7 +1419,6 @@ static int iommu_disable_translation(struct intel_iommu *iommu)
 		      readl, (!(sts & DMA_GSTS_TES)), sts);
 
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
-	return 0;
 }
 
 
@@ -2860,11 +2858,7 @@ static int __init init_dmars(void)
 
 		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
 		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
-
-		ret = iommu_enable_translation(iommu);
-		if (ret)
-			goto free_iommu;
-
+		iommu_enable_translation(iommu);
 		iommu_disable_protect_mem_regions(iommu);
 	}
 
@@ -3578,10 +3572,8 @@ static int init_iommu_hw(void)
 
 		iommu->flush.flush_context(iommu, 0, 0, 0,
 					   DMA_CCMD_GLOBAL_INVL);
-		iommu->flush.flush_iotlb(iommu, 0, 0, 0,
-					 DMA_TLB_GLOBAL_FLUSH);
-		if (iommu_enable_translation(iommu))
-			return 1;
+		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
+		iommu_enable_translation(iommu);
 		iommu_disable_protect_mem_regions(iommu);
 	}
 
-- 
1.7.10.4
