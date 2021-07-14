Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E77C07E95
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 02:58:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 685F0613AB
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 02:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685F0613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CC734030B;
	Wed, 14 Jul 2021 02:58:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mZ1oN0Plx1rX; Wed, 14 Jul 2021 02:58:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 94DC7402A9;
	Wed, 14 Jul 2021 02:58:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C608C0010;
	Wed, 14 Jul 2021 02:58:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 926AAC000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 02:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7484B60A63
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 02:58:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1nfBoZ5f9vT8 for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:58:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BBBE60A62
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 02:58:39 +0000 (UTC)
X-UUID: 476bd22a56064a38bfb34ea8a19996e9-20210714
X-UUID: 476bd22a56064a38bfb34ea8a19996e9-20210714
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 2066504944; Wed, 14 Jul 2021 10:58:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Jul 2021 10:58:34 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 10:58:32 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@canonical.com>, David Airlie <airlied@linux.ie>, Mauro
 Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v6 11/11] arm64: dts: mediatek: Get rid of mediatek,
 larb for MM nodes
Date: Wed, 14 Jul 2021 10:56:26 +0800
Message-ID: <20210714025626.5528-12-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210714025626.5528-1-yong.wu@mediatek.com>
References: <20210714025626.5528-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: Xia Jiang <xia.jiang@mediatek.com>,
 Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Will Deacon <will.deacon@arm.com>,
 dri-devel@lists.freedesktop.org, anthony.huang@mediatek.com,
 youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
 Evan Green <evgreen@chromium.org>, Eizan Miyamoto <eizan@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 Philipp Zabel <p.zabel@pengutronix.de>, yi.kuo@mediatek.com,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 ming-fan.chen@mediatek.com, Tiffany Lin <tiffany.lin@mediatek.com>,
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

After adding device_link between the IOMMU consumer and smi,
the mediatek,larb is unnecessary now.

CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 16 ----------------
 arch/arm64/boot/dts/mediatek/mt8183.dtsi |  6 ------
 2 files changed, 22 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 2f0fc1e317d7..cf5d26db82b8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1009,7 +1009,6 @@
 				 <&mmsys CLK_MM_MUTEX_32K>;
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
-			mediatek,larb = <&larb0>;
 		};
 
 		mdp_rdma1: rdma@14002000 {
@@ -1019,7 +1018,6 @@
 				 <&mmsys CLK_MM_MUTEX_32K>;
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_RDMA1>;
-			mediatek,larb = <&larb4>;
 		};
 
 		mdp_rsz0: rsz@14003000 {
@@ -1049,7 +1047,6 @@
 			clocks = <&mmsys CLK_MM_MDP_WDMA>;
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_WDMA>;
-			mediatek,larb = <&larb0>;
 		};
 
 		mdp_wrot0: wrot@14007000 {
@@ -1058,7 +1055,6 @@
 			clocks = <&mmsys CLK_MM_MDP_WROT0>;
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_WROT0>;
-			mediatek,larb = <&larb0>;
 		};
 
 		mdp_wrot1: wrot@14008000 {
@@ -1067,7 +1063,6 @@
 			clocks = <&mmsys CLK_MM_MDP_WROT1>;
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			iommus = <&iommu M4U_PORT_MDP_WROT1>;
-			mediatek,larb = <&larb4>;
 		};
 
 		ovl0: ovl@1400c000 {
@@ -1077,7 +1072,6 @@
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_OVL0>;
 			iommus = <&iommu M4U_PORT_DISP_OVL0>;
-			mediatek,larb = <&larb0>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
 		};
 
@@ -1088,7 +1082,6 @@
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_OVL1>;
 			iommus = <&iommu M4U_PORT_DISP_OVL1>;
-			mediatek,larb = <&larb4>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
 		};
 
@@ -1099,7 +1092,6 @@
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
-			mediatek,larb = <&larb0>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
 		};
 
@@ -1110,7 +1102,6 @@
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA1>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA1>;
-			mediatek,larb = <&larb4>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xf000 0x1000>;
 		};
 
@@ -1121,7 +1112,6 @@
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA2>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA2>;
-			mediatek,larb = <&larb4>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0 0x1000>;
 		};
 
