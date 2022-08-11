Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A720FC
	for <iommu@lists.linux.dev>; Thu, 11 Aug 2022 02:58:31 +0000 (UTC)
X-UUID: 793ceee6a8b543508222d02fd95ae238-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kmpHjJm3NwhGWARkt80tnbLRwJDYstuyEoPd3GlT7p4=;
	b=auaPTkFtC35in4S/RQqLPFeXRHp+ZCfSReeV8lLrgxBmEZaE6g551od9g2QXnPrRMW19yMDTJCOAMhc5/16TuipEt8Gp8jOPfSnwUcwLG7aXgvxfAG/YV0y1iXpXSiba6HrbXh8LRXloSrp4nf4oylaOcfYmdcrwQlC5JlVvTU0=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.9,REQID:8279cef6-233b-49da-9b7a-ca60338fc20c,OB:0,LO
	B:30,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_
	GS6885AD,ACTION:quarantine,TS:125
X-CID-INFO: VERSION:1.1.9,REQID:8279cef6-233b-49da-9b7a-ca60338fc20c,OB:0,LOB:
	30,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS
	981B3D,ACTION:quarantine,TS:125
X-CID-META: VersionHash:3d8acc9,CLOUDID:219afafc-9e71-4a0f-ba6b-417998daea35,C
	OID:47d4eb247e6c,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 793ceee6a8b543508222d02fd95ae238-20220811
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 390679182; Thu, 11 Aug 2022 10:58:16 +0800
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
Subject: [PATCH v6 05/20] dt-bindings: power: mediatek: Update maintainer list
Date: Thu, 11 Aug 2022 10:57:58 +0800
Message-ID: <20220811025813.21492-6-tinghan.shen@mediatek.com>
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

Update the maintainer list of power controller binding.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/power/mediatek,power-controller.yaml    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 2d6afc0909473..03b7f6aa591d4 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Mediatek Power Domains Controller
 
 maintainers:
-  - Weiyi Lu <weiyi.lu@mediatek.com>
+  - MandyJH Liu <mandyjh.liu@mediatek.com>
   - Matthias Brugger <mbrugger@suse.com>
 
 description: |
-- 
2.18.0

