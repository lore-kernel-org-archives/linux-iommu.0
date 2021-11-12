Return-Path: <SRS0=QSCI=P7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2823C433EF
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 10:56:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6981060F90
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 10:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6981060F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44A9B60678;
	Fri, 12 Nov 2021 10:56:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sHeQDUNu6Uao; Fri, 12 Nov 2021 10:56:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1EE0260655;
	Fri, 12 Nov 2021 10:56:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB171C002E;
	Fri, 12 Nov 2021 10:56:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C204C0012
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 10:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC5F3401B7
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 10:56:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 37sDtBseJZw7 for <iommu@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 10:56:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55F774013F
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 10:56:30 +0000 (UTC)
X-UUID: a52f80a27a7d4a529f46799d7f944407-20211112
X-UUID: a52f80a27a7d4a529f46799d7f944407-20211112
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 4873376; Fri, 12 Nov 2021 18:56:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 12 Nov 2021 18:56:25 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Nov 2021 18:56:23 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@canonical.com>, David Airlie <airlied@linux.ie>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>
Subject: [PATCH v9 05/15] iommu/mediatek: Add device_link between the consumer
 and the larb devices
Date: Fri, 12 Nov 2021 18:54:59 +0800
Message-ID: <20211112105509.12010-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211112105509.12010-1-yong.wu@mediatek.com>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, yf.wang@mediatek.com,
 anthony.huang@mediatek.com, youlin.pei@mediatek.com,
 Evan Green <evgreen@chromium.org>, Eizan Miyamoto <eizan@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org,
 mingyuan.ma@mediatek.com, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Frank Wunderlich <frank-w@public-files.de>, libo.kang@mediatek.com,
 yi.kuo@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Tiffany Lin <tiffany.lin@mediatek.com>,
 anan.sun@mediatek.com, srv_heupstream@mediatek.com, acourbot@chromium.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

MediaTek IOMMU-SMI diagram is like below. all the consumer connect with
smi-larb, then connect with smi-common.

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

When device_link_add, I add the flag DL_FLAG_STATELESS to avoid calling
pm_runtime_xx to keep the original status of clocks. It can avoid two
issues:
1) Display HW show fastlogo abnormally reported in [1]. At the beggining,
all the clocks are enabled before entering kernel, but the clocks for
display HW(always in larb0) will be gated after clk_enable and clk_disable
called from device_link_add(->pm_runtime_resume) and rpm_idle. The clock
operation happened before display driver probe. At that time, the display
HW will be abnormal.

2) A deadlock issue reported in [2]. Use DL_FLAG_STATELESS to skip
pm_runtime_xx to avoid the deadlock.

Corresponding, DL_FLAG_AUTOREMOVE_CONSUMER can't be added, then
device_link_removed should be added explicitly.

Meanwhile, Currently we don't have a device connect with 2 larbs at the
same time. Disallow this case, print the error log.

[1] https://lore.kernel.org/linux-mediatek/1564213888.22908.4.camel@mhfsdcap03/
[2] https://lore.kernel.org/patchwork/patch/1086569/

Suggested-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623
---
 drivers/iommu/mtk_iommu.c    | 30 ++++++++++++++++++++++++++++++
 drivers/iommu/mtk_iommu_v1.c | 29 ++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0033c0634e5e..5fed0b64ddd0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -560,22 +560,52 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct mtk_iommu_data *data;
+	struct device_link *link;
+	struct device *larbdev;
+	unsigned int larbid, larbidx, i;
 
 	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return ERR_PTR(-ENODEV); /* Not a iommu client device */
 
 	data = dev_iommu_priv_get(dev);
 
+	/*
+	 * Link the consumer device with the smi-larb device(supplier).
+	 * The device that connects with each a larb is a independent HW.
+	 * All the ports in each a device should be in the same larbs.
+	 */
+	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+	for (i = 1; i < fwspec->num_ids; i++) {
+		larbidx = MTK_M4U_TO_LARB(fwspec->ids[i]);
+		if (larbid != larbidx) {
+			dev_err(dev, "Can only use one larb. Fail@larb%d-%d.\n",
+				larbid, larbidx);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+	larbdev = data->larb_imu[larbid].dev;
+	link = device_link_add(dev, larbdev,
+			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+	if (!link)
+		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
 	return &data->iommu;
 }
 
 static void mtk_iommu_release_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct mtk_iommu_data *data;
+	struct device *larbdev;
+	unsigned int larbid;
 
 	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return;
 
+	data = dev_iommu_priv_get(dev);
+	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+	larbdev = data->larb_imu[larbid].dev;
+	device_link_remove(dev, larbdev);
+
 	iommu_fwspec_free(dev);
 }
 
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 4089077256f4..4052aad75a81 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -423,7 +423,9 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct of_phandle_args iommu_spec;
 	struct mtk_iommu_data *data;
-	int err, idx = 0;
+	int err, idx = 0, larbid, larbidx;
+	struct device_link *link;
+	struct device *larbdev;
 
 	/*
 	 * In the deferred case, free the existed fwspec.
@@ -453,6 +455,23 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 
 	data = dev_iommu_priv_get(dev);
 
+	/* Link the consumer device with the smi-larb device(supplier) */
+	larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
+	for (idx = 1; idx < fwspec->num_ids; idx++) {
+		larbidx = mt2701_m4u_to_larb(fwspec->ids[idx]);
+		if (larbid != larbidx) {
+			dev_err(dev, "Can only use one larb. Fail@larb%d-%d.\n",
+				larbid, larbidx);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	larbdev = data->larb_imu[larbid].dev;
+	link = device_link_add(dev, larbdev,
+			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+	if (!link)
+		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
+
 	return &data->iommu;
 }
 
@@ -473,10 +492,18 @@ static void mtk_iommu_probe_finalize(struct device *dev)
 static void mtk_iommu_release_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct mtk_iommu_data *data;
+	struct device *larbdev;
+	unsigned int larbid;
 
 	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
 		return;
 
+	data = dev_iommu_priv_get(dev);
+	larbid = mt2701_m4u_to_larb(fwspec->ids[0]);
+	larbdev = data->larb_imu[larbid].dev;
+	device_link_remove(dev, larbdev);
+
 	iommu_fwspec_free(dev);
 }
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
