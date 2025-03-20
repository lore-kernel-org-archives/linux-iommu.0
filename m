Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12731EE7A9
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456223; cv=none; b=aio6OLBgRb3d+DTC27JEYOMCK1acbWUkwpYUXF1sg5toXgAahVarU3I47sixBgZBTL4HfRrRvNR2HJQG5T/Mv7uQoGVKNdQ/QLQxqV5j1N/nw1+mr7kJgheP0Gt5HptOO/sGIWhQs9hDkEkqsuW8bJ82NS15ZY4Z9aQ1WHCwTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456223; c=relaxed/simple;
	bh=+Dzrxx/9nMdgHvFemt+nVAtC7SVC9ikkxC8F+c4VnbE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GhDV/Ui1kqP+UycY/WKg9Zi5Y7xL2+AZA3It/qvFCzJgdVqMKEigNUkP7fil86uAPLBaXsHlRCuYv7iSF9qEDYoK4jCKpLZ9Q2QOxlIaWKMTHu2ualdThBSOmpPuSqJ5mrTB8YJ3SHT+Fh86ZW3bhzy1ZGQi04EVUc7WmnQWasE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=k5cxgUnR; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k5cxgUnR"
X-UUID: 1a0cc776055e11f08eb9c36241bbb6fb-20250320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KzsI2dcH77WIYuzMov1WZY4sjPCFu5uSEpq9ji+VCkM=;
	b=k5cxgUnRiA0GQN4I4WMIGQSx5diKIpkGreWF4G7Z3LyORyq7d4p3thfvxr1ZOJ1k+4zFBIM3PBjdHNyryd+YhdGZH9jZ1MdNYsxYj3ONeil90CtErDl9m3SkDw/AUJ/URtXpSNJHkL926CVDmFuWKjYL2YzgtNMOR+C5eMgbAxI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:aeeb9ac1-f183-4d2d-babd-6716988649e8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:fcad9c8c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1a0cc776055e11f08eb9c36241bbb6fb-20250320
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <xueqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 153291958; Thu, 20 Mar 2025 15:36:57 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 20 Mar 2025 15:36:55 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 20 Mar 2025 15:36:54 +0800
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
Subject: [PATCH 2/3] memory: mtk-smi: Add a flag skip_rpm
Date: Thu, 20 Mar 2025 15:36:17 +0800
Message-ID: <20250320073625.25225-3-xueqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250320073625.25225-1-xueqi.zhang@mediatek.com>
References: <20250320073625.25225-1-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

MT8196 SMI commons is backed up/restored by RTFF HW.
It doesn't need SW control the register backup/store
in the runtime callback.Therefore, add a flag skip_rpm
to help skip RPM operations for SMI commons.

Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
---
 drivers/memory/mtk-smi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index a8f5467d6b31..b9affa3c3185 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -123,6 +123,7 @@ static const char * const mtk_smi_common_clks[] = {"apb", "smi", "gals0", "gals1
 struct mtk_smi_common_plat {
 	enum mtk_smi_type	type;
 	bool			has_gals;
+	bool			skip_rpm;
 	u32			bus_sel; /* Balance some larbs to enter mmu0 or mmu1 */
 
 	const struct mtk_smi_reg_pair	*init;
@@ -547,6 +548,9 @@ static int mtk_smi_dts_clk_init(struct device *dev, struct mtk_smi *smi,
 {
 	int i, ret;
 
+	if (smi->plat->skip_rpm)
+		return 0;
+
 	for (i = 0; i < clk_nr_required; i++)
 		smi->clks[i].id = clks[i];
 	ret = devm_clk_bulk_get(dev, clk_nr_required, smi->clks);
@@ -783,7 +787,7 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	common->dev = dev;
 	common->plat = of_device_get_match_data(dev);
 
-	if (common->plat->has_gals) {
+	if (!common->plat->skip_rpm && common->plat->has_gals) {
 		if (common->plat->type == MTK_SMI_GEN2)
 			clk_required = MTK_SMI_COM_GALS_REQ_CLK_NR;
 		else if (common->plat->type == MTK_SMI_GEN2_SUB_COMM)
@@ -814,13 +818,14 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	}
 
 	/* link its smi-common if this is smi-sub-common */
-	if (common->plat->type == MTK_SMI_GEN2_SUB_COMM) {
+	if (common->plat->type == MTK_SMI_GEN2_SUB_COMM && !common->plat->skip_rpm) {
 		ret = mtk_smi_device_link_common(dev, &common->smi_common_dev);
 		if (ret < 0)
 			return ret;
 	}
 
-	pm_runtime_enable(dev);
+	if (!common->plat->skip_rpm)
+		pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, common);
 	return 0;
 }
-- 
2.46.0

