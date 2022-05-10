Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FE4C433EF
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 02:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E15D80DD1;
	Tue, 10 May 2022 02:37:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OO8SdSLjONfh; Tue, 10 May 2022 02:37:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5C927812B1;
	Tue, 10 May 2022 02:37:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20807C0039;
	Tue, 10 May 2022 02:37:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24DF1C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2174C40201
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nS-BoMR-aHzo for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:37:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 615034002B
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652150233; x=1683686233;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TurO++ArSPwtRSlnD+UqnnGzZwZyKgvoPtQmvAWuBnM=;
 b=ji4/QgaaWJN451eRfpkWPRgwkbsYNo/PQyLkx+Yh+JVWR2bRPPjfUSIo
 GGSLQHf4cmFpt8qjzMt671XIrvzhsr7YuG4TiITUyBkU/etMZhSg20ES/
 ewZOFjXWHKW/h+MjOejicyPuwB/1NL6a2MsYy32Vrs18oayCW2Nd2l+ct
 tcpEFySKZVG5sVAPwOr9NR9TmDEKLihBpXGKt/0JUTSU0T5FA26LD+LtX
 zT6+OzVSgZG1XPMKJNZ6HMnnqYzGSUgjR39ETDBPDyK2AoXZE+W9Utg0x
 YjGAGCmV/ZDaLCCkI6mCvENvdGSg3zVcV9DvoJJY/9aMMaIt2osnRZrD7 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266825959"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="266825959"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 19:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="519523430"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga003.jf.intel.com with ESMTP; 09 May 2022 19:37:10 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/8] iommu/vt-d: Remove unneeded validity check on dev
Date: Tue, 10 May 2022 10:34:00 +0800
Message-Id: <20220510023407.2759143-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510023407.2759143-1-baolu.lu@linux.intel.com>
References: <20220510023407.2759143-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@lst.de>
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

From: Muhammad Usama Anjum <usama.anjum@collabora.com>

dev_iommu_priv_get() is being used at the top of this function which
dereferences dev. Dev cannot be NULL after this. Remove the validity
check on dev and simplify the code.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/r/20220313150337.593650-1-usama.anjum@collabora.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2990f80c5e08..626c2927344f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2522,7 +2522,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		}
 	}
 
-	if (dev && domain_context_mapping(domain, dev)) {
+	if (domain_context_mapping(domain, dev)) {
 		dev_err(dev, "Domain context map failed\n");
 		dmar_remove_one_dev_info(dev);
 		return NULL;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
