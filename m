From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 04/13] iommu/mediatek: Add device_link between the consumer
	and the larb devices
Date: Tue, 1 Jan 2019 12:51:07 +0800
Message-ID: <1546318276-18993-5-git-send-email-yong.wu@mediatek.com>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1546318276-18993-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

MediaTek IOMMU don't have its power-domain. all the consumer connect
with smi-larb, then connect with smi-common.

        M4U
         |
    smi-common
         |
  -------------
  |         |    ...
  |         |
larb1     larb2
  |         |
vdec       venc

When the consumer works, it should enable the smi-larb's power which
also need enable the smi-common's power firstly.

Thus, First of all, use the device link connect the consumer and the
smi-larbs. then add device link between the smi-larb and smi-common.

This patch adds device_link between the consumer and the larbs.

Suggested-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/iommu/mtk_iommu.c    | 15 +++++++++++++--
 drivers/iommu/mtk_iommu_v1.c | 14 ++++++++++++--
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 202e41b..735ae8d 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -247,6 +247,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 	struct mtk_smi_larb_iommu    *larb_mmu;
 	unsigned int                 larbid, portid;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct device_link *link;
 	int i;
 
 	for (i = 0; i < fwspec->num_ids; ++i) {
@@ -257,10 +258,20 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 		dev_dbg(dev, "%s iommu port: %d\n",
 			enable ? "enable" : "disable", portid);
 
-		if (enable)
+		if (enable) {
 			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
-		else
+			/* Link the consumer with the larb device(supplier) */
+			link = device_link_add(dev, larb_mmu->dev,
+					       DL_FLAG_PM_RUNTIME |
+					       DL_FLAG_AUTOREMOVE_CONSUMER);
+			if (!link) {
+				dev_err(dev, "Unable to link %s\n",
+					dev_name(larb_mmu->dev));
+				return;
+			}
+		} else {
 			larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
+		}
 	}
 }
 
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 9386aee..022bad9 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -201,6 +201,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 	struct mtk_smi_larb_iommu    *larb_mmu;
 	unsigned int                 larbid, portid;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct device_link *link;
 	int i;
 
 	for (i = 0; i < fwspec->num_ids; ++i) {
@@ -211,10 +212,19 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 		dev_dbg(dev, "%s iommu port: %d\n",
 			enable ? "enable" : "disable", portid);
 
-		if (enable)
+		if (enable) {
 			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
-		else
+			link = device_link_add(dev, larb_mmu->dev,
+					       DL_FLAG_PM_RUNTIME |
+					       DL_FLAG_AUTOREMOVE_CONSUMER);
+			if (!link) {
+				dev_err(dev, "Unable to link %s\n",
+					dev_name(larb_mmu->dev));
+				return;
+			}
+		} else {
 			larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
+		}
 	}
 }
 
-- 
1.9.1
