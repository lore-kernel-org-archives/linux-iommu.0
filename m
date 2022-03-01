Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E86C433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 02:03:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A69460E57;
	Tue,  1 Mar 2022 02:03:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ljO_2IzNbm_Y; Tue,  1 Mar 2022 02:03:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 268E660AE1;
	Tue,  1 Mar 2022 02:03:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0075C0077;
	Tue,  1 Mar 2022 02:03:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE80BC001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7E1680C36
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CeG5y6s1M7ED for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 02:03:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E8DD80C15
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646100227; x=1677636227;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BZ7DwxKzD51PvZ+PgpOpb5RrvjLcf6wbv0afQDiSVj8=;
 b=eLl8Hq2927DthbQXevnIiQUw//WXy98vzNf9L58eRXWmoD4JH0dPTI6J
 9cP0Fh1S88qmr7S3ofBI09vwQlQ3jtjL0dGKQSoxxeJh7acs54eZ2JK44
 HylCA0JxSo5RydIrN1mpGuMzk/DBFysS16mom0SiTyDAcl5F8YbiWblWt
 N8CcoRdCPCGESM3MC5iI5jlpuI0Q9Ek7aTQmb+hzlqo1ABPwOV6vPRF+P
 tYpxu9BzGeIS6iAVb5YD342rkNe/deBrjsx1xehKa+fAfIOcvftTO5/x0
 AAfWwkySJOZEtGNDLX7+ZEo9YiypbqLD+lSV/r8SxJ/lOoSp/TXg+UFHC g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339468445"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="339468445"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2022 18:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="685551137"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 18:03:44 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 03/12] iommu/vt-d: Remove iova_cache_get/put()
Date: Tue,  1 Mar 2022 10:01:50 +0800
Message-Id: <20220301020159.633356-4-baolu.lu@linux.intel.com>
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

These have been done in drivers/iommu/dma-iommu.c. Remove this duplicate
code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20220214025704.3184654-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 56fe9b22c576..a1b6fc7174c8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3381,9 +3381,6 @@ static inline int iommu_devinfo_cache_init(void)
 static int __init iommu_init_mempool(void)
 {
 	int ret;
-	ret = iova_cache_get();
-	if (ret)
-		return ret;
 
 	ret = iommu_domain_cache_init();
 	if (ret)
@@ -3395,7 +3392,6 @@ static int __init iommu_init_mempool(void)
 
 	kmem_cache_destroy(iommu_domain_cache);
 domain_error:
-	iova_cache_put();
 
 	return -ENOMEM;
 }
@@ -3404,7 +3400,6 @@ static void __init iommu_exit_mempool(void)
 {
 	kmem_cache_destroy(iommu_devinfo_cache);
 	kmem_cache_destroy(iommu_domain_cache);
-	iova_cache_put();
 }
 
 static void __init init_no_remapping_devices(void)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
