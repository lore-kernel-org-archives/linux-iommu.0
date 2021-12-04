Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3EAC433EF
	for <iommu@archiver.kernel.org>; Sat,  4 Dec 2021 15:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DD2E60807;
	Sat,  4 Dec 2021 15:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lnoT0afwXEgF; Sat,  4 Dec 2021 15:24:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 71C1260650;
	Sat,  4 Dec 2021 15:24:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4975C0073;
	Sat,  4 Dec 2021 15:24:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F68CC0012
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 15:24:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F93740392
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 15:24:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (bad RSA signature)"
 header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Orv0rfeVUtRa for <iommu@lists.linux-foundation.org>;
 Sat,  4 Dec 2021 15:24:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F1E140110
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a00:c281:1409:4a00:6988:6ac4:851c:3f63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DD8B01F45BF3;
 Sat,  4 Dec 2021 15:24:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638631481; bh=1E+wYaMVZBLQy1MDTb6xEPfgm8aPG7uh2L3Go1Tg6oI=;
 h=From:To:Cc:Subject:Date:From;
 b=Tx+RJ08t1neArUXh2vBRPECZ1q2onTyXQrBcW7IiTAAHIGfE2FhTPvWPyIF4gEWl2
 g8RxGzGwOFpegsuE1s4hfSAD3NjKZ6C5uQLAdJTEb7pYHJsecj0hwRkFPnooE5/LCR
 PKHDhZ5QCW0co94RMSGORYs69+LTL/B8gBqzKhLECZjfdl7VFqNiUdybyYU7rnIUKV
 5UJ6sxz1m1trs3GVRlTZk2dRhe/XlP2DrjhKzpMIukvRVJ14skngYAzrdYfMicu+9k
 pcRXpR74sFBARdk9kpIYlilOnNa2L0vsCcTAFX2evBE0BgwSqGp/1UgLrDZA+hZUTB
 GUf+CcVfCEowA==
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/4] iommu/rockchip: replace 4 with sizeof(u32)
Date: Sat,  4 Dec 2021 17:24:25 +0200
Message-Id: <20211204152428.13899-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
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

In log_iova, multiply by 4 is used to calculate the
addresses. In other places in this driver, sizeof(u3)
is used. So replace 4 with sizeof(u32) for consistency

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/iommu/rockchip-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 5cb260820eda..bd22d0a6eaf0 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -580,14 +580,14 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
 	mmu_dte_addr_phys = rk_ops->dte_addr_phys(mmu_dte_addr);
 
-	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
+	dte_addr_phys = mmu_dte_addr_phys + sizeof(u32) * dte_index;
 	dte_addr = phys_to_virt(dte_addr_phys);
 	dte = *dte_addr;
 
 	if (!rk_dte_is_pt_valid(dte))
 		goto print_it;
 
-	pte_addr_phys = rk_ops->pt_address(dte) + (pte_index * 4);
+	pte_addr_phys = rk_ops->pt_address(dte) + pte_index * sizeof(u32);
 	pte_addr = phys_to_virt(pte_addr_phys);
 	pte = *pte_addr;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
