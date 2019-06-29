Return-Path: <SRS0=Olzo=U4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E39C5B57A
	for <iommu@archiver.kernel.org>; Sat, 29 Jun 2019 02:42:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651FB2086D
	for <iommu@archiver.kernel.org>; Sat, 29 Jun 2019 02:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651FB2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4C3B1D2E;
	Sat, 29 Jun 2019 02:42:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 50B05C00
	for <iommu@lists.linux-foundation.org>;
	Sat, 29 Jun 2019 02:42:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 784332C6
	for <iommu@lists.linux-foundation.org>;
	Sat, 29 Jun 2019 02:42:23 +0000 (UTC)
X-UUID: b2bd86026c704cf6bb13c727e6fa5e7b-20190629
X-UUID: b2bd86026c704cf6bb13c727e6fa5e7b-20190629
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mhqrelay.mediatek.com ESMTP with TLS)
	with ESMTP id 2091088091; Sat, 29 Jun 2019 10:42:21 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
	mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Sat, 29 Jun 2019 10:42:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Sat, 29 Jun 2019 10:42:19 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v8 20/21] iommu/mediatek: Clean up struct mtk_smi_iommu
Date: Sat, 29 Jun 2019 10:39:54 +0800
Message-ID: <1561775995-24963-21-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561775995-24963-11-git-send-email-yong.wu@mediatek.com>
References: <1561775995-24963-11-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	Matthias Kaehlcke <mka@chromium.org>,
	linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com,
	anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Remove the "struct mtk_smi_iommu" to simplify the code since it has only
one item in it right now.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c    | 4 ++--
 drivers/iommu/mtk_iommu.h    | 6 +++---
 drivers/iommu/mtk_iommu_v1.c | 4 ++--
 drivers/memory/mtk-smi.c     | 6 +++---
 include/soc/mediatek/smi.h   | 4 ----
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index fcf18d7..4212221 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -276,7 +276,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 	for (i = 0; i < fwspec->num_ids; ++i) {
 		larbid = MTK_M4U_TO_LARB(fwspec->ids[i]);
 		portid = MTK_M4U_TO_PORT(fwspec->ids[i]);
-		larb_mmu = &data->smi_imu.larb_imu[larbid];
+		larb_mmu = &data->larb_imu[larbid];
 
 		dev_dbg(dev, "%s iommu port: %d\n",
 			enable ? "enable" : "disable", portid);
@@ -678,7 +678,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			of_node_put(larbnode);
 			return -EPROBE_DEFER;
 		}
-		data->smi_imu.larb_imu[id].dev = &plarbdev->dev;
+		data->larb_imu[id].dev = &plarbdev->dev;
 
 		component_match_add_release(dev, &match, release_of,
 					    compare_of, larbnode);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 3954876..dda74f1 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -64,7 +64,6 @@ struct mtk_iommu_data {
 	struct mtk_iommu_suspend_reg	reg;
 	struct mtk_iommu_domain		*m4u_dom;
 	struct iommu_group		*m4u_group;
-	struct mtk_smi_iommu		smi_imu;      /* SMI larb iommu info */
 	bool                            enable_4GB;
 	bool				tlb_flush_active;
 
@@ -72,6 +71,7 @@ struct mtk_iommu_data {
 	const struct mtk_iommu_plat_data *plat_data;
 
 	struct list_head		list;
+	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
 };
 
 static inline int compare_of(struct device *dev, void *data)
@@ -88,14 +88,14 @@ static inline int mtk_iommu_bind(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 
-	return component_bind_all(dev, &data->smi_imu);
+	return component_bind_all(dev, &data->larb_imu);
 }
 
 static inline void mtk_iommu_unbind(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 
-	component_unbind_all(dev, &data->smi_imu);
+	component_unbind_all(dev, &data->larb_imu);
 }
 
 #endif
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 73308ad..ba0408b 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -214,7 +214,7 @@ static void mtk_iommu_config(struct mtk_iommu_data *data,
 	for (i = 0; i < fwspec->num_ids; ++i) {
 		larbid = mt2701_m4u_to_larb(fwspec->ids[i]);
 		portid = mt2701_m4u_to_port(fwspec->ids[i]);
-		larb_mmu = &data->smi_imu.larb_imu[larbid];
+		larb_mmu = &data->larb_imu[larbid];
 
 		dev_dbg(dev, "%s iommu port: %d\n",
 			enable ? "enable" : "disable", portid);
@@ -618,7 +618,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			}
 		}
 
-		data->smi_imu.larb_imu[larb_nr].dev = &plarbdev->dev;
+		data->larb_imu[larb_nr].dev = &plarbdev->dev;
 		component_match_add_release(dev, &match, release_of,
 					    compare_of, larb_spec.np);
 		larb_nr++;
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 7d13a0b..0e310d5 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -151,13 +151,13 @@ void mtk_smi_larb_put(struct device *larbdev)
 mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
-	struct mtk_smi_iommu *smi_iommu = data;
+	struct mtk_smi_larb_iommu *larb_mmu = data;
 	unsigned int         i;
 
 	for (i = 0; i < MTK_LARB_NR_MAX; i++) {
-		if (dev == smi_iommu->larb_imu[i].dev) {
+		if (dev == larb_mmu[i].dev) {
 			larb->larbid = i;
-			larb->mmu = &smi_iommu->larb_imu[i].mmu;
+			larb->mmu = &larb_mmu[i].mmu;
 			return 0;
 		}
 	}
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index a65324d..baad22f 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -28,10 +28,6 @@ struct mtk_smi_larb_iommu {
 	unsigned int   mmu;
 };
 
-struct mtk_smi_iommu {
-	struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX];
-};
-
 /*
  * mtk_smi_larb_get: Enable the power domain and clocks for this local arbiter.
  *                   It also initialize some basic setting(like iommu).
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
