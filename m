Return-Path: <SRS0=QSCI=P7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305FBC433EF
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 10:55:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E428D60EFD
	for <iommu@archiver.kernel.org>; Fri, 12 Nov 2021 10:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E428D60EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AD3F54013F;
	Fri, 12 Nov 2021 10:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fdVK0_pjlcM8; Fri, 12 Nov 2021 10:55:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 74E06401B0;
	Fri, 12 Nov 2021 10:55:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50644C002E;
	Fri, 12 Nov 2021 10:55:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62516C0012
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 10:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CE8840579
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 10:55:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AqiCFBftsP8Q for <iommu@lists.linux-foundation.org>;
 Fri, 12 Nov 2021 10:55:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DE9C40575
 for <iommu@lists.linux-foundation.org>; Fri, 12 Nov 2021 10:55:55 +0000 (UTC)
X-UUID: 492fa436d19c4418bb72f5b539602551-20211112
X-UUID: 492fa436d19c4418bb72f5b539602551-20211112
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 82111728; Fri, 12 Nov 2021 18:55:51 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Fri, 12 Nov 2021 18:55:49 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Nov 2021 18:55:48 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@canonical.com>, David Airlie <airlied@linux.ie>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>
Subject: [PATCH v9 02/15] iommu/mediatek-v1: Free the existed fwspec if the
 master dev already has
Date: Fri, 12 Nov 2021 18:54:56 +0800
Message-ID: <20211112105509.12010-3-yong.wu@mediatek.com>
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

When the iommu master device enters of_iommu_xlate, the ops may be
NULL(iommu dev is defered), then it will initialize the fwspec here:

[<c0c9c5bc>] (dev_iommu_fwspec_set) from [<c06bda80>]
(iommu_fwspec_init+0xbc/0xd4)
[<c06bd9c4>] (iommu_fwspec_init) from [<c06c0db4>]
(of_iommu_xlate+0x7c/0x12c)
[<c06c0d38>] (of_iommu_xlate) from [<c06c10e8>]
(of_iommu_configure+0x144/0x1e8)

BUT the mtk_iommu_v1.c only supports arm32, the probing flow still is a bit
weird. We always expect create the fwspec internally. otherwise it will
enter here and return fail.

static int mtk_iommu_create_mapping(struct device *dev,
				    struct of_phandle_args *args)
{
        ...
	if (!fwspec) {
	        ....
	} else if (dev_iommu_fwspec_get(dev)->ops != &mtk_iommu_ops) {
                >>>>>>>>>>Enter here. return fail.<<<<<<<<<<<<
		return -EINVAL;
	}
	...
}

Thus, Free the existed fwspec if the master device already has fwspec.

This issue is reported at:
https://lore.kernel.org/linux-mediatek/trinity-7d9ebdc9-4849-4d93-bfb5-429dcb4ee449-1626253158870@3c-app-gmx-bs01/

Reported-by: Frank Wunderlich <frank-w@public-files.de>
Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu_v1.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index be22fcf988ce..1467ba1e4417 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -425,6 +425,15 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 	struct mtk_iommu_data *data;
 	int err, idx = 0;
 
+	/*
+	 * In the deferred case, free the existed fwspec.
+	 * Always initialize the fwspec internally.
+	 */
+	if (fwspec) {
+		iommu_fwspec_free(dev);
+		fwspec = dev_iommu_fwspec_get(dev);
+	}
+
 	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
 					   "#iommu-cells",
 					   idx, &iommu_spec)) {
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
