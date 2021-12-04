Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4525C433F5
	for <iommu@archiver.kernel.org>; Sat,  4 Dec 2021 15:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51BF8832C2;
	Sat,  4 Dec 2021 15:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J8rnAFkKqNvE; Sat,  4 Dec 2021 15:24:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E6FDB82CAC;
	Sat,  4 Dec 2021 15:24:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99E4EC006E;
	Sat,  4 Dec 2021 15:24:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 269FDC0012
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 15:24:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08B7E82F87
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 15:24:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sbcNL6gvD7un for <iommu@lists.linux-foundation.org>;
 Sat,  4 Dec 2021 15:24:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3ECD582CAC
 for <iommu@lists.linux-foundation.org>; Sat,  4 Dec 2021 15:24:45 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a00:c281:1409:4a00:6988:6ac4:851c:3f63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: dafna)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 14BE31F45C02;
 Sat,  4 Dec 2021 15:24:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
 t=1638631483; bh=H8N9l6Mnl7wSw3Je5KLmnGKYDyH1sMJryKMaYLsbsV4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OgiDW9mVSLkthGLSK+4bwSG829/yDcX9wj4K+eMdI6ExJeOYXGBTyhs/1ovr4/ETN
 1DcL7rqArlDUVFNnT4dl0WKKATfhyZ3dQqMToJC+a7TgO1N/nDdafoF94EuzEt6cZf
 9ADZDh9GSPDdlcxy5tL9NbAR8qPRfLsrAu3tVEtJ/eX2XO1g83HZiXgAU1jxOPvBJC
 ZJpc2K1Fb8F+1l4jOEAKX2nOgXGc0KKILfA2MGyH9jiG3ImayEEfMi5yWLm9DoEDcE
 wl/o+yCZyzTQ+9d5ARVm+CqYCG4gkrGYRtFv5taTH+G2gGjmWnsTcLr90D/EkHjlGs
 e4Aqij+/jjYqw==
From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/4] iommu/rockchip: remove redundant var dte_addr
Date: Sat,  4 Dec 2021 17:24:26 +0200
Message-Id: <20211204152428.13899-2-dafna.hirschfeld@collabora.com>
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

Using dte_addr as local var is redundant.
Instead acces rk_domain->dt[dte_index] directly.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/iommu/rockchip-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index bd22d0a6eaf0..bd73cf9c54f5 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -744,7 +744,7 @@ static void rk_iommu_zap_iova_first_last(struct rk_iommu_domain *rk_domain,
 static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 				  dma_addr_t iova)
 {
-	u32 *page_table, *dte_addr;
+	u32 *page_table;
 	u32 dte_index, dte;
 	phys_addr_t pt_phys;
 	dma_addr_t pt_dma;
@@ -752,8 +752,8 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	assert_spin_locked(&rk_domain->dt_lock);
 
 	dte_index = rk_iova_dte_index(iova);
-	dte_addr = &rk_domain->dt[dte_index];
-	dte = *dte_addr;
+	dte = rk_domain->dt[dte_index];
+
 	if (rk_dte_is_pt_valid(dte))
 		goto done;
 
@@ -769,7 +769,7 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
 	}
 
 	dte = rk_ops->mk_dtentries(pt_dma);
-	*dte_addr = dte;
+	rk_domain->dt[dte_index] = dte;
 
 	rk_table_flush(rk_domain,
 		       rk_domain->dt_dma + dte_index * sizeof(u32), 1);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
