Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECC4C433EF
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 02:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CEBA402E9;
	Tue, 10 May 2022 02:37:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nAV3D3b14BsN; Tue, 10 May 2022 02:37:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8F31840224;
	Tue, 10 May 2022 02:37:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 688D1C0039;
	Tue, 10 May 2022 02:37:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD6F1C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FC7981305
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tTj7l1crVZ6D for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:37:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A7BDC812C9
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652150243; x=1683686243;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xRHuEi4SQhS5U5fA8AI+qNo4SSWOPssIOZI4YeHGKLc=;
 b=KNfJTIyYcS8Fbo1PplWEAr5ZAw++xyJX8DoPSnlpUXChsjvMbM01waDA
 EA+uVWwxLsfyJHr66IGGMpdFZUpwFSuIzsm00k8WNjYlfjVwH9GXO9zbf
 Ym2VmSngBVv+kNS8dHbiNeHLom1w45Ir/nF80wY4sm+Rd3O9bUqdW/iQB
 AUUHSJ4Mb22q4K9cgACHlqbKMHVXEIw8EwBopI7pM21qZhYPMU4xs1xjp
 BtfwlFxhN9QD8GtwftR5cCfyLqTrWX4udmH/Xk/zckOmUn2g1MelSCKxj
 /VPidFcTrgAioIcCW0wGVFpBwjB2VacnBAVKLvWSXLtsVK706NhVNoI01 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266825984"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="266825984"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 19:37:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="519523462"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga003.jf.intel.com with ESMTP; 09 May 2022 19:37:21 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 6/8] iommu/vt-d: Check domain force_snooping against attached
 devices
Date: Tue, 10 May 2022 10:34:05 +0800
Message-Id: <20220510023407.2759143-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510023407.2759143-1-baolu.lu@linux.intel.com>
References: <20220510023407.2759143-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
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

As domain->force_snooping only impacts the devices attached with the
domain, there's no need to check against all IOMMU units. On the other
hand, force_snooping could be set on a domain no matter whether it has
been attached or not, and once set it is an immutable flag. If no
device attached, the operation always succeeds. Then this empty domain
can be only attached to a device of which the IOMMU supports snoop
control.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220508123525.1973626-1-baolu.lu@linux.intel.com
---
 include/linux/intel-iommu.h |  1 +
 drivers/iommu/intel/pasid.h |  2 ++
 drivers/iommu/intel/iommu.c | 53 ++++++++++++++++++++++++++++++++++---
 drivers/iommu/intel/pasid.c | 42 +++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 72e5d7900e71..4f29139bbfc3 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -540,6 +540,7 @@ struct dmar_domain {
 	u8 has_iotlb_device: 1;
 	u8 iommu_coherency: 1;		/* indicate coherency of iommu access */
 	u8 force_snooping : 1;		/* Create IOPTEs with snoop control */
+	u8 set_pte_snp:1;
 
 	struct list_head devices;	/* all devices' list */
 	struct iova_domain iovad;	/* iova's that belong to this domain */
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index ab4408c824a5..583ea67fc783 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -123,4 +123,6 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 bool fault_ignore);
 int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid);
 void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid);
+void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
+					  struct device *dev, u32 pasid);
 #endif /* __INTEL_PASID_H */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d68f5bbf3e93..6ac49daa483b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2459,7 +2459,7 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 	if (level == 5)
 		flags |= PASID_FLAG_FL5LP;
 
-	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
+	if (domain->force_snooping)
 		flags |= PASID_FLAG_PAGE_SNOOP;
 
 	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
@@ -4431,7 +4431,7 @@ static int intel_iommu_map(struct iommu_domain *domain,
 		prot |= DMA_PTE_READ;
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= DMA_PTE_WRITE;
-	if (dmar_domain->force_snooping)
+	if (dmar_domain->set_pte_snp)
 		prot |= DMA_PTE_SNP;
 
 	max_addr = iova + size;
@@ -4554,13 +4554,60 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
+static bool domain_support_force_snooping(struct dmar_domain *domain)
+{
+	struct device_domain_info *info;
+	bool support = true;
+
+	assert_spin_locked(&device_domain_lock);
+	list_for_each_entry(info, &domain->devices, link) {
+		if (!ecap_sc_support(info->iommu->ecap)) {
+			support = false;
+			break;
+		}
+	}
+
+	return support;
+}
+
+static void domain_set_force_snooping(struct dmar_domain *domain)
+{
+	struct device_domain_info *info;
+
+	assert_spin_locked(&device_domain_lock);
+
+	/*
+	 * Second level page table supports per-PTE snoop control. The
+	 * iommu_map() interface will handle this by setting SNP bit.
+	 */
+	if (!domain_use_first_level(domain)) {
+		domain->set_pte_snp = true;
+		return;
+	}
+
+	list_for_each_entry(info, &domain->devices, link)
+		intel_pasid_setup_page_snoop_control(info->iommu, info->dev,
+						     PASID_RID2PASID);
+}
+
 static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	unsigned long flags;
 
-	if (!domain_update_iommu_snooping(NULL))
+	if (dmar_domain->force_snooping)
+		return true;
+
+	spin_lock_irqsave(&device_domain_lock, flags);
+	if (!domain_support_force_snooping(dmar_domain)) {
+		spin_unlock_irqrestore(&device_domain_lock, flags);
 		return false;
+	}
+
+	domain_set_force_snooping(dmar_domain);
 	dmar_domain->force_snooping = true;
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
 	return true;
 }
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index f8d215d85695..d19dd66a670c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -762,3 +762,45 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 
 	return 0;
 }
+
+/*
+ * Set the page snoop control for a pasid entry which has been set up.
+ */
+void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
+					  struct device *dev, u32 pasid)
+{
+	struct pasid_entry *pte;
+	u16 did;
+
+	spin_lock(&iommu->lock);
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (WARN_ON(!pte || !pasid_pte_is_present(pte))) {
+		spin_unlock(&iommu->lock);
+		return;
+	}
+
+	pasid_set_pgsnp(pte);
+	did = pasid_get_domain_id(pte);
+	spin_unlock(&iommu->lock);
+
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(pte, sizeof(*pte));
+
+	/*
+	 * VT-d spec 3.4 table23 states guides for cache invalidation:
+	 *
+	 * - PASID-selective-within-Domain PASID-cache invalidation
+	 * - PASID-selective PASID-based IOTLB invalidation
+	 * - If (pasid is RID_PASID)
+	 *    - Global Device-TLB invalidation to affected functions
+	 *   Else
+	 *    - PASID-based Device-TLB invalidation (with S=1 and
+	 *      Addr[63:12]=0x7FFFFFFF_FFFFF) to affected functions
+	 */
+	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
+	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
+
+	/* Device IOTLB doesn't need to be flushed in caching mode. */
+	if (!cap_caching_mode(iommu->cap))
+		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
