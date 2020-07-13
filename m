Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F092C433E8
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 21:54:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5E22072D
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 21:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5E22072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3545188A81;
	Mon, 13 Jul 2020 21:54:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pRsYAIXoDz6s; Mon, 13 Jul 2020 21:54:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2FEDC8A385;
	Mon, 13 Jul 2020 21:54:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0ABF7C08A0;
	Mon, 13 Jul 2020 21:54:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A4A2C0733
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 21:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 33A3F204CB
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 21:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m2JdOoFYwvn3 for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 21:40:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by silver.osuosl.org (Postfix) with ESMTP id DBDAB22660
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 21:40:58 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.75,348,1589209200"; d="scan'208";a="51803377"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2020 06:35:55 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7347C40F7FC8;
 Tue, 14 Jul 2020 06:35:51 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Joerg Roedel <joro@8bytes.org>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7/9] arm64: dts: renesas: r8a774e1: Add GPIO device nodes
Date: Mon, 13 Jul 2020 22:35:18 +0100
Message-Id: <1594676120-5862-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailman-Approved-At: Mon, 13 Jul 2020 21:53:59 +0000
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, Prabhakar <prabhakar.csengg@gmail.com>,
 dmaengine@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

Add GPIO device nodes to the DT of the r8a774e1 SoC.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 73 +++++++++++++++++------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 9e05d134a295..599703d87b56 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -246,84 +246,123 @@
 		};
 
 		gpio0: gpio@e6050000 {
+			compatible = "renesas,gpio-r8a774e1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6050000 0 0x50>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 0 16>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 912>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 912>;
 		};
 
 		gpio1: gpio@e6051000 {
+			compatible = "renesas,gpio-r8a774e1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6051000 0 0x50>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 32 29>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 911>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 911>;
 		};
 
 		gpio2: gpio@e6052000 {
+			compatible = "renesas,gpio-r8a774e1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6052000 0 0x50>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 64 15>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 910>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 910>;
 		};
 
 		gpio3: gpio@e6053000 {
-			/* placeholder */
+			compatible = "renesas,gpio-r8a774e1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6053000 0 0x50>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 96 16>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 909>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 909>;
 		};
 
 		gpio4: gpio@e6054000 {
+			compatible = "renesas,gpio-r8a774e1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6054000 0 0x50>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 128 18>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 908>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 908>;
 		};
 
 		gpio5: gpio@e6055000 {
+			compatible = "renesas,gpio-r8a774e1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055000 0 0x50>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 160 26>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 907>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 907>;
 		};
 
 		gpio6: gpio@e6055400 {
+			compatible = "renesas,gpio-r8a774e1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055400 0 0x50>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 192 32>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 906>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 906>;
 		};
 
 		gpio7: gpio@e6055800 {
+			compatible = "renesas,gpio-r8a774e1",
+				     "renesas,rcar-gen3-gpio";
 			reg = <0 0xe6055800 0 0x50>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
 			gpio-controller;
+			gpio-ranges = <&pfc 0 224 4>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
-
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 905>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 905>;
 		};
 
 		pfc: pin-controller@e6060000 {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
