Return-Path: <SRS0=U/E5=CJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DBCC433E6
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 10:56:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB98206F0
	for <iommu@archiver.kernel.org>; Mon, 31 Aug 2020 10:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SjNBQ6we"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB98206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5F05186410;
	Mon, 31 Aug 2020 10:56:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E-RiIanQonYr; Mon, 31 Aug 2020 10:56:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 46B5886378;
	Mon, 31 Aug 2020 10:56:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21D1CC07FF;
	Mon, 31 Aug 2020 10:56:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AFB8C0051
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 10:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 37BD186DEA
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 10:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qBPiXQ9czfca for <iommu@lists.linux-foundation.org>;
 Mon, 31 Aug 2020 10:56:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9AECD86DB0
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 10:56:51 +0000 (UTC)
X-UUID: d92c9e3114fa4d5c8c978949b4224d19-20200831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=PFK96T7avqn9jICrOvLa+GZbdRwSDF9sP7kZd14N3es=; 
 b=SjNBQ6weldBIG4cCv4v/RPnwzTdTxs5IQIjHtZhR4RBdjJe/nKlWJUWONsjlKK/3OjNjAX/cP++Px1uHRAHGe2c40dtq7y/zYwZKZSNqiFLrbnurigTOnLoo5SFAbfocv31xnZrAlFDBB09+DfFoam9uOMdhbb2DbX/AtzakNgc=;
X-UUID: d92c9e3114fa4d5c8c978949b4224d19-20200831
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
 (envelope-from <miles.chen@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1501708277; Mon, 31 Aug 2020 18:56:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 Aug 2020 18:56:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Mon, 31 Aug 2020 18:56:38 +0800
From: Miles Chen <miles.chen@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh@kernel.org>
Subject: [PATCH v5] iommu/mediatek: check 4GB mode by reading infracfg
Date: Mon, 31 Aug 2020 18:56:39 +0800
Message-ID: <20200831105639.2856-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-TM-SNTS-SMTP: 80F077771CDF5D82782C84C936A5D97B92B6AC9617A3A67447E00A9E4B201C822000:8
X-MTK: N
Cc: wsd_upstream@mediatek.com, David Hildenbrand <david@redhat.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Miles Chen <miles.chen@mediatek.com>, linux-mediatek@lists.infradead.org,
 Yingjoe Chen <yingjoe.chen@mediatek.com>, Mike Rapoport <rppt@linux.ibm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

In previous discussion [1] and [2], we found that it is risky to
use max_pfn or totalram_pages to tell if 4GB mode is enabled.

Check 4GB mode by reading infracfg register, remove the usage
of the un-exported symbol max_pfn.

This is a step towards building mtk_iommu as a kernel module.

[1] https://lore.kernel.org/lkml/20200603161132.2441-1-miles.chen@mediatek.com/
[2] https://lore.kernel.org/lkml/20200604080120.2628-1-miles.chen@mediatek.com/
[3] https://lore.kernel.org/lkml/20200715205120.GA778876@bogus/

Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Yong Wu <yong.wu@mediatek.com>
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>

---

Change since v4
- remove unnecessary data->enable_4GB = false, since it is kzalloc()ed.

Change since v3
- use lore.kernel.org links
- move "change since..." after "---"

Change since v2:
- determine compatible string by m4u_plat
- rebase to next-20200720
- add "---"

Change since v1:
- remove the phandle usage, search for infracfg instead [3]
- use infracfg instead of infracfg_regmap
- move infracfg definitaions to linux/soc/mediatek/infracfg.h
- update enable_4GB only when has_4gb_mode
---
 drivers/iommu/mtk_iommu.c             | 33 +++++++++++++++++++++++----
 include/linux/soc/mediatek/infracfg.h |  3 +++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 785b228d39a6..e7b8b2bb08a9 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2015-2016 MediaTek Inc.
  * Author: Yong Wu <yong.wu@mediatek.com>
  */
-#include <linux/memblock.h>
 #include <linux/bug.h>
 #include <linux/clk.h>
 #include <linux/component.h>
@@ -15,13 +14,16 @@
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/list.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/of_iommu.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/soc/mediatek/infracfg.h>
 #include <asm/barrier.h>
 #include <soc/mediatek/smi.h>
 
@@ -640,8 +642,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	struct resource         *res;
 	resource_size_t		ioaddr;
 	struct component_match  *match = NULL;
+	struct regmap		*infracfg;
 	void                    *protect;
 	int                     i, larb_nr, ret;
+	u32			val;
+	char                    *p;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -655,10 +660,28 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
 
-	/* Whether the current dram is over 4GB */
-	data->enable_4GB = !!(max_pfn > (BIT_ULL(32) >> PAGE_SHIFT));
-	if (!MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
-		data->enable_4GB = false;
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE)) {
+		switch (data->plat_data->m4u_plat) {
+		case M4U_MT2712:
+			p = "mediatek,mt2712-infracfg";
+			break;
+		case M4U_MT8173:
+			p = "mediatek,mt8173-infracfg";
+			break;
+		default:
+			p = NULL;
+		}
+
+		infracfg = syscon_regmap_lookup_by_compatible(p);
+
+		if (IS_ERR(infracfg))
+			return PTR_ERR(infracfg);
+
+		ret = regmap_read(infracfg, REG_INFRA_MISC, &val);
+		if (ret)
+			return ret;
+		data->enable_4GB = !!(val & F_DDR_4GB_SUPPORT_EN);
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->base = devm_ioremap_resource(dev, res);
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index fd25f0148566..233463d789c6 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -32,6 +32,9 @@
 #define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
 						 BIT(7) | BIT(8))
 
+#define REG_INFRA_MISC				0xf00
+#define F_DDR_4GB_SUPPORT_EN			BIT(13)
+
 int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
 		bool reg_update);
 int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
