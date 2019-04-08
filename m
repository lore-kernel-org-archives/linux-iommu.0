Return-Path: <SRS0=6I1K=SK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4083C10F13
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 12:41:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BC2214C6
	for <iommu@archiver.kernel.org>; Mon,  8 Apr 2019 12:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BC2214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 68166EEE;
	Mon,  8 Apr 2019 12:41:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 68455EED
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 12:41:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 6AB7863D
	for <iommu@lists.linux-foundation.org>;
	Mon,  8 Apr 2019 12:41:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DCFD15BF;
	Mon,  8 Apr 2019 05:41:54 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 20CBA3F68F; 
	Mon,  8 Apr 2019 05:41:52 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Subject: [PATCH] iommu: Fix offsetof() usage
Date: Mon,  8 Apr 2019 13:41:47 +0100
Message-Id:
 <85778a4619eab832eb0b003a68f377aea9d97b22.1554727307.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, David Laight <David.Laight@ACULAB.COM>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190408124147.r_7sxGOX1S0FnW5cf3tKYlfU9N4gZRr7XhL3yXED7L4@z>

David rightly points out that, although GCC lets us get away with it,
using offsetof() with a non-constant member designator is not compliant
with the C standard. I'm responsible for a couple of those misuses, but
both in circumstances for which we now have a specific helper, so we can
use that to put things straight.

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 3 +--
 drivers/iommu/iommu.c    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 74e944bd4a8d..81d449451494 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1484,8 +1484,7 @@ static int arm_smmu_add_device(struct device *dev)
 	}
 
 	ret = -ENOMEM;
-	cfg = kzalloc(offsetof(struct arm_smmu_master_cfg, smendx[i]),
-		      GFP_KERNEL);
+	cfg = kzalloc(struct_size(cfg, smendx, i), GFP_KERNEL);
 	if (!cfg)
 		goto out_free;
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 33a982e33716..ad28919e1452 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2021,7 +2021,7 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	if (!fwspec)
 		return -EINVAL;
 
-	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
+	size = struct_size(fwspec, ids, fwspec->num_ids + num_ids);
 	if (size > sizeof(*fwspec)) {
 		fwspec = krealloc(fwspec, size, GFP_KERNEL);
 		if (!fwspec)
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