@@ -1132,7 +1122,6 @@
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_WDMA0>;
 			iommus = <&iommu M4U_PORT_DISP_WDMA0>;
-			mediatek,larb = <&larb0>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x1000 0x1000>;
 		};
 
@@ -1143,7 +1132,6 @@
 			power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
 			clocks = <&mmsys CLK_MM_DISP_WDMA1>;
 			iommus = <&iommu M4U_PORT_DISP_WDMA1>;
-			mediatek,larb = <&larb4>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x2000 0x1000>;
 		};
 
@@ -1394,7 +1382,6 @@
 			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
 			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */
 			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_LOW>;
-			mediatek,larb = <&larb1>;
 			iommus = <&iommu M4U_PORT_HW_VDEC_MC_EXT>,
 				 <&iommu M4U_PORT_HW_VDEC_PP_EXT>,
 				 <&iommu M4U_PORT_HW_VDEC_AVC_MV_EXT>,
@@ -1462,7 +1449,6 @@
 			compatible = "mediatek,mt8173-vcodec-enc";
 			reg = <0 0x18002000 0 0x1000>;	/* VENC_SYS */
 			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
-			mediatek,larb = <&larb3>;
 			iommus = <&iommu M4U_PORT_VENC_RCPU>,
 				 <&iommu M4U_PORT_VENC_REC>,
 				 <&iommu M4U_PORT_VENC_BSDMA>,
@@ -1490,7 +1476,6 @@
 			clock-names = "jpgdec-smi",
 				      "jpgdec";
 			power-domains = <&spm MT8173_POWER_DOMAIN_VENC>;
-			mediatek,larb = <&larb3>;
 			iommus = <&iommu M4U_PORT_JPGDEC_WDMA>,
 				 <&iommu M4U_PORT_JPGDEC_BSDMA>;
 		};
@@ -1524,7 +1509,6 @@
 				 <&iommu M4U_PORT_VENC_CUR_CHROMA_SET2>,
 				 <&iommu M4U_PORT_VENC_REF_LUMA_SET2>,
 				 <&iommu M4U_PORT_VENC_REC_CHROMA_SET2>;
-			mediatek,larb = <&larb5>;
 			mediatek,vpu = <&vpu>;
 			clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
 			clock-names = "venc_lt_sel";
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index ca8ad953de91..d21e1ffc9b35 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1239,7 +1239,6 @@
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_OVL0>;
 			iommus = <&iommu M4U_PORT_DISP_OVL0>;
-			mediatek,larb = <&larb0>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x8000 0x1000>;
 		};
 
@@ -1250,7 +1249,6 @@
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_OVL0_2L>;
 			iommus = <&iommu M4U_PORT_DISP_2L_OVL0_LARB0>;
-			mediatek,larb = <&larb0>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0x9000 0x1000>;
 		};
 
@@ -1261,7 +1259,6 @@
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_OVL1_2L>;
 			iommus = <&iommu M4U_PORT_DISP_2L_OVL1_LARB0>;
-			mediatek,larb = <&larb0>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xa000 0x1000>;
 		};
 
@@ -1272,7 +1269,6 @@
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
-			mediatek,larb = <&larb0>;
 			mediatek,rdma-fifo-size = <5120>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xb000 0x1000>;
 		};
@@ -1284,7 +1280,6 @@
 			power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
 			clocks = <&mmsys CLK_MM_DISP_RDMA1>;
 			iommus = <&iommu M4U_PORT_DISP_RDMA1>;
-			mediatek,larb = <&larb0>;
 			mediatek,rdma-fifo-size = <2048>;
 			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
 		};
@@ -1439,7 +1434,6 @@
 			compatible = "mediatek,mt8183-jpgenc", "mediatek,mtk-jpgenc";
 			reg = <0 0x17030000 0 0x1000>;
 			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_LOW>;
-			mediatek,larb = <&larb4>;
 			iommus = <&iommu M4U_PORT_JPGENC_RDMA>,
 				 <&iommu M4U_PORT_JPGENC_BSDMA>;
 			power-domains = <&spm MT8183_POWER_DOMAIN_VENC>;
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
