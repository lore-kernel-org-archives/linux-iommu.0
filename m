Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B785388
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 09:33:37 +0000 (UTC)
X-UUID: ecc3a29ed84b11eda9a90f0bb45854f4-20230411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ikbJp6d90IXVw0sxspdPpFbtjqXNe1M7Eau6Eu2D3DM=;
	b=f9pTAfbq28w5eWLoj77qyWV5xNn/RoL/i4QfkoyezqCNIQZ7Fi/xY2Z3g8cVkkL7cIQpMyIf7Bcm3VwYnZvX5xydpgyQQIqyKqKIvmKyVH++BukxiOis3cSwxWvO8pMpdSSGoWVO4fe6XvP0AK2i9IyodwySzfmFZ7/0SIr7tVc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:e4ac7712-56ea-4127-9061-527a628af346,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:fd7bf3a0-8fcb-430b-954a-ba3f00fa94a5,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: ecc3a29ed84b11eda9a90f0bb45854f4-20230411
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1093196087; Tue, 11 Apr 2023 17:33:32 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 11 Apr 2023 17:33:31 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 11 Apr 2023 17:33:30 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Hans Verkuil
	<hverkuil@xs4all.nl>, <nfraprado@collabora.com>,
	<linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, AngeloGioacchino Del
 Regno <angelogioacchino.delregno@collabora.com>, <mingyuan.ma@mediatek.com>,
	<yf.wang@mediatek.com>, <jianjiao.zeng@mediatek.com>, Yunfei Dong
	<yunfei.dong@mediatek.com>, kyrie wu
	<kyrie.wu@mediatek.corp-partner.google.com>, <chengci.xu@mediatek.com>,
	<youlin.pei@mediatek.com>, <anan.sun@mediatek.com>, Yong Wu
	<yong.wu@mediatek.com>
Subject: [PATCH v7 09/14] iommu/mediatek: Set dma_mask for the master devices
Date: Tue, 11 Apr 2023 17:31:39 +0800
Message-ID: <20230411093144.2690-10-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230411093144.2690-1-yong.wu@mediatek.com>
References: <20230411093144.2690-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

MediaTek iommu arranges dma ranges for all the masters, this patch is to
help them set dma mask. This is to avoid each master setting their own
mask, but also to avoid a real issue, such as JPEG uses
"mediatek,mtk-jpgenc" for 2701/8183/8186/8188, then JPEG could ignore its
different dma_mask in different SoC to achieve common code.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0e104bb27010..f58b970dccf2 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -738,6 +738,14 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	}
 	mutex_unlock(&data->mutex);
 
+	if (region_id > 0) {
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
+		if (ret) {
+			dev_err(m4udev, "Failed to set dma_mask for %s(%d).\n", dev_name(dev), ret);
+			return ret;
+		}
+	}
+
 	return mtk_iommu_config(data, dev, true, region_id);
 
 err_unlock:
-- 
2.25.1

