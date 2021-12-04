Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8514DC4332F
	for <iommu@archiver.kernel.org>; Sat,  4 Dec 2021 15:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BEC983268;
	Sat,  4 Dec 2021 15:24:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vl4Q2Dd7GzQD; Sat,  4 Dec 2021 15:24:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3C7DC831F8;
	Sat,  4 Dec 2021 15:24:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B7C9C0071;
	Sat,  4 Dec 2021 15:24:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4572DC0012
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 15:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 409FF40392
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 15:24:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (bad RSA signature)"
 header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fBMeMVEkZ6yO for <iommu@lists.linux-foundation.org>;
 Sat,  4 Dec 2021 15:24:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8585440110
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a00:c281:1409:4a00:6988:6ac4:851c:3f63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 460EA1F45C18;
 Sat,  4 Dec 2021 15:24:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638631486; bh=TJgzJWHgw20tjqwBYUENEs/cvyV4mlypJvEi9jBKaRA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e067vp0TClN94lPv74YYkPxc3aJT8AuIVEJcLUyrKR3Uo2YPLVtDyr/L3fwFknt4D
 AeqlioS5PIbkAAhpQ7mKZbUMc26C1r9PUxQnqsAvUX67T2zoKO9lcsgWdc4PFaja28
 75VlAx2/R0Z9Tg3s9wHv7eNCVtDoGtM8Ill7VlDnzlkAB3EFB5rUUZjAj8s+lMXHM/
 5/ovMpVlhmIPIT9HyKBSWmNLtyV6Oo5e4EWjSSTCw2oPVjQpFkEAzZidZT5X8utAy2
 WB1yZN6kQxBY3uZwgGmug84KoEN49gkPdMIDu6kjThfc+1N3bV5b9Q5ShQpRs/Rpx8
 zZ93RcUzgB+ow==
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 4/4] iommu/rockchip: replace pt_address cb with dma_addr_dte
 when setting dt addr
Date: Sat,  4 Dec 2021 17:24:28 +0200
Message-Id: <20211204152428.13899-4-dafna.hirschfeld@collabora.com>
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

The dt address is calculated using the dma_addr_dte cb.
So when setting the dt address to the DTE_ADDR_DUMMY
that cb should be used instead of pt_address.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/iommu/rockchip-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ba60f0faafcc..013f7608a2e6 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -510,7 +510,7 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 	 * and verifying that upper 5 nybbles are read back.
 	 */
 	for (i = 0; i < iommu->num_mmu; i++) {
-		dte_addr = rk_ops->pt_address(DTE_ADDR_DUMMY);
+		dte_addr = rk_ops->dma_addr_dte(DTE_ADDR_DUMMY);
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR, dte_addr);
 
 		if (dte_addr != rk_iommu_read(iommu->bases[i], RK_MMU_DTE_ADDR)) {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
