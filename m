Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F851810
	for <iommu@lists.linux.dev>; Fri, 17 Mar 2023 08:57:45 +0000 (UTC)
X-UUID: c472231ec4a111edbd2e61cc88cc8f98-20230317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FXIRjztEzMzSx83OQvjQ8zFoDhjED/9EfeXJ/BDwRnA=;
	b=c7bNRj+ZPgl3nxyd4kXHbOcr8G8kZFMs5N5ViLp0A4wMoNBRBhqoO28R6zQ0Z0n7GJyhJ1fn7gLUzOguHNbPMUbPAVjO+xVUyyA/i4S/iDNxYrBieZeOURNYFvAB/yG5BySgzgekMz17+wmdp1u2a9yoWJjfmPBaivO/ZemSQpE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:826612dd-dcb8-4c07-bcb7-e4ec01689d44,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:83295aa,CLOUDID:aa461cf6-ddba-41c3-91d9-10eeade8eac7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: c472231ec4a111edbd2e61cc88cc8f98-20230317
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 335145409; Fri, 17 Mar 2023 16:57:38 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 17 Mar 2023 16:57:37 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 17 Mar 2023 16:57:36 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
CC: Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Yong Wu <yong.wu@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	<iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <mingyuan.ma@mediatek.com>,
	<yf.wang@mediatek.com>, <jianjiao.zeng@mediatek.com>,
	<chengci.xu@mediatek.com>
Subject: [PATCH v9 7/7] MAINTAINERS: iommu/mediatek: Update the header file name
Date: Fri, 17 Mar 2023 16:55:41 +0800
Message-ID: <20230317085541.20447-8-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317085541.20447-1-yong.wu@mediatek.com>
References: <20230317085541.20447-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

We add the prefix "mediatek," for the lastest ports header file name,
Update the entry from "mt*" to "m*".

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..cf4c867bfb8a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13056,7 +13056,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/iommu/mediatek*
 F:	drivers/iommu/mtk_iommu*
-F:	include/dt-bindings/memory/mt*-port.h
+F:	include/dt-bindings/memory/m*-port.h
 
 MEDIATEK JPEG DRIVER
 M:	Bin Liu <bin.liu@mediatek.com>
-- 
2.25.1

