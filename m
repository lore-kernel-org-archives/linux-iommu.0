Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2D33999
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347479; cv=none; b=IWfvDqPr1AP/cevwEztbUSEwx83jpfKVeBvSibiejF7P2kdeOyCIAiS+8339S7TWF+mqqoN08N/tXbs3BJUFWOm4YFHsB0cBoGWxANz6TxArqlOZN5/ZTGPI75YTPCrMCBMOHg+yfCEoJo28BceumRoby2FE/TFC/2NORdaHXpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347479; c=relaxed/simple;
	bh=asEDmeXDl1N/4vOyb1Ze5R3nFBwcUgF3u9stk5nDo/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tFCGL9lLJOXKxH7ZOV9JL6P+g7fHOkJOiA4rY3WNnBlrWaPOfVrdvrKGMaTTBmxPcqhNaQ+B6AnjQh2bOq8daqXiYNuieu0SPpNtmX2uv0C18q0rg/W6iIkz7ICmYZgnFdxFBpa1d66F6xcT3CLGj/jkN02Hp21H7slFiacqzG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5PSmt31; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5PSmt31"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347478; x=1739883478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=asEDmeXDl1N/4vOyb1Ze5R3nFBwcUgF3u9stk5nDo/c=;
  b=T5PSmt31FJrzHY63zNsu7s9pa3qOOflcWZju0aOTAvPDXORrYuuACJAr
   hMOLiM7phIEllXR/XGjPQWCruVbxn6Mc37R8je8FglQQVNO37uZNEpKwC
   DY+XDxv2Yr/bBikv7EAnTldfb4CX97ytUl9iWdPHN1dYJGY9Y2AmwlQLG
   nLRYRZigjZVrVNRy4nRGbVyHsKfoH56VLcQUt28HAK8iCH3aMs34nnhBT
   irtCTCExgAZ6hf5EtCG0LBoCqiFWANOahFQJ+ggL+Zn6Zktxla4bKSCYK
   PtUqSoJAbMQvRZv8VLPQHYDHHBK4Q0sWhhr0RzEk2MdQp3JuBuAC5Pfez
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2296469"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2296469"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4449309"
Received: from zhaojia-mobl2.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.255.28.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:56 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 11/13] iommu/vt-d: Retire intel_svm_remove_dev_pasid function
Date: Mon, 19 Feb 2024 20:57:21 +0800
Message-Id: <20240219125723.1645703-12-tina.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219125723.1645703-1-tina.zhang@intel.com>
References: <20240219125723.1645703-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOMMU core has added a dedicated callback for allocating sva domain.
So intel driver doesn't need intel_svm_remove_dev_pasid function to handle
mm notification any more.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 12 +-----------
 drivers/iommu/intel/iommu.h |  4 ----
 drivers/iommu/intel/svm.c   | 34 ----------------------------------
 3 files changed, 1 insertion(+), 49 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0d4d8cee1639..ebbdbeefc402 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4576,19 +4576,9 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	unsigned long flags;
 
 	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
-	if (WARN_ON_ONCE(!domain))
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(domain)))
 		goto out_tear_down;
 
-	/*
-	 * The SVA implementation needs to handle its own stuffs like the mm
-	 * notification. Before consolidating that code into iommu core, let
-	 * the intel sva code handle it.
-	 */
-	if (domain_type_is_sva(dmar_domain)) {
-		intel_svm_remove_dev_pasid(dev, pasid);
-		goto out_tear_down;
-	}
-
 	dmar_domain = to_dmar_domain(domain);
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ec071a6a56f0..e09aa4ee609d 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1088,7 +1088,6 @@ int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
 					    struct mm_struct *mm);
-void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid);
 void intel_drain_pasid_prq(struct device *dev, u32 pasid);
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
@@ -1099,9 +1098,6 @@ static inline struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
 	return NULL;
 }
 
-static inline void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid)
-{
-}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 4cf7f5445e1a..38e9ff95029a 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -27,23 +27,6 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-static struct dev_pasid_info *
-domain_lookup_dev_pasid_info_by_dev(struct dmar_domain *domain, struct device *dev)
-{
-	struct dev_pasid_info *dev_pasid = NULL, *t;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(t, &domain->dev_pasids, link_domain) {
-		if (t->dev == dev) {
-			dev_pasid = t;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return dev_pasid;
-}
-
 int intel_svm_enable_prq(struct intel_iommu *iommu)
 {
 	struct iopf_queue *iopfq;
@@ -270,23 +253,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.arch_invalidate_secondary_tlbs = intel_arch_invalidate_secondary_tlbs,
 };
 
-void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
-{
-	struct iommu_domain *domain;
-	struct dev_pasid_info *dev_pasid;
-
-	domain = iommu_get_domain_for_dev_pasid(dev, pasid,
-						IOMMU_DOMAIN_SVA);
-	if (WARN_ON_ONCE(IS_ERR_OR_NULL(domain)))
-		return;
-
-	dev_pasid = domain_lookup_dev_pasid_info_by_dev(to_dmar_domain(domain), dev);
-	if (dev_pasid) {
-		list_del_rcu(&dev_pasid->link_domain);
-		kfree_rcu(dev_pasid, rcu);
-	}
-}
-
 /* Page request queue descriptor */
 struct page_req_dsc {
 	union {
-- 
2.34.1

