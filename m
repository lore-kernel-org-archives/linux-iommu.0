Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79B6C49361
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 11:46:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F060611AC
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 11:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F060611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38A6E83981;
	Fri, 18 Jun 2021 11:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MASK6moZjJ9X; Fri, 18 Jun 2021 11:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E76183942;
	Fri, 18 Jun 2021 11:46:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6851C000D;
	Fri, 18 Jun 2021 11:46:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 276FAC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 11:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2347583942
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 11:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gb52YW59ArRQ for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 11:46:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8C208394A
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a01:e0a:4cb:a870:141f:c87a:873e:7b6f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: benjamin.gaignard)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 39D9B1F40891;
 Fri, 18 Jun 2021 12:46:23 +0100 (BST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: will@kernel.org, robh+dt@kernel.org, heiko@sntech.de, xxm@rock-chips.com,
 robin.murphy@arm.com, joro@8bytes.org, dan.carpenter@oracle.com
Subject: [PATCH] iommu: rockchip: Fix physical address decoding
Date: Fri, 18 Jun 2021 13:46:15 +0200
Message-Id: <20210618114615.443961-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 kernel@collabora.com, Benjamin Gaignard <benjamin.gaignard@collabora.com>,
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

Restore bits 39 to 32 at correct position.
It reverses the operation done in rk_dma_addr_dte_v2().

Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/iommu/rockchip-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 94b9d8e5b9a40..e55482a477080 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -544,12 +544,13 @@ static inline u32 rk_dma_addr_dte(dma_addr_t dt_dma)
 }
 
 #define DT_HI_MASK GENMASK_ULL(39, 32)
+#define DTE_BASE_HI_MASK GENMASK(11, 4)
 #define DT_SHIFT   28
 
 static inline phys_addr_t rk_dte_addr_phys_v2(u32 addr)
 {
 	return (phys_addr_t)(addr & RK_DTE_PT_ADDRESS_MASK) |
-	       ((addr & DT_HI_MASK) << DT_SHIFT);
+	       ((addr & DTE_BASE_HI_MASK) << DT_SHIFT);
 }
 
 static inline u32 rk_dma_addr_dte_v2(dma_addr_t dt_dma)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
