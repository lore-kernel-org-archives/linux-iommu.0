From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 8/8] memory: mtk-smi: Degrade SMI init to module_init
Date: Mon, 21 Aug 2017 19:00:21 +0800
Message-ID: <1503313221-26453-9-git-send-email-yong.wu@mediatek.com>
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

The initialization of MediaTek power manager(SCPSYS) is
builtin_platform_driver, and SMI must depend on power-domain.
Thus, currently subsys_initcall for SMI is unnecessary, SMI will be
always probe defered by power-domain. Degrade it to module_init.

In addition, there are two small changes about the probe sequence:
1) Delete this two lines.
    	if (!dev->pm_domain)
		return -EPROBE_DEFER;
   This is not helpful. the platform driver framework guarantee this.
   The "dev_pm_domain_attach" in the "platform_drv_probe" will return
   EPROBE_DEFER if its powerdomain is not ready.

2) Add the probe-defer for the smi-larb device should waiting for
   smi-common.
   In mt2712, there are 2 smi-commons, 10 smi-larbs. All will be
   probe-defered by the power-domain, there is seldom case that
   smi-larb probe done before smi-common. then it will hang like
   this:

   Unable to handle kernel NULL pointer dereference at virtual address
00000000 pgd = ffffff800a4e0000
[00000000] *pgd=00000000beffe003[   17.610026] , *pud=00000000beffe003
...
[<ffffff800897fe04>] mtk_smi_enable+0x1c/0xd0
[<ffffff800897fee8>] mtk_smi_larb_get+0x30/0x98
[<ffffff80088edfa8>] mtk_mipicsi0_resume+0x38/0x1b8
[<ffffff8008634f44>] pm_generic_runtime_resume+0x3c/0x58
[<ffffff8008644ff8>] __genpd_runtime_resume+0x38/0x98
[<ffffff8008647434>] genpd_runtime_resume+0x164/0x220
[<ffffff80086372f8>] __rpm_callback+0x78/0xa0
[<ffffff8008637358>] rpm_callback+0x38/0xa0
[<ffffff8008638a4c>] rpm_resume+0x4a4/0x6f8
[<ffffff8008638d04>] __pm_runtime_resume+0x64/0xa0
[<ffffff80088ed05c>] mtk_mipicsi0_probe+0x40c/0xb70
[<ffffff800862cdc0>] platform_drv_probe+0x58/0xc0
[<ffffff800862a514>] driver_probe_device+0x284/0x438
[<ffffff800862a8ac>] __device_attach_driver+0xb4/0x160
[<ffffff8008627d58>] bus_for_each_drv+0x68/0xa8
[<ffffff800862a0a4>] __device_attach+0xd4/0x168
[<ffffff800862a9d4>] device_initial_probe+0x24/0x30
[<ffffff80086291d8>] bus_probe_device+0xa0/0xa8
[<ffffff8008629784>] deferred_probe_work_func+0x94/0xf0
[<ffffff80080f03a8>] process_one_work+0x1d8/0x6e0

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 drivers/memory/mtk-smi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 8ffe321..8f2d152 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -288,9 +289,6 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	struct platform_device *smi_pdev;
 	int err;
 
-	if (!dev->pm_domain)
-		return -EPROBE_DEFER;
-
 	larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
 	if (!larb)
 		return -ENOMEM;
@@ -326,6 +324,8 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	smi_pdev = of_find_device_by_node(smi_node);
 	of_node_put(smi_node);
 	if (smi_pdev) {
+		if (!platform_get_drvdata(smi_pdev))
+			return -EPROBE_DEFER;
 		larb->smi_common_dev = &smi_pdev->dev;
 	} else {
 		dev_err(dev, "Failed to get the smi_common device\n");
@@ -377,9 +377,6 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	enum mtk_smi_gen smi_gen;
 	int ret;
 
-	if (!dev->pm_domain)
-		return -EPROBE_DEFER;
-
 	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
 	if (!common)
 		return -ENOMEM;
@@ -456,4 +453,4 @@ static int __init mtk_smi_init(void)
 	return ret;
 }
 
-subsys_initcall(mtk_smi_init);
+module_init(mtk_smi_init);
-- 
1.9.1
