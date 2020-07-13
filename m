Return-Path: <SRS0=SFHS=AY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AABC433E6
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 21:54:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34E12072D
	for <iommu@archiver.kernel.org>; Mon, 13 Jul 2020 21:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34E12072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4979B89E6A;
	Mon, 13 Jul 2020 21:54:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ecQaP8YgayO; Mon, 13 Jul 2020 21:54:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D9788A371;
	Mon, 13 Jul 2020 21:54:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7E47C08A0;
	Mon, 13 Jul 2020 21:54:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C7D6C0888
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 21:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1B41B8845C
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 21:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z4QUGhzudIGP for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jul 2020 21:40:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 65B0988451
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jul 2020 21:40:44 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.75,348,1589209200"; d="scan'208";a="52015992"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2020 06:35:38 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id E110440F7FE5;
 Tue, 14 Jul 2020 06:35:34 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Joerg Roedel <joro@8bytes.org>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 3/9] arm64: dts: renesas: r8a774e1: Add IPMMU device nodes
Date: Mon, 13 Jul 2020 22:35:14 +0100
Message-Id: <1594676120-5862-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add RZ/G2H (R8A774E1) IPMMU nodes.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 121 ++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 7484ad530068..0fc0d9ff5bc5 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -408,6 +408,127 @@
 			/* placeholder */
 		};
 
+		ipmmu_ds0: iommu@e6740000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xe6740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 0>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_ds1: iommu@e7740000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xe7740000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 1>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_hc: iommu@e6570000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xe6570000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 2>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_mm: iommu@e67b0000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xe67b0000 0 0x1000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_mp0: iommu@ec670000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xec670000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 4>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_pv0: iommu@fd800000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfd800000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 6>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_pv1: iommu@fd950000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfd950000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 7>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_pv2: iommu@fd960000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfd960000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 8>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_pv3: iommu@fd970000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfd970000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 9>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vc0: iommu@fe6b0000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfe6b0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 12>;
+			power-domains = <&sysc R8A774E1_PD_A3VC>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vc1: iommu@fe6f0000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfe6f0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 13>;
+			power-domains = <&sysc R8A774E1_PD_A3VC>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vi0: iommu@febd0000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfebd0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 14>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vi1: iommu@febe0000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfebe0000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 15>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vp0: iommu@fe990000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfe990000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 16>;
+			power-domains = <&sysc R8A774E1_PD_A3VP>;
+			#iommu-cells = <1>;
+		};
+
+		ipmmu_vp1: iommu@fe980000 {
+			compatible = "renesas,ipmmu-r8a774e1";
+			reg = <0 0xfe980000 0 0x1000>;
+			renesas,ipmmu-main = <&ipmmu_mm 17>;
+			power-domains = <&sysc R8A774E1_PD_A3VP>;
+			#iommu-cells = <1>;
+		};
+
 		avb: ethernet@e6800000 {
 			reg = <0 0xe6800000 0 0x800>;
 			#address-cells = <1>;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
