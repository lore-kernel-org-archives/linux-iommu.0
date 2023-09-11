Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F034317C8
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 01:33:08 +0000 (UTC)
X-UUID: 0ad45d10504111ee8051498923ad61e6-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XdWqhKYkevuD4gHDxGKnGlxf5l7bvx+XEvKm3C2ZXss=;
	b=tT8f8dxfcFHVsJbfsbuWhcJpq9mxHkopa2377Kp0EmFgDylbHy4PbESxzOQ2PG1SnbQ0pCnBlksc8R2jkCojfppz7089TkC2aKafJYQf/nNh3cbpGdCpEqrH4IQ5I1iT8sXNviDj4YMPjKCAzFFRz44s7hpZG2f9I6NFPQL3UrA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:a2d913a5-0992-42ed-8a81-405406024e46,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:3910ddc2-1e57-4345-9d31-31ad9818b39f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0ad45d10504111ee8051498923ad61e6-20230911
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1906270115; Mon, 11 Sep 2023 09:17:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 09:17:56 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 09:17:56 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>
CC: Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Yong Wu <yong.wu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<anan.sun@mediatek.com>, <yf.wang@mediatek.com>, <mingyuan.ma@mediatek.com>,
	"T . J . Mercier" <tjmercier@google.com>
Subject: iommu/mediatek: Add SVP support for mt8188
Date: Mon, 11 Sep 2023 09:17:47 +0800
Message-ID: <20230911011751.29906-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This patchset adds support for SVP(Secure video play). We always use the
last bank(id:4) to map secure memory. But the detail mapping and control
information are in the TEE. In kernel, We just register the IRQ to report
specific information when secure translation fault occurs.

Base on v6.6-rc1.

Yong Wu (4):
  iommu/mediatek: Initialise the secure bank
  iommu/mediatek: Add irq handle for secure bank
  iommu/mediatek: Avoid access secure bank register in runtime_suspend
  iommu/mediatek: mt8188: Enable secure bank for MM IOMMU

 drivers/iommu/mtk_iommu.c  | 94 +++++++++++++++++++++++++++-----------
 include/soc/mediatek/smi.h |  1 +
 2 files changed, 69 insertions(+), 26 deletions(-)

-- 
2.18.0


