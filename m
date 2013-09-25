From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/3] Fix compile error in drivers/gpu/drm/msm/msm_drv.c with
	IOMMU disabled
Date: Wed, 25 Sep 2013 16:49:42 +0200
Message-ID: <1380120582-9068-3-git-send-email-joro@8bytes.org>
References: <1380120582-9068-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1380120582-9068-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The function msm_iommu_get_ctx() is needed buy the MSM-GPU
driver with and wiithout IOMMU compiled in. Make the
function available when no IOMMU driver is there.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/msm_iommu.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/msm_iommu.h b/drivers/iommu/msm_iommu.h
index 5c7c955..da53558 100644
--- a/drivers/iommu/msm_iommu.h
+++ b/drivers/iommu/msm_iommu.h
@@ -108,7 +108,14 @@ struct msm_iommu_ctx_drvdata {
  * Useful for testing and drivers that do not yet fully have IOMMU stuff in
  * their platform devices.
  */
+#ifdef CONFIG_MSM_IOMMU
 struct device *msm_iommu_get_ctx(const char *ctx_name);
+#else
+static inline struct device *msm_iommu_get_ctx(const char *ctx_name)
+{
+	return NULL;
+}
+#endif
 
 /*
  * Interrupt handler for the IOMMU context fault interrupt. Hooking the
-- 
1.7.9.5
