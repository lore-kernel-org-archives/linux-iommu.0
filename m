Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD81CC433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 02:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BCB9410C1;
	Tue,  1 Mar 2022 02:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RWuyCvG2UzeH; Tue,  1 Mar 2022 02:04:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 71DF0410D8;
	Tue,  1 Mar 2022 02:04:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E70AC0077;
	Tue,  1 Mar 2022 02:04:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 378FDC001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:04:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19B9E80CDE
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fVMs0hWx0zzT for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 02:04:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F291813C9
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646100243; x=1677636243;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tVdRouOwQNvJlmCXxUqkgKbXu/COIHd7uNVT3Gc67ew=;
 b=EgyKn/yUQxB3C8s51PdCI0QnMv83LQNRjk8mUeqrXmUHIlDuQ16z2Bxq
 79GV0szAnvRG9gYD+Nc/hJorRGXvY73ubziIu209uXKPtcH+DRGn2Qung
 ZqOGkMb0R5UbhMSiDuO5R+RGFT/oHwJRtjb9m26r3Nlm1Rp+UZSFrS2dg
 YJbnzcCR0J1rH94hrLNdW95Wh6NLGO5ABWtxDoy96I/9w0dxvMA+7GdMz
 klKL1/tGZPltCal/UyQZycPVzlRHrcaBGV9lUrkrqXEpFCss8/hA2MbG9
 TO8yyUBVAXGPFNS7c36nf2zLBjuQl2X4MnXb2k619qXYLfAiu4tUO+e8j A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339468488"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="339468488"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2022 18:04:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="685551236"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 18:04:01 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 10/12] iommu/vt-d: Add missing "__init" for rmrr_sanity_check()
Date: Tue,  1 Mar 2022 10:01:57 +0800
Message-Id: <20220301020159.633356-11-baolu.lu@linux.intel.com>
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

From: Marco Bonelli <marco@mebeim.net>

rmrr_sanity_check() calls arch_rmrr_sanity_check(), which is marked as
"__init". Add the annotation for rmrr_sanity_check() too. This function is
currently only called from dmar_parse_one_rmrr() which is also "__init".

Signed-off-by: Marco Bonelli <marco@mebeim.net>
Link: https://lore.kernel.org/r/20220210023141.9208-1-marco@mebeim.net
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f5b15bc20426..19562891d6ef 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3364,7 +3364,7 @@ static void __init init_iommu_pm_ops(void)
 static inline void init_iommu_pm_ops(void) {}
 #endif	/* CONFIG_PM */
 
-static int rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
+static int __init rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 {
 	if (!IS_ALIGNED(rmrr->base_address, PAGE_SIZE) ||
 	    !IS_ALIGNED(rmrr->end_address + 1, PAGE_SIZE) ||
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
