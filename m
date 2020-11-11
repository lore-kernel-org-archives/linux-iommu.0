Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA75DC388F9
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 12:41:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 450A320679
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 12:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450A320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E4DA086C4D;
	Wed, 11 Nov 2020 12:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d3ynnukTPpmj; Wed, 11 Nov 2020 12:41:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3962386C3B;
	Wed, 11 Nov 2020 12:41:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 337BEC088B;
	Wed, 11 Nov 2020 12:41:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B50CC016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 12:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 78CC88754B
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 12:41:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V7-yxnGEbqS0 for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 12:41:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7D0C687528
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 12:41:14 +0000 (UTC)
X-UUID: dfd23aa02cbb494db0a286a2be4eaf22-20201111
X-UUID: dfd23aa02cbb494db0a286a2be4eaf22-20201111
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 907776938; Wed, 11 Nov 2020 20:41:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 20:41:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 20:41:08 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 15/24] iommu/mediatek: Add power-domain operation
Date: Wed, 11 Nov 2020 20:38:29 +0800
Message-ID: <20201111123838.15682-16-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201111123838.15682-1-yong.wu@mediatek.com>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, kernel-team@android.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
 Greg Kroah-Hartman <gregkh@google.com>, linux-arm-kernel@lists.infradead.org
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

There will be one case that pm runctime status is not expected when tlb
flush. After boot, the display may call dma_alloc_attrs before it call
pm_runtime_get(disp-dev), then the m4u's pm status is not active inside
the dma_alloc_attrs. Since it only happens after boot, the tlb is clean
at that time, I also think this is ok.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index fe16053eda48..90aae34f4da0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -183,6 +183,8 @@ static void mtk_iommu_tlb_flush_all(void *cookie)
 	struct mtk_iommu_data *data = cookie;
 
 	for_each_m4u(data) {
+		if (!pm_runtime_active(data->dev))
+			continue;
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			       data->base + data->plat_data->inv_sel_reg);
 		writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
@@ -199,6 +201,10 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 	u32 tmp;
 
 	for_each_m4u(data) {
+		/* skip tlb flush when pm is not active. */
+		if (!pm_runtime_active(data->dev))
+			continue;
+
 		spin_lock_irqsave(&data->tlb_lock, flags);
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 			       data->base + data->plat_data->inv_sel_reg);
@@ -383,6 +389,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 {
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct device *m4udev = data->dev;
 	int ret;
 
 	if (!data)
@@ -390,12 +397,18 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 
 	/* Update the pgtable base address register of the M4U HW */
 	if (!data->m4u_dom) {
+		ret = pm_runtime_get_sync(m4udev);
+		if (ret < 0)
+			return ret;
 		ret = mtk_iommu_hw_init(data);
-		if (ret)
+		if (ret) {
+			pm_runtime_put(m4udev);
 			return ret;
+		}
 		data->m4u_dom = dom;
 		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
 		       data->base + REG_MMU_PT_BASE_ADDR);
+		pm_runtime_put(m4udev);
 	}
 
 	mtk_iommu_config(data, dev, true);
@@ -746,10 +759,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (dev->pm_domain) {
 		struct device_link *link;
 
+		pm_runtime_enable(dev);
+
 		link = device_link_add(data->smicomm_dev, dev,
 				       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
 		if (!link) {
 			dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
+			pm_runtime_disable(dev);
 			return -EINVAL;
 		}
 	}
@@ -779,8 +795,10 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 out_sysfs_remove:
 	iommu_device_sysfs_remove(&data->iommu);
 out_link_remove:
-	if (dev->pm_domain)
+	if (dev->pm_domain) {
 		device_link_remove(data->smicomm_dev, dev);
+		pm_runtime_disable(dev);
+	}
 	return ret;
 }
 
@@ -795,8 +813,10 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 		bus_set_iommu(&platform_bus_type, NULL);
 
 	clk_disable_unprepare(data->bclk);
-	if (pdev->dev.pm_domain)
+	if (pdev->dev.pm_domain) {
 		device_link_remove(data->smicomm_dev, &pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
 	return 0;
@@ -828,6 +848,9 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	void __iomem *base = data->base;
 	int ret;
 
+	/* Avoid first resume to affect the default value of registers below. */
+	if (!m4u_dom)
+		return 0;
 	ret = clk_prepare_enable(data->bclk);
 	if (ret) {
 		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
@@ -841,9 +864,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
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
