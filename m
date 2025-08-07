Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD120145329
	for <iommu@lists.linux.dev>; Thu,  7 Aug 2025 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754560628; cv=none; b=QCQyWGPtlgKOoXca/3otNKrepmvhxSl70eSvEB8OTtYrmC8CriA7RW1w7ZLiDiep8EFFOApyiqJaQHaNg8W0nQ1NPLHfkndQ01dehqrsyap7d5JWZzmIgSAilxmhthNbi85jaPiezoZHhOpzFs+SeqlW/TJAbe4aMpySNk/6FwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754560628; c=relaxed/simple;
	bh=0b4xDo1r+kr6ya93KP0giDGtbFS8G3eE0JvgchpSkqI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KNn4iiWx/oPw0SYSlGmn3kRNgB8inzVyrXP11f3K/fDLOr04aYoF/qT3iCib7iTjzN/+MwJorjFEQvvSpGyEW6h7mUq3JPLF4WfGF1j/DfwNn8E0hF/ncbRxEWkn4Z/RfGH0E08nJI8K8f87i89HjFphbd3YuFJEcMAPqxgoRzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CSsq/AFK; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CSsq/AFK"
X-UUID: dc0ccc2a737411f08871991801538c65-20250807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RuyjJTkS/rjYI9TGsC4pvcmFFvays7Lr8kUHUlZ7ORA=;
	b=CSsq/AFKqGkven0I+W5xcM89EeRv0Szc+PgqWFI42PaPoiE9LYJh7pILjsXk/UhLUY17ivAg2w78F/VlBTBozXihEr/E3CNXDvdaLCjBL+X2g6sfZNyvnbMmF0N0wLr9MgqcaPQfoq7stEnYITBvUAJtBAXtw53IDSARZRU/qp4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:31220521-ab06-47a8-b60f-9bc5b3638bd5,IP:0,UR
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
X-UUID: dc0ccc2a737411f08871991801538c65-20250807
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 772866443; Thu, 07 Aug 2025 17:56:59 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 7 Aug 2025 17:56:57 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 7 Aug 2025 17:56:56 +0800
From: zhengnan chen <zhengnan.chen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<zhengnan.chen@mediatek.com>
Subject: [PATCH 0/3] MT8189 IOMMU SUPPORT
Date: Thu, 7 Aug 2025 17:55:52 +0800
Message-ID: <20250807095609.11785-1-zhengnan.chen@mediatek.com>
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

