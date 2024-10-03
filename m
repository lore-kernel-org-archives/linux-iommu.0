Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901971E526
	for <iommu@lists.linux.dev>; Thu,  3 Oct 2024 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727924975; cv=none; b=tEoanbD0fUb7JASFDe6rpOUx3sdNFbtsxvQ1yB0g06fMGsSTV8S4W3ZHGM9Ym/qUf2MXFhYGapyoYt7+/LZrEZX1URXwK5VyOc8+A4zEtVw89uckk6VW25AeXLH61eqbUhX3ys63qNzNAvah0j/blHMGYianwqERB2SDOptdVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727924975; c=relaxed/simple;
	bh=iQTBdZsQqVxN5pbNHU109Vw4ixsvnHck5x8Ns+4MIoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5t+xJBEz3bu6h5xHLmtFF0jGeUgha1gKVmfDC2QhMGedz/NONLP/VlDb3yIKl19yVy52eIoCyfQWsueP55p/jNiNmnR2rnhoFW3lHIOlk+MYkpOfH6keAFYBwdG48Av7s7zlmG2zYssrsgeUW0qeRCPw3o+5Cfdnqxu7q/xJDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CZjHTZqS; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CZjHTZqS"
X-UUID: e72df990813411efb66947d174671e26-20241003
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=y+/q2mCK0XJ8ag77MrdRNzJZqPH1iD6XZZ/UwSEWzsw=;
	b=CZjHTZqSMxKLW6D1Yx1bkfP40kkQa4pbM/Rn/iqQujtQqDGb4zUkGACMQUxnsKUt/JHo+GFLCcmAnXgMR7ct05ro/sgtMON+qk+y+YSkb3VNe3ThNoH4OFOGpDnvyzh9woU1XlWmxWSQPZLy5khEzO6RE8m27KmPkggGWxJ63MA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:59c9a872-4dc1-4c78-b88e-431514458864,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:0f03143c-93c1-4dd7-9dcb-d081586a26a6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e72df990813411efb66947d174671e26-20241003
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1755936061; Thu, 03 Oct 2024 11:09:28 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 3 Oct 2024 11:09:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 3 Oct 2024 11:09:25 +0800
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
	<wenst@chromium.org>
Subject: [PATCH v6 2/4] arm64: dts: mediatek: mt8395-genio-1200-evk: Fix dtbs_check error for phy
Date: Thu, 3 Oct 2024 11:09:17 +0800
Message-ID: <20241003030919.17980-2-macpaul.lin@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.841900-8.000000
X-TMASE-MatchedRID: zCWA9GkRdEXwBTQ+XvV6VZdc7I2df+ms2D9FbDg9BP7HkH7uosEn7E/3
	ZkXeY1OAsdosXJJWMVwSc9Me4enxyKXzgcphDfm8i/b+LxU2p47Dx2NobQWtm3td2pOTSxFkZvo
	+mFW19mDftLFtxOSbQ4Ay6p60ZV62fJ5/bZ6npdjGVuWouVipcp4sBTE6I60vn04MC/32hamTFH
	Y3fpknPk+1Y2AWrhCZQn+6Lm/IJRrsM5jjy6iom9ieHLZMZ/BPRPZbP+jn79N3eENhF60Pgm1Rj
	oup2VCcWve+eVz4Pp5Vk5utmQ1VlGVF3+d9rnoxpI8EFEZVbig=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.841900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3A432F52C549AB02A7417472CA6CA1845F5AEEE3A9D0766BCF32ECD3255395DB2000:8
X-MTK: N

The ethernet-phy node in mt8395-genio-1200-evk.dts was triggering a
dtbs_check error. The error message was:
  eth-phy0@1: $nodename:0: 'eth-phy0@1' does not match
              '^ethernet-phy(@[a-f0-9]+)?$'
Fix this issue by replacing 'eth-phy' node to generic 'ethernet-phy'.

Fixes: f2b543a191b6 ("arm64: dts: mediatek: add device-tree for Genio 1200 EVK board")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes for v2, v3, v4, v5 and v6:
 - No change.

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

