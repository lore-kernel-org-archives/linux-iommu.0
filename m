Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7865621103
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 01:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IV1jfGLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705367589; x=1736903589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=xbPvu4VK4GtkG+D9584MOtuu0La0+AteRb0rjTcW9eY=;
  b=IV1jfGLo4qyAmSz+G1AcM78Q1pLNQMQw1QelK66dE50jkavygnhmhQEp
   KWipaKWXRnBuch7/rvAFM+gPmjTyXMouVJSAfFvn6NBca9qQlqYKG8qHU
   5/LwJe6/h7wphLr5XZGuXiJeRwO8iTEVrWTiqWJpK7Jy2K2Mi7BJcVqUi
   eVbzqfpd3jMqfoYNhmO3hgJbzJOBrwkvf4ba1M2ld+QRnJbUO08fQtYao
   3wfvHg3cwSY1OE0tId9UjHWwbZ4rL7h8B0G6fw/+yw7aak0/hwbKw37Qe
   fqzve4epvikPDtHRwRyveHoGjrer4G1CDJnQsOys9nmadKVxtixrwHLgv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464004450"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="464004450"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:13:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733427399"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733427399"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 17:13:04 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 07/11] iommu/vt-d: Use RCU for dev_pasids list updates in set/remove_dev_pasid()
Date: Tue, 16 Jan 2024 09:11:42 +0800
Message-Id: <20240116011146.18645-8-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116011146.18645-1-tina.zhang@intel.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Extend intel_iommu_remove_dev_pasid() and intel_iommu_set_dev_pasid() to
support updating dev_pasids list concurrently with readers.

For default domain operations, the dev_pasids list accesses are protected
by domain->lock and therefore all read/write accesses of default domain
operations to dev_pasids list are performed sequentially. However, for sva
domain, the dev_pasids list accesses could be performed concurrently.
For example, the callbacks invoked by memory management notifier may run
in a process which runs concurrently with another process wherein the
intel_iommu_set/remove_dev_pasid operations are performed.

To extend intel_iommu_set/remove_dev_pasid() to have the ability to update
the dev_pasids list concurrently with multiple readers (which is required
by sva domain), RCU mechanism is being used here.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 847e21117e7a..0eec5d971315 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4553,7 +4553,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
 		if (curr->dev == dev && curr->pasid == pasid) {
-			list_del(&curr->link_domain);
+			list_del_rcu(&curr->link_domain);
 			dev_pasid = curr;
 			break;
 		}
@@ -4563,7 +4563,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 
 	domain_detach_iommu(dmar_domain, iommu);
 	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
-	kfree(dev_pasid);
+	kfree_rcu(dev_pasid, rcu);
 out_tear_down:
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 	intel_drain_pasid_prq(dev, pasid);
@@ -4613,8 +4613,14 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 
 	dev_pasid->dev = dev;
 	dev_pasid->pasid = pasid;
+
+	/*
+	 * Spin lock protects dev_pasids list from being updated concurrently with
+	 * multiple updaters, while rcu ensures concurrency between one updater
+	 * and multiple readers
+	 */
 	spin_lock_irqsave(&dmar_domain->lock, flags);
-	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+	list_add_rcu(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	if (domain->type & __IOMMU_DOMAIN_PAGING)
-- 
2.39.3

