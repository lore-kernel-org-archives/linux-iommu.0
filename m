Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F41990C7
	for <iommu@lists.linux.dev>; Sat, 18 Oct 2025 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760793998; cv=none; b=B0LUD0/Wy2KjMp+xA94gBBbWD8qQJ/lypPt++W/PN2xpNT42GLlOoZ5Y9+FUlP4iNR3BFtfJPGj3JYZj+AH7i0qkWa+6U/xr3Hg09TUfWH8ip9aOHtrVTU+yU2rwRNeERztpqvBnr73LmuWNFcQMcE4JaGf+qeLINDqxbbIPAFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760793998; c=relaxed/simple;
	bh=lyVjm6ck46phytBMZinDezVAE1jJLQRyw8mqNIVlWho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=evgmwf3G84XmcDuPkY9n3sfacYR6pIrPn4OdCVeL7Mkq69nlssEin0KrLExYtptJYRyL/3BQ8EsbZaMo2ftQCCasCzBsV0ycEeOLe84HndoFLZEvYIKBZQN01LFtn8btR41nMmuSf/MAEwBmeKRNwVjdJBGukuWuQDbevahHhmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EBw9e0g6; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EBw9e0g6"
X-UUID: 0e6039acac2611f0b33aeb1e7f16c2b6-20251018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+1CMbAeL2NJN2/LGKuIDaLpZNmwS98qeYaK4StS57Mo=;
	b=EBw9e0g6co315gGbIbyCAdB0M+/RZnDHwJfj6K3goKVeB7KHQMB3AFeOsIB1/n1ajAEvat40EujXJHLC4J+e+FRZx3/+VijXj8LSBAmikVSsV2s+3bcsOwLvvgFzesFzrG/P/mSq/95fhr2QK58fkJ9J87VE56cCmBSzP0klQWo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1687f6f4-99b6-4a14-91ae-56ae77f83073,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:228f3251-c509-4cf3-8dc0-fcdaad49a6d3,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:99|1,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0e6039acac2611f0b33aeb1e7f16c2b6-20251018
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1658190808; Sat, 18 Oct 2025 21:26:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 18 Oct 2025 21:26:25 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Sat, 18 Oct 2025 21:26:25 +0800
From: Zhengnan Chen <zhengnan.chen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Zhengnan Chen
	<zhengnan.chen@mediatek.com>
Subject: [PATCH v4 0/5] MT8189 IOMMU SUPPORT
Date: Sat, 18 Oct 2025 21:26:09 +0800
Message-ID: <20251018132625.14428-1-zhengnan.chen@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Based on tag: next-20251017, linux-next/master

This patchset adds MT8189 iommu support.

MT8189 have 3 IOMMU HWs. 1 IOMMU HW is for multimedia,
1 IOMMU HW is for apu(AI processer unit),
and 2 IOMMU HW is for infra-master, like PCIe/USB.

About the INFRA IOMMU, it don't have larbs, the master connects the
iommu directly. It use a independent pgtable, and these two
INFRA IOMMU HW share a pgtable.

In mt8189, the display connect with larb1 and larb2 at the same time.
Thus, we should add link between disp-dev with these two larbs.

The software solutions can be summarized as follows:
1. Add iommu support for mt8189
2. Add a flag DL_WITH_MULTI_LARB to support the HW which connect with
   multiple larbs.

---
Changes in v4:
- Move mt8189 after mt8188 in enum mtk_iommu_plat
- Link to v3:
  https://lore.kernel.org/all/20251015125532.9041-1-zhengnan.chen@mediatek.com/

Changes in v3:
- Exclude the mediatek,larbs attribute of apu iommu in mediatek,iommu.yaml
- Link to v2:
  https://lore.kernel.org/all/20251015032509.5057-1-zhengnan.chen@mediatek.com/

Changes in v2:
- Split mt8189 iommu support patch into three patches, namely APU IOMMU,
  INFRA IOMMU and MM IOMMU
- Disable bank 4 of MM IOMMU
- Link to v1:
  https://lore.kernel.org/all/20250807095756.11840-1-zhengnan.chen@mediatek.com/
---

Zhengnan Chen (5):
  dt-bindings: mediatek: mt8189: Add bindings for MM & APU & INFRA IOMMU
  iommu/mediatek: Add a flag DL_WITH_MULTI_LARB
  iommu/mediatek: mt8189: Add APU IOMMUs support
  iommu/mediatek: mt8189: Add INFRA IOMMUs support
  iommu/mediatek: mt8189: Add MM IOMMUs support

 .../bindings/iommu/mediatek,iommu.yaml        |   8 +
 drivers/iommu/mtk_iommu.c                     | 132 +++++++-
 .../memory/mediatek,mt8189-memory-port.h      | 283 ++++++++++++++++++
 3 files changed, 410 insertions(+), 13 deletions(-)
 create mode 100644 include/dt-bindings/memory/mediatek,mt8189-memory-port.h

-- 
2.46.0

