Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239EAC433FE
	for <iommu@archiver.kernel.org>; Sun,  8 May 2022 12:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1D5840911;
	Sun,  8 May 2022 12:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GjJ92353Kxwn; Sun,  8 May 2022 12:38:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2E7D8408BE;
	Sun,  8 May 2022 12:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08604C0032;
	Sun,  8 May 2022 12:38:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC4A7C002D
 for <iommu@lists.linux-foundation.org>; Sun,  8 May 2022 12:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A71D760706
 for <iommu@lists.linux-foundation.org>; Sun,  8 May 2022 12:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yGUlKMEfoQRi for <iommu@lists.linux-foundation.org>;
 Sun,  8 May 2022 12:38:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D186760EE3
 for <iommu@lists.linux-foundation.org>; Sun,  8 May 2022 12:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652013518; x=1683549518;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CiZdEsd5O1Thd3MOkJmZf+9TrbEZ8a8dnl1TKG1jbMs=;
 b=EKiagnsqFO3am8ts0GhjaE3KtbTTu+8UBsAURhFmelXoHvAJ8kozGLKZ
 QVFtIBf9iCkX8uUb+BaJw3uhNeKpXh2BpXm9AYu1g93pqotJ22mCUWlnu
 8yWoosfiCKajZLlk/SomhAMBEXXtb6d+lvDrHqOvcBNg2d2rIFRLIRAHr
 q/hKXzcOziwd6UM6eCZDrsPDLyFYrpNcm+V+WDiDhKTFQww99XyM/Rc/i
 jgtzbzIR4+rmxrLdm/i18f9YOlJ2Pu57/pIPU0lubhjYi6QbSOgbi2cN2
 RJEnQJFEGPlt1KvZXvPgfSRDMstJObrwVdiQjurVye81nxbeWRctrI4Lt w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="331845781"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; d="scan'208";a="331845781"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2022 05:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; d="scan'208";a="710143734"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 08 May 2022 05:38:36 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v4 2/4] iommu/vt-d: Check domain force_snooping against
 attached devices
Date: Sun,  8 May 2022 20:35:23 +0800
Message-Id: <20220508123525.1973626-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508123525.1973626-1-baolu.lu@linux.intel.com>
References: <20220508123525.1973626-1-baolu.lu@linux.intel.com>
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

As domain->force_snooping only impacts the devices attached with the
domain, there's no need to check against all IOMMU units. On the other
hand, force_snooping could be set on a domain no matter whether it has
been attached or not, and once set it is an immutable flag. If no
device attached, the operation always succeeds. Then this empty domain
can be only attached to a device of which the IOMMU supports snoop
control.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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
index b4802f4055a0..048ebfbd5fcb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2459,7 +2459,7 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 	if (level == 5)
 		flags |= PASID_FLAG_FL5LP;
 
-	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
+	if (domain->force_snooping)
 		flags |= PASID_FLAG_PAGE_SNOOP;
 
 	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
@@ -4444,7 +4444,7 @@ static int intel_iommu_map(struct iommu_domain *domain,
 		prot |= DMA_PTE_READ;
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= DMA_PTE_WRITE;
-	if (dmar_domain->force_snooping)
+	if (dmar_domain->set_pte_snp)
 		prot |= DMA_PTE_SNP;
 
 	max_addr = iova + size;
@@ -4567,13 +4567,60 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
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
