Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4842264FB2
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377797; cv=none; b=Zemf4mgx3bJZWVhlDfJHWvQRb8akAO20Kh23E8zcMkWJYnKqMYvEKP7Kdj2ldiWU64MKqEAjvXG2FH1V2OqHvGUlfKfrFImFJdF65k9mj6EL1DisHA2Abfaw1EYha9Xp2buzCPja8ltNsyQS6WVgcP0GucxnqDGYMR81Wc5qTD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377797; c=relaxed/simple;
	bh=+hW7JcAr+6EOSDzqv7OIfCrpIM+Dso5F0RZpEoC2c/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=If6oC+bKttwWuy6OWskuNN2ZoQq6r7qqYLv/CK4AvILoTV7hMB81XZlcpwseUValJvZcoWr9eFU4kieK6GKqIAfzgScFb9gtBejVFA5v8VsPX3xRhBUfXLE5Hd84C4ea37EfOl69XEjKRW0Z+yRQDoRazZPVPsWe9q0t20x/RWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRaMZFqp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRaMZFqp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745377796; x=1776913796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+hW7JcAr+6EOSDzqv7OIfCrpIM+Dso5F0RZpEoC2c/Q=;
  b=TRaMZFqpllG59xwjbhJjZP5TRAn51DuwrtRMN6QAZ6EMPARH9crdkB8K
   XB/Utxx3eS+LaKN22JrRCmfBGnrfR7e1b+jQ6U3QEJHjLVxK1Otw47vMI
   JDGdZX3uXGGYxdDOHqR2ie9cd9DjBv1wCnTCD4TaEAgQkVQI9lkf2/83X
   9v/qbC8ddqZL6nEwwpCAZLJSuWP33GhrmXpvn691nmSEz6XRRKLgcI576
   UUsxMjOra75ovpsUU2xVKxFz9aAbUEX18Ila1ohrUrLzGzmcsKu53db81
   u/0U252ruE/WOvFfViaunAoEphJ8Wf94MxrrE2tLT2EbsUDgSZ/XWoltW
   Q==;
X-CSE-ConnectionGUID: rXlMXJ4YQ+q/N2WjAz3scA==
X-CSE-MsgGUID: efTlMoTuRd2I/oa8jI2WZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57145940"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="57145940"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 20:09:55 -0700
X-CSE-ConnectionGUID: fB2ijo1rS32UJK9a9CbBVA==
X-CSE-MsgGUID: x/IwPMz2TDe1OlpeMDQ6qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="155398704"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 22 Apr 2025 20:09:53 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/3] iommu/vt-d: Replace spin_lock with mutex to protect domain ida
Date: Wed, 23 Apr 2025 11:10:19 +0800
Message-ID: <20250423031020.2189546-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
References: <20250423031020.2189546-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The domain ID allocator is currently protected by a spin_lock. However,
ida_alloc_range can potentially block if it needs to allocate memory to
grow its internal structures.

Replace the spin_lock with a mutex which allows sleep on block. Thus,
the memory allocation flags can be updated from GFP_ATOMIC to GFP_KERNEL
to allow blocking memory allocations if necessary.

Introduce a new mutex, did_lock, specifically for protecting the domain
ida. The existing spinlock will remain for protecting other intel_iommu
fields.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c | 12 ++++--------
 drivers/iommu/intel/iommu.h |  2 ++
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 0afba7434a5c..e25e8d3dedcb 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1101,6 +1101,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	iommu->node = NUMA_NO_NODE;
 	spin_lock_init(&iommu->lock);
 	ida_init(&iommu->domain_ida);
+	mutex_init(&iommu->did_lock);
 
 	ver = readl(iommu->reg + DMAR_VER_REG);
 	pr_info("%s: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 76e170922149..3a9ea0ad2cd3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1347,17 +1347,16 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	if (!info)
 		return -ENOMEM;
 
-	spin_lock(&iommu->lock);
+	guard(mutex)(&iommu->did_lock);
 	curr = xa_load(&domain->iommu_array, iommu->seq_id);
 	if (curr) {
 		curr->refcnt++;
-		spin_unlock(&iommu->lock);
 		kfree(info);
 		return 0;
 	}
 
 	num = ida_alloc_range(&iommu->domain_ida, FLPT_DEFAULT_DID + 1,
-			      cap_ndoms(iommu->cap) - 1, GFP_ATOMIC);
+			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
 	if (num < 0) {
 		pr_err("%s: No free domain ids\n", iommu->name);
 		goto err_unlock;
@@ -1367,19 +1366,17 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	info->did	= num;
 	info->iommu	= iommu;
 	curr = xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
-			  NULL, info, GFP_ATOMIC);
+			  NULL, info, GFP_KERNEL);
 	if (curr) {
 		ret = xa_err(curr) ? : -EBUSY;
 		goto err_clear;
 	}
 
-	spin_unlock(&iommu->lock);
 	return 0;
 
 err_clear:
 	ida_free(&iommu->domain_ida, info->did);
 err_unlock:
-	spin_unlock(&iommu->lock);
 	kfree(info);
 	return ret;
 }
@@ -1391,7 +1388,7 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	if (domain->domain.type == IOMMU_DOMAIN_SVA)
 		return;
 
-	spin_lock(&iommu->lock);
+	guard(mutex)(&iommu->did_lock);
 	info = xa_load(&domain->iommu_array, iommu->seq_id);
 	if (--info->refcnt == 0) {
 		ida_free(&iommu->domain_ida, info->did);
@@ -1399,7 +1396,6 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 		domain->nid = NUMA_NO_NODE;
 		kfree(info);
 	}
-	spin_unlock(&iommu->lock);
 }
 
 static void domain_exit(struct dmar_domain *domain)
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 993232292400..1e98c10ca553 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -722,6 +722,8 @@ struct intel_iommu {
 	unsigned char	name[16];    /* Device Name */
 
 #ifdef CONFIG_INTEL_IOMMU
+	/* mutex to protect domain_ida */
+	struct mutex	did_lock;
 	struct ida	domain_ida; /* domain id allocator */
 	unsigned long	*copied_tables; /* bitmap of copied tables */
 	spinlock_t	lock; /* protect context, domain ids */
-- 
2.43.0

