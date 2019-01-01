From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v5 03/20] memory: mtk-smi: Use a general config_port interface
Date: Tue, 1 Jan 2019 11:55:35 +0800
Message-ID: <1546314952-15990-4-git-send-email-yong.wu@mediatek.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1546314952-15990-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The config_port of mt2712 and mt8183 are the same. Use a general
config_port interface instead.

In addition, in mt2712, larb8 and larb9 are the bdpsys larbs which
are not the normal larb, their register space are different from the
normal one. thus, we can not call the general config_port. In mt8183,
IPU0/1 and CCU connect with smi-common directly, they also are not
the normal larb. Hence, we add a "larb_direct_to_common_mask" for these
larbs which connect to smi-commmon directly.

This is also a preparing patch for adding mt8183 SMI support.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Reviewed-by: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/memory/mtk-smi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 8f2d152..9fd6b3d 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -53,6 +53,7 @@ struct mtk_smi_larb_gen {
 	bool need_larbid;
 	int port_in_larb[MTK_LARB_NR_MAX + 1];
 	void (*config_port)(struct device *);
+	unsigned int larb_direct_to_common_mask;
 };
 
 struct mtk_smi {
@@ -176,17 +177,13 @@ void mtk_smi_larb_put(struct device *larbdev)
 	return -ENODEV;
 }
 
-static void mtk_smi_larb_config_port_mt2712(struct device *dev)
+static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
 	u32 reg;
 	int i;
 
-	/*
-	 * larb 8/9 is the bdpsys larb, the iommu_en is enabled defaultly.
-	 * Don't need to set it again.
-	 */
-	if (larb->larbid == 8 || larb->larbid == 9)
+	if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
 		return;
 
 	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
@@ -261,7 +258,8 @@ static void mtk_smi_larb_config_port_gen1(struct device *dev)
 
 static const struct mtk_smi_larb_gen mtk_smi_larb_mt2712 = {
 	.need_larbid = true,
-	.config_port = mtk_smi_larb_config_port_mt2712,
+	.config_port                = mtk_smi_larb_config_port_gen2_general,
+	.larb_direct_to_common_mask = BIT(8) | BIT(9),      /* bdpsys */
 };
 
 static const struct of_device_id mtk_smi_larb_of_ids[] = {
-- 
1.9.1
