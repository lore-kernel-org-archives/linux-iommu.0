Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9BBC433FE
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 22:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEC724011B;
	Mon,  7 Feb 2022 22:48:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oOZ7RQ9Y434k; Mon,  7 Feb 2022 22:48:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D130740131;
	Mon,  7 Feb 2022 22:48:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0760C0011;
	Mon,  7 Feb 2022 22:48:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 235D2C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 22:48:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA8FF40131
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 22:48:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JkI8gOtEBPP4 for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 22:48:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr
 [80.12.242.132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D63DA4011B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 22:47:59 +0000 (UTC)
Received: from pop-os.home ([90.126.236.122]) by smtp.orange.fr with ESMTPA
 id HCncnIqRubnFGHCncnWXsD; Mon, 07 Feb 2022 23:47:57 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 07 Feb 2022 23:47:57 +0100
X-ME-IP: 90.126.236.122
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 2/2] iommu/arm-smmu-v3: Simplify memory allocation
Date: Mon,  7 Feb 2022 23:47:55 +0100
Message-Id: <598bd905103dcbe5653a54bb0dfb5a8597728214.1644274051.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <3f7b9b202c6b6f5edc234ab7af5f208fbf8bc944.1644274051.git.christophe.jaillet@wanadoo.fr>
References: <3f7b9b202c6b6f5edc234ab7af5f208fbf8bc944.1644274051.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 iommu@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Use devm_bitmap_zalloc() instead of hand writing it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is NOT compile tested.
I don't have the needed cross compiling tools.

v2: - remove the dev_err() message
    - remove the 'bitmap' variable
    - update the error handling path to be more future proof and return
      an explicit 0 in the success path
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 +++++----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 14d06aad0726..bbc4eeb42811 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2911,32 +2911,20 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static void arm_smmu_cmdq_free_bitmap(void *data)
-{
-	unsigned long *bitmap = data;
-	bitmap_free(bitmap);
-}
-
 static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 {
-	int ret = 0;
 	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
-	atomic_long_t *bitmap;
 
 	atomic_set(&cmdq->owner_prod, 0);
 	atomic_set(&cmdq->lock, 0);
 
-	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
-	if (!bitmap) {
-		dev_err(smmu->dev, "failed to allocate cmdq bitmap\n");
-		ret = -ENOMEM;
-	} else {
-		cmdq->valid_map = bitmap;
-		devm_add_action(smmu->dev, arm_smmu_cmdq_free_bitmap, bitmap);
-	}
+	cmdq->valid_map = (atomic_long_t *)devm_bitmap_zalloc(smmu->dev, nents,
+							      GFP_KERNEL);
+	if (!cmdq->valid_map)
+		return -ENOMEM;
 
-	return ret;
+	return 0;
 }
 
 static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
