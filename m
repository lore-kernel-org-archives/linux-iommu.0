Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908E1DDC37
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533038; cv=none; b=oP7U1b/UwcQNlZ4skS3nXlf1W9bxcF7Z/jUPLYFL/fctruSA5IrgJngUAPTkBv5BJqyFrK6w3DXDapJ00cHHIMVPtbLrAARFntS9/O2Ous7xECFOVjT6t338S6ozmXY0lc2XSKHVSyq9x6AHZotvCVAnV3dsHIGeZNGMGDa1szo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533038; c=relaxed/simple;
	bh=MS33kYmVbAfDBf4w0xV5HM6ziBuxUf4smxdzEYxZR0M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WVo451CJLkeclbLfiVQTfKf70nZFvJoDiFKmztcDWc8JmiW+e00zEnTRxjU+nXWBWfZVkdr+CSzfCEVJ/MYLYfpjMvzeEeI6xXDQdWui2DgzH954btUybvC83Lr8POSNfI1r/Bqq98e4mKB9+tFyk09W5yrbrN3BuYb/rAuriSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EOAoYoAq; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EOAoYoAq"
X-UUID: 7366781ea9c611f0ae1e63ff8927bad3-20251015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4aznyswgxbtzCDp+tK6zg0PO3+Q09TU9/s3JSyyLDKI=;
	b=EOAoYoAqC9vXZL7u9xXlE3w0RGG1RKGXU32nKWnpzGOsNGb6eaOU/4V8QSNgtXGdotIEFV7pxKZkJWaXU3CXaLUpXA2yl8mPe/55mw2CviEzVulx1iEmLmL+cFt9TTh9kVyVx8lZIOVOTwo3qN9aRhylm6FO3uJqMCdFhcHI/WQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:f0692741-71e7-4d15-b569-ab22697226b0,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:8e2b33b9-795c-4f99-91f3-c115e0d49051,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:99|1,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7366781ea9c611f0ae1e63ff8927bad3-20251015
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 85036494; Wed, 15 Oct 2025 20:57:05 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 15 Oct 2025 20:57:03 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 15 Oct 2025 20:57:02 +0800
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
Subject: [PATCH v3 0/5] MT8189 IOMMU SUPPORT
Date: Wed, 15 Oct 2025 20:55:12 +0800
Message-ID: <20251015125532.9041-1-zhengnan.chen@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Based on tag: next-20251014, linux-next/master

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

