Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740D2C6A3
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341716; cv=none; b=PTaKVkf2BJYC5iAXUGu1q6maj1q3lCDAW8PP9We8fhYZGs3FN3FxEot3mc9KhyCMUURNe1rxG+H5x0/SNP8Xv5xOeI5QonXI//h5bc7vDpvWY7oF4M9l8sH8xaRwCY55w+PpR5Dd/x1bxJTutmNerQgChEz2ZiB/M3A4gu/Y3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341716; c=relaxed/simple;
	bh=FU4fhoGWvuGe6qI9myzpUIIpInnM2vTTQxC1ESzz82w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tu47pkt+j/8aCXsxkgq3I5cUn6ZItjXZfBXBBdbFZ5hs6eX3ClYVFeCiDxn9TsgdkPGesgDs21PAHO9y0V2y8U6pd1kNq0sI5owP+LimxvUM52/Lro+qAcURAB5fFUFCa6nPLtK/cYzBfplf8Aagztl4aXPEnKpT66hL800hMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3HQxZ2S; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3HQxZ2S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708341716; x=1739877716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FU4fhoGWvuGe6qI9myzpUIIpInnM2vTTQxC1ESzz82w=;
  b=c3HQxZ2SffUSjsvN3/rHwb1MArztMxPkaZTD4B4+pRwTIFIfZq0BWQsY
   GLcohVg0dCAwDuHy+h0ycVG3AY6dovlwsS0MSxKqkadQtVp5YF13UmzvU
   NbtPQq15PM8HDcrOYoju2s3wohPMzGRVhqDXk//dz9iRQ4DfcPlOIp713
   LRLlwy9RTNslH4KzboIekwC3RmAkDYCtkRGOFuMBnl9CqHrBiJbc8vj6F
   b1FyWJncuXqubIwH7sjypzcVrJpLC5QJ1qv4mcOVw+rSax3nRTeU1lArS
   Uj6N2ghr664Sn0hM4/FuwnhUaE3j6yNF/0c11+LJWDF2yWgzzdET/bHD/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="13823337"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="13823337"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4826784"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2024 03:21:52 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] iommu/vt-d: Track nested domains in parent
Date: Mon, 19 Feb 2024 19:15:52 +0800
Message-Id: <20240219111601.96405-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219111601.96405-1-baolu.lu@linux.intel.com>
References: <20240219111601.96405-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240208082307.15759-2-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h  |  6 ++++++
 drivers/iommu/intel/iommu.c  | 18 ++++++++++++++----
 drivers/iommu/intel/nested.c | 12 +++++++++++-
 3 files changed, 31 insertions(+), 5 deletions(-)

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
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index f26c7f1c46cc..6a75f6eb18f1 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -70,7 +70,13 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 
 static void intel_nested_domain_free(struct iommu_domain *domain)
 {
-	kfree(to_dmar_domain(domain));
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct dmar_domain *s2_domain = dmar_domain->s2_domain;
+
+	spin_lock(&s2_domain->s1_lock);
+	list_del(&dmar_domain->s2_link);
+	spin_unlock(&s2_domain->s1_lock);
+	kfree(dmar_domain);
 }
 
 static void nested_flush_dev_iotlb(struct dmar_domain *domain, u64 addr,
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

