Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D33C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 06:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7758740272;
	Mon,  7 Feb 2022 06:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i8Qx-DIwWgxG; Mon,  7 Feb 2022 06:43:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1FEAC4023F;
	Mon,  7 Feb 2022 06:43:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09047C0011;
	Mon,  7 Feb 2022 06:43:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 403E7C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3ADF840240
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ek6dU4njgeAm for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 06:43:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EC184023F
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 06:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644216194; x=1675752194;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fIEVBkJiUooXYrTSIvBLA7Ijyh2xdWSYljcHg0SF2/8=;
 b=jqYFxplyn6seeQIubrn0od/YxOm/Phwz32SJNiC6j2xLdcVeExex44ec
 kjZwPLOCck4aHKa5taRUkr/3/RlOuHJ9lMP6UuGJpZv/2y9vGLj45nHFf
 BPQVI1bDIng9lO2aGkfyNCCzxBOjy8qimd8PF9THUtvbWPX/HMxs/dfe7
 OdO9k3BdKvM5pItcQa8Ksaq7wMkkbzNGQayz0CWDSsJuJhN25jIxq8Dl6
 NxatNC1p42kqOefF+XCKACvOxUOwtsHxRFisl8FizLuVjg1c5Bfp+hfWQ
 NP5gO3S4N84RDvalgyPr5FBoN53Dzowkb1ChHFYR7W37GHr7fsX33vxOt w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="228622941"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="228622941"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2022 22:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; d="scan'208";a="525020245"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:43:09 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v1 04/10] iommu/vt-d: Remove iova_cache_get/put()
Date: Mon,  7 Feb 2022 14:41:36 +0800
Message-Id: <20220207064142.1092846-5-baolu.lu@linux.intel.com>
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

These have been done in drivers/iommu/dma-iommu.c. Remove this duplicate
code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 583ec0fa4ac1..e8d58654361c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3348,9 +3348,6 @@ static inline int iommu_devinfo_cache_init(void)
 static int __init iommu_init_mempool(void)
 {
 	int ret;
-	ret = iova_cache_get();
-	if (ret)
-		return ret;
 
 	ret = iommu_domain_cache_init();
 	if (ret)
@@ -3362,7 +3359,6 @@ static int __init iommu_init_mempool(void)
 
 	kmem_cache_destroy(iommu_domain_cache);
 domain_error:
-	iova_cache_put();
 
 	return -ENOMEM;
 }
@@ -3371,7 +3367,6 @@ static void __init iommu_exit_mempool(void)
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
