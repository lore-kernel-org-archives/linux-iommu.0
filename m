Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED223323D
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 12:28:49 +0000 (UTC)
X-UUID: 32b4b3f1d4894d5b8e98f69713308ccb-20220714
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:15ed6012-0824-40d4-baa5-9c6f257f1e56,OB:0,LO
	B:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,A
	CTION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:15ed6012-0824-40d4-baa5-9c6f257f1e56,OB:0,LOB:
	10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,A
	CTION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:005d4d64-0b3f-4b2c-b3a6-ed5c044366a0,C
	OID:b099b36d39dd,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 32b4b3f1d4894d5b8e98f69713308ccb-20220714
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 1627513037; Thu, 14 Jul 2022 20:28:40 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 14 Jul 2022 20:28:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 14 Jul 2022 20:28:39 +0800
From: Tinghan Shen <tinghan.shen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lee Jones
	<lee.jones@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Tinghan
 Shen <tinghan.shen@mediatek.com>, Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, MandyJH
 Liu <mandyjh.liu@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 00/19] Add driver nodes for MT8195 SoC
Date: Thu, 14 Jul 2022 20:28:18 +0800
Message-ID: <20220714122837.20094-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Add driver nodes for MT8195 SoC.

Patchset 15 "arm64: dts: mt8195: Add adsp node and adsp mailbox" depends on 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=009b21f392759ca7be91bc4be9d9534f6cee2878
---

v1 -> v2:
  - add new dt-bindings: mfd/mediatek,scpsys.yaml
    - update compatible string for mt81xx scpsys nodes
  - apply comments for yaml files: iommu, smi-common, and power-controller
  - apply comments for dts nodes: power domain, vdosys0. 
  - apply comments for commit message of watchdog, i2c, and smi-common. 
  - add review-by tags
---
Jason-JH.Lin (2):
  arm64: dts: mt8195: Add gce node
  arm64: dts: mt8195: Add display node for vdosys0

Tinghan Shen (13):
  dt-bindings: iommu: mediatek: Increase max interrupt number
  dt-bindings: memory: mediatek: Update condition for mt8195 smi node
  dt-bindings: power: mediatek: Add bindings for MediaTek SCPSYS
  dt-bindings: power: mediatek: Update example in dt-bindings
  dt-bindings: power: mediatek: Refine multiple level power domain nodes
  arm64: dts: mediatek: Update mt81xx scpsys node to align with
    dt-bindings
  arm64: dts: mt8195: Disable watchdog external reset signal
  arm64: dts: mt8195: Add vdosys and vppsys clock nodes
  arm64: dts: mt8195: Add power domains controller
  arm64: dts: mt8195: Add spmi node
  arm64: dts: mt8195: Add scp node
  arm64: dts: mt8195: Add audio related nodes
  arm64: dts: mt8195: Add iommu and smi nodes

Trevor Wu (1):
  arm64: dts: mt8195: Specify audio reset controller

Tzung-Bi Shih (1):
  arm64: dts: mt8195: Disable I2C0 node

YC Hung (1):
  arm64: dts: mt8195: Add adsp node and adsp mailbox nodes

YT Lee (1):
  arm64: dts: mt8195: Add cpufreq node

 .../bindings/iommu/mediatek,iommu.yaml        |   12 +-
 .../mediatek,smi-common.yaml                  |   11 +-
 .../bindings/mfd/mediatek,scpsys.yaml         |   62 +
 .../power/mediatek,power-controller.yaml      |  146 +--
 arch/arm64/boot/dts/mediatek/mt8167.dtsi      |    3 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |    3 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |    3 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |    3 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 1056 ++++++++++++++++-
 9 files changed, 1167 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml

-- 
2.18.0

