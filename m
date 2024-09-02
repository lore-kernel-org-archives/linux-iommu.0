Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8C144D0A
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244306; cv=none; b=bByHhLM+q0cUkqi3aFGelgCpqVMAHmqL1z5AvRT13D2ToJJxHoV0k2mOfEahWjauzeAOxEzZNXqE5elR25sEky6fdRbPiFVWV0dfhtk45lFuccqrkCaBg998dkUfRONN9lB9lPSaTCzUDxTOiej2+MQJ2i51HKuKolT/Zl059Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244306; c=relaxed/simple;
	bh=xGjTtLzwtzCEOrsJubGNRKuJETMqym6KddPhb61StuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HV2a1N6LUa7E/VcfzEGWXnHY20HzeTShZoD0Rto1EiQ2OSNpzTYdqHE9CJmN5cV5iCr/Bj4gFM+KlWPyxK8ok8qgUXwSj2IZZFE3WDcJmEqVKBjVLEiwl2bbOmtzcTfWq7YdZgvbvDsW/ajn3shSWe58DniWQz9MU7avunNQ3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mqm4B+1O; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mqm4B+1O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244304; x=1756780304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xGjTtLzwtzCEOrsJubGNRKuJETMqym6KddPhb61StuM=;
  b=mqm4B+1ObpeXI7kHS3tX6k1hrqmX9kSxTNUE7rnXYNSjXfz36Sq2pRGA
   wBSZMuGywZ+/iIWMaBU+WMPcPGzuPhaUenpxFpWzlgLjq06Q6EMk5n+cJ
   UB7T3nCpuEBBw1AUzAehBNFrbppgaZ4Ckgp2M1+d9EzYsfzVjJJIN+K1d
   TY9Y0rHPzeZOKBNnoQtq4MNQXaLzGJxBYEPf0nebFL5JHUyQaW6b/692B
   jc6VTPtzXmwXwechdeVGTdhN78Axkn5H7tujCY6IPHoAI9erbQf0xt2dc
   Zxf6BmisHe/tyRap6fz8kOmqFJCbPHTzVB91n8gzwnvi4HLBIXdpZEW9U
   g==;
X-CSE-ConnectionGUID: 7UYFa3q8R4ewDWwFcoj/SQ==
X-CSE-MsgGUID: mCK2ShKaSGuOQTX0L5uLEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994351"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994351"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:44 -0700
X-CSE-ConnectionGUID: SiikL3VkQBSnEg1JNZ3G4Q==
X-CSE-MsgGUID: ZJPvh4o2Riq1RFQ7G3lY+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359361"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:43 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] iommu/vt-d: Add qi_batch for dmar_domain
Date: Mon,  2 Sep 2024 10:27:23 +0800
Message-Id: <20240902022724.67059-14-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902022724.67059-1-baolu.lu@linux.intel.com>
References: <20240902022724.67059-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces a qi_batch structure to hold batched cache invalidation
descriptors on a per-dmar_domain basis. A fixed-size descriptor
array is used for simplicity. The qi_batch is allocated when the
first cache tag is added to the domain and freed during
iommu_free_domain().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Link: https://lore.kernel.org/r/20240815065221.50328-4-tina.zhang@intel.com
---
 drivers/iommu/intel/iommu.h  | 14 ++++++++++++++
 drivers/iommu/intel/cache.c  |  7 +++++++
 drivers/iommu/intel/iommu.c  |  1 +
 drivers/iommu/intel/nested.c |  1 +
 drivers/iommu/intel/svm.c    |  5 ++++-
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ba40db4f8399..428d253f1348 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -584,6 +584,19 @@ struct iommu_domain_info {
 					 * to VT-d spec, section 9.3 */
 };
 
+/*
+ * We start simply by using a fixed size for the batched descriptors. This
+ * size is currently sufficient for our needs. Future improvements could
+ * involve dynamically allocating the batch buffer based on actual demand,
+ * allowing us to adjust the batch size for optimal performance in different
+ * scenarios.
+ */
+#define QI_MAX_BATCHED_DESC_COUNT 16
+struct qi_batch {
+	struct qi_desc descs[QI_MAX_BATCHED_DESC_COUNT];
+	unsigned int index;
+};
+
 struct dmar_domain {
 	int	nid;			/* node id */
 	struct xarray iommu_array;	/* Attached IOMMU array */
@@ -608,6 +621,7 @@ struct dmar_domain {
 
 	spinlock_t cache_lock;		/* Protect the cache tag list */
 	struct list_head cache_tags;	/* Cache tag list */
+	struct qi_batch *qi_batch;	/* Batched QI descriptors */
 
 	int		iommu_superpage;/* Level of superpages supported:
 					   0 == 4KiB (no superpages), 1 == 2MiB,
diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 08f7ce2c16c3..2e997d782beb 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -190,6 +190,13 @@ int cache_tag_assign_domain(struct dmar_domain *domain,
 	u16 did = domain_get_id_for_dev(domain, dev);
 	int ret;
 
+	/* domain->qi_bach will be freed in iommu_free_domain() path. */
+	if (!domain->qi_batch) {
+		domain->qi_batch = kzalloc(sizeof(*domain->qi_batch), GFP_KERNEL);
+		if (!domain->qi_batch)
+			return -ENOMEM;
+	}
+
 	ret = __cache_tag_assign_domain(domain, did, dev, pasid);
 	if (ret || domain->domain.type != IOMMU_DOMAIN_NESTED)
 		return ret;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 779e258188cd..0500022e789e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1572,6 +1572,7 @@ static void domain_exit(struct dmar_domain *domain)
 	if (WARN_ON(!list_empty(&domain->devices)))
 		return;
 
+	kfree(domain->qi_batch);
 	kfree(domain);
 }
 
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 36a91b1b52be..433c58944401 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -83,6 +83,7 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 	spin_lock(&s2_domain->s1_lock);
 	list_del(&dmar_domain->s2_link);
 	spin_unlock(&s2_domain->s1_lock);
+	kfree(dmar_domain->qi_batch);
 	kfree(dmar_domain);
 }
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ef12e95e400a..078d1e32a24e 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -184,7 +184,10 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 static void intel_mm_free_notifier(struct mmu_notifier *mn)
 {
-	kfree(container_of(mn, struct dmar_domain, notifier));
+	struct dmar_domain *domain = container_of(mn, struct dmar_domain, notifier);
+
+	kfree(domain->qi_batch);
+	kfree(domain);
 }
 
 static const struct mmu_notifier_ops intel_mmuops = {
-- 
2.34.1

