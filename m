Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6336AC4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 08:11:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2127061052
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 08:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2127061052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1F1083294;
	Tue, 10 Aug 2021 08:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9wO8n0IOr6vi; Tue, 10 Aug 2021 08:11:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CFD2E83422;
	Tue, 10 Aug 2021 08:11:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0735C0010;
	Tue, 10 Aug 2021 08:11:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 488DDC000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 08:11:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2832983422
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 08:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GlxvDSKMwWg7 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 08:11:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6AFD3832D1
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 08:11:00 +0000 (UTC)
X-UUID: 781678e9f89f4f5d9f34668020e1b445-20210810
X-UUID: 781678e9f89f4f5d9f34668020e1b445-20210810
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 304722485; Tue, 10 Aug 2021 16:10:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Aug 2021 16:10:54 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Aug 2021 16:10:47 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v3 13/13] MAINTAINERS: Add entry for MediaTek SMI
Date: Tue, 10 Aug 2021 16:08:59 +0800
Message-ID: <20210810080859.29511-14-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210810080859.29511-1-yong.wu@mediatek.com>
References: <20210810080859.29511-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 anthony.huang@mediatek.com, ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Ikjoon Jang <ikjn@chromium.org>,
 linux-arm-kernel@lists.infradead.org
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

I am the author of MediaTek SMI driver, and will to maintain
and develop it further.
Add myself to cover these items.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a61f4f3b78a9..91af55b45e80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11754,6 +11754,14 @@ M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained
 F:	drivers/char/hw_random/mtk-rng.c
 
+MEDIATEK SMI DRIVER
+M:	Yong Wu <yong.wu@mediatek.com>
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/memory-controllers/mediatek,smi*
+F:	drivers/memory/mtk-smi.c
+F:	include/soc/mediatek/smi.h
+
 MEDIATEK SWITCH DRIVER
 M:	Sean Wang <sean.wang@mediatek.com>
 M:	Landen Chao <Landen.Chao@mediatek.com>
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
