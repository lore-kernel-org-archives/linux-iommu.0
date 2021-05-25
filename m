Return-Path: <SRS0=tLZ8=KU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E18C2B9F8
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 12:39:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 627D36141B
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 12:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 627D36141B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 337B140226;
	Tue, 25 May 2021 12:39:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7_YXf1FZGFpu; Tue, 25 May 2021 12:39:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 22E74400C6;
	Tue, 25 May 2021 12:39:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F19BDC000D;
	Tue, 25 May 2021 12:39:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5632CC0001
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 12:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4496B40264
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 12:39:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LH0PgWvLUOPl for <iommu@lists.linux-foundation.org>;
 Tue, 25 May 2021 12:39:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A44A4025E
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 12:39:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: benjamin.gaignard)
 with ESMTPSA id ED3081F4241D
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org, will@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
 xxm@rock-chips.com, robin.murphy@arm.com
Subject: [PATCH v7 4/4] iommu: rockchip: Add support for iommu v2
Date: Tue, 25 May 2021 14:38:52 +0200
Message-Id: <20210525123853.658267-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, kernel@collabora.com,
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

This second version of the hardware block has a different bits
mapping for page table entries.
Add the ops matching to this new mapping.
Define a new compatible to distinguish it from the first version.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
version 7:
 - Set dma_bit_mask field.
 - Add rk_dma_addr_dte_v2 function
 - Rebased on v5.13-rc3

version 5:
 - Use internal ops to support v2 hardware block
 - Use GENMASK macro.
 - Keep rk_dte_pt_address() and rk_dte_pt_address_v2() separated
   because I believe that is more readable like this.
 - Do not duplicate code.

 drivers/iommu/rockchip-iommu.c | 85 ++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index bd2cf7f08c71..16dd2bf4a859 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -189,6 +189,33 @@ static inline phys_addr_t rk_dte_pt_address(u32 dte)
 	return (phys_addr_t)dte & RK_DTE_PT_ADDRESS_MASK;
 }
 
+/*
+ * In v2:
+ * 31:12 - PT address bit 31:0
+ * 11: 8 - PT address bit 35:32
+ *  7: 4 - PT address bit 39:36
+ *  3: 1 - Reserved
+ *     0 - 1 if PT @ PT address is valid
+ */
+#define RK_DTE_PT_ADDRESS_MASK_V2 GENMASK_ULL(31, 4)
+#define DTE_HI_MASK1	GENMASK(11, 8)
+#define DTE_HI_MASK2	GENMASK(7, 4)
+#define DTE_HI_SHIFT1	24 /* shift bit 8 to bit 32 */
+#define DTE_HI_SHIFT2	32 /* shift bit 4 to bit 36 */
+#define PAGE_DESC_HI_MASK1	GENMASK_ULL(39, 36)
+#define PAGE_DESC_HI_MASK2	GENMASK_ULL(35, 32)
+
+static inline phys_addr_t rk_dte_pt_address_v2(u32 dte)
+{
+	u64 dte_v2 = dte;
+
+	dte_v2 = ((dte_v2 & DTE_HI_MASK2) << DTE_HI_SHIFT2) |
+		 ((dte_v2 & DTE_HI_MASK1) << DTE_HI_SHIFT1) |
+		 (dte_v2 & RK_DTE_PT_ADDRESS_MASK);
+
+	return (phys_addr_t)dte_v2;
+}
+
 static inline bool rk_dte_is_pt_valid(u32 dte)
 {
 	return dte & RK_DTE_PT_VALID;
@@ -199,6 +226,15 @@ static inline u32 rk_mk_dte(dma_addr_t pt_dma)
 	return (pt_dma & RK_DTE_PT_ADDRESS_MASK) | RK_DTE_PT_VALID;
 }
 
+static inline u32 rk_mk_dte_v2(dma_addr_t pt_dma)
+{
+	pt_dma = (pt_dma & RK_DTE_PT_ADDRESS_MASK) |
+		 ((pt_dma & PAGE_DESC_HI_MASK1) >> DTE_HI_SHIFT1) |
+		 (pt_dma & PAGE_DESC_HI_MASK2) >> DTE_HI_SHIFT2;
+
+	return (pt_dma & RK_DTE_PT_ADDRESS_MASK_V2) | RK_DTE_PT_VALID;
+}
+
 /*
  * Each PTE has a Page address, some flags and a valid bit:
  * +---------------------+---+-------+-+
@@ -240,6 +276,29 @@ static u32 rk_mk_pte(phys_addr_t page, int prot)
 	return page | flags | RK_PTE_PAGE_VALID;
 }
 
+/*
+ * In v2:
+ * 31:12 - Page address bit 31:0
+ *  11:9 - Page address bit 34:32
+ *   8:4 - Page address bit 39:35
+ *     3 - Security
+ *     2 - Readable
+ *     1 - Writable
+ *     0 - 1 if Page @ Page address is valid
+ */
+#define RK_PTE_PAGE_READABLE_V2      BIT(2)
+#define RK_PTE_PAGE_WRITABLE_V2      BIT(1)
+
+static u32 rk_mk_pte_v2(phys_addr_t page, int prot)
+{
+	u32 flags = 0;
+
+	flags |= (prot & IOMMU_READ) ? RK_PTE_PAGE_READABLE_V2 : 0;
+	flags |= (prot & IOMMU_WRITE) ? RK_PTE_PAGE_WRITABLE_V2 : 0;
+
+	return rk_mk_dte_v2(page) | flags;
+}
+
 static u32 rk_mk_pte_invalid(u32 pte)
 {
 	return pte & ~RK_PTE_PAGE_VALID;
@@ -485,6 +544,21 @@ static inline u32 rk_dma_addr_dte(dma_addr_t dt_dma)
 	return dt_dma;
 }
 
+#define DT_HI_MASK GENMASK_ULL(39, 32)
+#define DT_SHIFT   28
+
+static inline phys_addr_t rk_dte_addr_phys_v2(u32 addr)
+{
+	return (phys_addr_t)(addr & RK_DTE_PT_ADDRESS_MASK) |
+	       ((addr & DT_HI_MASK) << DT_SHIFT);
+}
+
+static inline u32 rk_dma_addr_dte_v2(dma_addr_t dt_dma)
+{
+	return (dt_dma & RK_DTE_PT_ADDRESS_MASK) |
+	       ((dt_dma & DT_HI_MASK) >> DT_SHIFT);
+}
+
 static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 {
 	void __iomem *base = iommu->bases[index];
@@ -1316,11 +1390,22 @@ static struct rk_iommu_ops iommu_data_ops_v1 = {
 	.dma_bit_mask = DMA_BIT_MASK(32),
 };
 
+static struct rk_iommu_ops iommu_data_ops_v2 = {
+	.pt_address = &rk_dte_pt_address_v2,
+	.mk_dtentries = &rk_mk_dte_v2,
+	.mk_ptentries = &rk_mk_pte_v2,
+	.dte_addr_phys = &rk_dte_addr_phys_v2,
+	.dma_addr_dte = &rk_dma_addr_dte_v2,
+	.dma_bit_mask = DMA_BIT_MASK(40),
+};
 
 static const struct of_device_id rk_iommu_dt_ids[] = {
 	{	.compatible = "rockchip,iommu",
 		.data = &iommu_data_ops_v1,
 	},
+	{	.compatible = "rockchip,rk3568-iommu",
+		.data = &iommu_data_ops_v2,
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
