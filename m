Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EA2C433FE
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 01:10:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0122C41956;
	Thu,  5 May 2022 01:10:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id csI2r1NyKXlL; Thu,  5 May 2022 01:10:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D1F5F41953;
	Thu,  5 May 2022 01:10:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B96FDC0039;
	Thu,  5 May 2022 01:10:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA9C7C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 01:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BE9B41952
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 01:10:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mNZpknruVHFG for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 01:10:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7ED44194E
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 01:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651713016; x=1683249016;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4PNStGZhBcO3401PL1GueqUZp/xD3Mm67eTtFhhqUXo=;
 b=TJ1jrMHQa/9OrweOUowvNVx1ql+fb5v3kVUvbH8iK8ZqYwAYtVtP3F+X
 y/2NO8vlOsJEMyqIPkPHf3LTQFQZ+T6Az4fDjluMfb2+XczqkAfh6hH79
 sf3FFZ3dEXd1ALd5hmb75Ff4T685G7w1f8DVHU5/F4a5pgbL+eBtCyxlH
 /jmIqIkWJ2OcrfpvzHHJr+QE/3vQf6DyVpyLDW/zMZun5md17SUEUJsKi
 zUu2BgzFPx9K7k8dnVQ0Y6sR2HDIfhQ/7esdYxPOH7OWdWKsppXMxccSH
 R5d1kqdpWPIZsd9YESRkP0yfE/SB8Xol7YYJU1IS/thbw1X4BHt2hgXdf g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="247857813"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; d="scan'208";a="247857813"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2022 18:10:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; d="scan'208";a="708713914"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 04 May 2022 18:10:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v2 3/4] iommu/vt-d: Remove domain_update_iommu_snooping()
Date: Thu,  5 May 2022 09:07:09 +0800
Message-Id: <20220505010710.1477739-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
References: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The IOMMU force snooping capability is not required to be consistent
among all the IOMMUs anymore. Remove force snooping capability check
in the IOMMU hot-add path and domain_update_iommu_snooping() becomes
a dead code now.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/iommu.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 98112228ae93..da4bfb34ae4b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -533,33 +533,6 @@ static void domain_update_iommu_coherency(struct dmar_domain *domain)
 	rcu_read_unlock();
 }
 
-static bool domain_update_iommu_snooping(struct intel_iommu *skip)
-{
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	bool ret = true;
-
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (iommu != skip) {
-			/*
-			 * If the hardware is operating in the scalable mode,
-			 * the snooping control is always supported since we
-			 * always set PASID-table-entry.PGSNP bit if the domain
-			 * is managed outside (UNMANAGED).
-			 */
-			if (!sm_supported(iommu) &&
-			    !ecap_sc_support(iommu->ecap)) {
-				ret = false;
-				break;
-			}
-		}
-	}
-	rcu_read_unlock();
-
-	return ret;
-}
-
 static int domain_update_iommu_superpage(struct dmar_domain *domain,
 					 struct intel_iommu *skip)
 {
@@ -3593,12 +3566,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 			iommu->name);
 		return -ENXIO;
 	}
-	if (!ecap_sc_support(iommu->ecap) &&
-	    domain_update_iommu_snooping(iommu)) {
-		pr_warn("%s: Doesn't support snooping.\n",
-			iommu->name);
-		return -ENXIO;
-	}
+
 	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
 	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
 		pr_warn("%s: Doesn't support large page.\n",
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
