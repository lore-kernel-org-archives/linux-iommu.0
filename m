Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523319B3DD
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173934; cv=none; b=Ji5XLuXExYcAEkhUSzQIG/WvL1t42ClM/EpNfr1GhwDeud9SV6cENN9OYQcOExv3dZKxOT+gDDqgEVOKHtfEk4gwgr5cI5il527DGy1N+GxfYewZUIQbgQqf8Uv1pm/NHoD/0ywuQq2ESNwGqzTaomlJiIKfTgVNZscp0ieoc40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173934; c=relaxed/simple;
	bh=Irns9Gelwi5yRjyspkWdWAv06puhDn2KYzCPEmvWDLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEj+LgO2mVGrKqCCHqHPOS5C7RkXvn0D+FR7z2UylsEZxE/ezrf2dMtD9jt6YwGKn+/fD3SE2Y40vX0TjWtC9Ccl+rMFXGotuLbC/ybBTbRbBgkMvHjHCv/b9BJRRPZhj/NqSkDPpeRbe5R5rhuqN+dL14dB/IWxiaW+JA6EP9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rXXw06Mz; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rXXw06Mz"
X-UUID: 3f9b0ffe7a6011ef8b96093e013ec31c-20240924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WqMUkHibRFQJzxVRNs/YI4Ut6LjJ37Tr4E7dO4UTK5U=;
	b=rXXw06MzgEnve7a2G0kNbpQd3kOGDYIXbRs3HLQsgGHSI80hykGIzcIneiLWk9DwBh+kiXCE3q2mJuRGdXWhA7k58WOObQ1XzFIg4O2mEpkjMW5WEb/yCiGaYXLZmzskQxUaeFzUQfa46oE+WIsU4Vc0J+FDEaHcBJm93wkJAfA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:2a9f412b-e891-4962-b258-c5acfce7ffe8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:2d847b9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3f9b0ffe7a6011ef8b96093e013ec31c-20240924
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1509937100; Tue, 24 Sep 2024 18:32:07 +0800
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
Subject: [PATCH 4/6] arm64: dts: mediatek: mt8395-genio-1200-evk: Fix dtbs_check error for phy
Date: Tue, 24 Sep 2024 18:31:54 +0800
Message-ID: <20240924103156.13119-4-macpaul.lin@mediatek.com>
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
X-TM-AS-Result: No-10--5.438800-8.000000
X-TMASE-MatchedRID: EzeqGrx38DnwBTQ+XvV6VZdc7I2df+ms2D9FbDg9BP7HkH7uosEn7E/3
	ZkXeY1OAsdosXJJWMVxc2EOZWhu2PoJrRWPc34Z+A9lly13c/gGL/KYnYVWDlJsoi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNX0IQgVUelAtSSjjOiT/nEohOCA9g8Z/VG4DBjGd6CEytFKFEkw0fxM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.438800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A59B566F2211A148FA8D553435D5BF7E7D13ED5B07B53F2AFF477E1B636851312000:8
X-MTK: N

The ethernet-phy node in mt8395-genio-1200-evk.dts was triggering a
dtbs_check error. The error message was:
  eth-phy0@1: $nodename:0: 'eth-phy0@1' does not match
              '^ethernet-phy(@[a-f0-9]+)?$'
Fix this issue by replacing 'eth-phy' node to generic 'ethernet-phy'.

Fixes: f2b543a191b6 ("arm64: dts: mediatek: add device-tree for Genio 1200 EVK board")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index 1ef6262b65c9..b4b48eb93f3c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -187,7 +187,7 @@ mdio {
 		compatible = "snps,dwmac-mdio";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		eth_phy0: eth-phy0@1 {
+		eth_phy0: ethernet-phy@1 {
 			compatible = "ethernet-phy-id001c.c916";
 			reg = <0x1>;
 		};
-- 
2.45.2

