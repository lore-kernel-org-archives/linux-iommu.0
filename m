Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E876299AAF
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760498781; cv=none; b=S/uxgvEr8w75Svqcp9OLW3FkbPRhuKkrkR/hhsD+uclgjQz8AbNqkq4tcVD9FS5GxcDVNdza7kZXSi/XW4QSfqUHsRhGOroJgIsl3TBC6dEDLFM8PDuTf/ouy7ra0lgRNYG9Cy5TQD2gQ6jSzH5+FeglqVl17jpCDsiZvRBrYXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760498781; c=relaxed/simple;
	bh=ibi3EvWlOjJI9LmYkRv5bNV8ffal6fRzPr3erXb3T5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjERJ8+x5yzSWqxUbqEswmSnKltX8YbtqGf4zuA39k4PcdjA5S2aU5PFa2fj1C7RDXA0PVTCykiJXcCOjSNZ20R1EJPSxWJjgC0HhQpIATRObayYhaeD7wIJuI2kBCoXhMpMEJLX8GmjG2iGhgDFFxqJWtube42YdERImll7Vyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mPV9ayf6; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mPV9ayf6"
X-UUID: b28d69eea97611f0ae1e63ff8927bad3-20251015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bkeZWL/aC0QqQsmb6lMOmPRcVdbGQcpa7vlMcE32JQQ=;
	b=mPV9ayf6F80ZOe5FKEUKSzvywPoRT1aWdfZCExSX7I60A6w7ORzyy12ZOa3FVXsSxMOF+SWVInaocJEQeevw1Npt0pQjPDqy1A3M8YokfzwSvaQMWIhINYp4sG7NPk3OQgdRpqxkjfxKKlD42faew7Tv8N7lgN6AL0dkgorm93Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5f5f55d6-67bb-42c1-8efb-64421d8ccde0,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:33453986-2e17-44e4-a09c-1e463bf6bc47,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b28d69eea97611f0ae1e63ff8927bad3-20251015
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2093147980; Wed, 15 Oct 2025 11:26:11 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 15 Oct 2025 11:26:09 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 15 Oct 2025 11:26:08 +0800
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
Subject: [PATCH v2 2/5] iommu/mediatek: Add a flag DL_WITH_MULTI_LARB
Date: Wed, 15 Oct 2025 11:24:18 +0800
Message-ID: <20251015032509.5057-3-zhengnan.chen@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251015032509.5057-1-zhengnan.chen@mediatek.com>
References: <20251015032509.5057-1-zhengnan.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add DL_WITH_MULTI_LARB flag to support the HW which connect with
multiple larbs. Prepare for mt8189. In mt8189, the display connect
with larb1 and larb2 at the same time. Thus, we should add link
between disp-dev with these two larbs.

Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 56 ++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0e0285348d2b..7af47c59b10b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -147,6 +147,7 @@
 #define TF_PORT_TO_ADDR_MT8173		BIT(18)
 #define INT_ID_PORT_WIDTH_6		BIT(19)
 #define CFG_IFA_MASTER_IN_ATF		BIT(20)
+#define DL_WITH_MULTI_LARB		BIT(21)
 
 #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
 				((((pdata)->flags) & (mask)) == (_x))
@@ -865,6 +866,7 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 	struct device_link *link;
 	struct device *larbdev;
+	unsigned long larbid_msk = 0;
 	unsigned int larbid, larbidx, i;
 
 	if (!MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
@@ -872,30 +874,50 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 
 	/*
 	 * Link the consumer device with the smi-larb device(supplier).
-	 * The device that connects with each a larb is a independent HW.
-	 * All the ports in each a device should be in the same larbs.
+	 * w/DL_WITH_MULTI_LARB: the master may connect with multi larbs,
+	 * we should create device link with each larb.
+	 * w/o DL_WITH_MULTI_LARB: the master must connect with one larb,
+	 * otherwise fail.
 	 */
 	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
 	if (larbid >= MTK_LARB_NR_MAX)
 		return ERR_PTR(-EINVAL);
 
+	larbid_msk |= BIT(larbid);
+
 	for (i = 1; i < fwspec->num_ids; i++) {
 		larbidx = MTK_M4U_TO_LARB(fwspec->ids[i]);
-		if (larbid != larbidx) {
+		if (MTK_IOMMU_HAS_FLAG(data->plat_data, DL_WITH_MULTI_LARB)) {
+			larbid_msk |= BIT(larbidx);
+		} else if (larbid != larbidx) {
 			dev_err(dev, "Can only use one larb. Fail@larb%d-%d.\n",
 				larbid, larbidx);
 			return ERR_PTR(-EINVAL);
 		}
 	}
-	larbdev = data->larb_imu[larbid].dev;
-	if (!larbdev)
-		return ERR_PTR(-EINVAL);
 
-	link = device_link_add(dev, larbdev,
-			       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
-	if (!link)
-		dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
+	for_each_set_bit(larbid, &larbid_msk, 32) {
+		larbdev = data->larb_imu[larbid].dev;
+		if (!larbdev)
+			return ERR_PTR(-EINVAL);
+
+		link = device_link_add(dev, larbdev,
+				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
+		if (!link) {
+			dev_err(dev, "Unable to link %s\n", dev_name(larbdev));
+			goto link_remove;
+		}
+	}
+
 	return &data->iommu;
+
+link_remove:
+	for_each_set_bit(i, &larbid_msk, larbid) {
+		larbdev = data->larb_imu[i].dev;
+		device_link_remove(dev, larbdev);
+	}
+
+	return ERR_PTR(-ENODEV);
 }
 
 static void mtk_iommu_release_device(struct device *dev)
@@ -903,11 +925,19 @@ static void mtk_iommu_release_device(struct device *dev)
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct mtk_iommu_data *data;
 	struct device *larbdev;
-	unsigned int larbid;
+	unsigned int larbid, i;
+	unsigned long larbid_msk = 0;
 
 	data = dev_iommu_priv_get(dev);
-	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
-		larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+	if (!MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
+		return;
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		larbid = MTK_M4U_TO_LARB(fwspec->ids[i]);
+		larbid_msk |= BIT(larbid);
+	}
+
+	for_each_set_bit(larbid, &larbid_msk, 32) {
 		larbdev = data->larb_imu[larbid].dev;
 		device_link_remove(dev, larbdev);
 	}
-- 
2.46.0

