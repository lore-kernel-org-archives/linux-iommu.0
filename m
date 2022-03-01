Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649C9C433F5
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 02:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06F3B80C58;
	Tue,  1 Mar 2022 02:03:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ccTtJgL3Ch55; Tue,  1 Mar 2022 02:03:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E23A180C15;
	Tue,  1 Mar 2022 02:03:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC38CC0078;
	Tue,  1 Mar 2022 02:03:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6895C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5A5F80C52
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XNti4EgMkWNA for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 02:03:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCDC580C38
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646100225; x=1677636225;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w80dCvEHh6ThBRA0Iy5eUqYQ1TWwi0SZXWCYDblCDG8=;
 b=Q4Im9NQz52Lj5+iui3VLJOY13x03/blIOGBL5bMPRK8Ic2uaksdoDeXH
 LL9sKFIhbkTyaRlANDD/FbQ9HIl3tvxdBKoCx3eOX5TcGqtKpOu64L3MO
 ad0rc3ec5rXWFI0NiEWxhDg0RErA7uSvihuGMcjjJuuPDsXtsLrbK3n1b
 IMx/krpCJNy0Bb6b3VTTgnG/sqllCPRdB6UplQACbxRgBhZF6MJkfRiBF
 /eEyPdc6k0DwFSM5K2wUSLoc8NqDLM5FdG/bsHUH/QNvAUd6v+RhwIfGg
 6kK112KfNxrTBLxEroWuvHHfeXYZF56Qs6ACavCg++wq0hsfiiBsh1CkK g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339468438"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="339468438"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2022 18:03:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="685551115"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 18:03:42 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 02/12] iommu/vt-d: Remove finding domain in
 dmar_insert_one_dev_info()
Date: Tue,  1 Mar 2022 10:01:49 +0800
Message-Id: <20220301020159.633356-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220301020159.633356-1-baolu.lu@linux.intel.com>
References: <20220301020159.633356-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: YueHaibing <yuehaibing@huawei.com>, Marco Bonelli <marco@mebeim.net>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20220214025704.3184654-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ff43c2a3a206..56fe9b22c576 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2554,7 +2554,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 						    struct device *dev,
 						    struct dmar_domain *domain)
 {
-	struct dmar_domain *found = NULL;
 	struct device_domain_info *info;
 	unsigned long flags;
 	int ret;
@@ -2605,26 +2604,6 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
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
