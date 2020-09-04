Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84D5C43461
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 11:39:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54D42073B
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 11:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54D42073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 98A2A86CBA;
	Fri,  4 Sep 2020 11:39:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9lo+B6oSwNMZ; Fri,  4 Sep 2020 11:39:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B300886B80;
	Fri,  4 Sep 2020 11:39:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3FA9C0890;
	Fri,  4 Sep 2020 11:39:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34827C0052
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 11:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 14FCD272AB
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 11:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Vuwq-7A4o89 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 11:39:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 01BC3228A0
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 11:39:09 +0000 (UTC)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de
 [84.154.221.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id DDBCD249;
 Fri,  4 Sep 2020 13:39:07 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/sun50i: Fix set-but-not-used variable warning
Date: Fri,  4 Sep 2020 13:39:06 +0200
Message-Id: <20200904113906.3906-1-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: Joerg Roedel <jroedel@suse.de>, kernel test robot <lkp@intel.com>,
 iommu@lists.linux-foundation.org, Maxime Ripard <mripard@kernel.org>,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
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

From: Joerg Roedel <jroedel@suse.de>

Fix the following warning the the SUN50I driver:

   drivers/iommu/sun50i-iommu.c: In function 'sun50i_iommu_irq':
   drivers/iommu/sun50i-iommu.c:890:14: warning: variable 'iova' set but not used [-Wunused-but-set-variable]
     890 |  phys_addr_t iova;
         |              ^~~~

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/sun50i-iommu.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 3b1bf2fb94f5..ea6db1341916 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -881,7 +881,6 @@ static phys_addr_t sun50i_iommu_handle_perm_irq(struct sun50i_iommu *iommu)
 static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 {
 	struct sun50i_iommu *iommu = dev_id;
-	phys_addr_t iova;
 	u32 status;
 
 	spin_lock(&iommu->iommu_lock);
@@ -893,15 +892,15 @@ static irqreturn_t sun50i_iommu_irq(int irq, void *dev_id)
 	}
 
 	if (status & IOMMU_INT_INVALID_L2PG)
-		iova = sun50i_iommu_handle_pt_irq(iommu,
-						  IOMMU_INT_ERR_ADDR_L2_REG,
-						  IOMMU_L2PG_INT_REG);
+		sun50i_iommu_handle_pt_irq(iommu,
+					    IOMMU_INT_ERR_ADDR_L2_REG,
+					    IOMMU_L2PG_INT_REG);
 	else if (status & IOMMU_INT_INVALID_L1PG)
-		iova = sun50i_iommu_handle_pt_irq(iommu,
-						  IOMMU_INT_ERR_ADDR_L1_REG,
-						  IOMMU_L1PG_INT_REG);
+		sun50i_iommu_handle_pt_irq(iommu,
+					   IOMMU_INT_ERR_ADDR_L1_REG,
+					   IOMMU_L1PG_INT_REG);
 	else
-		iova = sun50i_iommu_handle_perm_irq(iommu);
+		sun50i_iommu_handle_perm_irq(iommu);
 
 	iommu_write(iommu, IOMMU_INT_CLR_REG, status);
 
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
