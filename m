From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/8] iommu/mediatek: Move MTK_M4U_TO_LARB/PORT into
	mtk_iommu.c
Date: Mon, 21 Aug 2017 19:00:15 +0800
Message-ID: <1503313221-26453-3-git-send-email-yong.wu@mediatek.com>
References: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1503313221-26453-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cloud.zhou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The definition of MTK_M4U_TO_LARB and MTK_M4U_TO_PORT are shared by
all the gen2 M4U HWs. Thus, Move them out from mt8173-larb-port.h,
and put them into the c file.

Suggested-by: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
This patch only moves the position of the MACRO MTK_M4U_TO_LARB/PORT.
---
 drivers/iommu/mtk_iommu.c                     | 8 +++++++-
 include/dt-bindings/memory/mt8173-larb-port.h | 4 ----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 91c6d36..4db6c8f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -31,7 +31,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <asm/barrier.h>
-#include <dt-bindings/memory/mt8173-larb-port.h>
 #include <soc/mediatek/smi.h>
 
 #include "mtk_iommu.h"
@@ -93,6 +92,13 @@
 
 #define MTK_PROTECT_PA_ALIGN			128
 
+/*
+ * Get the local arbiter ID and the portid within the larb arbiter
+ * from mtk_m4u_id which is defined by MTK_M4U_ID.
+ */
+#define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x7)
+#define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
+
 struct mtk_iommu_domain {
 	spinlock_t			pgtlock; /* lock for page table */
 
diff --git a/include/dt-bindings/memory/mt8173-larb-port.h b/include/dt-bindings/memory/mt8173-larb-port.h
index 5fef5d1..111b4b0 100644
--- a/include/dt-bindings/memory/mt8173-larb-port.h
+++ b/include/dt-bindings/memory/mt8173-larb-port.h
@@ -15,10 +15,6 @@
 #define __DTS_IOMMU_PORT_MT8173_H
 
 #define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
-/* Local arbiter ID */
-#define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x7)
-/* PortID within the local arbiter */
-#define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
-- 
1.9.1
