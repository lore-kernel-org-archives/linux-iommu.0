Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D33C433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 09:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF0ED40AA9;
	Tue, 25 Jan 2022 09:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CxIYO2cX7wgq; Tue, 25 Jan 2022 09:00:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4515940A9F;
	Tue, 25 Jan 2022 09:00:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 115B8C0031;
	Tue, 25 Jan 2022 09:00:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AC6BC002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 09:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69F9E84CC8
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 09:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MkpKcfSkKJ8L for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 09:00:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66F9E84CAA
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 09:00:31 +0000 (UTC)
X-UUID: 089594734954453985adea28b154e097-20220125
X-UUID: 089594734954453985adea28b154e097-20220125
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 741491565; Tue, 25 Jan 2022 17:00:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 25 Jan 2022 17:00:25 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 17:00:24 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v4 27/35] iommu/mediatek: Remove mtk_iommu.h
Date: Tue, 25 Jan 2022 16:56:26 +0800
Message-ID: <20220125085634.17972-28-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220125085634.17972-1-yong.wu@mediatek.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>
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

Currently there is only compare_of/release_of/a suspend structure in the
header file. I think it is no need to keep a header file only for these.
Move these into the c file and rm this header file.

I think there should be a common helper for compare_of and release_of.
There is many copy in drm, it should be another topic.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c    | 25 ++++++++++++++++++++-
 drivers/iommu/mtk_iommu.h    | 42 ------------------------------------
 drivers/iommu/mtk_iommu_v1.c | 21 +++++++++++++++---
 3 files changed, 42 insertions(+), 46 deletions(-)
 delete mode 100644 drivers/iommu/mtk_iommu.h

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 80c1e5a75868..f88c7bb235bf 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
+#include <linux/io-pgtable.h>
 #include <linux/list.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -30,7 +31,7 @@
 #include <asm/barrier.h>
 #include <soc/mediatek/smi.h>
 
-#include "mtk_iommu.h"
+#include <dt-bindings/memory/mtk-memory-port.h>
 
 #define REG_MMU_PT_BASE_ADDR			0x000
 #define MMU_PT_ADDR_MASK			GENMASK(31, 7)
@@ -166,6 +167,17 @@ struct mtk_iommu_iova_region {
 	unsigned long long	size;
 };
 
+struct mtk_iommu_suspend_reg {
+	u32			misc_ctrl;
+	u32			dcm_dis;
+	u32			ctrl_reg;
+	u32			int_control0;
+	u32			int_main_control;
+	u32			ivrp_paddr;
+	u32			vld_pa_rng;
+	u32			wr_len_ctrl;
+};
+
 struct mtk_iommu_plat_data {
 	enum mtk_iommu_plat			m4u_plat;
 	u32					flags;
@@ -219,6 +231,17 @@ struct mtk_iommu_domain {
 	struct mutex			mutex; /* Protect "data" in this structure */
 };
 
+/* TODO: A common helper is expected. */
+static inline int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static inline void release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
 static inline int mtk_iommu_bind(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
deleted file mode 100644
index d332f9769f83..000000000000
--- a/drivers/iommu/mtk_iommu.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2015-2016 MediaTek Inc.
- * Author: Honghui Zhang <honghui.zhang@mediatek.com>
- */
-
-#ifndef _MTK_IOMMU_H_
-#define _MTK_IOMMU_H_
-
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/io-pgtable.h>
-#include <linux/iommu.h>
-#include <linux/spinlock.h>
-#include <soc/mediatek/smi.h>
-#include <dt-bindings/memory/mtk-memory-port.h>
-
-struct mtk_iommu_suspend_reg {
-	union {
-		u32			standard_axi_mode;/* v1 */
-		u32			misc_ctrl;/* v2 */
-	};
-	u32				dcm_dis;
-	u32				ctrl_reg;
-	u32				int_control0;
-	u32				int_main_control;
-	u32				ivrp_paddr;
-	u32				vld_pa_rng;
-	u32				wr_len_ctrl;
-};
-
-static inline int compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
-static inline void release_of(struct device *dev, void *data)
-{
-	of_node_put(data);
-}
-
-#endif
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index b762a05328d4..23c3bc175153 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -7,7 +7,6 @@
  *
  * Based on driver/iommu/mtk_iommu.c
  */
-#include <linux/memblock.h>
 #include <linux/bug.h>
 #include <linux/clk.h>
 #include <linux/component.h>
@@ -28,10 +27,9 @@
 #include <linux/spinlock.h>
 #include <asm/barrier.h>
 #include <asm/dma-iommu.h>
-#include <linux/init.h>
+#include <dt-bindings/memory/mtk-memory-port.h>
 #include <dt-bindings/memory/mt2701-larb-port.h>
 #include <soc/mediatek/smi.h>
-#include "mtk_iommu.h"
 
 #define REG_MMU_PT_BASE_ADDR			0x000
 
@@ -87,6 +85,13 @@
  */
 #define M2701_IOMMU_PGT_SIZE			SZ_4M
 
+struct mtk_iommu_suspend_reg {
+	u32			standard_axi_mode;
+	u32			dcm_dis;
+	u32			ctrl_reg;
+	u32			int_control0;
+};
+
 struct mtk_iommu_data {
 	void __iomem			*base;
 	int				irq;
@@ -110,6 +115,16 @@ struct mtk_iommu_domain {
 	struct mtk_iommu_data		*data;
 };
 
+static inline int compare_of(struct device *dev, void *data)
+{
+	return dev->of_node == data;
+}
+
+static inline void release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
 static inline int mtk_iommu_bind(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
