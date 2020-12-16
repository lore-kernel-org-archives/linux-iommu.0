Return-Path: <SRS0=vTls=FU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73215C2BBCA
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 11:36:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E0023382
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 11:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E0023382
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7A7C5214F6;
	Wed, 16 Dec 2020 11:36:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id orK-dIhhhUZ7; Wed, 16 Dec 2020 11:36:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8BB602034B;
	Wed, 16 Dec 2020 11:36:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CDDBC0893;
	Wed, 16 Dec 2020 11:36:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C413C013B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 11:36:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F2FCD8689A
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 11:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7BQ8NVycMbNj for <iommu@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 11:36:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3C94786881
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 11:36:42 +0000 (UTC)
X-UUID: 86b6c24a846540cd85cab6ea4107d6a8-20201216
X-UUID: 86b6c24a846540cd85cab6ea4107d6a8-20201216
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1493634832; Wed, 16 Dec 2020 19:36:39 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Dec 2020 19:36:36 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Dec 2020 19:36:35 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] arm64: dts: mt8192: add m4u and smi nodes
Date: Wed, 16 Dec 2020 19:36:30 +0800
Message-ID: <20201216113630.26050-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, weiyi.lu@mediatek.com,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 yi.kuo@mediatek.com, Project_Global_Chrome_Upstream_Group@mediatek.com,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
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

Add mt8192 IOMMU and smi larb/common nodes.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
This patch base on:
1. mt8192 dts base which is in the linux-next now.
https://lore.kernel.org/linux-mediatek/20201030092207.26488-2-seiya.wang@mediatek.com/

2. clock nodes and definitions:
https://lore.kernel.org/linux-mediatek/1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com/

3. PM definitions:
https://patchwork.kernel.org/project/linux-mediatek/patch/20201030113622.201188-15-enric.balletbo@collabora.com/

4. PM nodes:
https://lore.kernel.org/linux-mediatek/1605782884-19741-1-git-send-email-weiyi.lu@mediatek.com/

5. iommu ports defintions:
https://lore.kernel.org/linux-iommu/20201209080102.26626-1-yong.wu@mediatek.com/T/#t
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 193 +++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index a315568fcd9a..b84585de5ca8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8192-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/memory/mt8192-larb-port.h>
 #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
 #include <dt-bindings/power/mt8192-power.h>
 
@@ -807,24 +808,116 @@
 			#clock-cells = <1>;
 		};
 
+		smi_common: smi@14002000 {
+			compatible = "mediatek,mt8192-smi-common";
+			reg = <0 0x14002000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_SMI_INFRA>,
+				 <&mmsys CLK_MM_SMI_GALS>,
+				 <&mmsys CLK_MM_SMI_GALS>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+		};
+
+		larb0: larb@14003000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x14003000 0 0x1000>;
+			mediatek,larb-id = <0>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_SMI_INFRA>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+		};
+
+		larb1: larb@14004000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x14004000 0 0x1000>;
+			mediatek,larb-id = <1>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_SMI_INFRA>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+		};
+
+		iommu0: m4u@1401d000 {
+			compatible = "mediatek,mt8192-m4u";
+			reg = <0 0x1401d000 0 0x1000>;
+			mediatek,larbs = <&larb0 &larb1 &larb2
+					  &larb4 &larb5 &larb7
+					  &larb9 &larb11 &larb13
+					  &larb14 &larb16 &larb17
+					  &larb18 &larb19 &larb20>;
+			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&mmsys CLK_MM_SMI_IOMMU>;
+			clock-names = "bclk";
+			power-domains = <&spm MT8192_POWER_DOMAIN_DISP>;
+			#iommu-cells = <1>;
+		};
+
 		imgsys: syscon@15020000 {
 			compatible = "mediatek,mt8192-imgsys", "syscon";
 			reg = <0 0x15020000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb9: larb@1502e000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x1502e000 0 0x1000>;
+			mediatek,larb-id = <9>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&imgsys CLK_IMG_LARB9>,
+				 <&imgsys CLK_IMG_LARB9>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_ISP>;
+		};
+
 		imgsys2: syscon@15820000 {
 			compatible = "mediatek,mt8192-imgsys2", "syscon";
 			reg = <0 0x15820000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb11: larb@1582e000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x1582e000 0 0x1000>;
+			mediatek,larb-id = <11>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&imgsys2 CLK_IMG2_LARB11>,
+				 <&imgsys2 CLK_IMG2_LARB11>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_ISP2>;
+		};
+
+		larb5: larb@1600d000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x1600d000 0 0x1000>;
+			mediatek,larb-id = <5>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vdecsys_soc CLK_VDEC_SOC_LARB1>,
+				 <&vdecsys_soc CLK_VDEC_SOC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_VDEC>;
+		};
+
 		vdecsys_soc: syscon@1600f000 {
 			compatible = "mediatek,mt8192-vdecsys_soc", "syscon";
 			reg = <0 0x1600f000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb4: larb@1602e000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x1602e000 0 0x1000>;
+			mediatek,larb-id = <4>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vdecsys CLK_VDEC_SOC_LARB1>,
+				 <&vdecsys CLK_VDEC_SOC_LARB1>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_VDEC2>;
+		};
+
 		vdecsys: syscon@1602f000 {
 			compatible = "mediatek,mt8192-vdecsys", "syscon";
 			reg = <0 0x1602f000 0 0x1000>;
@@ -837,12 +930,79 @@
 			#clock-cells = <1>;
 		};
 
