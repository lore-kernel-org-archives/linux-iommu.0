Return-Path: <SRS0=LkSb=OO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3930C433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 02:33:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A36261019
	for <iommu@archiver.kernel.org>; Fri, 24 Sep 2021 02:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A36261019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D96764036E;
	Fri, 24 Sep 2021 02:33:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VG0MOtI45fTO; Fri, 24 Sep 2021 02:33:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AE76B40341;
	Fri, 24 Sep 2021 02:33:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72A77C000F;
	Fri, 24 Sep 2021 02:33:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B645FC000D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 02:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE7A140365
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 02:33:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qnoy5-hG-LMr for <iommu@lists.linux-foundation.org>;
 Fri, 24 Sep 2021 02:33:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E231540341
 for <iommu@lists.linux-foundation.org>; Fri, 24 Sep 2021 02:33:02 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211225067"
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; d="scan'208";a="211225067"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2021 19:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,318,1624345200"; d="scan'208";a="475054299"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 23 Sep 2021 19:32:59 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/1] iommu/vt-d: Use second level for GPA->HPA translation
Date: Fri, 24 Sep 2021 10:29:31 +0800
Message-Id: <20210924022931.780963-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

The IOMMU VT-d implementation uses the first level for GPA->HPA translation
by default. Although both the first level and the second level could handle
the DMA translation, they are different in some way. For example, the second
level translation has separate controls for the Access/Dirty page tracking
and the page-level forcing snoop. With first level translation, there're
no such controls. This uses the second level for GPA->HPA translation so
that it could provide a consistent hardware interface for use cases like
dirty page tracking during the VM live migration.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h |  7 ++-----
 drivers/iommu/intel/iommu.c | 21 +++++++++++++--------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 05a65eb155f7..a5fb20702201 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -517,22 +517,19 @@ struct context_entry {
 	u64 hi;
 };
 
-/* si_domain contains mulitple devices */
-#define DOMAIN_FLAG_STATIC_IDENTITY		BIT(0)
-
 /*
  * When VT-d works in the scalable mode, it allows DMA translation to
  * happen through either first level or second level page table. This
  * bit marks that the DMA translation for the domain goes through the
  * first level page table, otherwise, it goes through the second level.
  */
-#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(1)
+#define DOMAIN_FLAG_USE_FIRST_LEVEL		BIT(0)
 
 /*
  * Domain represents a virtual machine which demands iommu nested
  * translation mode support.
  */
-#define DOMAIN_FLAG_NESTING_MODE		BIT(2)
+#define DOMAIN_FLAG_NESTING_MODE		BIT(1)
 
 struct dmar_domain {
 	int	nid;			/* node id */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d75f59ae28e6..c814fea0522e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -522,7 +522,7 @@ static inline void free_devinfo_mem(void *vaddr)
 
 static inline int domain_type_is_si(struct dmar_domain *domain)
 {
-	return domain->flags & DOMAIN_FLAG_STATIC_IDENTITY;
+	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
 }
 
 static inline bool domain_use_first_level(struct dmar_domain *domain)
@@ -1874,12 +1874,18 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
  * Check and return whether first level is used by default for
  * DMA translation.
  */
-static bool first_level_by_default(void)
+static bool first_level_by_default(unsigned int type)
 {
-	return scalable_mode_support() && intel_cap_flts_sanity();
+	if (type == IOMMU_DOMAIN_UNMANAGED)
+		return false;
+
+	if (!scalable_mode_support() || !intel_cap_flts_sanity())
+		return false;
+
+	return true;
 }
 
-static struct dmar_domain *alloc_domain(int flags)
+static struct dmar_domain *alloc_domain(unsigned int type)
 {
 	struct dmar_domain *domain;
 
@@ -1889,8 +1895,7 @@ static struct dmar_domain *alloc_domain(int flags)
 
 	memset(domain, 0, sizeof(*domain));
 	domain->nid = NUMA_NO_NODE;
-	domain->flags = flags;
-	if (first_level_by_default())
+	if (first_level_by_default(type))
 		domain->flags |= DOMAIN_FLAG_USE_FIRST_LEVEL;
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
@@ -2708,7 +2713,7 @@ static int __init si_domain_init(int hw)
 	struct device *dev;
 	int i, nid, ret;
 
-	si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
+	si_domain = alloc_domain(IOMMU_DOMAIN_IDENTITY);
 	if (!si_domain)
 		return -EFAULT;
 
@@ -4517,7 +4522,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
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
