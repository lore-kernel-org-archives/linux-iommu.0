Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD627C07E96
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 12:12:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F5F61374
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 12:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F5F61374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 12D9D4038C;
	Thu, 15 Jul 2021 12:12:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2hK3Y1wUh8B5; Thu, 15 Jul 2021 12:12:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F088D402AB;
	Thu, 15 Jul 2021 12:12:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C77FDC0010;
	Thu, 15 Jul 2021 12:12:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2373C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 12:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2D5C42262
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 12:12:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VBFVkZ7geAFG for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 12:12:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8189342260
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 12:12:28 +0000 (UTC)
X-UUID: 4a40208b6f1e45608533bb756d6ca5e4-20210715
X-UUID: 4a40208b6f1e45608533bb756d6ca5e4-20210715
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1608474198; Thu, 15 Jul 2021 20:12:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 20:12:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 20:12:20 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 00/11] MT8195 SMI support
Date: Thu, 15 Jul 2021 20:11:58 +0800
Message-ID: <20210715121209.31024-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

This patchset mainly adds SMI support for mt8195.

Comparing with the previous version, add two new functions:
a) add smi sub common
b) add initial setting for smi-common and smi-larb.

change note:
v2: rebase on v5.14-rc1
    1) Adjust clk_bulk flow: use devm_clk_bulk_get for necessary clocks.
    2) Add two new little patches:
       a) use devm_platform_ioremap_resource
       b) Add error handle for smi_probe

v1: https://lore.kernel.org/linux-mediatek/20210616114346.18812-1-yong.wu@mediatek.com/

Yong Wu (11):
  dt-bindings: memory: mediatek: Add mt8195 smi binding
  dt-bindings: memory: mediatek: Add mt8195 smi sub common
  memory: mtk-smi: Use clk_bulk instead of the clk ops
  memory: mtk-smi: Rename smi_gen to smi_type
  memory: mtk-smi: Adjust some code position
  memory: mtk-smi: Add error handle for smi_probe
  memory: mtk-smi: Add smi sub common support
  memory: mtk-smi: Use devm_platform_ioremap_resource
  memory: mtk-smi: mt8195: Add smi support
  memory: mtk-smi: mt8195: Add initial setting for smi-common
  memory: mtk-smi: mt8195: Add initial setting for smi-larb

 .../mediatek,smi-common.yaml                  |  31 +-
 .../memory-controllers/mediatek,smi-larb.yaml |   3 +
 drivers/memory/mtk-smi.c                      | 572 ++++++++++--------
 3 files changed, 356 insertions(+), 250 deletions(-)

-- 
2.18.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
