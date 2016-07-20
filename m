From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/3] memory: mediatek: Add a new interface
	mtk_smi_larb_is_ready
Date: Wed, 20 Jul 2016 11:01:59 +0800
Message-ID: <1468983721-3627-1-git-send-email-yong.wu@mediatek.com>
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
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, CK Hu <ck.hu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Bibby Hsieh <bibby.hsieh-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, YT Shen <yt.shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tiffany Lin <tiffany.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Currently the iommu consumer always call iommu_present to get whether
the iommu is ready. But in MTK IOMMU, this function can't indicate
this. The IOMMU call bus_set_iommu->mtk_iommu_add_device->
mtk_iommu_attach_device to parse the iommu data, then it's able to
transfer "struct mtk_smi_iommu" to SMI-LARB, and the iommu uses the
larbs as compoents, the iommu will finish its probe until all the larbs
probe done.

If the iommu consumer(like DRM) begin to probe after the time of
calling bus_set_iommu and before the time of SMI probe finish, it
will hang like this:

[    7.832359] Call trace:
[    7.834778] [<ffffffc000764424>] mtk_smi_larb_get+0x24/0xa8
[    7.840300] [<ffffffc0005a1390>] mtk_drm_crtc_enable+0x6c/0x450

Because the larb->mmu is NULL at that time.

In order to avoid this issue, we add a new interface
(mtk_smi_larb_is_ready) for checking whether the IOMMU and SMI have
finished their probe. If it return false, the iommu consumer should
probe-defer for the IOMMU and SMI.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
Adding this interface is for avoid adjust the sequence of power
domain probe[1]. This patch-set is based on next-20160719. And
patch[1/3] base on [2], patch[3/3] base on [3], both are in the
pull tree.

[1]:http://lists.infradead.org/pipermail/linux-mediatek/2016-July/006189.html
[2]:https://patchwork.kernel.org/patch/9164067/
[3]:http://www.spinics.net/lists/arm-kernel/msg517840.html
---
 drivers/memory/mtk-smi.c   | 8 ++++++++
 include/soc/mediatek/smi.h | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 4afbc41..3e58cbb7 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -141,6 +141,14 @@ void mtk_smi_larb_put(struct device *larbdev)
 }
 EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
 
+bool mtk_smi_larb_is_ready(struct device *larbdev)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
+
+	return larb && larb->mmu;
+}
+EXPORT_SYMBOL_GPL(mtk_smi_larb_is_ready);
+
 static int
 mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
 {
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index 8893c5e..f0690e0 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -33,6 +33,9 @@ struct mtk_smi_iommu {
 	struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX];
 };
 
+/* Whether SMI-larb has probe done. */
+bool mtk_smi_larb_is_ready(struct device *larbdev);
+
 /*
  * mtk_smi_larb_get: Enable the power domain and clocks for this local arbiter.
  *                   It also initialize some basic setting(like iommu).
@@ -46,6 +49,11 @@ void mtk_smi_larb_put(struct device *larbdev);
 
 #else
 
+static inline bool mtk_smi_larb_is_ready(struct device *larbdev)
+{
+	return false;
+}
+
 static inline int mtk_smi_larb_get(struct device *larbdev)
 {
 	return 0;
-- 
1.8.1.1.dirty
