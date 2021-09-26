Return-Path: <SRS0=RzN/=OQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2997C433F5
	for <iommu@archiver.kernel.org>; Sun, 26 Sep 2021 11:49:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814CD60EB4
	for <iommu@archiver.kernel.org>; Sun, 26 Sep 2021 11:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 814CD60EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39BD280E85;
	Sun, 26 Sep 2021 11:49:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AP0jyznrVgMX; Sun, 26 Sep 2021 11:49:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1DEC480E22;
	Sun, 26 Sep 2021 11:49:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91CD3C0020;
	Sun, 26 Sep 2021 11:49:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27E43C000D
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 11:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09BF3402EF
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 11:49:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R6Mk0k11AW1h for <iommu@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 11:49:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB6F1402FD
 for <iommu@lists.linux-foundation.org>; Sun, 26 Sep 2021 11:49:15 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10118"; a="222450217"
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; d="scan'208";a="222450217"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2021 04:49:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,323,1624345200"; d="scan'208";a="475640103"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 26 Sep 2021 04:49:13 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 1/3] iommu/vt-d: Remove duplicate identity domain flag
Date: Sun, 26 Sep 2021 19:45:33 +0800
Message-Id: <20210926114535.923263-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210926114535.923263-1-baolu.lu@linux.intel.com>
References: <20210926114535.923263-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

The iommu_domain data structure already has the "type" field to keep the
type of a domain. It's unnecessary to have the DOMAIN_FLAG_STATIC_IDENTITY
flag in the vt-d implementation. This cleans it up with no functionality
change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h | 3 ---
 drivers/iommu/intel/iommu.c | 9 ++++-----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4bff70c26416..c24bdf5a9285 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -517,9 +517,6 @@ struct context_entry {
 	u64 hi;
 };
 
-/* si_domain contains mulitple devices */
-#define DOMAIN_FLAG_STATIC_IDENTITY		BIT(0)
-
 /*
  * When VT-d works in the scalable mode, it allows DMA translation to
  * happen through either first level or second level page table. This
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b0076f54f5f4..dc2030d014e0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -528,7 +528,7 @@ static inline void free_devinfo_mem(void *vaddr)
 
 static inline int domain_type_is_si(struct dmar_domain *domain)
 {
-	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;
+	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
 }
 
 static inline bool domain_use_first_level(struct dmar_domain *domain)
@@ -1996,7 +1996,7 @@ static bool first_level_by_default(void)
 	return scalable_mode_support() && intel_cap_flts_sanity();
 }
 
-static struct dmar_domain *alloc_domain(int flags)
+static struct dmar_domain *alloc_domain(unsigned int type)
 {
 	struct dmar_domain *domain;
 
@@ -2006,7 +2006,6 @@ static struct dmar_domain *alloc_domain(int flags)
 
 	memset(domain, 0, sizeof(*domain));
 	domain->nid = NUMA_NO_NODE;
-	domain->flags = flags;
 	if (first_level_by_default())
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
@@ -2830,7 +2829,7 @@ static int __init si_domain_init(int hw)
 	struct device *dev;
 	int i, nid, ret;
 
-	si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
+	si_domain = alloc_domain(IOMMU_DOMAIN_IDENTITY);
 	if (!si_domain)
 		return -EFAULT;
 
@@ -4639,7 +4638,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 	case IOMMU_DOMAIN_DMA:
 	case IOMMU_DOMAIN_DMA_FQ:
 	case IOMMU_DOMAIN_UNMANAGED:
-		dmar_domain = alloc_domain(0);
+		dmar_domain = alloc_domain(type);
 		if (!dmar_domain) {
 			pr_err("Can't allocate dmar_domain\n");
 			return NULL;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
