Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2B816
	for <iommu@lists.linux.dev>; Thu,  4 Aug 2022 10:58:47 +0000 (UTC)
X-UUID: c5334d1d89994d26abfd0f85f5cc45af-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nMH8VVvpGtEg/6R0rI1o7WdbvyAocREfG4SSLR45xhA=;
	b=ceLxuCvKPPcxTyBnlcBgPeHzZVEAq8E8IGuarfsAcFpn6lA4mDaLT038gzbUE7NEDfsHghexjUeXrZgUImC5/xr4V/pBBTvm2wGHff9mD6p/YlAJBY/iyqMJmWCEuHM5JN3W894hoKFmLSDfatZSVrmK6m1N097a0KuRwbdjfgs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:c79dd188-d26e-4221-a365-9d16ad5681c4,OB:0,LO
	B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
	TION:release,TS:90
X-CID-INFO: VERSION:1.1.8,REQID:c79dd188-d26e-4221-a365-9d16ad5681c4,OB:0,LOB:
	0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
	TION:quarantine,TS:90
X-CID-META: VersionHash:0f94e32,CLOUDID:93e64325-a982-4824-82d2-9da3b6056c2a,C
	OID:16fcf0381704,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: c5334d1d89994d26abfd0f85f5cc45af-20220804
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
	(envelope-from <chengci.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 210552057; Thu, 04 Aug 2022 18:58:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 4 Aug 2022 18:58:38 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 4 Aug 2022 18:58:37 +0800
From: Chengci.Xu <chengci.xu@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chengci.Xu
	<chengci.xu@mediatek.com>
Subject: [PATCH 0/3] MT8188 IOMMU SUPPORT
Date: Thu, 4 Aug 2022 18:58:31 +0800
Message-ID: <20220804105834.626-1-chengci.xu@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patchset adds MT8188 IOMMU support.

MT8188 have 3 IOMMU HWs. 2 IOMMU HW is for multimedia, and 1 IOMMU HW
is for infra-master, like PCIe.

About the 2 MM IOMMU HW, the connection could be something like this:

        IOMMU(VDO)          IOMMU(VPP)
           |                   |
      SMI_COMMON(VDO)      SMI_COMMON(VPP)
      ---------------     ----------------
      |      |   ...      |      |     ...
    larb0 larb2  ...    larb1 larb3    ...

INFRA IOMMU does not have SMI, the master connects to IOMMU directly.

Although multiple banks supported in MT8188, we only use one of them,
which means PCIe is put in bank0 of INFRA IOMMU.

So we have two pgtable for MT8188, specifically, these two MM IOMMU HW
share a pgtable while INFRA IOMMU HW use a independent pgtable.

Another change is that we add some SMC command for INFRA master to 
enable/disable INFRA IOMMU in ATF considering security concerns.

changes since v1:
  - base on tag: next-20220803.
  - adds MT8188 IOMMU support.

Chengci.Xu (3):
  dt-bindings: mediatek: mt8188: Add binding for MM & INFRA IOMMU
  iommu/mediatek: Add enable IOMMU SMC command for INFRA master
  iommu/mediatek: Add MT8188 IOMMU Support

 .../bindings/iommu/mediatek,iommu.yaml        |  12 +-
 drivers/iommu/mtk_iommu.c                     |  82 ++-
 .../dt-bindings/memory/mt8188-memory-port.h   | 482 ++++++++++++++++++
 include/soc/mediatek/smi.h                    |   1 +
 4 files changed, 568 insertions(+), 9 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8188-memory-port.h

-- 
2.25.1

