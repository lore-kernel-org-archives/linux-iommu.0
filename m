Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C61AED4D
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727349311; cv=none; b=Zz/cRZs3lwqP/WMvRZL0OUqTxPn2Maj3Pb/WqHD3XSG83elvLN9XbJoWrdrPO5ctnGcdSN+SlL91pTB5F2TxMzLdbrmlx1RjFCwMolFAXKEi6wle1wesVD2Mxmfo5RdvClHrpuuwDvQSaZwTPkoVfQ0LzSyys/LI7dsaEFtIzTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727349311; c=relaxed/simple;
	bh=PLAmmMmytHk023+f96FToohXJVTV2bZ1vmhDlatkkFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWlNLQmkH6tMJjr9RLVKVfxZ84WhYyUuN3UXMS2/PL2hrva1JWy18GBCyRNS8HC/sG+ire+Mquf+GHH8kFLuNrZIVR4xsrpevZfGWzotN0AHQdWkC/fz6UNIGlDDlcI5s6xzqhJeL6GQqNJAz35dle4jGZDsfovzJbRVoUdQxjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uGYNDIOd; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uGYNDIOd"
X-UUID: 9451517c7bf811ef8b96093e013ec31c-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8TucMTel3hohwxs6kGcphC2e2kM6zgmyC1hJadPP2us=;
	b=uGYNDIOdBVGkCpGXyCkd607b//ZF9MDO3UvGSAIJ93OOCY3/W8woSLU5Gu+Me7tQXqZ2fjui9UXXPtOONAha2aRWGNEgFI2pycuXtamqf22knGVY3/4fxgg1xJyGGkDT3Kv2Zqpl4NoKgAFz/LlH8079Vt5Gw++wBaoxpMk+DGI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:1015f5ea-52b0-41af-a105-975204ac3de2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:ba964b18-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: 9451517c7bf811ef8b96093e013ec31c-20240926
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2142787173; Thu, 26 Sep 2024 19:15:04 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 19:15:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 19:15:01 +0800
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
Subject: [PATCH v2 5/5] dt-bindings: display: mediatek: dpi: Add mt8195 support in power domains
Date: Thu, 26 Sep 2024 19:14:49 +0800
Message-ID: <20240926111449.9245-5-macpaul.lin@mediatek.com>
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
X-TM-AS-Result: No-10--2.896300-8.000000
X-TMASE-MatchedRID: k8Cd32tj8sEDFgoHQs6fmo7Su3QulAZ5AWQaZTMSP87fUZT83lbkEOSZ
	Xqpiw34H8gMEd8ypEKNwN7+iItfSth9J5bZqJbIJwCZxkTHxccnJ5SXtoJPLyL6majHNXd7Go8W
	MkQWv6iXBcIE78YqRWo6HM5rqDwqtqghXpaTf3SrfCJlZUJnnduI+qs8eq/YRT6HjoeF/jdcsN6
	OqbCF1maekXSEz/hmVJtoaSBlm7M9iXRhtqPi8cH0de3y1eaDB4sOrsb4iT/K/bbEolHIgZUOc7
	GjOamnWv5a9cmIodEszD8HZ4XvJ2ZRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.896300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4C671D08952117956573CDFA07FA76C03FDDA8D6790DA04E86A4B8DFED1EE75C2000:8
X-MTK: N

Add power domain binding to the mediatek DPI controller for MT8185.

The dpi node in mt8195.dtsi was triggering a dtbs_check error:
  dp-intf@1c113000: power-domains: False schema does not allow [[44, 18]]

Fixes: 5474d49b2f79 ("dt-bindings: display: mediatek: dpi: Add power domains")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1 +
 1 file changed, 1 insertion(+)

Changes for v2:
 - Because of the corresponding dts fix has been reviewed with a Reviewed-by: tag.
   [1] https://lore.kernel.org/all/20240925080515.16377-1-macpaul.lin@mediatek.com/
   We still need this change to fix the 2 dtbs_check errors.
   So keeps no change here.

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 3a82aec9021c..07acc8a76bfc 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -89,6 +89,7 @@ allOf:
                 - mediatek,mt6795-dpi
                 - mediatek,mt8173-dpi
                 - mediatek,mt8186-dpi
+                - mediatek,mt8195-dp-intf
     then:
       properties:
         power-domains: false
-- 
2.45.2

