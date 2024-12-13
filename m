Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83892207A
	for <iommu@lists.linux.dev>; Fri, 13 Dec 2024 01:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052773; cv=none; b=Lu+zOoCul7h5jUb4wufmtxUsT0MVkuJi2ozDtm4SInQISpo/lWkvTrRJD2j9DLOUc3P4WJNAPjAdVvhRrWm/yLGolwi/9/uVoKnb1RKxGzDm4qPLUax8zZKF0tF9eZ0n/FYG1S+Z2Wacmhf7WIfpI0zaVNPzrGrP7JBQHtOlVPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052773; c=relaxed/simple;
	bh=oFTAE7oILI0nnbHGudLD0dYAdhiiCnQbK/kloxuCPM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cl/WwCbDhTwwzPgMvi3yjesWG9nI8le95fNP25AvvklFGMVgsw8BJeaQHrCg+CC121OqtLHzaCPou8NMQ8pk6uudHdDguezewgiC3aoKtZ1RbmTg+hKIUbUh35VUkkP1dcmmmcJN4hf49mNXJ0LJVXN/i58ebtyRVyypl1DGGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hj1nCrmu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hj1nCrmu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734052772; x=1765588772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFTAE7oILI0nnbHGudLD0dYAdhiiCnQbK/kloxuCPM4=;
  b=Hj1nCrmuOfuGm9RFMWK204JyoCQyppsEXDfFrm2RFdAhQN5iCr8M+WAL
   zmntgoe9XL3fRaHgI+K/MDZjAL+YiS4I8rbp/ZFG/wXJ/V2km4RzblQXs
   DhQju9pTLI1pLb+JcDUBzq5wSFZ+bU6pPpc2jS/mtAQr3aqA+WqMnY+l0
   GU4hcDN7LdKqNLQ1XSK9Nxjs7cMd3Ot+KklL6LASCJ24KvUbCrb0CHL8e
   xqvFnCChLKV6UE0TrhyG69D6ALYtSzAcBtqxwS5w6moeFQtALbXgIp4UB
   S+iKgNfxlxR5kelFTeTSESMOsXzxWdbLMKHIsHGOjEUN2GeKi5ZFGx9rM
   Q==;
X-CSE-ConnectionGUID: MqjR8firTomqp9SHN51ZTA==
X-CSE-MsgGUID: Y/RJmSGnSeS13HEv0GZL+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45510018"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45510018"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 17:19:31 -0800
X-CSE-ConnectionGUID: sjSfKWVZSyG+SPkpKWQk6w==
X-CSE-MsgGUID: FV7igCqmRqCVX/3r1uCpLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96835622"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by orviesa007.jf.intel.com with ESMTP; 12 Dec 2024 17:19:30 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iommu/vt-d: Fix qi_batch NULL pointer with nested parent domain
Date: Fri, 13 Dec 2024 09:17:51 +0800
Message-ID: <20241213011752.1177061-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213011752.1177061-1-baolu.lu@linux.intel.com>
References: <20241213011752.1177061-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

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
Cc: stable@vger.kernel.org
Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20241210130322.17175-1-yi.l.liu@intel.com
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
2.43.0

