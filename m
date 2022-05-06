Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C52C433F5
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 05:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9957760BCC;
	Fri,  6 May 2022 05:30:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eNkRznnKWLLs; Fri,  6 May 2022 05:30:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7885660BAE;
	Fri,  6 May 2022 05:30:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61849C0032;
	Fri,  6 May 2022 05:30:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1758C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9906D4199A
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:30:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ahoq5OHwyuxI for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 05:30:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE22B418D6
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651815034; x=1683351034;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dhHzVPtGCmtqjw7nHlmUc46+bVg8lesIZ0/A9YXT9us=;
 b=JCRDdAuFAIRRyv7ApbZ0qIJTWxRDuVB6ibdvnY7Be66lQlDsbnvZxYp9
 XYZ9+/Q6aSduNNKyhwSl3a/0nMcfXsoLwfU0vDKsEfTFlW83uLbsMS//r
 zW9gNcSLhelMB6AdQsyf/RxZ5sHgDyxStL5d0JKEHvOzRij50qNNpFWvB
 36zmwdKfUF/iqDuu3wDsRSTX3NQYOvPxfhuFeHCBlEtdf9bF5bg/7CjiZ
 zK4DwLoGDvZ0nuqfsAUwmU/edhN/Q9C6h32dGBLWgLUwk6mwqtO8dviAO
 RZJLVFX7T94K7ShK92rZ2Vc4GNAFJ4c4/why7J76aD7wCpFzaSmIL975i A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="354790968"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="354790968"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 22:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="695011085"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga004.jf.intel.com with ESMTP; 05 May 2022 22:30:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v3 3/4] iommu/vt-d: Remove domain_update_iommu_snooping()
Date: Fri,  6 May 2022 13:27:26 +0800
Message-Id: <20220506052727.1689687-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506052727.1689687-1-baolu.lu@linux.intel.com>
References: <20220506052727.1689687-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 048ebfbd5fcb..444d51a18c93 100644
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
@@ -3606,12 +3579,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
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
