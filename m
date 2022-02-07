Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7922AC433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 06:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D7EC8145E;
	Mon,  7 Feb 2022 06:43:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GFgAtEK4nAOR; Mon,  7 Feb 2022 06:43:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 06C158145B;
	Mon,  7 Feb 2022 06:43:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6F71C0011;
	Mon,  7 Feb 2022 06:43:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67AD8C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 515D840240
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wgEKHK_6Y4Gv for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:43:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98AF84023F
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644216189; x=1675752189;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OKL1r6Isxh5NwGJDUX9vHjv6BhHF7fJWfzI6cLdyIuo=;
 b=Ns8YtUQkUoewgi1dZFfvJskI/hOvEhMre5MdBRFI6JHUYlx3SFrqVriG
 3LyJPby19M2Nepyclf7PaAfVg8BppK2Ylty4tnSL2PQnMt3usEh4qhfvU
 n/CufrdZuVxbI7c9XA4X+yu0B3U0jll5pF2NFqnsi4nRloydp+gBNqsAp
 gMQAwzgN16/RJt0Bva5xQeNmnnq4tUAysdi+163m4emjvDQa6NTsJULMw
 g7AbTsDv1b5TSgfXl32+7KifZhWidltfta3rcG0bTOk7Gf/Y7WBP9x1Wt
 5LoO7iyN8tR30I4oOdQ4k51V5rsX2lOPYpW3dMCmsfEJcy3BGR6SsntSc g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="228622930"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="228622930"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2022 22:43:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="525020221"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:43:06 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v1 03/10] iommu/vt-d: Remove finding domain in
 dmar_insert_one_dev_info()
Date: Mon,  7 Feb 2022 14:41:35 +0800
Message-Id: <20220207064142.1092846-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
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

The Intel IOMMU driver has already converted to use default domain
framework in iommu core. There's no need to find a domain for the
device in the domain attaching path. Cleanup that code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 438da5da301d..583ec0fa4ac1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2521,7 +2521,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 						    struct device *dev,
 						    struct dmar_domain *domain)
 {
-	struct dmar_domain *found = NULL;
 	struct device_domain_info *info;
 	unsigned long flags;
 	int ret;
@@ -2572,26 +2571,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	}
 
 	spin_lock_irqsave(&device_domain_lock, flags);
-	if (dev)
-		found = find_domain(dev);
-
-	if (!found) {
-		struct device_domain_info *info2;
-		info2 = dmar_search_domain_by_dev_info(info->segment, info->bus,
-						       info->devfn);
-		if (info2) {
-			found      = info2->domain;
-			info2->dev = dev;
-		}
-	}
-
-	if (found) {
-		spin_unlock_irqrestore(&device_domain_lock, flags);
-		free_devinfo_mem(info);
-		/* Caller must free the original domain */
-		return found;
-	}
-
 	spin_lock(&iommu->lock);
 	ret = domain_attach_iommu(domain, iommu);
 	spin_unlock(&iommu->lock);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
