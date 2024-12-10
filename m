Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D11A2846
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835806; cv=none; b=oBjsDELbmOIkImsS1fsjgzAokVWlW/IS3gT6rj14TvydLJy3YMIxoCpOuihMfMYlu+9hNJ80Y9oxB2lhe/LU0lgC5ihKKclqFPsAbZNiRGIrsOIf/i8i/RT9403v6/f/RjS2+ColrdlsYViDvuVR4ijtfaY1WQf7CbbZ1FaGstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835806; c=relaxed/simple;
	bh=B75tNjKQhevbcTVExx2aMKJ7Rdvz+ByxuuZhYvYtgm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qw2Fnh+njIIiv5sunmAa6vi0nSQk3bltBmLGG2bN4htT56mlE0MpJvRoEWyqPyxu70X5PsjrqH5Zcd4jpapOqTadAHmQSO+BBDRLQndpMTyDpUIsvQFUNuQi0e1lakqrMUeCaDxyLvZt0t/F9I/2X3FL6uAJcHo/xjYW1gG6TCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhvQ8QYq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhvQ8QYq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733835805; x=1765371805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B75tNjKQhevbcTVExx2aMKJ7Rdvz+ByxuuZhYvYtgm8=;
  b=PhvQ8QYqMd/uoEJdt2K1G6SxnktOQneGRVzK6s1u4U0rm5NdNUVMNrPU
   HJvdNaU+8UAEEjvgYWbKr+0sE1pEmitd75gjRLrI3z4D3UCHmHZqTm+sF
   beZkZk/r4WcrWHPZG0zYzDMgFvR19Kr0qLYcKhNv/1fPBrOB1LuEL0ESk
   EyFr9QfU+AfKRdqdm+x5SezVGMyE4b1TunQH7SoV4gOcEOh66XroK4IDR
   neZMQ14RB4wGHITD99YrRXzPNTR+D1J3i9RfEX5H+D48zIFAWVqvQSQT3
   0nfNN5ykuLhX/0CDAm0rO+gfPKa0+KSGSha2tWS4/O6E8rLnVW33ZZUFu
   A==;
X-CSE-ConnectionGUID: Qf85yRppTYebjcona75k5Q==
X-CSE-MsgGUID: i/wslWeQRru3G1p94ZclUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="21760840"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="21760840"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 05:03:24 -0800
X-CSE-ConnectionGUID: NELILM2URh+7AbFQf7mEoA==
X-CSE-MsgGUID: MiVkhiWNQTebEAquQulAEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95609589"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa008.fm.intel.com with ESMTP; 10 Dec 2024 05:03:23 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev
Subject: [PATCH v2] iommu/vt-d: Fix qi_batch NULL pointer with nested parent domain
Date: Tue, 10 Dec 2024 05:03:22 -0800
Message-Id: <20241210130322.17175-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qi_batch is allocated when assigning cache tag for a domain. While
for nested parent domain, it is missed. Hence, when trying to map pages
to the nested parent, NULL dereference occurred. Also, there is potential
memleak since there is no lock around domain->qi_batch allocation.

To solve it, add a helper for qi_batch allocation, and call it in both
the __cache_tag_assign_domain() and __cache_tag_assign_parent_domain().

  BUG: kernel NULL pointer dereference, address: 0000000000000200
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 8104795067 P4D 0
  Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 223 UID: 0 PID: 4357 Comm: qemu-system-x86 Not tainted 6.13.0-rc1-00028-g4b50c3c3b998-dirty #2632
  Call Trace:
   ? __die+0x24/0x70
   ? page_fault_oops+0x80/0x150
   ? do_user_addr_fault+0x63/0x7b0
   ? exc_page_fault+0x7c/0x220
   ? asm_exc_page_fault+0x26/0x30
   ? cache_tag_flush_range_np+0x13c/0x260
   intel_iommu_iotlb_sync_map+0x1a/0x30
   iommu_map+0x61/0xf0
   batch_to_domain+0x188/0x250
   iopt_area_fill_domains+0x125/0x320
   ? rcu_is_watching+0x11/0x50
   iopt_map_pages+0x63/0x100
   iopt_map_common.isra.0+0xa7/0x190
   iopt_map_user_pages+0x6a/0x80
   iommufd_ioas_map+0xcd/0x1d0
   iommufd_fops_ioctl+0x118/0x1c0
   __x64_sys_ioctl+0x93/0xc0
   do_syscall_64+0x71/0x140
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 705c1cdf1e73 ("iommu/vt-d: Introduce batched cache invalidation")
Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
Change log:
v2:
 - Fix it by allocating domain->qi_batch under domain->cache_lock (Baolu)
 - Simplify the calltrace log in commit message (Baolu)

v1: https://lore.kernel.org/linux-iommu/20241207120304.5710-1-yi.l.liu@intel.com/
---
 drivers/iommu/intel/cache.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index e5b89f728ad3..09694cca8752 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -105,12 +105,35 @@ static void cache_tag_unassign(struct dmar_domain *domain, u16 did,
 	spin_unlock_irqrestore(&domain->cache_lock, flags);
 }
 
+/* domain->qi_batch will be freed in iommu_free_domain() path. */
+static int domain_qi_batch_alloc(struct dmar_domain *domain)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	if (domain->qi_batch)
+		goto out_unlock;
+
+	domain->qi_batch = kzalloc(sizeof(*domain->qi_batch), GFP_ATOMIC);
+	if (!domain->qi_batch)
+		ret = -ENOMEM;
+out_unlock:
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+
+	return ret;
+}
+
 static int __cache_tag_assign_domain(struct dmar_domain *domain, u16 did,
 				     struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	int ret;
 
+	ret = domain_qi_batch_alloc(domain);
+	if (ret)
+		return ret;
+
 	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_IOTLB);
 	if (ret || !info->ats_enabled)
 		return ret;
@@ -139,6 +162,10 @@ static int __cache_tag_assign_parent_domain(struct dmar_domain *domain, u16 did,
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	int ret;
 
+	ret = domain_qi_batch_alloc(domain);
+	if (ret)
+		return ret;
+
 	ret = cache_tag_assign(domain, did, dev, pasid, CACHE_TAG_NESTING_IOTLB);
 	if (ret || !info->ats_enabled)
 		return ret;
@@ -190,13 +217,6 @@ int cache_tag_assign_domain(struct dmar_domain *domain,
 	u16 did = domain_get_id_for_dev(domain, dev);
 	int ret;
 
-	/* domain->qi_bach will be freed in iommu_free_domain() path. */
-	if (!domain->qi_batch) {
-		domain->qi_batch = kzalloc(sizeof(*domain->qi_batch), GFP_KERNEL);
-		if (!domain->qi_batch)
-			return -ENOMEM;
-	}
-
 	ret = __cache_tag_assign_domain(domain, did, dev, pasid);
 	if (ret || domain->domain.type != IOMMU_DOMAIN_NESTED)
 		return ret;
-- 
2.34.1

