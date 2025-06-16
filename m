Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F6A29C35F
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042617; cv=none; b=K2pdEkJqEtkS5BuFlpR2giUemeP22bPaOyXMyhW1x6oLcxKp0uOrD806U+GEyjahgZou54Z9xvYuE6BkIgWkzL0+b5o62yBGZOzI4AkCaFD0ZHKO0o9vE9TzjVJSvEpEX3yHeph3qIl7jOkiUZwX1dHAPA+w0aiHoKDEG6nQ9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042617; c=relaxed/simple;
	bh=mW41p3KakDMRoVE0rvPGMA/OhcrOHUP9oobaDy6sCqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EaYb9h+oTLbYz+kKniE1hrxuHowcA2gJJ5i8N8hL974EM+V/ale0ktKW+IJv1dS63kBJB49C1g46aZUKjCUvkuZbtG39t+/JShh/sbG/OOGfR1LMQ/HsTSA/7huQw21XZZ4gDcmZP7C9zJzCOVVIhbUjZA1mWIeN5E9X7X87Trs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mlOkSmuH; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mlOkSmuH"
X-UUID: 8c8d45de4a5d11f0b910cdf5d4d8066a-20250616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xLriN2KjCA0IFbfsQGb7OkB87uKmU7ASl8EB4pFyKGc=;
	b=mlOkSmuHemCwuWY2vTG+OekAg/8Ev7CLLpkl2BwLuRBsZ9oBxWO8WIuJH2PV+9QQd8ZlPvhDwkKifASYXfXmMlzT05LRq5mdSL5ZE/kmIwMNO11uUd4rL6kv1PhoW0ydN9mKmMDC71ehEYXs6YPkDvM1BgvRh90+oqtQJhDsrUE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:f8f28128-d7f6-47c1-96d3-248863f97b4c,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:09905cf,CLOUDID:4409b758-abad-4ac2-9923-3af0a8a9a079,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8c8d45de4a5d11f0b910cdf5d4d8066a-20250616
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <xueqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 33681473; Mon, 16 Jun 2025 10:56:49 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 16 Jun 2025 10:56:48 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 16 Jun 2025 10:56:47 +0800
From: Xueqi Zhang <xueqi.zhang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <Project_Global_Chrome_Upstream_Group@mediatek.com>, Ning li
	<ning.li@mediatek.com>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <iommu@lists.linux.dev>, Xueqi Zhang
	<xueqi.zhang@mediatek.com>
Subject: [RFC PATCH 8/8] iommu/arm-smmu-v3: mediatek: Implement rpm get/put function
Date: Mon, 16 Jun 2025 10:56:14 +0800
Message-ID: <20250616025628.25454-9-xueqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
References: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In some projects, we also have EL2 driver, so we put the pm operation
in TFA(EL3), then all the kernel and EL2 could control the pm.
Implement rpm get/put function which send smc call to ATF to get/put
SMMU power.

Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-mediatek.c    | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
index 448166c1ca64..38c995e90469 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
@@ -397,9 +397,87 @@ static int mtk_smmu_v3_smmuwp_irq_handler(int irq, struct arm_smmu_device *smmu)
 	return 0;
 }
 
+/*
+ * SMMU TF-A SMC cmd format:
+ * sec[11:11] + smmu_type[10:8] + cmd_id[7:0]
+ */
+#define SMMU_ATF_SET_CMD(smmu_type, sec, cmd_id) \
+	((cmd_id) | ((smmu_type) << 8) | ((sec) << 11))
+
+enum smmu_atf_cmd {
+	SMMU_SECURE_PM_GET,
+	SMMU_SECURE_PM_PUT,
+	SMMU_CMD_NUM
+};
+
+/*
+ * a0/in0 = MTK_IOMMU_SECURE_CONTROL(IOMMU SMC ID)
+ * a1/in1 = SMMU TF-A SMC cmd (sec + smmu_type + cmd_id)
+ * a2/in2 ~ a7/in7: user defined
+ */
+static int mtk_smmu_atf_call(u32 smmu_type, unsigned long cmd,
+			     unsigned long in2, unsigned long in3, unsigned long in4,
+			     unsigned long in5, unsigned long in6, unsigned long in7)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(MTK_SIP_KERNEL_IOMMU_CONTROL, cmd, in2, in3, in4, in5, in6, in7, &res);
+
+	return res.a0;
+}
+
+static int mtk_smmu_atf_call_common(u32 smmu_type, unsigned long cmd_id)
+{
+	unsigned long cmd = SMMU_ATF_SET_CMD(smmu_type, 1, cmd_id);
+
+	return mtk_smmu_atf_call(smmu_type, cmd, 0, 0, 0, 0, 0, 0);
+}
+
+static int mtk_smmu_pm_get(struct device *dev, uint32_t smmu_type)
+{
+	int ret;
+
+	ret = mtk_smmu_atf_call_common(smmu_type, SMMU_SECURE_PM_GET);
+	if (ret) {
+		dev_dbg(dev, "%s, smc call fail. ret:%d, type:%u\n", __func__, ret, smmu_type);
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static int mtk_smmu_pm_put(struct device *dev, uint32_t smmu_type)
+{
+	int ret;
+
+	ret = mtk_smmu_atf_call_common(smmu_type, SMMU_SECURE_PM_PUT);
+	if (ret) {
+		dev_dbg(dev, "%s, smc call fail:%d, type:%u\n", __func__, ret, smmu_type);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int mtk_smmu_power_get(struct arm_smmu_device *smmu)
+{
+	struct mtk_smmu_v3 *mtk_smmuv3 = to_mtk_smmu_v3(smmu);
+	const struct mtk_smmu_v3_plat *plat_data = mtk_smmuv3->plat_data;
+
+	return mtk_smmu_pm_get(smmu->dev, plat_data->smmu_type);
+}
+
+static int mtk_smmu_power_put(struct arm_smmu_device *smmu)
+{
+	struct mtk_smmu_v3 *mtk_smmuv3 = to_mtk_smmu_v3(smmu);
+	const struct mtk_smmu_v3_plat *plat_data = mtk_smmuv3->plat_data;
+
+	return mtk_smmu_pm_put(smmu->dev, plat_data->smmu_type);
+}
+
 static const struct arm_smmu_v3_impl mtk_smmu_v3_impl = {
 	.combined_irq_handle = mtk_smmu_v3_smmuwp_irq_handler,
 	.smmu_evt_handler = mtk_smmu_evt_handler,
+	.smmu_power_get = mtk_smmu_power_get,
+	.smmu_power_put = mtk_smmu_power_put,
 };
 
 struct arm_smmu_device *arm_smmu_v3_impl_mtk_init(struct arm_smmu_device *smmu)
-- 
2.46.0

