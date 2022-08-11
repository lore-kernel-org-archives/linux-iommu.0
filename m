Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEAC20EC
	for <iommu@lists.linux.dev>; Thu, 11 Aug 2022 02:58:28 +0000 (UTC)
X-UUID: ed3d26a6179546d1bead17901b8731fd-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0xsciSuEWGlfUogQATKa51f0ayGsstjaIavZnJxxmZk=;
	b=U7A8ID2jhH8/Fq3lq8J1bB00RqPkBsrxtzc2DoZ/BFFsmsO1SPJmdoeJxSg5I2NmN9CQ5skj1Xo0BpXxhB5VKOmjR/ewbGML1UB0uwMCJp8Mh2SaMt97WqJZJOvl8E7w1K203SdeWOHUGDkEv52hrdkFURQ6dnDXRr8ZuDTHQ/A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:9022d4cf-5c89-4f5a-be05-6afe2bd6c541,OB:10,L
	OB:60,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Relea
	se_Ham,ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.9,REQID:9022d4cf-5c89-4f5a-be05-6afe2bd6c541,OB:10,LOB
	:60,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS
	981B3D,ACTION:quarantine,TS:100
X-CID-META: VersionHash:3d8acc9,CLOUDID:cea1559c-da39-4e3b-a854-56c7d2111b46,C
	OID:c61491456753,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: ed3d26a6179546d1bead17901b8731fd-20220811
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 507108906; Thu, 11 Aug 2022 10:58:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 11 Aug 2022 10:58:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 11 Aug 2022 10:58:15 +0800
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
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v6 04/20] dt-bindings: power: mediatek: Support naming power controller node with unit address
Date: Thu, 11 Aug 2022 10:57:57 +0800
Message-ID: <20220811025813.21492-5-tinghan.shen@mediatek.com>
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

Support naming power controller node with unit address, also compatible
with node names without unit address.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/power/mediatek,power-controller.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 321802c95308f..2d6afc0909473 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -19,7 +19,7 @@ description: |
 
 properties:
   $nodename:
-    const: power-controller
+    pattern: '^power-controller(@[0-9a-f]+)?$'
 
   compatible:
     enum:
-- 
2.18.0

