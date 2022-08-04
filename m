Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301462C
	for <iommu@lists.linux.dev>; Thu,  4 Aug 2022 02:16:10 +0000 (UTC)
X-UUID: cd0c03c3beba4fc8bb66c9c3a75992b4-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HmSmq6yMM36pKrdp31Ni74Gs/X4TNMNcYcMhqJnFRkA=;
	b=ijS7UJZuzZU+3yA3SmQqfrf8TPlyUWSbzdwQqCIWApxkftBIfFOH8HHvDj3wrt83QNx7jnim/O+LBrcgvzmqoCTnRripn1P6WRhDFnBmXH+7y23/TBk+1ALSgECdYX78Fe2AHSj3ctXWKdHeRsMxvLWa7BXBds0inSQlC0k6vks=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:0ee0bc20-69af-4200-9fff-4d9fdfcd987e,OB:0,LO
	B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:a3c03bd0-a6cf-4fb6-be1b-c60094821ca2,C
	OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
	,QS:nil,BEC:nil,COL:0
X-UUID: cd0c03c3beba4fc8bb66c9c3a75992b4-20220804
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 726060087; Thu, 04 Aug 2022 10:15:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 4 Aug 2022 10:15:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Aug 2022 10:15:56 +0800
From: Tinghan Shen <tinghan.shen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Lee Jones <lee@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Tinghan Shen
	<tinghan.shen@mediatek.com>, MandyJH Liu <mandyjh.liu@mediatek.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, YT Lee
	<yt.lee@mediatek.corp-partner.google.com>
Subject: [PATCH v5 10/20] arm64: dts: mt8195: Add cpufreq node
Date: Thu, 4 Aug 2022 10:15:43 +0800
Message-ID: <20220804021553.14867-11-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220804021553.14867-1-tinghan.shen@mediatek.com>
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: YT Lee <yt.lee@mediatek.corp-partner.google.com>

Add cpufreq node for mt8195.

Signed-off-by: YT Lee <yt.lee@mediatek.corp-partner.google.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
 b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 8032b839dfe8d..900aaa16f862f 100644
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

