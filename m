Return-Path: <SRS0=v/Dl=XS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776AEC3A5A6
	for <iommu@archiver.kernel.org>; Mon, 23 Sep 2019 12:27:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567F7207FD
	for <iommu@archiver.kernel.org>; Mon, 23 Sep 2019 12:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567F7207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A57F3CC9;
	Mon, 23 Sep 2019 12:27:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D8620CC6
	for <iommu@lists.linux-foundation.org>;
	Mon, 23 Sep 2019 12:27:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 6D87E8AA
	for <iommu@lists.linux-foundation.org>;
	Mon, 23 Sep 2019 12:27:29 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Sep 2019 05:27:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,539,1559545200"; d="scan'208";a="203116684"
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2019 05:27:26 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [RFC PATCH 4/4] iommu/vt-d: Identify domains using first level page
	table
Date: Mon, 23 Sep 2019 20:24:54 +0800
Message-Id: <20190923122454.9888-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923122454.9888-1-baolu.lu@linux.intel.com>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
	ashok.raj@intel.com, kvm@vger.kernel.org,
	sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, yi.y.sun@intel.com
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

This checks whether a domain should use first level page table
for map/unmap. And if so, we should attach the domain to the
device in first level translation mode.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>
Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 41 ++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 103480016010..d539e6a6c3dd 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1722,6 +1722,26 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 #endif
 }
 
+/*
+ * Check and return whether first level is used by default for
+ * DMA translation.
+ */
+static bool first_level_by_default(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd)
+		if (!sm_supported(iommu) ||
+		    !ecap_flts(iommu->ecap) ||
+		    !cap_caching_mode(iommu->cap))
+			return false;
+	rcu_read_unlock();
+
+	return true;
+}
+
 static struct dmar_domain *alloc_domain(int flags)
 {
 	struct dmar_domain *domain;
@@ -1736,6 +1756,9 @@ static struct dmar_domain *alloc_domain(int flags)
 	domain->has_iotlb_device = false;
 	INIT_LIST_HEAD(&domain->devices);
 
+	if (first_level_by_default())
+		domain->flags |= DOMAIN_FLAG_FIRST_LEVEL_TRANS;
+
 	return domain;
 }
 
@@ -2625,6 +2648,11 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
+		else if (domain_type_is_flt(domain))
+			ret = intel_pasid_setup_first_level(iommu, dev,
+					domain->pgd, PASID_RID2PASID,
+					domain->iommu_did[iommu->seq_id],
+					PASID_FLAG_SUPERVISOR_MODE);
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
@@ -5349,8 +5377,14 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
 		goto attach_failed;
 
 	/* Setup the PASID entry for mediated devices: */
-	ret = intel_pasid_setup_second_level(iommu, domain, dev,
-					     domain->default_pasid);
+	if (domain_type_is_flt(domain))
+		ret = intel_pasid_setup_first_level(iommu, dev,
+				domain->pgd, domain->default_pasid,
+				domain->iommu_did[iommu->seq_id],
+				PASID_FLAG_SUPERVISOR_MODE);
+	else
+		ret = intel_pasid_setup_second_level(iommu, domain, dev,
+						     domain->default_pasid);
 	if (ret)
 		goto table_failed;
 	spin_unlock(&iommu->lock);
@@ -5583,7 +5617,8 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	int level = 0;
 	u64 phys = 0;
 
-	if (dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN)
+	if ((dmar_domain->flags & DOMAIN_FLAG_LOSE_CHILDREN) ||
+	    (dmar_domain->flags & DOMAIN_FLAG_FIRST_LEVEL_TRANS))
 		return 0;
 
 	pte = pfn_to_dma_pte(dmar_domain, iova >> VTD_PAGE_SHIFT, &level);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
