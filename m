Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3321FF24
	for <iommu@lists.linux.dev>; Thu,  7 Aug 2025 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754560711; cv=none; b=D/PY9mdxf8yssZ8p5THCOrtHZakGy/OgoggZrpwyQThRQEipj2IiEKGgJn50PyR/PfLs14MhOUkRg16vJMNPTLmTdk6fKbJzdRNy/fcOflXGTYcTtVsHG+WN7DFieevR0zEYSB3svLBVl9MY0tzjXKmzxs7hs9bNMgutUIdKSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754560711; c=relaxed/simple;
	bh=0b4xDo1r+kr6ya93KP0giDGtbFS8G3eE0JvgchpSkqI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AWMqFcK4vhaoQjZ6WORdy9Nd+6MqS3l87HMQDPX1G50liVKJX3hQ86ABZZ2Ai7QBB/LiE/YfgIi2/j7AJsU0pgME0BY5Gm3FsqfOnLxlTHm5CZ3Ctz/u70gwxDvX5TNxDZxggMhw8dxv44EpBobafwiuGJjek5DGWoJXD0Drnyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CUCqULvN; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CUCqULvN"
X-UUID: 0ddb6a22737511f08871991801538c65-20250807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RuyjJTkS/rjYI9TGsC4pvcmFFvays7Lr8kUHUlZ7ORA=;
	b=CUCqULvNk3TlWLZIEtPbqvJuN8aA5J9ZipRnKqrEAg48wMHTwKOIbrhPAZx6O+jlDWArVz0TvdFCePZvscyqhO6mU5OeTwGdtLIki6kvN8rKfLqSFkvElOMaE4Zka0pwdZB4b13I36yQLLqBBFdRPxWgq0Qvz8SCyVr3bAQghxA=;
X-CID-CACHE: Type:Local,Time:202508071757+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:2e66b4af-cf66-491c-9a59-237b8a52fa3b,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:f1326cf,CLOUDID:9e942a51-d89a-4c27-9e37-f7ccfcbebd5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0ddb6a22737511f08871991801538c65-20250807
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1154758033; Thu, 07 Aug 2025 17:58:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 7 Aug 2025 17:58:21 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 7 Aug 2025 17:58:20 +0800
From: zhengnan chen <zhengnan.chen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, zhengnan chen
	<zhengnan.chen@mediatek.com>
Subject: [PATCH 0/3] MT8189 IOMMU SUPPORT
Date: Thu, 7 Aug 2025 17:57:45 +0800
Message-ID: <20250807095756.11840-1-zhengnan.chen@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Based on tag: next-20250806, linux-next/master

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


zhengnan.chen (3):
  dt-bindings: mediatek: mt8189: Add bindings for MM & APU & INFRA IOMMU
  iommu/mediatek: Add a flag DL_WITH_MULTI_LARB
  iommu/mediatek: Add support for mt8189

 .../bindings/iommu/mediatek,iommu.yaml        |   7 +
 drivers/iommu/mtk_iommu.c                     | 132 +++++++-
 .../memory/mediatek,mt8189-memory-port.h      | 283 ++++++++++++++++++
 3 files changed, 409 insertions(+), 13 deletions(-)
 create mode 100644 include/dt-bindings/memory/mediatek,mt8189-memory-port.h

-- 
2.46.0

