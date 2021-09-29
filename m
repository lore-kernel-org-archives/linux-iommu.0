Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D60CC4332F
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 01:39:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D9C6140F
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 01:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31D9C6140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0975340258;
	Wed, 29 Sep 2021 01:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iKOQNnX9D_JQ; Wed, 29 Sep 2021 01:39:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B045A40265;
	Wed, 29 Sep 2021 01:39:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 942F9C000F;
	Wed, 29 Sep 2021 01:39:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A344C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 01:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 081A34026B
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 01:39:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bey1ADdkONbM for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 01:39:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06B3F40258
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 01:39:15 +0000 (UTC)
X-UUID: 71ca1f60db8e42ad84902da71072dd38-20210929
X-UUID: 71ca1f60db8e42ad84902da71072dd38-20210929
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 256579881; Wed, 29 Sep 2021 09:39:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 29 Sep 2021 09:39:06 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Sep 2021 09:39:04 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@canonical.com>, David Airlie <airlied@linux.ie>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>
Subject: [PATCH v8 11/12] arm: dts: mediatek: Get rid of mediatek,
 larb for MM nodes
Date: Wed, 29 Sep 2021 09:37:18 +0800
Message-ID: <20210929013719.25120-12-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210929013719.25120-1-yong.wu@mediatek.com>
References: <20210929013719.25120-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, anthony.huang@mediatek.com,
 youlin.pei@mediatek.com, Evan Green <evgreen@chromium.org>,
 Eizan Miyamoto <eizan@chromium.org>, Matthias Kaehlcke <mka@chromium.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
 Frank Wunderlich <frank-w@public-files.de>, yi.kuo@mediatek.com,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>, anan.sun@mediatek.com,
 srv_heupstream@mediatek.com, acourbot@chromium.org,
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

After adding device_link between the IOMMU consumer and smi, the
mediatek,larb is unnecessary now.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623
---
 arch/arm/boot/dts/mt2701.dtsi  | 2 --
 arch/arm/boot/dts/mt7623n.dtsi | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 4776f85d6d5b..ef583cfd3baf 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -564,7 +564,6 @@
 		clock-names = "jpgdec-smi",
 			      "jpgdec";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
-		mediatek,larb = <&larb2>;
 		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
 			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
 	};
@@ -577,7 +576,6 @@
 		clocks =  <&imgsys CLK_IMG_VENC>;
 		clock-names = "jpgenc";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
-		mediatek,larb = <&larb2>;
 		iommus = <&iommu MT2701_M4U_PORT_JPGENC_RDMA>,
 			 <&iommu MT2701_M4U_PORT_JPGENC_BSDMA>;
 	};
diff --git a/arch/arm/boot/dts/mt7623n.dtsi b/arch/arm/boot/dts/mt7623n.dtsi
index bcb0846e29fd..3adab5cd1fef 100644
--- a/arch/arm/boot/dts/mt7623n.dtsi
+++ b/arch/arm/boot/dts/mt7623n.dtsi
@@ -121,7 +121,6 @@
 		clock-names = "jpgdec-smi",
 			      "jpgdec";
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
-		mediatek,larb = <&larb2>;
 		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
 			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
 	};
@@ -144,7 +143,6 @@
 		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&mmsys CLK_MM_DISP_OVL>;
 		iommus = <&iommu MT2701_M4U_PORT_DISP_OVL_0>;
-		mediatek,larb = <&larb0>;
 	};
 
 	rdma0: rdma@14008000 {
@@ -154,7 +152,6 @@
 		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&mmsys CLK_MM_DISP_RDMA>;
 		iommus = <&iommu MT2701_M4U_PORT_DISP_RDMA>;
-		mediatek,larb = <&larb0>;
 	};
 
 	wdma@14009000 {
@@ -164,7 +161,6 @@
 		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&mmsys CLK_MM_DISP_WDMA>;
 		iommus = <&iommu MT2701_M4U_PORT_DISP_WDMA>;
-		mediatek,larb = <&larb0>;
 	};
 
 	bls: pwm@1400a000 {
@@ -215,7 +211,6 @@
 		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_LOW>;
 		clocks = <&mmsys CLK_MM_DISP_RDMA1>;
 		iommus = <&iommu MT2701_M4U_PORT_DISP_RDMA1>;
-		mediatek,larb = <&larb0>;
 	};
 
 	dpi0: dpi@14014000 {
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
