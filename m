From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] iommu/omap: fix checkpatch warnings in omap iommu code
Date: Thu, 30 May 2013 18:10:59 -0500
Message-ID: <1369955459-51101-1-git-send-email-s-anna@ti.com>
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
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch fixes the checkpatch warnings in omap iommu
code, most of them are related to broken strings.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 drivers/iommu/omap-iommu.c     | 9 ++++-----
 drivers/iommu/omap-iopgtable.h | 2 +-
 drivers/iommu/omap-iovmm.c     | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 0cc658c..0ba3766 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -833,16 +833,15 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	iopgd = iopgd_offset(obj, da);
 
 	if (!iopgd_is_table(*iopgd)) {
-		dev_err(obj->dev, "%s: errs:0x%08x da:0x%08x pgd:0x%p "
-			"*pgd:px%08x\n", obj->name, errs, da, iopgd, *iopgd);
+		dev_err(obj->dev, "%s: errs:0x%08x da:0x%08x pgd:0x%p *pgd:px%08x\n",
+				obj->name, errs, da, iopgd, *iopgd);
 		return IRQ_NONE;
 	}
 
 	iopte = iopte_offset(iopgd, da);
 
-	dev_err(obj->dev, "%s: errs:0x%08x da:0x%08x pgd:0x%p *pgd:0x%08x "
-		"pte:0x%p *pte:0x%08x\n", obj->name, errs, da, iopgd, *iopgd,
-		iopte, *iopte);
+	dev_err(obj->dev, "%s: errs:0x%08x da:0x%08x pgd:0x%p *pgd:0x%08x pte:0x%p *pte:0x%08x\n",
+			obj->name, errs, da, iopgd, *iopgd, iopte, *iopte);
 
 	return IRQ_NONE;
 }
diff --git a/drivers/iommu/omap-iopgtable.h b/drivers/iommu/omap-iopgtable.h
index cd4ae9e..f4003d5 100644
--- a/drivers/iommu/omap-iopgtable.h
+++ b/drivers/iommu/omap-iopgtable.h
@@ -95,4 +95,4 @@ static inline phys_addr_t omap_iommu_translate(u32 d, u32 va, u32 mask)
 #define iopte_offset(iopgd, da)	(iopgd_page_vaddr(iopgd) + iopte_index(da))
 
 #define to_iommu(dev)							\
-	(struct omap_iommu *)platform_get_drvdata(to_platform_device(dev))
+	((struct omap_iommu *)platform_get_drvdata(to_platform_device(dev)))
diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
index 46d87569..d147259 100644
--- a/drivers/iommu/omap-iovmm.c
+++ b/drivers/iommu/omap-iovmm.c
@@ -102,8 +102,8 @@ static size_t sgtable_len(const struct sg_table *sgt)
 		}
 
 		if (i && sg->offset) {
-			pr_err("%s: sg[%d] offset not allowed in internal "
-					"entries\n", __func__, i);
+			pr_err("%s: sg[%d] offset not allowed in internal entries\n",
+				__func__, i);
 			return 0;
 		}
 
-- 
1.8.2
