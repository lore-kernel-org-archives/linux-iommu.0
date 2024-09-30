Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4D117C7C4
	for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685549; cv=none; b=YayBzlA2zBZGbOg/lGkfPPX9W5TnKGBRxkqZBwxRPIV2hPMlV8Hr6r60QcKyDhM1juo/BdsYqxAt2SPbcyc43oKM/mTgX6fSQr45lThwj6nCTcHCjsOEBIga9CZ56l5WdPsd7tpwFRETjwyX9/Dvm8EXpGQt9cd73xXwUbLMMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685549; c=relaxed/simple;
	bh=yS64edU2NqBEpuyYjGIWM98niV5r3SJa3VvZIKeZYnI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmK7+k5sdA52ZTSaKmA4BW40W+xynokHUfeHpi9svqrFLAr2I0lDIWLJIR5n5pVtRt2DK5kgwQF71ckkNtr1AE2r9XIaKoVOXhnDp1xGmjATDk7UrbqWBYG8M5YwyQBdqy1TIlSMLdPm/7BViwkZFYmssDPWaJ/ZT1hLRrlThe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XmCbRvqk; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XmCbRvqk"
X-UUID: 7251ef5c7f0711ef8b96093e013ec31c-20240930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hDNEUbRfs0AZlP5WUz/9DU29TC9XdZVz1HcuFrNQPGU=;
	b=XmCbRvqkygMC6mzKbD3hSgWJOk067mLL3nZGn5MPXBhYlHzBKPWKVMkZ2PFWoT/HM2sFFjkrOSE0dHJJpv9IAFvGhLg568hGbIeJHsQDlFjAtZ/ENxYEgy/uvq47NMLqxmgw3GVMfjoAqFkeM/rqYVE2VrZiEAr+nsVLdU2SB4k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:29aca526-a073-405a-9f79-301bbf273a37,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:669f7818-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 7251ef5c7f0711ef8b96093e013ec31c-20240930
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1854820576; Mon, 30 Sep 2024 16:39:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 30 Sep 2024 16:39:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 30 Sep 2024 16:39:00 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Rohit
 Agarwal" <rohiagar@chromium.org>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, "Sen
 Chu" <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v4 5/5] dt-bindings: display: mediatek: dpi: correct power-domains property
Date: Mon, 30 Sep 2024 16:38:54 +0800
Message-ID: <20240930083854.7267-5-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240930083854.7267-1-macpaul.lin@mediatek.com>
References: <20240930083854.7267-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.634400-8.000000
X-TMASE-MatchedRID: qW4A1GTxjidpqqYAQ+J6uSYRREGYqtmUmoKXVHfiMM9KUzR+o2IehUGW
	yClQhQkvKY6B7sY8Ci7dRIKCUEZlk77J5yv1W35KA9lly13c/gG+1Vx7rDn4ryJ8zskw0dbrzTO
	MdSL65dGPBBqsttKK1ATOtv1QaDkraxXbwRJk57z0hv/rD7WVZA+jS+LRpl81pzPA3TKVblhgIS
	cCiWkKENIS3Y3mrYfnGcJ+wyELRguQwm5+b+ZNPWwbuvhCHs3cmyqQJWNsuklnuv8pVwMzSaPFj
	JEFr+olwXCBO/GKkVqOhzOa6g8KreZSJ1TNsghrv/+5FGOeWZXcBv1Z1cQJdotlafIoElfjSNFf
	wUeiquw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.634400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 40AF8F1FFDEB6E24481B39A1EB76A7783E7F4B725E7D52BA28DB252CB7D854F12000:8
X-MTK: N

The MediaTek DPI module is typically associated with one of the
following multimedia power domains:
 - POWER_DOMAIN_DISPLAY
 - POWER_DOMAIN_VDOSYS
 - POWER_DOMAIN_MM
The specific power domain used varies depending on the SoC design.

These power domains are shared by multiple devices within the SoC.
In most cases, these power domains are enabled by other devices.
As a result, the DPI module of legacy SoCs often functions correctly
even without explicit configuration.

It is recommended to explicitly add the appropriate power domain
property to the DPI node in the device tree. Hence drop the
compatible checking for specific SoCs.

Fixes: 5474d49b2f79 ("dt-bindings: display: mediatek: dpi: Add power domains")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
---
 .../display/mediatek/mediatek,dpi.yaml        | 24 ++++++++-----------
 1 file changed, 10 insertions(+), 14 deletions(-)

Changes for v2:
 - Because of the corresponding dts fix has been reviewed with a Reviewed-by: tag.
   [1] https://lore.kernel.org/all/20240925080515.16377-1-macpaul.lin@mediatek.com/
   We still need this change to fix the 2 dtbs_check errors.
   So keeps no change here.

Changes for v3:
 - The origin patch is [2]
   https://lore.kernel.org/all/20240926111449.9245-2-macpaul.lin@mediatek.com/
 - Thanks for Conor's reminding, after MediaTek's internal discussion,
   This patch v3 is the replacement of [2] v2.
   Because the DPI module should has a explicit configuration with power domain.
 - Drop Acked-by: tag since v3 is nearly a new patch for different approach.

Changes for v4:
 - No change. Please help to review it again.

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 3a82aec9021c..497c0eb4ed0b 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -63,6 +63,16 @@ properties:
       - const: sleep
 
   power-domains:
+    description: |
+      The MediaTek DPI module is typically associated with one of the
+      following multimedia power domains:
+        POWER_DOMAIN_DISPLAY
+        POWER_DOMAIN_VDOSYS
+        POWER_DOMAIN_MM
+      The specific power domain used varies depending on the SoC design.
+
+      It is recommended to explicitly add the appropriate power domain
+      property to the DPI node in the device tree.
     maxItems: 1
 
   port:
@@ -79,20 +89,6 @@ required:
   - clock-names
   - port
 
-allOf:
-  - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              enum:
-                - mediatek,mt6795-dpi
-                - mediatek,mt8173-dpi
-                - mediatek,mt8186-dpi
-    then:
-      properties:
-        power-domains: false
-
 additionalProperties: false
 
 examples:
-- 
2.45.2

