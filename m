Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754BF173336
	for <iommu@lists.linux.dev>; Fri, 27 Sep 2024 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419853; cv=none; b=eP9BnC8kWP3KObTsBThKmwHLhIPt+WY1q1joTrNI+9aM2IJhsqw7Sv7SydYIiYkzLLRayCQOOkkkUnaRe5ADQRGNUZR55E+e8MvX2MOiHiLHNWk1CpYtWwjxO01YKON0CpIe9P3cHSbkI8lKpDCjtSt3AqO3T9vuDvG6gK/GqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419853; c=relaxed/simple;
	bh=2epJ24lOq66xl+SuNkwsg3Bt29VRH+GED6ap3EN6t9g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e1K2Jr497vsG682D+YUs4BfFrNTj8CANUKa/QZhWLkBjfChI9wXZVGXrFwdSZrNTMJuemh9Ec/51MVQ2EpbnugCs/44wCmZPmQB9wOu5d6z+od2NbcJsBp+3ZzDKmicTdWzr5RjYF00CxUJ2ykk7UI1gIxaYPmnK+rZ8ScS9auc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=az1WeokD; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="az1WeokD"
X-UUID: d16b3db27c9c11efb66947d174671e26-20240927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GoF6SJc6wFMZEyc0BXdDEMxFE4JRik1GAvCk+nHZpN4=;
	b=az1WeokDZGRi82UL/o/mNmP75tNjN5oaRjOKcgXvVlM0fLk/6rF7lgEm/Cy8dPKv2k9qSaZuYyX7bq7K5D+ysDL93Qhxgpt0x0RAUjfYmaLIg+m3JsCtsPb83Pp/E668N1/eK0XaxVVnZdHFbtvDUaUuXoRj6FNFC3lsznF5HPQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:7a126580-f70f-4747-b9ab-559b40f02486,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:c3bbdad0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d16b3db27c9c11efb66947d174671e26-20240927
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1291877166; Fri, 27 Sep 2024 14:50:44 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Sep 2024 14:50:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 27 Sep 2024 14:50:42 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
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
	Macpaul Lin <macpaul@gmail.com>, Sen Chu <sen.chu@mediatek.com>, Chris-qj
 chen <chris-qj.chen@mediatek.com>, MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH v3 1/5] arm64: dts: mt8195: Fix dtbs_check error for infracfg_ao node
Date: Fri, 27 Sep 2024 14:50:37 +0800
Message-ID: <20240927065041.15247-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The infracfg_ao node in mt8195.dtsi was causing a dtbs_check error.
The error message was:

syscon@10001000: compatible: ['mediatek,mt8195-infracfg_ao', 'syscon',
                 'simple-mfd'] is too long

To resolve this, remove 'simple-mfd' from the 'compatible' property of the
infracfg_ao node.

Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes for v2 and v3:
 - no change.

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index e89ba384c4aa..2e1b41359b43 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -487,7 +487,7 @@ topckgen: syscon@10000000 {
 		};
 
 		infracfg_ao: syscon@10001000 {
-			compatible = "mediatek,mt8195-infracfg_ao", "syscon", "simple-mfd";
+			compatible = "mediatek,mt8195-infracfg_ao", "syscon";
 			reg = <0 0x10001000 0 0x1000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
2.45.2

