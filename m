Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F07CC433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 14:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB0A140274;
	Mon,  7 Feb 2022 14:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jqVFSM9uhwI3; Mon,  7 Feb 2022 14:14:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CAC3A40266;
	Mon,  7 Feb 2022 14:14:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0A32C0011;
	Mon,  7 Feb 2022 14:14:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 995EEC000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 14:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 867C981336
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 14:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8InjjnebBTqs for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 14:14:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2A8A81332
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644243251; x=1675779251;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=X/LK6sULWZKDmHlbv9YKIUivTejDy195l3r0gIsqar4=;
 b=O8j+zxmm19WYJTeL2stTgD3dI9cTT7ZqZkABvOGNBBVfsGufpahxl2U9
 hWqo/UwHnbbk37dTvW1mKETXyUJl80yCUjHEppMpRj+i7xviJ0Wseji1x
 agFbr/SPngbb3ORdgRUXqGS9ZpV1YbK7n9wJFxLSsAjRCwsffXtmY9kBx
 8vNeSed3JPd3VKiQC6sU3+5tHrTIC7Ie5Jqfd8Yg2UdO6u539UidR1egy
 W/VexMwxvrIMnNoEHIimhkFTT0+arg/z0lLoHOOepkMeIbh6jNUIiQQue
 LNpOiuWawaXqwaIgZcjbbADuVwbr34yVEp/7OmcZWJ+jVGzee+xYcmZtN w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="312021767"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="312021767"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 06:13:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="700477351"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga005.jf.intel.com with ESMTP; 07 Feb 2022 06:13:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id B406A31D; Mon,  7 Feb 2022 16:13:22 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] iommu/dma: Use DMA ops setter instead of direct
 assignment
Date: Mon,  7 Feb 2022 16:13:21 +0200
Message-Id: <20220207141321.8293-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Will Deacon <will@kernel.org>
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

Use DMA ops setter instead of direct assignment. Even we know that
this module doesn't perform access to the dma_ops member of struct device,
it's better to use setter to avoid potential problems in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: rebased on top of the latest codebase
 drivers/iommu/dma-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d85d54f2b549..b585a3fdbc56 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1482,7 +1482,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	if (iommu_is_dma_domain(domain)) {
 		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
 			goto out_err;
-		dev->dma_ops = &iommu_dma_ops;
+		set_dma_ops(dev, &iommu_dma_ops);
 	}
 
 	return;
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
