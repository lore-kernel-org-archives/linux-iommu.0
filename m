Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34A3C433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 09:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F56684CCB;
	Tue, 25 Jan 2022 09:00:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uf4JW6kATHsM; Tue, 25 Jan 2022 09:00:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E5C7082A0B;
	Tue, 25 Jan 2022 09:00:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE547C0031;
	Tue, 25 Jan 2022 09:00:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BC4AC002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 09:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5649584CAA
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 09:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ZWJVM6NcC1F for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 09:00:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AF1182A0B
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 09:00:24 +0000 (UTC)
X-UUID: 2d6576185f154578b25e410fc2caa844-20220125
X-UUID: 2d6576185f154578b25e410fc2caa844-20220125
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 847174064; Tue, 25 Jan 2022 17:00:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Tue, 25 Jan 2022 17:00:19 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 17:00:17 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v4 26/35] iommu/mediatek: Separate mtk_iommu_data for v1 and v2
Date: Tue, 25 Jan 2022 16:56:25 +0800
Message-ID: <20220125085634.17972-27-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220125085634.17972-1-yong.wu@mediatek.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Prepare for adding the structure "mtk_iommu_bank_data". No functional
change. The mtk_iommu_domain in v1 and v2 are different, we could not add
current data as bank[0] in v1 simplistically.

Currently we have no plan to add new SoC for v1, in order to avoid affect
v1 when we add many new features for v2, I totally separate v1 and v2 in
this patch, there are many structures only for v2.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c    | 82 +++++++++++++++++++++++++++++++++---
 drivers/iommu/mtk_iommu.h    | 81 -----------------------------------
 drivers/iommu/mtk_iommu_v1.c | 29 +++++++++++++
 3 files changed, 106 insertions(+), 86 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 496ed9ecd23a..80c1e5a75868 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -146,6 +146,69 @@
 
 #define MTK_INVALID_LARBID		MTK_LARB_NR_MAX
 
