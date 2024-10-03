Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275317C9B
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 03:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727924976; cv=none; b=qGK/vgP8fCuqPjSBr1kExuVagnS7HsaDingE5UoQz3IJm3Cud8HN7412B4CUl+oivdqvM4zNYZoO7PiWbYx8kQwBT0v98tsrxeHfQEAEdMb8TZegYpYZTIajlIQBeZuuObIs9sQHY7/4CPmtxxNy7IqQM8cDojlmh5mO5jURTSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727924976; c=relaxed/simple;
	bh=GgH1zlfsBcYy2XR4gqGasev5RJpaPE4ofjQ4/pVn9GU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9F2ZuDoLO81rN14zrEcrxAN4bJGGUlI+M10iQTW9VeVJOf0NpxLXxvsKEu6KIrN9fATsDtuPKB4KscUNqywU1pkqX8p3PDMNQwEo0b2ppVFPDrRdaclvRBEsHNpq/ZckNlbrppO8Qi/aLcqrk3zJh/c5Kp01xa1jr9lSzHGzBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=H2PRcJar; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="H2PRcJar"
X-UUID: e64a9ab0813411efb66947d174671e26-20241003
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0KhrERn+x95fmVwYoycNWzZQMILdQBU+L1WFDe4D2c4=;
	b=H2PRcJarZfgkj83veVJL8Ap65D1C09uePxPBx8jWi1OF5wCI7XbnEw0cwuDkCWFb6IvNx+QxOcU4mqiAs/umgIgAoaUq+ar4hW/vhGg3y5uiifi7H6t13Cj5fYrq7oddQhf8SNRQTue1o4cNuUZ4aMFnERDcWMaNId3H/LkyAiw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:cc5269c6-8d46-4c03-a2a1-a8d612f82b3b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:6dc6a47,CLOUDID:a70ae51a-3b87-4dc0-9e4d-1d837ff4304b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:1|19,IP:nil
	,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: e64a9ab0813411efb66947d174671e26-20241003
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 716648927; Thu, 03 Oct 2024 11:09:27 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Oct 2024 20:09:25 -0700
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 3 Oct 2024 11:09:25 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rohit
 Agarwal <rohiagar@chromium.org>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen
 Chu <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v6 4/4] dt-bindings: display: mediatek: dpi: correct power-domains property
Date: Thu, 3 Oct 2024 11:09:19 +0800
Message-ID: <20241003030919.17980-4-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20241003030919.17980-1-macpaul.lin@mediatek.com>
References: <20241003030919.17980-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
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

Changes for v5:
 - Add missing Reviewed-by Tag from Krzysztof. Thanks.

Changes for v6:
 - No change.

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

