Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11323C433E1
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 23:41:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EB7207D8
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 23:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EB7207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 60B8087D0F;
	Thu, 18 Jun 2020 23:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zi3-yD8RPKZQ; Thu, 18 Jun 2020 23:41:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0335B87D08;
	Thu, 18 Jun 2020 23:41:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF634C088C;
	Thu, 18 Jun 2020 23:41:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FDE8C016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 23:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2BAA387D0A
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 23:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2OjHc2MSOTOE for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 23:41:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0FF6287D08
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 23:41:01 +0000 (UTC)
IronPort-SDR: +uCFvl3VTxBLJdnN91QShB+xG9Abzw4tU7ETIe9O8uw51VT/aGJ9V8zQ+BVB3WTLHSBg2biG4B
 F7UK+2X0VF1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="141075358"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; d="scan'208";a="141075358"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 16:41:00 -0700
IronPort-SDR: I0qU0iqtU7izjgw61vjOgd73oVqxTlEZTgba5DL+6SDxcPU/Rc4b6Mc6wMBpigTWgrWZwYsjg8
 M6qEHV9IC6Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; d="scan'208";a="383673934"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2020 16:40:59 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Fix misuse of iommu_domain_identity_map()
Date: Fri, 19 Jun 2020 07:36:50 +0800
Message-Id: <20200618233650.9214-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>,
 linux-kernel@vger.kernel.org
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

The iommu_domain_identity_map() helper takes start/end PFN as arguments.
Fix a misuse case where the start and end addresses are passed.

Fixes: e70b081c6f376 ("iommu/vt-d: Remove IOVA handling code from the non-dma_ops path")
Cc: Tom Murphy <murphyt7@tcd.ie>
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f16bf63ea9fd..d759e7234e98 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2701,7 +2701,9 @@ static int __init si_domain_init(int hw)
 				    end >> agaw_to_width(si_domain->agaw)))
 				continue;
 
-			ret = iommu_domain_identity_map(si_domain, start, end);
+			ret = iommu_domain_identity_map(si_domain,
+					mm_to_dma_pfn(start >> PAGE_SHIFT),
+					mm_to_dma_pfn(end >> PAGE_SHIFT));
 			if (ret)
 				return ret;
 		}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
