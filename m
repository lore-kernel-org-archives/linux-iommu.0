From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] iommu/msm: wire up fault handling
Date: Fri, 12 Aug 2016 11:29:07 -0400
Message-ID: <1471015747-569-2-git-send-email-robdclark@gmail.com>
References: <1471015747-569-1-git-send-email-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1471015747-569-1-git-send-email-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When things go wrong on the gpu, we can get *thousands* of faults.  With
so many pr_err() prints, which were slowing down resuming the iommu,
drm/msm would think the GPU had actually hung and reset it.

Wire up the fault reporting, so instead we get a small ratelimited print
of the fault address from drm/msm's fault handler instead.

Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/msm_iommu.c | 16 +++++++++++-----
 drivers/iommu/msm_iommu.h |  3 +++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index f6f596f..1110b72 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -411,6 +411,7 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 			}
 			__disable_clocks(iommu);
 			list_add(&iommu->dom_node, &priv->list_attached);
+			iommu->domain = domain;
 		}
 	}
 
@@ -614,8 +615,8 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 		goto fail;
 	}
 
-	pr_err("Unexpected IOMMU page fault!\n");
-	pr_err("base = %08x\n", (unsigned int)iommu->base);
+	pr_debug("Unexpected IOMMU page fault!\n");
+	pr_debug("base = %08x\n", (unsigned int)iommu->base);
 
 	ret = __enable_clocks(iommu);
 	if (ret)
@@ -624,9 +625,14 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 	for (i = 0; i < iommu->ncb; i++) {
 		fsr = GET_FSR(iommu->base, i);
 		if (fsr) {
-			pr_err("Fault occurred in context %d.\n", i);
-			pr_err("Interesting registers:\n");
-			print_ctx_regs(iommu->base, i);
+			int ret = report_iommu_fault(iommu->domain,
+					to_msm_priv(iommu->domain)->dev,
+					GET_FAR(iommu->base, i), 0);
+			if (ret == -ENOSYS) {
+				pr_err("Fault occurred in context %d.\n", i);
+				pr_err("Interesting registers:\n");
+				print_ctx_regs(iommu->base, i);
+			}
 			SET_FSR(iommu->base, i, 0x4000000F);
 			SET_RESUME(iommu->base, i, 1);
 		}
diff --git a/drivers/iommu/msm_iommu.h b/drivers/iommu/msm_iommu.h
index 4ca25d5..c53016c 100644
--- a/drivers/iommu/msm_iommu.h
+++ b/drivers/iommu/msm_iommu.h
@@ -56,6 +56,8 @@
  * dom_node:	list head for domain
  * ctx_list:	list of 'struct msm_iommu_ctx_dev'
  * context_map: Bitmap to track allocated context banks
+ * domain:	iommu domain that this iommu dev is a member of,
+ * 		ie. whose msm_priv::list_attached are we on?
  */
 struct msm_iommu_dev {
 	void __iomem *base;
@@ -68,6 +70,7 @@ struct msm_iommu_dev {
 	struct list_head dom_node;
 	struct list_head ctx_list;
 	DECLARE_BITMAP(context_map, IOMMU_MAX_CBS);
+	struct iommu_domain *domain;
 };
 
 /**
-- 
2.7.4
