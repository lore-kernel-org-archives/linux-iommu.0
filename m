Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C428E5F3
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 02:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042608; cv=none; b=icMKrXrtwk6YJcfkAScrHxr5jAYpq3YKMV8gJNn8HYDPwybioiujwRoYP0Y/aLARK+8TeczLPWeY/NtOiEao208bPkiW0Ydy4z8v9ESt8og05sYnf2bg6TIG6+k10OzsOjnJDVX/SXmxuJHmlgoMDu6usup3rtaUEIaxfB0UfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042608; c=relaxed/simple;
	bh=qPoWptFGIaQXfFMEYPCZ+O4wEIiUUVUhvJm/0dKm9zE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlrGgcCStICCqKPH2TCfaSYz8rbA4Mf82wd1ZzcPTbvKbEYJznivKnpWVZuvW2zwScpEYURQJQqVDk/TwHJw2uC3VS8tKLom4ps6faeHMy8/cPjb0qNavw6H6qOTxJT7KU5lSHkto8lzjSjjBLg/qjro5yaTeW9SMTSp1r7OCow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=umRThyxf; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="umRThyxf"
X-UUID: 86e04fbe4a5d11f0b910cdf5d4d8066a-20250616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NyZas3Lvh7H1mCmhnuCgcLJvePyut78m/vXrr6Nd/VI=;
	b=umRThyxfmeafjAyB3xahYrQTJwXwge3mmgxiNX2UY6HI50RDqIzpO4IoI78IUVrQ2W/u4X1Ds3oizOGoKsjujmGYcgMmNO2NuFRa5kmOPZwkMock812k5rZWQtncpY4VvgWw5cLlB7qySmfXBdnRm42kTBqBir8RCzmzuPc9+TI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:16e45a4e-1279-425c-af1c-caec81da2834,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:09905cf,CLOUDID:dc93b703-0d95-4f6b-a95f-3c560ebcf3ab,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 86e04fbe4a5d11f0b910cdf5d4d8066a-20250616
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <xueqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1991215331; Mon, 16 Jun 2025 10:56:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 16 Jun 2025 10:56:38 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 16 Jun 2025 10:56:37 +0800
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
Subject: [RFC PATCH 3/8] iommu/arm-smmu-v3: Add implementation for MT8196 MM SMMU
Date: Mon, 16 Jun 2025 10:56:09 +0800
Message-ID: <20250616025628.25454-4-xueqi.zhang@mediatek.com>
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

Add implementation for mediatek MM SMMU.

Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-mediatek.c    | 72 ++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
index 381268968185..c00ee687d839 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
@@ -4,10 +4,80 @@
  * Author: Ning li <ning.li@mediatek.com>
  * Author: Xueqi Zhang <xueqi.zhang@mediatek.com>
  */
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
 
 #include "arm-smmu-v3.h"
 
-struct arm_smmu_device *arm_smmu_v3_impl_mtk_init(struct arm_smmu_device *smmu)
+#define MTK_SMMU_COMP_STR_LEN		64
+#define MTK_SMMU_HAS_FLAG(pdata, _x)    (!!(((pdata)->flags) & (_x)))
+
+enum mtk_smmu_type {
+	MTK_SMMU_MM,
+	MTK_SMMU_TYPE_NUM,
+};
+
+struct mtk_smmu_v3_plat {
+	enum mtk_smmu_type	smmu_type;
+	u32			flags;
+};
+
+struct mtk_smmu_v3 {
+	struct arm_smmu_device	smmu;
+	const struct mtk_smmu_v3_plat *plat_data;
+};
+
+static const struct mtk_smmu_v3_plat mt8196_data_mm = {
+	.smmu_type		= MTK_SMMU_MM,
+};
+
+struct mtk_smmu_v3_of_device_data {
+	char			compatible[MTK_SMMU_COMP_STR_LEN];
+	const void		*data;
+};
+
+static const struct mtk_smmu_v3_of_device_data mtk_smmu_v3_of_ids[] = {
+	{ .compatible = "mediatek,mt8196-mm-smmu", .data = &mt8196_data_mm},
+};
+
+static inline struct mtk_smmu_v3 *to_mtk_smmu_v3(struct arm_smmu_device *smmu)
 {
+	return container_of(smmu, struct mtk_smmu_v3, smmu);
+}
+
+static const struct mtk_smmu_v3_plat *mtk_smmu_v3_get_plat_data(const struct device_node *np)
+{
+	const struct mtk_smmu_v3_of_device_data *of_device = mtk_smmu_v3_of_ids;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mtk_smmu_v3_of_ids); i++, of_device++) {
+		if (of_device_is_compatible(np, of_device->compatible))
+			return of_device->data;
+	}
 	return NULL;
 }
+
+struct arm_smmu_device *arm_smmu_v3_impl_mtk_init(struct arm_smmu_device *smmu)
+{
+	struct mtk_smmu_v3 *mtk_smmu_v3;
+	struct device *dev = smmu->dev;
+	struct platform_device *parent_pdev;
+	struct device_node *parent_node;
+
+	mtk_smmu_v3 = devm_krealloc(dev, smmu, sizeof(*mtk_smmu_v3), GFP_KERNEL);
+	if (!mtk_smmu_v3)
+		return ERR_PTR(-ENOMEM);
+
+	mtk_smmu_v3->plat_data = mtk_smmu_v3_get_plat_data(dev->of_node);
+	if (!mtk_smmu_v3->plat_data) {
+		dev_err(dev, "Get platform data fail\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &mtk_smmu_v3->smmu;
+}
-- 
2.46.0

