Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAD4C433F5
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 07:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9C3860FE4;
	Tue,  3 May 2022 07:19:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bclXXl-gZ0RT; Tue,  3 May 2022 07:19:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9735360FDD;
	Tue,  3 May 2022 07:19:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73619C0039;
	Tue,  3 May 2022 07:19:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A8E3C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 07:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3BB0F83089
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 07:19:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Im-OkdNSfkF for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 07:19:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 486908186E
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 07:19:16 +0000 (UTC)
X-UUID: 0b5c13b863af41fab0975419c8e9521a-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4, REQID:5c6d2d45-3cc6-443b-9cb9-981e8bb383cd, OB:80,
 L
 OB:20,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ha
 m,ACTION:release,TS:80
X-CID-INFO: VERSION:1.1.4, REQID:5c6d2d45-3cc6-443b-9cb9-981e8bb383cd, OB:80,
 LOB
 :20,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3
 D,ACTION:quarantine,TS:80
X-CID-META: VersionHash:faefae9, CLOUDID:ccc7822f-6199-437e-8ab4-9920b4bc5b76,
 C
 OID:641a58b95193,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
 ,QS:0,BEC:nil
X-UUID: 0b5c13b863af41fab0975419c8e9521a-20220503
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 2062503695; Tue, 03 May 2022 15:19:11 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 3 May 2022 15:19:10 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 May 2022 15:19:09 +0800
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v7 33/36] iommu/mediatek: Initialise/Remove for multi bank dev
Date: Tue, 3 May 2022 15:14:24 +0800
Message-ID: <20220503071427.2285-34-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220503071427.2285-1-yong.wu@mediatek.com>
References: <20220503071427.2285-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, libo.kang@mediatek.com,
 xueqi.zhang@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, yen-chang.chen@mediatek.com,
 chengci.xu@mediatek.com, iommu@lists.linux-foundation.org,
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The registers for each bank of the IOMMU base are in order, delta is
0x1000. Initialise the base for each bank.

For all the previous SoC, we only have bank0. thus use "do {} while()"
to allow bank0 always go.

When removing the device, Not always all the banks are initialised, it
depend on if there is masters for that bank.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 44 ++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 5f3e88c44514..400dea33aea1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -113,6 +113,7 @@
 #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
 
 #define MTK_PROTECT_PA_ALIGN			256
+#define MTK_IOMMU_BANK_SZ			0x1000
 
 #define PERICFG_IOMMU_1				0x714
 
@@ -1112,7 +1113,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	struct component_match  *match = NULL;
 	struct regmap		*infracfg;
 	void                    *protect;
-	int                     ret, banks_num;
+	int                     ret, banks_num, i = 0;
 	u32			val;
 	char                    *p;
 	struct mtk_iommu_bank_data *bank;
@@ -1153,27 +1154,36 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		data->enable_4GB = !!(val & F_DDR_4GB_SUPPORT_EN);
 	}
 
+	banks_num = data->plat_data->banks_num;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (resource_size(res) < banks_num * MTK_IOMMU_BANK_SZ) {
+		dev_err(dev, "banknr %d. res %pR is not enough.\n", banks_num, res);
+		return -EINVAL;
+	}
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 	ioaddr = res->start;
 
-	banks_num = data->plat_data->banks_num;
 	data->bank = devm_kmalloc(dev, banks_num * sizeof(*data->bank), GFP_KERNEL);
 	if (!data->bank)
 		return -ENOMEM;
 
-	bank = &data->bank[0];
-	bank->id = 0;
-	bank->base = base;
-	bank->m4u_dom = NULL;
-	bank->irq = platform_get_irq(pdev, 0);
-	if (bank->irq < 0)
-		return bank->irq;
-	bank->parent_dev = dev;
-	bank->parent_data = data;
-	spin_lock_init(&bank->tlb_lock);
+	do {
+		if (!data->plat_data->banks_enable[i])
+			continue;
+		bank = &data->bank[i];
+		bank->id = i;
+		bank->base = base + i * MTK_IOMMU_BANK_SZ;
+		bank->m4u_dom = NULL;
+
+		bank->irq = platform_get_irq(pdev, i);
+		if (bank->irq < 0)
+			return bank->irq;
+		bank->parent_dev = dev;
+		bank->parent_data = data;
+		spin_lock_init(&bank->tlb_lock);
+	} while (++i < banks_num);
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_BCLK)) {
 		data->bclk = devm_clk_get(dev, "bclk");
@@ -1261,7 +1271,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 static int mtk_iommu_remove(struct platform_device *pdev)
 {
 	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
-	struct mtk_iommu_bank_data *bank = &data->bank[0];
+	struct mtk_iommu_bank_data *bank;
+	int i;
 
 	iommu_device_sysfs_remove(&data->iommu);
 	iommu_device_unregister(&data->iommu);
@@ -1278,7 +1289,12 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 #endif
 	}
 	pm_runtime_disable(&pdev->dev);
-	devm_free_irq(&pdev->dev, bank->irq, bank);
+	for (i = 0; i < data->plat_data->banks_num; i++) {
+		bank = &data->bank[i];
+		if (!bank->m4u_dom)
+			continue;
+		devm_free_irq(&pdev->dev, bank->irq, bank);
+	}
 	return 0;
 }
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
