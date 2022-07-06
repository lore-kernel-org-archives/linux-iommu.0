Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F58C43334
	for <iommu@archiver.kernel.org>; Wed,  6 Jul 2022 03:00:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9D5BC409EE;
	Wed,  6 Jul 2022 03:00:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D5BC409EE
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GrGdeQ07
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J6eenDuZt2Hz; Wed,  6 Jul 2022 03:00:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 696B8408DD;
	Wed,  6 Jul 2022 03:00:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 696B8408DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45E9BC0071;
	Wed,  6 Jul 2022 03:00:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94F91C0070
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 03:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 628F040ACA
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 03:00:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 628F040ACA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pidPdV5xpJmN for <iommu@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 03:00:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 32A0E409EE
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32A0E409EE
 for <iommu@lists.linux-foundation.org>; Wed,  6 Jul 2022 03:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657076407; x=1688612407;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yJXUA+NuM0V10Ayu1Uk2puf2SUIVOwGMq3d3tn/fE84=;
 b=GrGdeQ07LZqKRULEzmb/QK2Uu+MYdfVjWallutsgZPfQEbsolnZuQ/aQ
 Q/KpIKYdlc86W2q+vEjGxr0P7GszAFV6VfZ0bhomUKmCUHoFuT1ExsQjX
 SPU2DDPs7ThRFwia3LtXMR9ZWHlbEzLDc4nMTlwyMD2fuPlwk7eMY3LkU
 V823PK0Khs/pCQBSLAybUkPX9BZDUw7WFd4gK4JPub7H3e7tipIpxezOQ
 rDAYbeSLShVgn4GJyK7ZoEJD/0giTkEaU8jav6T6ADU41wlH1MYooqFV0
 nZEec7534egixYlAZpCCcGfdwknoZBH67YefRGl8pGybDaTaetqN+2wmd w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272409572"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; d="scan'208";a="272409572"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2022 20:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; d="scan'208";a="567875034"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 20:00:04 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev
Subject: [PATCH v4 06/11] iommu/vt-d: Acquiring lock in domain ID allocation
 helpers
Date: Wed,  6 Jul 2022 10:55:19 +0800
Message-Id: <20220706025524.2904370-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
References: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, Jacob jun Pan <jacob.jun.pan@intel.com>
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

The iommu->lock is used to protect the per-IOMMU domain ID resource.
Moving the lock into the ID alloc/free helpers makes the code more
compact. At the same time, the device_domain_lock is irrelevant to
the domain ID resource, remove its assertion as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 93f01082dce1..7f03576e72d7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1779,16 +1779,13 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	return domain;
 }
 
-/* Must be called with iommu->lock */
 static int domain_attach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu)
 {
 	unsigned long ndomains;
-	int num;
-
-	assert_spin_locked(&device_domain_lock);
-	assert_spin_locked(&iommu->lock);
+	int num, ret = 0;
 
+	spin_lock(&iommu->lock);
 	domain->iommu_refcnt[iommu->seq_id] += 1;
 	if (domain->iommu_refcnt[iommu->seq_id] == 1) {
 		ndomains = cap_ndoms(iommu->cap);
@@ -1797,7 +1794,8 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		if (num >= ndomains) {
 			pr_err("%s: No free domain ids\n", iommu->name);
 			domain->iommu_refcnt[iommu->seq_id] -= 1;
-			return -ENOSPC;
+			ret = -ENOSPC;
+			goto out_unlock;
 		}
 
 		set_bit(num, iommu->domain_ids);
@@ -1806,7 +1804,9 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 	}
 
-	return 0;
+out_unlock:
+	spin_unlock(&iommu->lock);
+	return ret;
 }
 
 static void domain_detach_iommu(struct dmar_domain *domain,
@@ -1814,9 +1814,7 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 {
 	int num;
 
-	assert_spin_locked(&device_domain_lock);
-	assert_spin_locked(&iommu->lock);
-
+	spin_lock(&iommu->lock);
 	domain->iommu_refcnt[iommu->seq_id] -= 1;
 	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
 		num = domain->iommu_did[iommu->seq_id];
@@ -1824,6 +1822,7 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 		domain->iommu_did[iommu->seq_id] = 0;
 	}
+	spin_unlock(&iommu->lock);
 }
 
 static inline int guestwidth_to_adjustwidth(int gaw)
@@ -2472,9 +2471,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 
 	spin_lock(&device_domain_lock);
 	info->domain = domain;
-	spin_lock(&iommu->lock);
 	ret = domain_attach_iommu(domain, iommu);
-	spin_unlock(&iommu->lock);
 	if (ret) {
 		spin_unlock(&device_domain_lock);
 		return ret;
@@ -4178,10 +4175,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	}
 
 	list_del(&info->link);
-
-	spin_lock(&iommu->lock);
 	domain_detach_iommu(domain, iommu);
-	spin_unlock(&iommu->lock);
 }
 
 static void dmar_remove_one_dev_info(struct device *dev)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
