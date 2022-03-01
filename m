Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C323C433EF
	for <iommu@archiver.kernel.org>; Tue,  1 Mar 2022 02:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0772260E7E;
	Tue,  1 Mar 2022 02:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DDgtR_BcCe02; Tue,  1 Mar 2022 02:03:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DA13B60AE1;
	Tue,  1 Mar 2022 02:03:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4FEDC0077;
	Tue,  1 Mar 2022 02:03:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E6A6C001A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E39A80C9C
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x_FT6hTQoup1 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Mar 2022 02:03:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 77B3A80C52
 for <iommu@lists.linux-foundation.org>; Tue,  1 Mar 2022 02:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646100236; x=1677636236;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9J3nQPvKLV3PzJR+Q3C5MYsi1B1y6teH0xWKRB6/vuw=;
 b=KBIB+iLoDod9Zg8gzQ9qVER1QU3P9E5VWjNpOYSpsDIHeGqJORU1f7mX
 nENmivigZPaQQtZZfJHkt0oZ9I8rPfoa+4ZklQwE+1yxd26XZfbwH8LBU
 5IxofYxO6Y5d3KojL064Q9MU9IPBFq0gv8q7Bn9W6a5r1XTydTDV/HgDE
 u1nLGrITXyVyasgOfY7CkEceEsGi05YFlHPgASO9UyFMnwucJegUdJyxU
 VZmb2DWzESnYqqInKW0Wk7G44gYb3oQF6jDe+c9x++8RtomSUY/g3M/qH
 4HYQaO2aWPIIHqRw0Smnz+yPbTkqi9m/RfFRDnwN06wVAeE7J8JgT2PUe A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339468470"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="339468470"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2022 18:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; d="scan'208";a="685551198"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 18:03:54 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 07/12] iommu/vt-d: Remove unnecessary prototypes
Date: Tue,  1 Mar 2022 10:01:54 +0800
Message-Id: <20220301020159.633356-8-baolu.lu@linux.intel.com>
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

Some prototypes in iommu.c are unnecessary. Delete them.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20220214025704.3184654-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index be3dbc89df06..0030dbc8764a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -296,14 +296,9 @@ static LIST_HEAD(dmar_satc_units);
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
 
-static void domain_exit(struct dmar_domain *domain);
 static void domain_remove_dev_info(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct device *dev);
 static void __dmar_remove_one_dev_info(struct device_domain_info *info);
-static int intel_iommu_attach_device(struct iommu_domain *domain,
-				     struct device *dev);
-static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
-					    dma_addr_t iova);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
