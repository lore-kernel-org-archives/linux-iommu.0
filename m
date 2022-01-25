Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FE2C433EF
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 08:57:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A5AE140A97;
	Tue, 25 Jan 2022 08:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jSso6F5siVEq; Tue, 25 Jan 2022 08:57:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3967240494;
	Tue, 25 Jan 2022 08:57:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12CA2C0031;
	Tue, 25 Jan 2022 08:57:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD06DC002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 08:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DB0B84CB6
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 08:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ymLD5nUBs_wd for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:57:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD18284CAA
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 08:57:46 +0000 (UTC)
X-UUID: 11643d176e644c1d89b3094aaee55cdb-20220125
X-UUID: 11643d176e644c1d89b3094aaee55cdb-20220125
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1064192246; Tue, 25 Jan 2022 16:57:43 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Tue, 25 Jan 2022 16:57:42 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 16:57:40 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v4 06/35] iommu/mediatek: Add mutex for m4u_group and m4u_dom
 in data
Date: Tue, 25 Jan 2022 16:56:05 +0800
Message-ID: <20220125085634.17972-7-yong.wu@mediatek.com>
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

Add a mutex to protect the data in the structure mtk_iommu_data,
like ->"m4u_group" ->"m4u_dom". For the internal data, we should
protect it in ourselves driver. Add a mutex for this.
This could be a fix for the multi-groups support.

Fixes: c3045f39244e ("iommu/mediatek: Support for multi domains")
Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 13 +++++++++++--
 drivers/iommu/mtk_iommu.h |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index ec2c387abf60..095736bfb7b4 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -464,15 +464,16 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 		dom->data = data;
 	}
 
+	mutex_lock(&data->mutex);
 	if (!data->m4u_dom) { /* Initialize the M4U HW */
 		ret = pm_runtime_resume_and_get(m4udev);
 		if (ret < 0)
-			return ret;
+			goto data_unlock;
 
 		ret = mtk_iommu_hw_init(data);
 		if (ret) {
 			pm_runtime_put(m4udev);
-			return ret;
+			goto data_unlock;
 		}
 		data->m4u_dom = dom;
 		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
@@ -480,9 +481,14 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 
 		pm_runtime_put(m4udev);
 	}
+	mutex_unlock(&data->mutex);
 
 	mtk_iommu_config(data, dev, true, domid);
 	return 0;
+
+data_unlock:
+	mutex_unlock(&data->mutex);
+	return ret;
 }
 
 static void mtk_iommu_detach_device(struct iommu_domain *domain,
@@ -592,6 +598,7 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	if (domid < 0)
 		return ERR_PTR(domid);
 
+	mutex_lock(&data->mutex);
 	group = data->m4u_group[domid];
 	if (!group) {
 		group = iommu_group_alloc();
@@ -600,6 +607,7 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	} else {
 		iommu_group_ref_get(group);
 	}
+	mutex_unlock(&data->mutex);
 	return group;
 }
 
@@ -874,6 +882,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, data);
+	mutex_init(&data->mutex);
 
 	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
 				     "mtk-iommu.%pa", &ioaddr);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index f81fa8862ed0..f413546ac6e5 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -80,6 +80,8 @@ struct mtk_iommu_data {
 
 	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
 
+	struct mutex			mutex; /* Protect m4u_group/m4u_dom above */
+
 	struct list_head		list;
 	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
 };
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
