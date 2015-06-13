From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 04/19] iommu/vt-d: Detect pre enabled translation
Date: Sat, 13 Jun 2015 08:47:12 +0200
Message-ID: <1434178047-17809-5-git-send-email-joro@8bytes.org>
References: <1434178047-17809-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1434178047-17809-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, jroedel-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhen-hual-VXdhtT5mjnY@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Add code to detect whether translation is already enabled in
the IOMMU. Save this state in a flags field added to
struct intel_iommu.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 19 +++++++++++++++++++
 include/linux/intel-iommu.h |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f82918e..467414b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -435,6 +435,20 @@ static LIST_HEAD(device_domain_list);
 
 static const struct iommu_ops intel_iommu_ops;
 
+static bool translation_pre_enabled(struct intel_iommu *iommu)
+{
+	return (iommu->flags & VTD_FLAG_TRANS_PRE_ENABLED);
+}
+
+static void init_translation_status(struct intel_iommu *iommu)
+{
+	u32 gsts;
+
+	gsts = readl(iommu->reg + DMAR_GSTS_REG);
+	if (gsts & DMA_GSTS_TES)
+		iommu->flags |= VTD_FLAG_TRANS_PRE_ENABLED;
+}
+
 /* Convert generic 'struct iommu_domain to private struct dmar_domain */
 static struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
 {
@@ -2789,6 +2803,11 @@ static int __init init_dmars(void)
 		if (ret)
 			goto free_iommu;
 
+		init_translation_status(iommu);
+
+		if (translation_pre_enabled(iommu))
+			pr_info("Translation already enabled - trying to copy translation structures\n");
+
 		/*
 		 * TBD:
 		 * we could share the same root & context tables
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 796ef96..fff87f1 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -319,6 +319,9 @@ enum {
 	MAX_SR_DMAR_REGS
 };
 
+#define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
+#define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
+
 struct intel_iommu {
 	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
 	u64 		reg_phys; /* physical address of hw register set */
@@ -350,6 +353,7 @@ struct intel_iommu {
 #endif
 	struct device	*iommu_dev; /* IOMMU-sysfs device */
 	int		node;
+	u32		flags;      /* Software defined flags */
 };
 
 static inline void __iommu_flush_cache(
-- 
1.9.1
