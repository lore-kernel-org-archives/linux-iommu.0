Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBCBC433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Feb 2022 20:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F896813C8;
	Fri,  4 Feb 2022 20:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BladmvrdjbH8; Fri,  4 Feb 2022 20:16:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E60DC812C8;
	Fri,  4 Feb 2022 20:16:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5C3DC001A;
	Fri,  4 Feb 2022 20:16:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABEF6C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 20:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A24A760B35
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 20:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EiHEb1H8-53I for <iommu@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 20:16:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id C670A60AAE
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 20:16:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB84911D4;
 Fri,  4 Feb 2022 12:16:46 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AFA843F718;
 Fri,  4 Feb 2022 12:16:45 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH] iommu/msm: Use standard driver registration
Date: Fri,  4 Feb 2022 20:16:40 +0000
Message-Id: <05ca5e1b29bdd350f4e20b9ceb031a2c281e23d2.1644005728.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, Andy Gross <agross@kernel.org>,
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

It's been a long time since there was any reason to register IOMMU
drivers early. Convert to the standard platform driver helper.

CC: Andy Gross <agross@kernel.org>
CC: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/msm_iommu.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3a38352b603f..06bde6b66732 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -831,16 +831,4 @@ static struct platform_driver msm_iommu_driver = {
 	.probe		= msm_iommu_probe,
 	.remove		= msm_iommu_remove,
 };
-
-static int __init msm_iommu_driver_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&msm_iommu_driver);
-	if (ret != 0)
-		pr_err("Failed to register IOMMU driver\n");
-
-	return ret;
-}
-subsys_initcall(msm_iommu_driver_init);
-
+builtin_platform_driver(msm_iommu_driver);
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
