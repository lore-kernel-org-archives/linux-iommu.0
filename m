Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55079C433E0
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 11:20:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9A5421E92
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 11:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A5421E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 922C3204B0;
	Mon, 11 Jan 2021 11:20:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MBFLo-tCXrsL; Mon, 11 Jan 2021 11:20:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 97A9D20030;
	Mon, 11 Jan 2021 11:20:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82689C0893;
	Mon, 11 Jan 2021 11:20:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AECE4C013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AB19F85CD0
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:20:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zYiZXTfydbqC for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 11:20:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1F9D485CAA
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:20:35 +0000 (UTC)
X-UUID: 4fdcbdf3c18c43f0939b23679b1d26ce-20210111
X-UUID: 4fdcbdf3c18c43f0939b23679b1d26ce-20210111
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 2051502511; Mon, 11 Jan 2021 19:20:32 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:20:30 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:20:30 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v6 06/33] of/device: Move dma_range_map before
 of_iommu_configure
Date: Mon, 11 Jan 2021 19:18:47 +0800
Message-ID: <20210111111914.22211-7-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
 Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
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

"dev->dma_range_map" contains the devices' dma_ranges information,
This patch moves dma_range_map before of_iommu_configure. The iommu
driver may need to know the dma_address requirements of its iommu
consumer devices.

CC: Rob Herring <robh+dt@kernel.org>
CC: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/of/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index aedfaaafd3e7..1d84636149df 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -170,9 +170,11 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
 
+	dev->dma_range_map = map;
 	iommu = of_iommu_configure(dev, np, id);
 	if (PTR_ERR(iommu) == -EPROBE_DEFER) {
 		kfree(map);
+		dev->dma_range_map = NULL;
 		return -EPROBE_DEFER;
 	}
 
@@ -181,7 +183,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 
 	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
 
-	dev->dma_range_map = map;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure_id);
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
