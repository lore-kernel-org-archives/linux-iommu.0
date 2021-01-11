Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3ACC433E0
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 11:22:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DFC2220F
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 11:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DFC2220F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1D00E20C41;
	Mon, 11 Jan 2021 11:22:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Nc95uYR-Req; Mon, 11 Jan 2021 11:22:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 831FB204B0;
	Mon, 11 Jan 2021 11:22:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B947C0893;
	Mon, 11 Jan 2021 11:22:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9F3EC013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E43C785CA8
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bKMZU4C2Z6GB for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 11:22:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DE6C285C95
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:22:46 +0000 (UTC)
X-UUID: 343936d70bd141c2bf6093e4313bcfe5-20210111
X-UUID: 343936d70bd141c2bf6093e4313bcfe5-20210111
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1538222942; Mon, 11 Jan 2021 19:22:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:22:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:22:42 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v6 20/33] iommu/mediatek: Add power-domain operation
Date: Mon, 11 Jan 2021 19:19:01 +0800
Message-ID: <20210111111914.22211-21-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
 linux-arm-kernel@lists.infradead.org
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

In the previous SoC, the M4U HW is in the EMI power domain which is
always on. the latest M4U is in the display power domain which may be
turned on/off, thus we have to add pm_runtime interface for it.

When the engine work, the engine always enable the power and clocks for
smi-larb/smi-common, then the M4U's power will always be powered on
automatically via the device link with smi-common.

Note: we don't enable the M4U power in iommu_map/unmap for tlb flush.
If its power already is on, of course it is ok. if the power is off,
the main tlb will be reset while M4U power on, thus the tlb flush while
m4u power off is unnecessary, just skip it.
Therefore, we increase the ref_count for pm when pm status is ACTIVE,
otherwise, skip it. Meanwhile, the tlb_flush_range is called so often,
thus, update pm ref_count while the SoC has power-domain to avoid touch the
dev->power.lock. and the tlb_flush_all only is called when boot, so no
need check if the SoC has power-domain to keep code clean.

There will be one case that pm runctime status is not expected when tlb
flush. After boot, the display may call dma_alloc_attrs before it call
pm_runtime_get(disp-dev), then the m4u's pm status is not active inside
the dma_alloc_attrs. Since it only happens after boot, the tlb is clean
at that time, I also think this is ok.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 3682137b789a..b9c63c8de33e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -182,10 +182,15 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
 	for_each_m4u(data) {
+		if (pm_runtime_get_if_in_use(data->dev) <= 0)
+			continue;
+
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			       data->base + data->plat_data->inv_sel_reg);
 		writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
 		wmb(); /* Make sure the tlb flush all done */
+
+		pm_runtime_put(data->dev);
 	}
 }
 
@@ -193,11 +198,17 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 					   size_t granule,
 					   struct mtk_iommu_data *data)
 {
+	bool has_pm = !!data->dev->pm_domain;
 	unsigned long flags;
 	int ret;
 	u32 tmp;
 
 	for_each_m4u(data) {
+		if (has_pm) {
+			if (pm_runtime_get_if_in_use(data->dev) <= 0)
+				continue;
+		}
+
 		spin_lock_irqsave(&data->tlb_lock, flags);
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			       data->base + data->plat_data->inv_sel_reg);
@@ -219,6 +230,9 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 		/* Clear the CPE status */
 		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
 		spin_unlock_irqrestore(&data->tlb_lock, flags);
+
+		if (has_pm)
+			pm_runtime_put(data->dev);
 	}
 }
 
@@ -367,18 +381,27 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct device *m4udev = data->dev;
 	int ret;
 
 	if (!data)
 		return -ENODEV;
 
 	if (!data->m4u_dom) { /* Initialize the M4U HW */
+		ret = pm_runtime_resume_and_get(m4udev);
+		if (ret < 0)
+			return ret;
+
 		ret = mtk_iommu_hw_init(data);
-		if (ret)
+		if (ret) {
+			pm_runtime_put(m4udev);
 			return ret;
+		}
 		data->m4u_dom = dom;
 		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
 		       data->base + REG_MMU_PT_BASE_ADDR);
+
+		pm_runtime_put(m4udev);
 	}
 
 	mtk_iommu_config(data, dev, true);
@@ -738,11 +761,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	of_node_put(smicomm_node);
 	data->smicomm_dev = &plarbdev->dev;
 
+	pm_runtime_enable(dev);
+
 	link = device_link_add(data->smicomm_dev, dev,
 			DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
 	if (!link) {
 		dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
-		return -EINVAL;
+		goto out_runtime_disable;
 	}
 
 	platform_set_drvdata(pdev, data);
@@ -782,6 +807,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&data->iommu);
 out_link_remove:
 	device_link_remove(data->smicomm_dev, dev);
+out_runtime_disable:
+	pm_runtime_disable(dev);
 	return ret;
 }
 
@@ -797,6 +824,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->bclk);
 	device_link_remove(data->smicomm_dev, &pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
 	return 0;
@@ -828,6 +856,9 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	void __iomem *base = data->base;
 	int ret;
 
+	/* Avoid first resume to affect the default value of registers below. */
+	if (!m4u_dom)
+		return 0;
 	ret = clk_prepare_enable(data->bclk);
 	if (ret) {
 		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
@@ -841,9 +872,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
 	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
 	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
-	if (m4u_dom)
-		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
-		       base + REG_MMU_PT_BASE_ADDR);
+	writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK, base + REG_MMU_PT_BASE_ADDR);
 	return 0;
 }
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
