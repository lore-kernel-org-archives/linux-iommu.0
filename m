Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629CBCCA48A
	for <iommu@archiver.kernel.org>; Mon,  4 Jul 2022 12:18:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57F1560EA3;
	Mon,  4 Jul 2022 12:18:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57F1560EA3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1tdeKG5mobwB; Mon,  4 Jul 2022 12:18:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CDE1360E82;
	Mon,  4 Jul 2022 12:18:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CDE1360E82
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 372BCC007C;
	Mon,  4 Jul 2022 12:18:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC6CFC002D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:00:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4812D826C1
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:00:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4812D826C1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8lui3JIOl5W2 for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 10:00:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B4A282681
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B4A282681
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 10:00:40 +0000 (UTC)
X-UUID: 23f7023660df4b0c9587f1b802ebd709-20220704
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7, REQID:55a2ac7a-6bec-4b15-aa0f-4384b2abef32, OB:0,
 LO
 B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
 ON:release,TS:0
X-CID-META: VersionHash:87442a2, CLOUDID:c7d68dd6-5d6d-4eaf-a635-828a3ee48b7c,
 C
 OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
 ,QS:nil,BEC:nil,COL:0
X-UUID: 23f7023660df4b0c9587f1b802ebd709-20220704
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <tinghan.shen@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1630907575; Mon, 04 Jul 2022 18:00:30 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; 
 Mon, 4 Jul 2022 18:00:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 4 Jul 2022 18:00:30 +0800
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Chun-Jie Chen <chun-jie.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Enric
 Balletbo i Serra <enric.balletbo@collabora.com>, Tinghan Shen
 <tinghan.shen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v1 06/16] arm64: dts: mt8195: Add cpufreq node
Date: Mon, 4 Jul 2022 18:00:18 +0800
Message-ID: <20220704100028.19932-7-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220704100028.19932-1-tinghan.shen@mediatek.com>
References: <20220704100028.19932-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-Mailman-Approved-At: Mon, 04 Jul 2022 12:18:20 +0000
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 YT Lee <yt.lee@mediatek.corp-partner.google.com>,
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
From: Tinghan Shen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tinghan Shen <tinghan.shen@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: YT Lee <yt.lee@mediatek.corp-partner.google.com>

Add cpufreq node for mt8195.

Signed-off-by: YT Lee <yt.lee@mediatek.corp-partner.google.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 8032b839dfe8..900aaa16f862 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -26,6 +26,7 @@
 			compatible = "arm,cortex-a55";
 			reg = <0x000>;
 			enable-method = "psci";
+			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
 			capacity-dmips-mhz = <578>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
@@ -38,6 +39,7 @@
 			compatible = "arm,cortex-a55";
 			reg = <0x100>;
 			enable-method = "psci";
+			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
 			capacity-dmips-mhz = <578>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
@@ -50,6 +52,7 @@
 			compatible = "arm,cortex-a55";
 			reg = <0x200>;
 			enable-method = "psci";
+			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
 			capacity-dmips-mhz = <578>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
@@ -62,6 +65,7 @@
 			compatible = "arm,cortex-a55";
 			reg = <0x300>;
 			enable-method = "psci";
+			performance-domains = <&performance 0>;
 			clock-frequency = <1701000000>;
 			capacity-dmips-mhz = <578>;
 			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
@@ -74,6 +78,7 @@
 			compatible = "arm,cortex-a78";
 			reg = <0x400>;
 			enable-method = "psci";
+			performance-domains = <&performance 1>;
 			clock-frequency = <2171000000>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
@@ -86,6 +91,7 @@
 			compatible = "arm,cortex-a78";
 			reg = <0x500>;
 			enable-method = "psci";
+			performance-domains = <&performance 1>;
 			clock-frequency = <2171000000>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
@@ -98,6 +104,7 @@
 			compatible = "arm,cortex-a78";
 			reg = <0x600>;
 			enable-method = "psci";
+			performance-domains = <&performance 1>;
 			clock-frequency = <2171000000>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
@@ -110,6 +117,7 @@
 			compatible = "arm,cortex-a78";
 			reg = <0x700>;
 			enable-method = "psci";
+			performance-domains = <&performance 1>;
 			clock-frequency = <2171000000>;
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&cpu_off_b &cluster_off_b>;
@@ -231,6 +239,12 @@
 		clock-output-names = "clk32k";
 	};
 
+	performance: performance-controller@11bc10 {
+		compatible = "mediatek,cpufreq-hw";
+		reg = <0 0x0011bc10 0 0x120>, <0 0x0011bd30 0 0x120>;
+		#performance-domain-cells = <1>;
+	};
+
 	pmu-a55 {
 		compatible = "arm,cortex-a55-pmu";
 		interrupt-parent = <&gic>;
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
