Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F519ADA6
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 10:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173934; cv=none; b=caQERwiohMzWbPzIscYDEoIFPWi1NRNGgReFe205B4Czlg1Uye8zf2qD0X9nkM83sgguLD3tqPylx05woGO3M79b+dwN/NEOZZeMkPkeypNMKuoIWuQ2So8I6AUOalS3NnCkgXFgz0WnnHebHCkNVjzY4Er1vBxcMVC/YFVhdDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173934; c=relaxed/simple;
	bh=mxVO5E2wzoza9aozGwceZxMJa6iGe+g4SgzDXO3gkXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuGwE4khgyiRexXNrwPoT/uyjN3chIWVtTG7yb7onKoB3fJo0/bjqAQdX7BUwGD6GBWag63Jd84xR8teZVo3uvTR2FFmrVxqn3ypPGDjN1e61PL+OuP68LtTau4M+DlVrpxbffKGRZl2Qcv9rh+OHqoPrNDOefKnMZmvakk03f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EHR8K7ac; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EHR8K7ac"
X-UUID: 3f958ef87a6011ef8b96093e013ec31c-20240924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mAyM0KsUrQn5kYjbZlC40aRnbg125gf/j0VqMjQTJ5g=;
	b=EHR8K7acAa7NXk0MaPA3J5JxHphiCVVAgTx1x9xZyoGjBkwvrDUXuloBrDBUgQ8YVVK04zUoTyqa2FkPsLftlMAP486dVWy7nWcL62/W3VH19jl9WCOKfqhuoAkKO98Tc1pDMr47oIcrBQs7qgADeji6PpVU7ANypicHblUmJ4E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ca1d2907-db6a-44e0-b308-66e040f73e23,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:2c847b9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3f958ef87a6011ef8b96093e013ec31c-20240924
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1277769090; Tue, 24 Sep 2024 18:32:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 24 Sep 2024 18:32:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 24 Sep 2024 18:32:04 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yong Wu
	<yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, "Sen
 Chu" <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH 3/6] dt-bindings: display: mediatek: Fix clocks count constraint for new SoCs
Date: Tue, 24 Sep 2024 18:31:53 +0800
Message-ID: <20240924103156.13119-3-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240924103156.13119-1-macpaul.lin@mediatek.com>
References: <20240924103156.13119-1-macpaul.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.531600-8.000000
X-TMASE-MatchedRID: Wrb1MzA3JCo72d2F4DOSZIzb2GR6Ttd3sEf8CpnIYtnfUZT83lbkEDQz
	47GqDWjpCmxAYbRsjBPSR2ouhnxhVR8TzIzimOwPC24oEZ6SpSmcfuxsiY4QFCmU1IJiwDkzYmm
	AGY4XPwm8qqGul3EoMKl+jsxiwOcOKpyFGQ5bXGAK834sgRBBm34aK7DJzQRkPnRASFgM+BdjF2
	WKXloe/vI2nuDg9d7QFezHPq6MHFSrV/xdKQcFSY0leYQxW8u2lExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.531600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0C3DC89B3AF622131E2ACB82100E884D37A19CC32BE1839B84DFE3C8C3744E1E2000:8
X-MTK: N

The display node in mt8195.dtsi was triggering a CHECK_DTBS error due
to an excessively long 'clocks' property:
  display@14f06000: clocks: [[31, 14], [31, 43], [31, 44]] is too long

To resolve this issue, add "maxItems: 3" to the 'clocks' property in
the DT schema.

Fixes: 4ed545e7d100 ("dt-bindings: display: mediatek: disp: split each block to individual yaml")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,split.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
index e4affc854f3d..42d2d483cc29 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,split.yaml
@@ -57,6 +57,7 @@ properties:
   clocks:
     items:
       - description: SPLIT Clock
+    maxItems: 3
 
 required:
   - compatible
-- 
2.45.2

