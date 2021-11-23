Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958F7C433F5
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 10:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 312E280DDB;
	Tue, 23 Nov 2021 10:55:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r7xm0JB_kXn6; Tue, 23 Nov 2021 10:55:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A428880D83;
	Tue, 23 Nov 2021 10:55:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56FA6C001E;
	Tue, 23 Nov 2021 10:55:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C130CC0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 10:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A9B2A80DB1
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 10:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zaeeYMghz7hz for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 10:55:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0700280D83
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 10:55:39 +0000 (UTC)
Received: from cap.home.8bytes.org (p549adbee.dip0.t-ipconnect.de
 [84.154.219.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id F1939DB4;
 Tue, 23 Nov 2021 11:55:34 +0100 (CET)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/2] iommu/amd: Clarify AMD IOMMUv2 initialization messages
Date: Tue, 23 Nov 2021 11:55:07 +0100
Message-Id: <20211123105507.7654-3-joro@8bytes.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123105507.7654-1-joro@8bytes.org>
References: <20211123105507.7654-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: Joerg Roedel <jroedel@suse.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

The messages printed on the initialization of the AMD IOMMUv2 driver
have caused some confusion in the past. Clarify the messages to lower
the confusion in the future.

Cc: stable@vger.kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu_v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 13cbeb997cc1..58da08cc3d01 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -929,10 +929,8 @@ static int __init amd_iommu_v2_init(void)
 {
 	int ret;
 
-	pr_info("AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>\n");
-
 	if (!amd_iommu_v2_supported()) {
-		pr_info("AMD IOMMUv2 functionality not available on this system\n");
+		pr_info("AMD IOMMUv2 functionality not available on this system - This is not a bug.\n");
 		/*
 		 * Load anyway to provide the symbols to other modules
 		 * which may use AMD IOMMUv2 optionally.
@@ -947,6 +945,8 @@ static int __init amd_iommu_v2_init(void)
 
 	amd_iommu_register_ppr_notifier(&ppr_nb);
 
+	pr_info("AMD IOMMUv2 loaded and initialized\n");
+
 	return 0;
 
 out:
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
