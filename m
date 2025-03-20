Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DB1E231D
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 07:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456215; cv=none; b=FVrIoQqlvnWFNL5mQBCFaQU8/FMmUnlKVDucmaJNAB8e9OjHGUYTlghdzyb61KJEbCpeuIbibSS4ix+R5JnGq4RDN9/dXsY6+k9iApyqhRMU9rWbUCNAZ3EXqVwcUnDdwKcsgkFnmCoE6/ZdZExPcD+fKd3/iLxduyIO1TvuNFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456215; c=relaxed/simple;
	bh=s3Uf5iVx8FrSZ12ujfKX9sFRSzqRAGb5KOI3GdalfkM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tuClt5qOTpaLXXcLV9SIPkFex4cbEX/doPzd+3r7jq9sFuUyB7SHLsw/jBcjDMk8p2H4p0Tmzmzs0rqAFLf+rXXpU5axXP1DG8SrYVQk9fkikAENWBJ1ClAWcyN3epNQICkEM7ahGp6xPgXrOALYE0cYNt3A3Fjo7kuu+7glos0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ra7/F6i7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ra7/F6i7"
X-UUID: 15a481b0055e11f08eb9c36241bbb6fb-20250320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QZXUJ4VH3AfP2WjMQih2vKgtDXB87pmd/jXX3007I+c=;
	b=Ra7/F6i7QgLfWOnYZ2vFL03qL1+EQL2VQRAzcLBY7UXKoCTnurgd3Qt8cn+GYanholW7fZiGVwazA5P5TwXY0yqYZThhHO05LcxMl1E/ABxMU4KektBOiwDjP0R3GoNNVKOZX0oMscyZNBT32H6zgVK8NC5JPGqlLyRWrP5tziQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:1b842213-50d7-4ab6-afd6-2829e47ab772,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:67aa584a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 15a481b0055e11f08eb9c36241bbb6fb-20250320
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <xueqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1302099120; Thu, 20 Mar 2025 15:36:49 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 20 Mar 2025 15:36:48 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 20 Mar 2025 15:36:47 +0800
From: Xueqi Zhang <xueqi.zhang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Wendy-st Lin <wendy-st.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<iommu@lists.linux.dev>, Xueqi Zhang <xueqi.zhang@mediatek.com>
Subject: [PATCH 0/3] Add mt8196 SMI support
Date: Thu, 20 Mar 2025 15:36:15 +0800
Message-ID: <20250320073625.25225-1-xueqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add mt8196 SMI support

This patchset add mt8196 SMI support. 8196 SMI has several differences
compared to previous ICs. MT8196 SMI has more than 32 SMI larbs.
It connects with SMMUv3, rather than MTK_IOMMU.MT8196 SMI commons is
backed up/restored by RTFF HW.

Xueqi Zhang (3):
  dt-bindings: memory: mediatek: Add mt8196 support
  memory: mtk-smi: Add a flag skip_rpm
  memory: mtk-smi: mt8196: Add smi support

 .../mediatek,smi-common.yaml                  |   4 +-
 .../memory-controllers/mediatek,smi-larb.yaml |   4 +-
 drivers/memory/mtk-smi.c                      | 145 +++++-
 .../dt-bindings/memory/mt8196-memory-port.h   | 460 ++++++++++++++++++
 include/dt-bindings/memory/mtk-memory-port.h  |   4 +-
 5 files changed, 609 insertions(+), 8 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8196-memory-port.h

-- 
2.46.0

