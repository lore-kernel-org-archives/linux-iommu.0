Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2C2C43334
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 05:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F80D41728;
	Fri,  1 Jul 2022 05:40:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F80D41728
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id duzcqrbIdx7b; Fri,  1 Jul 2022 05:40:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 81A1C41716;
	Fri,  1 Jul 2022 05:40:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81A1C41716
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5373EC002D;
	Fri,  1 Jul 2022 05:40:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 514E5C0011
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 05:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E50083F9F
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 05:40:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E50083F9F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qw6KjEd54cpq for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 05:40:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4DEA883F9D
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4DEA883F9D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 05:40:10 +0000 (UTC)
X-UUID: 96455e091bf9430e959dc48d9bc7d00b-20220701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7, REQID:7325ef3e-1696-457a-a46b-0e75c92526c1, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
 TION:release,TS:90
X-CID-INFO: VERSION:1.1.7, REQID:7325ef3e-1696-457a-a46b-0e75c92526c1, OB:0,
 LOB:
 0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
 TION:quarantine,TS:90
X-CID-META: VersionHash:87442a2, CLOUDID:652a4486-57f0-47ca-ba27-fe8c57fbf305,
 C
 OID:3cec275428cf,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 96455e091bf9430e959dc48d9bc7d00b-20220701
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1518669920; Fri, 01 Jul 2022 13:40:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 1 Jul 2022 13:40:01 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 1 Jul 2022 13:39:59 +0800
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Will Deacon <will@kernel.org>
Subject: [PATCH v3 1/7] iommu/mediatek: Use dev_err_probe to mute probe_defer
 err log
Date: Fri, 1 Jul 2022 13:39:36 +0800
Message-ID: <20220701053942.3266-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220701053942.3266-1-yong.wu@mediatek.com>
References: <20220701053942.3266-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: anan.sun@mediatek.com, chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 iommu@lists.linux.dev, libo.kang@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, yf.wang@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Guenter Roeck <groeck@chromium.org>, Dan Carpenter <dan.carpenter@oracle.com>,
 mingyuan.ma@mediatek.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

Mute the probe defer log:

[    2.654806] mtk-iommu 14018000.iommu: mm dts parse fail(-517).
[    2.656168] mtk-iommu 1c01f000.iommu: mm dts parse fail(-517).

Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index bb9dd92c9898..3b2489e8a6dd 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1204,7 +1204,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		ret = mtk_iommu_mm_dts_parse(dev, &match, data);
 		if (ret) {
-			dev_err(dev, "mm dts parse fail(%d).", ret);
+			dev_err_probe(dev, ret, "mm dts parse fail.");
 			goto out_runtime_disable;
 		}
 	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
