Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7826DC433E1
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 14:04:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577DF20739
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 14:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577DF20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 04393261E5;
	Tue, 16 Jun 2020 14:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QO79srAa8HpA; Tue, 16 Jun 2020 14:04:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 16AB420417;
	Tue, 16 Jun 2020 14:04:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3C9DC08A0;
	Tue, 16 Jun 2020 14:04:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75A54C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 14:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 534A3261E4
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 14:04:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MK+JIyrwb0y8 for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 14:04:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by silver.osuosl.org (Postfix) with ESMTPS id 67C43261DF
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 14:04:06 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A527A8CCF87222C63618;
 Tue, 16 Jun 2020 22:03:57 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 22:03:51 +0800
From: John Garry <john.garry@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v2 1/4] iommu/arm-smmu-v3: Fix trivial typo
Date: Tue, 16 Jun 2020 21:59:50 +0800
Message-ID: <1592315993-164290-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1592315993-164290-1-git-send-email-john.garry@huawei.com>
References: <1592315993-164290-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: trivial@kernel.org, maz@kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

Set "cmq" -> "cmdq".

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f578677a5c41..a8e814c652fe 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1479,7 +1479,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		}
 
 		/*
-		 * Try to unlock the cmq lock. This will fail if we're the last
+		 * Try to unlock the cmdq lock. This will fail if we're the last
 		 * reader, in which case we can safely update cmdq->q.llq.cons
 		 */
 		if (!arm_smmu_cmdq_shared_tryunlock(cmdq)) {
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
