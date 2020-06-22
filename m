Return-Path: <SRS0=gLCG=AD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A51C433E0
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 23:18:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B5420738
	for <iommu@archiver.kernel.org>; Mon, 22 Jun 2020 23:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B5420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E886A8890A;
	Mon, 22 Jun 2020 23:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KaA03uMXNzCE; Mon, 22 Jun 2020 23:18:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0D9AA88A0E;
	Mon, 22 Jun 2020 23:18:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED748C0891;
	Mon, 22 Jun 2020 23:18:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA439C016F
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:18:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A2306262A6
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:18:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DgDkC9TB1rQ0 for <iommu@lists.linux-foundation.org>;
 Mon, 22 Jun 2020 23:18:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 4B2C422643
 for <iommu@lists.linux-foundation.org>; Mon, 22 Jun 2020 23:18:09 +0000 (UTC)
IronPort-SDR: fIfoOItCE55GY0ZKps/SK830VZhfrG/Oi/0SB966prFDHPXScWXlqQY9/lSDwaMNdAFMphN7Lw
 80gEKGZz2aFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="161982988"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="161982988"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 16:18:09 -0700
IronPort-SDR: 21ckAbzaXVQ2NVNeFJF8J8EkonangRlqcj6/AdU2iyyIk3NNvghrE+AuhfUjlzcJo/DVMgq9kD
 qNAn4DlSmQjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; d="scan'208";a="301006552"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 22 Jun 2020 16:18:07 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 6/6] iommu/vt-d: Fix misuse of iommu_domain_identity_map()
Date: Tue, 23 Jun 2020 07:13:45 +0800
Message-Id: <20200622231345.29722-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622231345.29722-1-baolu.lu@linux.intel.com>
References: <20200622231345.29722-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>
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
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
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
