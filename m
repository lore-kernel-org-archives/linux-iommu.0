Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C917C8
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 01:18:30 +0000 (UTC)
X-UUID: 19faeac0504111ee8051498923ad61e6-20230911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pd7h3S0CfqDYvAEqa2fXvAqeTJgVPjT60C7iyiJhbds=;
	b=R8lb7S8sftsh/eo4XVneoBusq0BlwqV9XoAuSNA3mN8Oi65BM6B3hMoRmrRGX42gIMkI7ccpwcDbFMXj8D8KXqjs5nuVwWFNkLmj0vfyHL2lZW/H6VRBKx0mwtLTfB4ZJ7KgL+EkmN/Qpm+OdSMJWyBsQhLeRZSJV6Oal6Rr/qo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:0a10127f-9e4b-4e97-b237-eac60ef707c6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:7d11ddc2-1e57-4345-9d31-31ad9818b39f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 19faeac0504111ee8051498923ad61e6-20230911
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2074060553; Mon, 11 Sep 2023 09:18:23 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Sep 2023 09:18:22 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Sep 2023 09:18:21 +0800
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
Subject: [PATCH 3/4] iommu/mediatek: Avoid access secure bank register in runtime_suspend
Date: Mon, 11 Sep 2023 09:17:50 +0800
Message-ID: <20230911011751.29906-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911011751.29906-1-yong.wu@mediatek.com>
References: <20230911011751.29906-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The secure bank registers are protected and they can only be accessed
in secure world. Avoid access them in runtime_suspend.

For secure bank, the m4u_dom always is NULL, thus we don't need add
this checking in runtime_resume.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e1faf2339b9a..24d7f5138f7b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1473,7 +1473,7 @@ static int __maybe_unused mtk_iommu_runtime_suspend(struct device *dev)
 	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
 	reg->vld_pa_rng = readl_relaxed(base + REG_MMU_VLD_PA_RNG);
 	do {
-		if (!data->plat_data->banks_enable[i])
+		if (!data->plat_data->banks_enable[i] || data->bank[i].is_secure)
 			continue;
 		base = data->bank[i].base;
 		reg->int_control[i] = readl_relaxed(base + REG_MMU_INT_CONTROL0);
-- 
2.25.1