+		larb7: larb@17010000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x17010000 0 0x1000>;
+			mediatek,larb-id = <7>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&vencsys CLK_VENC_SET0_LARB>,
+				 <&vencsys CLK_VENC_SET1_VENC>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_VENC>;
+		};
+
 		camsys: syscon@1a000000 {
 			compatible = "mediatek,mt8192-camsys", "syscon";
 			reg = <0 0x1a000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
 
+		larb13: larb@1a001000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x1a001000 0 0x1000>;
+			mediatek,larb-id = <13>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&camsys CLK_CAM_CAM>,
+				 <&camsys CLK_CAM_LARB13>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_CAM>;
+		};
+
+		larb14: larb@1a002000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x1a002000 0 0x1000>;
+			mediatek,larb-id = <14>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&camsys CLK_CAM_CAM>,
+				 <&camsys CLK_CAM_LARB14>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_CAM>;
+		};
+
+		larb16: larb@1a00f000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x1a00f000 0 0x1000>;
+			mediatek,larb-id = <16>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&camsys_rawa CLK_CAM_RAWA_CAM>,
+				 <&camsys_rawa CLK_CAM_RAWA_LARBX>;
+			clock-names = "apb", "smi";
+			mediatek,smi-id = <16>;
+			power-domains = <&spm MT8192_POWER_DOMAIN_CAM_RAWA>;
+		};
+
+		larb17: larb@1a010000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x1a010000 0 0x1000>;
+			mediatek,larb-id = <17>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&camsys_rawb CLK_CAM_RAWB_CAM>,
+				 <&camsys_rawb CLK_CAM_RAWB_LARBX>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_CAM_RAWB>;
+		};
+
+		larb18: larb@1a011000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x1a011000 0 0x1000>;
+			mediatek,larb-id = <18>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&camsys_rawc CLK_CAM_RAWC_LARBX>,
+				 <&camsys_rawc CLK_CAM_RAWC_CAM>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_CAM_RAWC>;
+		};
+
 		camsys_rawa: syscon@1a04f000 {
 			compatible = "mediatek,mt8192-camsys_rawa", "syscon";
 			reg = <0 0x1a04f000 0 0x1000>;
@@ -867,10 +1027,43 @@
 			#clock-cells = <1>;
 		};
 
+		larb20: larb@1b00f000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x1b00f000 0 0x1000>;
+			mediatek,larb-id = <20>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&ipesys CLK_IPE_SMI_SUBCOM>,
+				 <&ipesys CLK_IPE_LARB20>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_IPE>;
+		};
+
+		larb19: larb@1b10f000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x1b10f000 0 0x1000>;
+			mediatek,larb-id = <19>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&ipesys CLK_IPE_SMI_SUBCOM>,
+				 <&ipesys CLK_IPE_LARB19>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_IPE>;
+		};
+
 		mdpsys: syscon@1f000000 {
 			compatible = "mediatek,mt8192-mdpsys", "syscon";
 			reg = <0 0x1f000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		larb2: larb@1f002000 {
+			compatible = "mediatek,mt8192-smi-larb";
+			reg = <0 0x1f002000 0 0x1000>;
+			mediatek,larb-id = <2>;
+			mediatek,smi = <&smi_common>;
+			clocks = <&mdpsys CLK_MDP_SMI0>,
+				 <&mdpsys CLK_MDP_SMI0>;
+			clock-names = "apb", "smi";
+			power-domains = <&spm MT8192_POWER_DOMAIN_MDP>;
+		};
 	};
 };
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
