Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B791C433F5
	for <iommu@archiver.kernel.org>; Sun,  1 May 2022 11:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9807826DE;
	Sun,  1 May 2022 11:27:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NhAdSWAHPFya; Sun,  1 May 2022 11:27:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DA20A826B4;
	Sun,  1 May 2022 11:27:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B53D2C0085;
	Sun,  1 May 2022 11:27:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2590C0039
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 11:27:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D875409C6
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 11:27:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zNW4Zx5FGh4G for <iommu@lists.linux-foundation.org>;
 Sun,  1 May 2022 11:27:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E49CD4097E
 for <iommu@lists.linux-foundation.org>; Sun,  1 May 2022 11:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651404476; x=1682940476;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8Ab0hXVeJPQFxGivZE668c+wGDeZdo9BvU5oRO/0WGA=;
 b=nywwvmZWA6tyTi5d5M0IV66sqjT/MUglShO3T+BScG3xwJmWsAfh9UNM
 vEeka1OlSqbfq1DdwD9rRfUSIEmYzxMAbNNuqON9G7Hb79Al5mV6HFeM/
 EGOKogimeJ7Tfu2Jz2qwjqweBvXqAVGRqP+h1BqNgKtbPvAPtCJKh+vEs
 t0jduBysmfR99z+a7NZsHpqra+Yv+0e7qaeGnVsM6cHoqOKm5A1torPam
 bkiwFN73ejh+oqCXPPXL7FEVClFSFarIDR+626OuvrCuA4jJxd0+FSfzu
 75pO4V0WgoMDzJVSDSmi07FFPSAIZlo/iwnkKqYJzfvnY7PBPv7CaTUfC Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="292178352"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; d="scan'208";a="292178352"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2022 04:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; d="scan'208";a="545114906"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga002.jf.intel.com with ESMTP; 01 May 2022 04:27:54 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH 4/5] iommu/vt-d: Remove domain_update_iommu_snooping()
Date: Sun,  1 May 2022 19:24:33 +0800
Message-Id: <20220501112434.874236-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220501112434.874236-1-baolu.lu@linux.intel.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3c1c228f9031..d5808495eb64 100644
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
