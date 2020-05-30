Return-Path: <SRS0=Olas=7M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE78C433E0
	for <iommu@archiver.kernel.org>; Sat, 30 May 2020 08:18:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D255B20776
	for <iommu@archiver.kernel.org>; Sat, 30 May 2020 08:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Nex3X0ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D255B20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 810F589297;
	Sat, 30 May 2020 08:18:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MopKrF5L1FrR; Sat, 30 May 2020 08:18:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A594F8818D;
	Sat, 30 May 2020 08:18:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99E63C0863;
	Sat, 30 May 2020 08:18:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 146BDC016F
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F01CE88432
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id igCfKpb40Yin for <iommu@lists.linux-foundation.org>;
 Sat, 30 May 2020 08:18:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 115DA883DD
 for <iommu@lists.linux-foundation.org>; Sat, 30 May 2020 08:18:29 +0000 (UTC)
X-UUID: 4a4812554fa14c0c9f44175554c76e2a-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=iCWpalRO0XdbVaztaRZx/ne1mVNpXmxirc1lXZWueNc=; 
 b=Nex3X0caJOFuI6fN54Rw5cd84ndGj86LMCJKjWRmAzqvw3EDPu+b0apOv86+klv39SVkc83asvHMXy9wGdN1xUW+acX6t5/r8N1WNpnuOVAuJiuTQYXNqUPt4+mDXjgFYagneAJwryIXIpk6H4AAzUpr6VIPlZkNUvM4kbK/rZU=;
X-UUID: 4a4812554fa14c0c9f44175554c76e2a-20200530
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 2132094191; Sat, 30 May 2020 16:13:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:13:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:13:22 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 07/17] media: mtk-mdp: Get rid of mtk_smi_larb_get/put
Date: Sat, 30 May 2020 16:10:08 +0800
Message-ID: <1590826218-23653-8-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
 Will Deacon <will.deacon@arm.com>, youlin.pei@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, Evan Green <evgreen@chromium.org>,
 eizan@chromium.org, Matthias Kaehlcke <mka@chromium.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 cui.zhang@mediatek.com, Houlong Wei <houlong.wei@mediatek.com>,
 Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com, acourbot@chromium.org,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

MediaTek IOMMU has already added the device_link between the consumer
and smi-larb device. If the mdp device call the pm_runtime_get_sync,
the smi-larb's pm_runtime_get_sync also be called automatically.

CC: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
CC: Houlong Wei <houlong.wei@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 44 +--------------------------
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  2 --
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  1 -
 3 files changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
index 228c58f..388ae67 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c
@@ -13,7 +13,6 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <soc/mediatek/smi.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
@@ -58,18 +57,6 @@ void mtk_mdp_comp_clock_on(struct mtk_mdp_comp *comp)
 {
 	int i, err;
 
-	if (comp->larb_dev) {
-		err = mtk_smi_larb_get(comp->larb_dev);
-		if (err) {
-			enum mtk_mdp_comp_type comp_type =
-				(enum mtk_mdp_comp_type)
-				of_device_get_match_data(comp->dev);
-			dev_err(comp->dev,
-				"failed to get larb, err %d. type:%d\n",
-				err, comp_type);
-		}
-	}
-
 	err = pm_runtime_get_sync(comp->dev);
 	if (err < 0)
 		dev_err(comp->dev,
@@ -97,9 +84,6 @@ void mtk_mdp_comp_clock_off(struct mtk_mdp_comp *comp)
 		clk_disable_unprepare(comp->clk[i]);
 	}
 
-	if (comp->larb_dev)
-		mtk_smi_larb_put(comp->larb_dev);
-
 	pm_runtime_put_sync(comp->dev);
 }
 
@@ -132,12 +116,10 @@ static void mtk_mdp_comp_unbind(struct device *dev, struct device *master,
 
 int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct device *dev)
 {
-	struct device_node *larb_node;
-	struct platform_device *larb_pdev;
-	int i;
 	struct device_node *node = dev->of_node;
 	enum mtk_mdp_comp_type comp_type =
 		 (enum mtk_mdp_comp_type)of_device_get_match_data(dev);
+	int i;
 
 	INIT_LIST_HEAD(&comp->node);
 	comp->dev = dev;
@@ -156,30 +138,6 @@ int mtk_mdp_comp_init(struct mtk_mdp_comp *comp, struct device *dev)
 			break;
 	}
 
-	/* Only DMA capable components need the LARB property */
-	comp->larb_dev = NULL;
-	if (comp_type != MTK_MDP_RDMA &&
-	    comp_type != MTK_MDP_WDMA &&
-	    comp_type != MTK_MDP_WROT)
-		return 0;
-
-	larb_node = of_parse_phandle(node, "mediatek,larb", 0);
-	if (!larb_node) {
-		dev_err(dev,
-			"Missing mediadek,larb phandle in %pOF node\n", node);
-		return -EINVAL;
-	}
-
-	larb_pdev = of_find_device_by_node(larb_node);
-	if (!larb_pdev) {
-		dev_warn(dev, "Waiting for larb device %pOF\n", larb_node);
-		of_node_put(larb_node);
-		return -EPROBE_DEFER;
-	}
-	of_node_put(larb_node);
-
-	comp->larb_dev = &larb_pdev->dev;
-
 	return 0;
 }
 
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
index de158d3..355e226 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_comp.h
@@ -11,13 +11,11 @@
  * struct mtk_mdp_comp - the MDP's function component data
  * @node:	list node to track sibing MDP components
  * @clk:	clocks required for component
- * @larb_dev:	SMI device required for component
  * @dev:	component's device
  */
 struct mtk_mdp_comp {
 	struct list_head	node;
 	struct clk		*clk[2];
-	struct device		*larb_dev;
 	struct device		*dev;
 };
 
diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index 133d107..bc5472d 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -18,7 +18,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/workqueue.h>
-#include <soc/mediatek/smi.h>
 
 #include "mtk_mdp_comp.h"
 #include "mtk_mdp_core.h"
-- 
1.9.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
