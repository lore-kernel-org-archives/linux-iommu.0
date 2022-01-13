Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A25FC433F5
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 11:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96C196FC2B;
	Thu, 13 Jan 2022 11:11:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kQrD_ibIUWbt; Thu, 13 Jan 2022 11:11:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8B3F860ADD;
	Thu, 13 Jan 2022 11:11:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71165C0030;
	Thu, 13 Jan 2022 11:11:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51A11C001E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 11:11:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E06440A59
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 11:11:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FqUSABJJPh-x for <iommu@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 11:11:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2BC2C40A57
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 11:11:07 +0000 (UTC)
X-UUID: 96ecafd43a824de795c3657f691fe676-20220113
X-UUID: 96ecafd43a824de795c3657f691fe676-20220113
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 395357916; Thu, 13 Jan 2022 19:11:03 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 13 Jan 2022 19:11:02 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 19:11:01 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v3 0/7] MT8186 SMI SUPPORT
Date: Thu, 13 Jan 2022 19:10:50 +0800
Message-ID: <20220113111057.29918-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, anthony.huang@mediatek.com, anan.sun@mediatek.com,
 linux-arm-kernel@lists.infradead.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This patchset adds mt8186 smi support.
mainly adds a sleep control function.

Change note:
v3: a) Add a new binding patch for renaming "clock" to "clocks".
    b) Reword the title for the binding patches, more detailed.
    c) Add the sleep control error path: if err, return directly.
       also change the log from dev_warn to dev_err.    

v2: https://lore.kernel.org/linux-devicetree/20220111063904.7583-1-yong.wu@mediatek.com/
    a) Add two patches for the "make dtbs_check" warning.
    b) Seperate the "sleep control" into two functions.
       And add a "TODO" comment while sleep control fails.

v1: https://lore.kernel.org/linux-mediatek/20211203064027.14993-1-yong.wu@mediatek.com/
    Base on v5.16-rc1.

Yong Wu (7):
  dt-bindings: memory: mtk-smi: Rename clock to clocks
  dt-bindings: memory: mtk-smi: No need mediatek,larb-id for mt8167
  dt-bindings: memory: mtk-smi: Correct minItems to 2 for the gals
    clocks
  dt-bindings: memory: mediatek: Add mt8186 support
  memory: mtk-smi: Fix the return value for clk_bulk_prepare_enable
  memory: mtk-smi: Add sleep ctrl function
  memory: mtk-smi: mt8186: Add smi support

 .../mediatek,smi-common.yaml                  | 32 ++++++------
 .../memory-controllers/mediatek,smi-larb.yaml | 19 +++----
 drivers/memory/mtk-smi.c                      | 51 ++++++++++++++++++-
 3 files changed, 75 insertions(+), 27 deletions(-)

-- 
2.18.0


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
