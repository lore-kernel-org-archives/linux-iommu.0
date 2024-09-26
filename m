Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD6A1AF4D7
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727349312; cv=none; b=CkC8S+WPeGenvJvAjfngFg7/TgeYFb3z7d0EgzW/kBRtietfaFevIrE6Xs4ryk7zASX6xAhkn3lBMaUzw5g7FDFZ5b6OeSQbdbngW820oCe/18r1KkDeTMv/mJvAvNZe8rCPTeW+PEdw7f0iJK2HyzpgqXcGME/Gr7I4Izp1RWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727349312; c=relaxed/simple;
	bh=RuWwgIrp4FSS2bB+jFh4ZS3m2FyzwojlU2dvrFwJNxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwLU0wknv1au11HSiMll0++eg5R8gKofGCGFyOH30LROM0M3IB1KsrPcbyZPtsk3qfMrZHO52mLYn/R8CTRgtsmzqWXmxlT6t4+nZp6k0+4g6FX+wfRYZKkrHJGATafhW9PKLbBpsBjFpRLVkyCDRYGYFnFEertUrAUFJC6hml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kLJbUNqT; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kLJbUNqT"
X-UUID: 9472d3c47bf811efb66947d174671e26-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0qs5n6aiVKXUZ4oPXJXzyukG/oL76swZuP9snTdQB3c=;
	b=kLJbUNqTtw3xcBRt0Q7WkR+TX5IfmbarZW+ENV7wMfS0pRstIOYDF4UM/EtvJhnlGQ3zR0FBh5tktRUOyczPTlfZGjmtsIwvUfEcgZjXB4ScYjzLAQySA2p1tAygvZGpCgmo0FeME2Zg9ewaNB79WBoKCGTkLDPA2VEQnM/3PuE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f220c28a-cc58-4c35-9245-c3930c10c348,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:77f49a9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9472d3c47bf811efb66947d174671e26-20240926
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 345388608; Thu, 26 Sep 2024 19:15:04 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 19:15:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 19:15:00 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu
	<ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>, Tinghan Shen
	<tinghan.shen@mediatek.com>, Seiya Wang <seiya.wang@mediatek.com>, Ben Lok
	<ben.lok@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, "Nancy . Lin"
	<nancy.lin@mediatek.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, "Chris-qj
 chen" <chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH v2 2/5] dt-bindings: iommu: mediatek: Fix interrupt count constraint for new SoCs
Date: Thu, 26 Sep 2024 19:14:46 +0800
Message-ID: <20240926111449.9245-2-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240926111449.9245-1-macpaul.lin@mediatek.com>
References: <20240926111449.9245-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-1.215000-8.000000
X-TMASE-MatchedRID: P0y1Pz0bU7nwBTQ+XvV6VYzb2GR6Ttd3MZm0+sEE9msY0A95tjAn+9EQ
	LJPlYQqE0KHDXPxFjpD1VmTZnVKT+CaIC0lz+Wv3rQcmzcV8ovxbAoaK+wS4jUS/boWSGMtdi3N
	TyIt6V8peAwsJFuYQ4wTqbINU49IGbC1/2cudIH8SS5pQAyYxiqAPS3vFyaW6SSUXkvSVAdxZoZ
	UwtnkREuLzNWBegCW2wgn7iDBesS0qyYS0oyUVZrz092AhSRMerXqvQ7Xsx4NYyfd5fyfN9NdvP
	HFMK5cWUMepMtjA+idw3nV6gQuaZHRLk7foSK6ptbu7GfNV+t87DHWNfN2q6oSVUZZHNLr+RgV6
	Hsqyx11QaONuZ6Jr4g9k3l8EaYIcOQLK/ZH4rlaeqD9WtJkSIw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-1.215000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3C0E2BE1189122A4A3757AF41D63E367D739BF21E4BD2B17129FB16398AB53EB2000:8
X-MTK: N

The infra-iommu node in mt8195.dtsi was triggering a CHECK_DTBS error due
to an excessively long 'interrupts' property. The error message was:

  infra-iommu@10315000: interrupts: [[0, 795, 4, 0], [0, 796, 4, 0],
                     [0, 797, 4, 0], [0, 798, 4, 0], [0, 799, 4, 0]]
                     is too long

To address this issue, add "minItems: 1" and "maxItems: 5" constraints to
the 'interrupts' property in the DT binding schema. This change allows for
flexibility in the number of interrupts for new SoCs.
The purpose of these 5 interrupts is also added.

Fixes: bca28426805d ("dt-bindings: iommu: mediatek: Convert IOMMU to DT schema")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../bindings/iommu/mediatek,iommu.yaml        | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

Changes for v2:
 - commit message: re-formatting and add a description of adding 5 interrupts.
 - add 'description' and 'maxItems: 5' for 'interrupt' property of
   'mt8195-iommu-infra'
 - others keeps 'maxItems: 1'

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index ea6b0f5f24de..fdd2996d2a31 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -96,7 +96,8 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 5
 
   clocks:
     items:
@@ -210,6 +211,28 @@ allOf:
       required:
         - mediatek,larbs
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8195-iommu-infra
+
+    then:
+      properties:
+        interrupts:
+          description: |
+            The IOMMU of MT8195 has 5 banks: 0/1/2/3/4.
+            Each bank has a set of APB registers corresponding to the
+            normal world, protected world 1/2/3, and secure world, respectively.
+            Therefore, 5 interrupt numbers are needed.
+          maxItems: 5
+
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.45.2

