Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1B5C433FE
	for <iommu@archiver.kernel.org>; Sat,  4 Dec 2021 15:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB2C682F87;
	Sat,  4 Dec 2021 15:24:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vj9gZ6FHYmaI; Sat,  4 Dec 2021 15:24:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7EB3F833A8;
	Sat,  4 Dec 2021 15:24:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49024C0072;
	Sat,  4 Dec 2021 15:24:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69A27C0012
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 15:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 492C082CAC
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 15:24:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pwj9y55Q3XEw for <iommu@lists.linux-foundation.org>;
 Sat,  4 Dec 2021 15:24:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B1F2682F4A
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a00:c281:1409:4a00:6988:6ac4:851c:3f63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 307051F45C0C;
 Sat,  4 Dec 2021 15:24:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638631485; bh=9ICs/y4HUDZ5NV8MZBtkV53PWQ6+UIINUtCdzKskXtw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=S4+QEALCIB7I8isBb8M+sZZTnmXTzAEHomEidsXLEP7XLjEkZVVeHjIEFa2ki6zRC
 hRajHtxBZJ8ON4fKVx/IW7W8vayTMySQO5nfl1Q4J0/HJoH3zurAE/aRZrf+KSG+jn
 KUIFloASV69am+tAedU114mhAu4PpaEqpVoxByO3hAk4vdKbLiT0MS5Jq6tNtcSdF0
 h2E7h/cI3vN4g/XGN2vFHbxbIAONMYIeSCZEpNPu6YszHXlzG3THlu5mBqIQFd1OeC
 9eqmmabmZZMOEB+JqhBsQ6VdWPacG7MpQSo7IxvzlWn2ZED4v567A+KBr+i1feMKtk
 PQ42R1SZFtZmA==
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 3/4] iommu/rockchip: rename dte_index to dte
Date: Sat,  4 Dec 2021 17:24:27 +0200
Message-Id: <20211204152428.13899-3-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211204152428.13899-1-dafna.hirschfeld@collabora.com>
References: <20211204152428.13899-1-dafna.hirschfeld@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 kernel@collabora.com, Will Deacon <will@kernel.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

In rk_iommu_map, the var dte_index is actually
set to the dte and not to the dte index. Rename it.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/iommu/rockchip-iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index bd73cf9c54f5..ba60f0faafcc 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -852,7 +852,7 @@ static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
 	unsigned long flags;
 	dma_addr_t pte_dma, iova = (dma_addr_t)_iova;
 	u32 *page_table, *pte_addr;
-	u32 dte_index, pte_index;
+	u32 dte, pte_index;
 	int ret;
 
 	spin_lock_irqsave(&rk_domain->dt_lock, flags);
@@ -870,11 +870,11 @@ static int rk_iommu_map(struct iommu_domain *domain, unsigned long _iova,
 		return PTR_ERR(page_table);
 	}
 
-	dte_index = rk_domain->dt[rk_iova_dte_index(iova)];
+	dte = rk_domain->dt[rk_iova_dte_index(iova)];
 	pte_index = rk_iova_pte_index(iova);
 	pte_addr = &page_table[pte_index];
 
-	pte_dma = rk_ops->pt_address(dte_index) + pte_index * sizeof(u32);
+	pte_dma = rk_ops->pt_address(dte) + pte_index * sizeof(u32);
 	ret = rk_iommu_map_iova(rk_domain, pte_addr, pte_dma, iova,
 				paddr, size, prot);
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
