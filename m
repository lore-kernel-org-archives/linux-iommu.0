Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B651C433EF
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 06:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1ADFC8492B;
	Fri, 27 May 2022 06:34:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WwpbrElODQLK; Fri, 27 May 2022 06:34:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 087E284928;
	Fri, 27 May 2022 06:34:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D92C8C0032;
	Fri, 27 May 2022 06:34:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A85A2C002D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:34:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A581A412DE
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:34:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id meRHiu3qhmxY for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 06:34:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13B92412DB
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 06:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653633265; x=1685169265;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RLgt8GpnD0r5X5XNCxy8KVU7WroIhMRrSOoUkBm0OtU=;
 b=js7Y0Pt7EuSjw9BLEu+rlSm4KKoqAAN9dnfe3YDu4at6C2rzp39U5yPz
 Y5OuaK1vz9FLD5YAltZBMU2Yfqk1QE5ZikWZHqZrpuTtq4Lw1BctjZnLy
 33h9zm2izGpk50vgkCKwJzSSIGMn8k/QIgNe+Vyycmc2UykaggAAQWApH
 HSXchN0Gk2TyKSSQGvJDSUboIO8QO95G7LX5vImLWlz7NN2t4s4MuJUvw
 Ulyrpw6EqVtu8/oG35eI7F6JUwApTNzrA0/y8RKSL1sHOusUUuBeU9yrW
 YUpRIKaVs5W3nZQvSYPi67R81dYINs33FmyRYUWRKZN3fBL1gDilyi1Ur g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274123380"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="274123380"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2022 23:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; d="scan'208";a="718688729"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:34:21 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 09/12] iommu/vt-d: Check device list of domain in domain free
 path
Date: Fri, 27 May 2022 14:30:16 +0800
Message-Id: <20220527063019.3112905-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

When the IOMMU domain is about to be freed, it should not be set on any
device. Instead of silently dealing with some bug cases, it's better to
trigger a warning to report and fix any potential bugs at the first time.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e195a639502..6f3119c68cd2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -294,7 +294,6 @@ static LIST_HEAD(dmar_satc_units);
 /* bitmap for indexing intel_iommus */
 static int g_num_of_iommus;
 
-static void domain_remove_dev_info(struct dmar_domain *domain);
 static void dmar_remove_one_dev_info(struct device *dev);
 static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 
@@ -1835,9 +1834,8 @@ static inline int guestwidth_to_adjustwidth(int gaw)
 
 static void domain_exit(struct dmar_domain *domain)
 {
-
-	/* Remove associated devices and clear attached or cached domains */
-	domain_remove_dev_info(domain);
+	if (WARN_ON(!list_empty(&domain->devices)))
+		return;
 
 	if (domain->pgd) {
 		LIST_HEAD(freelist);
@@ -2328,17 +2326,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	__iommu_flush_dev_iotlb(info, 0, MAX_AGAW_PFN_WIDTH);
 }
 
-static void domain_remove_dev_info(struct dmar_domain *domain)
-{
-	struct device_domain_info *info, *tmp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	list_for_each_entry_safe(info, tmp, &domain->devices, link)
-		__dmar_remove_one_dev_info(info);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-}
-
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