+#define MTK_LARB_COM_MAX	8
+#define MTK_LARB_SUBCOM_MAX	8
+
+#define MTK_IOMMU_GROUP_MAX	8
+
+enum mtk_iommu_plat {
+	M4U_MT2712,
+	M4U_MT6779,
+	M4U_MT8167,
+	M4U_MT8173,
+	M4U_MT8183,
+	M4U_MT8192,
+	M4U_MT8195,
+};
+
+struct mtk_iommu_iova_region {
+	dma_addr_t		iova_base;
+	unsigned long long	size;
+};
+
+struct mtk_iommu_plat_data {
+	enum mtk_iommu_plat			m4u_plat;
+	u32					flags;
+	u32					inv_sel_reg;
+
+	char					*pericfg_comp_str;
+	struct list_head			*hw_list;
+	unsigned int				iova_region_nr;
+	const struct mtk_iommu_iova_region	*iova_region;
+	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
+};
+
+struct mtk_iommu_data {
+	void __iomem			*base;
+	int				irq;
+	struct device			*dev;
+	struct clk			*bclk;
+	phys_addr_t			protect_base; /* protect memory base */
+	struct mtk_iommu_suspend_reg	reg;
+	struct mtk_iommu_domain		*m4u_dom;
+	struct iommu_group		*m4u_group[MTK_IOMMU_GROUP_MAX];
+	bool                            enable_4GB;
+	spinlock_t			tlb_lock; /* lock for tlb range flush */
+
+	struct iommu_device		iommu;
+	const struct mtk_iommu_plat_data *plat_data;
+	struct device			*smicomm_dev;
+
+	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
+	struct regmap			*pericfg;
+
+	struct mutex			mutex; /* Protect m4u_group/m4u_dom above */
+
+	/*
+	 * In the sharing pgtable case, list data->list to the global list like m4ulist.
+	 * In the non-sharing pgtable case, list data->list to the itself hw_list_head.
+	 */
+	struct list_head		*hw_list;
+	struct list_head		hw_list_head;
+	struct list_head		list;
+	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
+};
+
 struct mtk_iommu_domain {
 	struct io_pgtable_cfg		cfg;
 	struct io_pgtable_ops		*iop;
@@ -156,6 +219,20 @@ struct mtk_iommu_domain {
 	struct mutex			mutex; /* Protect "data" in this structure */
 };
 
+static inline int mtk_iommu_bind(struct device *dev)
+{
+	struct mtk_iommu_data *data = dev_get_drvdata(dev);
+
+	return component_bind_all(dev, &data->larb_imu);
+}
+
+static inline void mtk_iommu_unbind(struct device *dev)
+{
+	struct mtk_iommu_data *data = dev_get_drvdata(dev);
+
+	component_unbind_all(dev, &data->larb_imu);
+}
+
 static const struct iommu_ops mtk_iommu_ops;
 
 static int mtk_iommu_hw_init(const struct mtk_iommu_data *data);
@@ -193,11 +270,6 @@ static LIST_HEAD(m4ulist);	/* List all the M4U HWs */
 
 #define for_each_m4u(data, head)  list_for_each_entry(data, head, list)
 
-struct mtk_iommu_iova_region {
-	dma_addr_t		iova_base;
-	unsigned long long	size;
-};
-
 static const struct mtk_iommu_iova_region single_domain[] = {
 	{.iova_base = 0,		.size = SZ_4G},
 };
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 9dba98bb12eb..d332f9769f83 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -7,23 +7,14 @@
 #ifndef _MTK_IOMMU_H_
 #define _MTK_IOMMU_H_
 
-#include <linux/clk.h>
-#include <linux/component.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
-#include <linux/list.h>
 #include <linux/spinlock.h>
-#include <linux/dma-mapping.h>
 #include <soc/mediatek/smi.h>
 #include <dt-bindings/memory/mtk-memory-port.h>
 
-#define MTK_LARB_COM_MAX	8
-#define MTK_LARB_SUBCOM_MAX	8
-
-#define MTK_IOMMU_GROUP_MAX	8
-
 struct mtk_iommu_suspend_reg {
 	union {
 		u32			standard_axi_mode;/* v1 */
@@ -38,64 +29,6 @@ struct mtk_iommu_suspend_reg {
 	u32				wr_len_ctrl;
 };
 
-enum mtk_iommu_plat {
-	M4U_MT2701,
-	M4U_MT2712,
-	M4U_MT6779,
-	M4U_MT8167,
-	M4U_MT8173,
-	M4U_MT8183,
-	M4U_MT8192,
-	M4U_MT8195,
-};
-
-struct mtk_iommu_iova_region;
-
-struct mtk_iommu_plat_data {
-	enum mtk_iommu_plat m4u_plat;
-	u32                 flags;
-	u32                 inv_sel_reg;
-
-	char					*pericfg_comp_str;
-	struct list_head			*hw_list;
-	unsigned int				iova_region_nr;
-	const struct mtk_iommu_iova_region	*iova_region;
-	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
-};
-
-struct mtk_iommu_domain;
-
-struct mtk_iommu_data {
-	void __iomem			*base;
-	int				irq;
-	struct device			*dev;
-	struct clk			*bclk;
-	phys_addr_t			protect_base; /* protect memory base */
-	struct mtk_iommu_suspend_reg	reg;
-	struct mtk_iommu_domain		*m4u_dom;
-	struct iommu_group		*m4u_group[MTK_IOMMU_GROUP_MAX];
-	bool                            enable_4GB;
-	spinlock_t			tlb_lock; /* lock for tlb range flush */
-
-	struct iommu_device		iommu;
-	const struct mtk_iommu_plat_data *plat_data;
-	struct device			*smicomm_dev;
-
-	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
-	struct regmap			*pericfg;
-
-	struct mutex			mutex; /* Protect m4u_group/m4u_dom above */
-
-	/*
-	 * In the sharing pgtable case, list data->list to the global list like m4ulist.
-	 * In the non-sharing pgtable case, list data->list to the itself hw_list_head.
-	 */
-	struct list_head		*hw_list;
-	struct list_head		hw_list_head;
-	struct list_head		list;
-	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
-};
-
 static inline int compare_of(struct device *dev, void *data)
 {
 	return dev->of_node == data;
@@ -106,18 +39,4 @@ static inline void release_of(struct device *dev, void *data)
 	of_node_put(data);
 }
 
-static inline int mtk_iommu_bind(struct device *dev)
-{
-	struct mtk_iommu_data *data = dev_get_drvdata(dev);
-
-	return component_bind_all(dev, &data->larb_imu);
-}
-
-static inline void mtk_iommu_unbind(struct device *dev)
-{
-	struct mtk_iommu_data *data = dev_get_drvdata(dev);
-
-	component_unbind_all(dev, &data->larb_imu);
-}
-
 #endif
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index be22fcf988ce..b762a05328d4 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -87,6 +87,21 @@
  */
 #define M2701_IOMMU_PGT_SIZE			SZ_4M
 
+struct mtk_iommu_data {
+	void __iomem			*base;
+	int				irq;
+	struct device			*dev;
+	struct clk			*bclk;
+	phys_addr_t			protect_base; /* protect memory base */
+	struct mtk_iommu_domain		*m4u_dom;
+
+	struct iommu_device		iommu;
+	struct dma_iommu_mapping	*mapping;
+	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
+
+	struct mtk_iommu_suspend_reg	reg;
+};
+
 struct mtk_iommu_domain {
 	spinlock_t			pgtlock; /* lock for page table */
 	struct iommu_domain		domain;
@@ -95,6 +110,20 @@ struct mtk_iommu_domain {
 	struct mtk_iommu_data		*data;
 };
 
+static inline int mtk_iommu_bind(struct device *dev)
+{
+	struct mtk_iommu_data *data = dev_get_drvdata(dev);
+
+	return component_bind_all(dev, &data->larb_imu);
+}
+
+static inline void mtk_iommu_unbind(struct device *dev)
+{
+	struct mtk_iommu_data *data = dev_get_drvdata(dev);
+
+	component_unbind_all(dev, &data->larb_imu);
+}
+
 static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 {
 	return container_of(dom, struct mtk_iommu_domain, domain);
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
