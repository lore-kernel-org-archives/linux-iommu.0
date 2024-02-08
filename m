Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD96A03B
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380594; cv=none; b=O2yCkSkTY8Sq+iyE4CFKYGMwSDO3uwF367b0yq4a2Fbzk8DioKFhz86BT5uqLm5Og19bxUandMZ3ZE8uXSPbf+VNAKQBs278RfyXTJjo7t+FG4mGgbQEaXPksHu7rFXu/LSU7SFMkr0xFjp8uhDNhPO84bB+lzDZqt0/mZp8wk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380594; c=relaxed/simple;
	bh=/GnRCRW90B1W9TXPxSmAiTyrVQIgkymW5d5jQqKtU2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b3Anv1JEjALO10v4JDLBvNrIJ1ecVnJxX2FtmiCJziSwd/ZRX48gpDRC+VjyaL0PBEzt4sbp+KrQtmXQX3ONZjlUlojXX8kZ0iIo/TUjIB/os/0c1qjUxDlCoskT4GKwqefLnYVY5JVGeL8XaUa5Tmdq9sTdPVM7GttJt5UMJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCwwPC09; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCwwPC09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707380592; x=1738916592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/GnRCRW90B1W9TXPxSmAiTyrVQIgkymW5d5jQqKtU2w=;
  b=hCwwPC09uzE9Gj+PaHWhSh9N1Hs7ZnHiqZxo0MGN1GqgjqX1L5TNqAxV
   9WbYb9OmriPg5n8/vmu6jFotPd7n6BJiaZUBTmVC8I0FE9Y93MAG5FOrJ
   ZAUl9oj01lmfgdojwhBux1+Jd4bi9VSoNMkXjq+hD2AeQX/TTWEUkGDWv
   2z+NwAPro82UEREeYsL06au2YRDis2X7QnTIgmZBg7fgzTWhFajxZ/hD+
   cblLN1b3egOrfjaZ5XnejXDr1PWQmP8ZKQKR3+zYksB+V3PoupF/ILkFz
   uGyIjW9cVkuQzx447ZJgpcSlJE/idl8b1xqrBtYXW7PSyyjSgne/SVuVi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="5036303"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="5036303"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 00:23:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6252090"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa003.jf.intel.com with ESMTP; 08 Feb 2024 00:23:10 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	robin.murphy@arm.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	yi.y.sun@linux.intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com
Subject: [PATCH rc 1/8] iommu/vt-d: Track nested domains in parent
Date: Thu,  8 Feb 2024 00:23:00 -0800
Message-Id: <20240208082307.15759-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208082307.15759-1-yi.l.liu@intel.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Today the parent domain (s2_domain) is unaware of which DID's are
used by and which devices are attached to nested domains (s1_domain)
nested on it. This leads to a problem that some operations (flush
iotlb/devtlb and enable dirty tracking) on parent domain only apply to
DID's and devices directly tracked in the parent domain hence are
incomplete.

This tracks the nested domains in list in parent domain. With this,
operations on parent domain can loop the nested domains and refer to
the devices and iommu_array to ensure the operations on parent domain
take effect on all the affected devices and iommus.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  | 18 ++++++++++++++----
 drivers/iommu/intel/iommu.h  |  6 ++++++
 drivers/iommu/intel/nested.c | 10 ++++++++++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6fb5f6fceea1..e393c62776f3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3883,6 +3883,7 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	bool nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 	struct intel_iommu *iommu = info->iommu;
+	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
 
 	/* Must be NESTING domain */
@@ -3908,11 +3909,16 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	if (nested_parent)
-		to_dmar_domain(domain)->nested_parent = true;
+	dmar_domain = to_dmar_domain(domain);
+
+	if (nested_parent) {
+		dmar_domain->nested_parent = true;
+		INIT_LIST_HEAD(&dmar_domain->s1_domains);
+		spin_lock_init(&dmar_domain->s1_lock);
+	}
 
 	if (dirty_tracking) {
-		if (to_dmar_domain(domain)->use_first_level) {
+		if (dmar_domain->use_first_level) {
 			iommu_domain_free(domain);
 			return ERR_PTR(-EOPNOTSUPP);
 		}
@@ -3924,8 +3930,12 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 
 static void intel_iommu_domain_free(struct iommu_domain *domain)
 {
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+
+	WARN_ON(dmar_domain->nested_parent &&
+		!list_empty(&dmar_domain->s1_domains));
 	if (domain != &si_domain->domain)
-		domain_exit(to_dmar_domain(domain));
+		domain_exit(dmar_domain);
 }
 
 int prepare_domain_attach_device(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d02f916d8e59..9b27edb73aa9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -627,6 +627,10 @@ struct dmar_domain {
 			int		agaw;
 			/* maximum mapped address */
 			u64		max_addr;
+			/* Protect the s1_domains list */
+			spinlock_t	s1_lock;
+			/* Track s1_domains nested on this domain */
+			struct list_head s1_domains;
 		};
 
 		/* Nested user domain */
@@ -637,6 +641,8 @@ struct dmar_domain {
 			unsigned long s1_pgtbl;
 			/* page table attributes */
 			struct iommu_hwpt_vtd_s1 s1_cfg;
+			/* link to parent domain siblings */
+			struct list_head s2_link;
 		};
 	};
 
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index f26c7f1c46cc..42d4d222e70f 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -70,6 +70,12 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 
 static void intel_nested_domain_free(struct iommu_domain *domain)
 {
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct dmar_domain *s2_domain = dmar_domain->s2_domain;
+
+	spin_lock(&s2_domain->s1_lock);
+	list_del(&dmar_domain->s2_link);
+	spin_unlock(&s2_domain->s1_lock);
 	kfree(to_dmar_domain(domain));
 }
 
@@ -201,5 +207,9 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 	spin_lock_init(&domain->lock);
 	xa_init(&domain->iommu_array);
 
+	spin_lock(&s2_domain->s1_lock);
+	list_add(&domain->s2_link, &s2_domain->s1_domains);
+	spin_unlock(&s2_domain->s1_lock);
+
 	return &domain->domain;
 }
-- 
2.34.1

