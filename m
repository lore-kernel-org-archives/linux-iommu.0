Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E820E7
	for <iommu@lists.linux.dev>; Thu, 11 Aug 2022 02:58:27 +0000 (UTC)
X-UUID: 1bb47b5347474144b9463c99e3298857-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/TzAQBhHFvAwj4SZDXvO3m+6p+7tUyPoJbBgU9gTz9U=;
	b=uH0u1TcQszn79DB05Lbe369tWwC/9WqNByXxJSiAJQizSfuKQOA0EgMgJgv+lxqCwOs3GGZheN6WWE7x2C7QrzGb29Uz/HbkOPgu94emfpBaJiJRrpK9Xjslm3fW5m1QbbRowBOzuAheDKMtwXNJlgNerHAAveR7kXnjVtF4aAg=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.9,REQID:8bed2460-51ed-4cbb-a2fc-0d8136917c4f,OB:0,LO
	B:0,IP:0,URL:0,TC:0,Content:51,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_G
	S6885AD,ACTION:quarantine,TS:151
X-CID-INFO: VERSION:1.1.9,REQID:8bed2460-51ed-4cbb-a2fc-0d8136917c4f,OB:0,LOB:
	0,IP:0,URL:0,TC:0,Content:51,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_US6
	5DF41,ACTION:quarantine,TS:151
X-CID-META: VersionHash:3d8acc9,CLOUDID:aba1559c-da39-4e3b-a854-56c7d2111b46,C
	OID:26a0113b1745,Recheck:0,SF:28|16|19|48|801,TC:nil,Content:3,EDM:-3,IP:n
	il,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1bb47b5347474144b9463c99e3298857-20220811
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 137493137; Thu, 11 Aug 2022 10:58:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 11 Aug 2022 10:58:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 11 Aug 2022 10:58:16 +0800
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
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Fengquan Chen
	<fengquan.chen@mediatek.com>
Subject: [PATCH v6 08/20] arm64: dts: mt8195: Disable watchdog external reset signal
Date: Thu, 11 Aug 2022 10:58:01 +0800
Message-ID: <20220811025813.21492-9-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220811025813.21492-1-tinghan.shen@mediatek.com>
References: <20220811025813.21492-1-tinghan.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Disable the external output reset signal of watchdog reset to avoid losing
the reset reason stored in the watchdog registers.

Signed-off-by: Fengquan Chen <fengquan.chen@mediatek.com>
Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 066c14989708a..436687ba826f4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -327,6 +327,7 @@
 		watchdog: watchdog@10007000 {
 			compatible = "mediatek,mt8195-wdt",
 				     "mediatek,mt6589-wdt";
+			mediatek,disable-extrst;
 			reg = <0 0x10007000 0 0x100>;
 		};
 
-- 
2.18.0

