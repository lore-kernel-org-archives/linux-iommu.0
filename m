Return-Path: <SRS0=fKZg=UI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7668DC28CC5
	for <iommu@archiver.kernel.org>; Sun,  9 Jun 2019 02:46:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D78216C8
	for <iommu@archiver.kernel.org>; Sun,  9 Jun 2019 02:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D78216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D59F4BA9;
	Sun,  9 Jun 2019 02:45:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C2EA8B9E
	for <iommu@lists.linux-foundation.org>;
	Sun,  9 Jun 2019 02:45:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 15B2D174
	for <iommu@lists.linux-foundation.org>;
	Sun,  9 Jun 2019 02:45:38 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Jun 2019 19:45:37 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2019 19:45:36 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 5/6] iommu/vt-d: Cleanup after delegating DMA domain to
	generic iommu
Date: Sun,  9 Jun 2019 10:38:02 +0800
Message-Id: <20190609023803.23832-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190609023803.23832-1-baolu.lu@linux.intel.com>
References: <20190609023803.23832-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, cai@lca.pw, jacob.jun.pan@intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

[No functional changes]

1. Starting with commit df4f3c603aeb ("iommu/vt-d: Remove static identity
map code") there are no callers for iommu_prepare_rmrr_dev() but the
implementation of the function still exists, so remove it. Also, as a
ripple effect remove get_domain_for_dev() and iommu_prepare_identity_map()
because they aren't being used either.

2. init_dmars() runs the same loop (for_each_active_iommu(iommu, drhd))
over different functions back to back. So, remove the duplicate loop to
make it a single for_each_active_iommu().

3. Cleanup few double spaces.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 drivers/iommu/intel-iommu.c | 68 ++++---------------------------------
 1 file changed, 6 insertions(+), 62 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d1cd7e449161..d60cf0fd9500 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -909,7 +909,6 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
 	return pte;
 }
 
-
 /* return address's pte at specific level */
 static struct dma_pte *dma_pfn_level_pte(struct dmar_domain *domain,
 					 unsigned long pfn,
@@ -1578,7 +1577,6 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-
 static int iommu_init_domains(struct intel_iommu *iommu)
 {
 	u32 ndomains, nlongs;
@@ -1616,8 +1614,6 @@ static int iommu_init_domains(struct intel_iommu *iommu)
 		return -ENOMEM;
 	}
 
-
-
 	/*
 	 * If Caching mode is set, then invalid translations are tagged
 	 * with domain-id 0, hence we need to pre-allocate it. We also
@@ -2649,29 +2645,6 @@ static struct dmar_domain *set_domain_for_dev(struct device *dev,
 	return domain;
 }
 
-static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
-{
-	struct dmar_domain *domain, *tmp;
-
-	domain = find_domain(dev);
-	if (domain)
-		goto out;
-
-	domain = find_or_alloc_domain(dev, gaw);
-	if (!domain)
-		goto out;
-
-	tmp = set_domain_for_dev(dev, domain);
-	if (!tmp || domain != tmp) {
-		domain_exit(domain);
-		domain = tmp;
-	}
-
-out:
-
-	return domain;
-}
-
 static int iommu_domain_identity_map(struct dmar_domain *domain,
 				     unsigned long long start,
 				     unsigned long long end)
@@ -2736,33 +2709,6 @@ static int domain_prepare_identity_map(struct device *dev,
 	return iommu_domain_identity_map(domain, start, end);
 }
 
-static int iommu_prepare_identity_map(struct device *dev,
-				      unsigned long long start,
-				      unsigned long long end)
-{
-	struct dmar_domain *domain;
-	int ret;
-
-	domain = get_domain_for_dev(dev, DEFAULT_DOMAIN_ADDRESS_WIDTH);
-	if (!domain)
-		return -ENOMEM;
-
-	ret = domain_prepare_identity_map(dev, domain, start, end);
-	if (ret)
-		domain_exit(domain);
-
-	return ret;
-}
-
-static inline int iommu_prepare_rmrr_dev(struct dmar_rmrr_unit *rmrr,
-					 struct device *dev)
-{
-	if (dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO)
-		return 0;
-	return iommu_prepare_identity_map(dev, rmrr->base_address,
-					  rmrr->end_address);
-}
-
 static int md_domain_init(struct dmar_domain *domain, int guest_width);
 
 static int __init si_domain_init(int hw)
@@ -3306,14 +3252,13 @@ static int __init init_dmars(void)
 		if (pasid_supported(iommu))
 			intel_svm_init(iommu);
 #endif
-	}
 
-	/*
-	 * Now that qi is enabled on all iommus, set the root entry and flush
-	 * caches. This is required on some Intel X58 chipsets, otherwise the
-	 * flush_context function will loop forever and the boot hangs.
-	 */
-	for_each_active_iommu(iommu, drhd) {
+		/*
+		 * Now that qi is enabled on all iommus, set the root entry and
+		 * flush caches. This is required on some Intel X58 chipsets,
+		 * otherwise the flush_context function will loop forever and
+		 * the boot hangs.
+		 */
 		iommu_flush_write_buffer(iommu);
 		iommu_set_root_entry(iommu);
 		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
@@ -4058,7 +4003,6 @@ static void __init init_iommu_pm_ops(void)
 static inline void init_iommu_pm_ops(void) {}
 #endif	/* CONFIG_PM */
 
-
 int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 {
 	struct acpi_dmar_reserved_memory *rmrr;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
