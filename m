Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D656162D
	for <iommu@lists.linux.dev>; Thu,  4 Aug 2022 02:16:04 +0000 (UTC)
X-UUID: f569d5f1517742de8bc3c159dbdac023-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+0uzshzNpYhYfr57wBmr/MKQQ0fubuE8SCiieVRxOsM=;
	b=jRGEybTcSSWTRkz0eE5Hci5zAuLmhvt4veFCyY4blQkP8hMGOlFh3ltBjcbjttltX9EP+bGkf9RRIbgQ7HHbAr4y6j3trfoGJiM88rS0lkC462TjmAbFd7M+MsHClx7xiKnI5Qsdv/TqHpdAUMGUkQsK6BHwhntfiO7fKagyM4k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:c135642b-9b6e-448c-b590-be049e0a38d2,OB:0,LO
	B:20,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
	CTION:release,TS:90
X-CID-INFO: VERSION:1.1.8,REQID:c135642b-9b6e-448c-b590-be049e0a38d2,OB:0,LOB:
	20,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
	CTION:quarantine,TS:90
X-CID-META: VersionHash:0f94e32,CLOUDID:b1432cd1-841b-4e95-ad42-8f86e18f54fc,C
	OID:60d80c33a225,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: f569d5f1517742de8bc3c159dbdac023-20220804
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1024746149; Thu, 04 Aug 2022 10:15:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 4 Aug 2022 10:15:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Aug 2022 10:15:57 +0800
From: Tinghan Shen <tinghan.shen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Lee Jones <lee@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Tinghan Shen
	<tinghan.shen@mediatek.com>, MandyJH Liu <mandyjh.liu@mediatek.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Trevor Wu
	<trevor.wu@mediatek.com>
Subject: [PATCH v5 15/20] arm64: dts: mt8195: Add audio related nodes
Date: Thu, 4 Aug 2022 10:15:48 +0800
Message-ID: <20220804021553.14867-16-tinghan.shen@mediatek.com>
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

Add audio related nodes for mt8195.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 58 ++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
 b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index d10db01a360aa..bbea0acff3d2f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -226,6 +226,17 @@
 		       <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
 	};
 
+	dmic_codec: dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <2>;
+		wakeup-delay-ms = <50>;
+	};
+
+	sound: mt8195-sound {
+		mediatek,platform = <&afe>;
+		status = "disabled";
+	};
+
 	clk26m: oscillator-26m {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -728,6 +739,53 @@
 			#clock-cells = <1>;
 		};
 
+		afe: mt8195-afe-pcm@10890000 {
+			compatible = "mediatek,mt8195-audio";
+			reg = <0 0x10890000 0 0x10000>;
+			mediatek,topckgen = <&topckgen>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_AUDIO>;
+			interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&clk26m>,
+				<&apmixedsys CLK_APMIXED_APLL1>,
+				<&apmixedsys CLK_APMIXED_APLL2>,
+				<&topckgen CLK_TOP_APLL12_DIV0>,
+				<&topckgen CLK_TOP_APLL12_DIV1>,
+				<&topckgen CLK_TOP_APLL12_DIV2>,
+				<&topckgen CLK_TOP_APLL12_DIV3>,
+				<&topckgen CLK_TOP_APLL12_DIV9>,
+				<&topckgen CLK_TOP_A1SYS_HP>,
+				<&topckgen CLK_TOP_AUD_INTBUS>,
+				<&topckgen CLK_TOP_AUDIO_H>,
+				<&topckgen CLK_TOP_AUDIO_LOCAL_BUS>,
+				<&topckgen CLK_TOP_DPTX_MCK>,
+				<&topckgen CLK_TOP_I2SO1_MCK>,
+				<&topckgen CLK_TOP_I2SO2_MCK>,
+				<&topckgen CLK_TOP_I2SI1_MCK>,
+				<&topckgen CLK_TOP_I2SI2_MCK>,
+				<&infracfg_ao CLK_INFRA_AO_AUDIO_26M_B>,
+				<&scp_adsp CLK_SCP_ADSP_AUDIODSP>;
+			clock-names = "clk26m",
+				"apll1_ck",
+				"apll2_ck",
+				"apll12_div0",
+				"apll12_div1",
+				"apll12_div2",
+				"apll12_div3",
+				"apll12_div9",
+				"a1sys_hp_sel",
+				"aud_intbus_sel",
+				"audio_h_sel",
+				"audio_local_bus_sel",
+				"dptx_m_sel",
+				"i2so1_m_sel",
+				"i2so2_m_sel",
+				"i2si1_m_sel",
+				"i2si2_m_sel",
+				"infra_ao_audio_26m_b",
+				"scp_adsp_audiodsp";
+			status = "disabled";
+		};
+
 		uart0: serial@11001100 {
 			compatible = "mediatek,mt8195-uart",
 				     "mediatek,mt6577-uart";
-- 
2.18.0

