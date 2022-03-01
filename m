Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA817C433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 02:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A85A5410D3;
	Tue,  1 Mar 2022 02:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ywkk5pv6Ywn1; Tue,  1 Mar 2022 02:04:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9BF3B410D2;
	Tue,  1 Mar 2022 02:04:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75AF2C0077;
	Tue,  1 Mar 2022 02:04:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42B00C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 244EF81756
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hlsLVPzeUfwG for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 02:04:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 676A780CDE
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646100245; x=1677636245;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zi2EP28k2yM5mMmj4YGXnh91ov8rhYkUOiLeW+/zrOc=;
 b=OO29TQaGoBuNerSEbFmnV/EWpwdlHCHguGM0842GmB3oeY+fCLFD5ZlT
 zuFNnZ/eGVugNfeU9zfj+tHB1D+dttGRRSZHrAXLhJ/1EA3V8nyFIPiZU
 lO1/80JytKdhMz4vVfq3UgmbdLAEYrq7tIETLaytjN2zdmDnNG5dWk4ha
 3+C0GJVlZaNAqvmfex6kSqQMZ0gr3ylfrIf/nrYS+DVTGc6W4uvGEVeGQ
 JFWojF/qfu+Tk/JTxDRUmBH6ImTDRHcTbfpEETp8tMNfXSIMeCupUmtFU
 +KLhZPkrL27nkIdJNKLO4s8gen/yqAFjkGASAiJMUKPhL0DVaWuxfgUwu A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339468495"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="339468495"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2022 18:04:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="685551245"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 18:04:03 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 11/12] iommu/vt-d: Remove unused function intel_svm_capable()
Date: Tue,  1 Mar 2022 10:01:58 +0800
Message-Id: <20220301020159.633356-12-baolu.lu@linux.intel.com>
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

From: YueHaibing <yuehaibing@huawei.com>

This is unused since commit 4048377414162 ("iommu/vt-d: Use
iommu_sva_alloc(free)_pasid() helpers").

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20220216113851.25004-1-yuehaibing@huawei.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 944e2408b6d2..241d095b6dcf 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -168,11 +168,6 @@ int intel_svm_finish_prq(struct intel_iommu *iommu)
 	return 0;
 }
 
-static inline bool intel_svm_capable(struct intel_iommu *iommu)
-{
-	return iommu->flags & VTD_FLAG_SVM_CAPABLE;
-}
-
 void intel_svm_check(struct intel_iommu *iommu)
 {
 	if (!pasid_supported(iommu))
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
