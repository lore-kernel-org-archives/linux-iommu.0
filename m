Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8301F32C90
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347473; cv=none; b=JcSaiZy/lJnfC16uXTaWKaGmQb4uqqFEpJeVarsGnOuGnF2RNFDCZeXeb7V5sqUq/MfuSe9AYr7KJm4va/HKFJ243XBkvI9K5t6Dhp3tmJ4Qx4HFssJ5QymZ26PREBVdl5OStjFKRibV2YNj01HAbhcuFcYCwieeWAlzB6exIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347473; c=relaxed/simple;
	bh=tRA6jymA697yUSywA4xxlRqU12vlaRajTQrAF8yXzFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SLRZIt36apuIesuuCaJt0SqOUXLL+BQm//MRYY6n6U/XRfpM9LhYsbdeUPyEnWb2lZOK31ZSoQ3pt8K5Y3/EddHjhQh/x8GhlVhLinD4gT8irwcJP6522ENIaB2anYkg0gqStUrr81kNIXK0qQy5QHxJEbH31Fuigoaec24x53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7m/lRPN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7m/lRPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347472; x=1739883472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tRA6jymA697yUSywA4xxlRqU12vlaRajTQrAF8yXzFE=;
  b=N7m/lRPNDse/L7+QiZQZ19ZuYOfsq3niiyGpDXqhZR3sE2PlSJ3JHfth
   E+ZQ8RRVnZ4jZJ3sPzFxv11u1o96f/+FGbfmYk3eqELh2Yc0w9LdLAVV4
   jJeKbAeN0Z2BT5ESCc2ie+bcZnpdsm+/1bpGdUjBJrxQWDJtgNPpZIrF4
   w3thdLrtv1Uf8l3X2Ezq6MS4o5fF5YEz2qQCKeDgN29UG8k0oms2VBnIU
   fEQZB5qWXUDbJ/xsWxdTPNC2iVdgEg/J9fghdpHvRio9NOSIjzaUyTSRo
   khIdztRz3JZ5tf7JOTOlmM/BEkE1KJMuCiHLP0S7LaKB+Dew4XTjJIWj8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2296450"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2296450"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4449294"
Received: from zhaojia-mobl2.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.255.28.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:50 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 07/13] iommu/vt-d: Use RCU for dev_pasids list updates in set/remove_dev_pasid()
Date: Mon, 19 Feb 2024 20:57:17 +0800
Message-Id: <20240219125723.1645703-8-tina.zhang@intel.com>
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

Extend intel_iommu_remove_dev_pasid() and intel_iommu_set_dev_pasid() to
support updating dev_pasids list concurrently with readers.

This extension doesn't have any effect on the default domain operations.
Because for default domain operations, the dev_pasids list accesses are
protected by domain->lock and therefore all read/write accesses of default
domain operations to dev_pasids list are performed sequentially.

However, for sva domain, the dev_pasids list accesses are expected to
perform concurrently. For example, the callbacks invoked by memory
management notifier may run in a process which runs concurrently with
another process wherein the intel_iommu_set/remove_dev_pasid operations
are performed. Using RCU can give good read-side performance.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 98a23a3a6447..b7e1f0be880b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4569,7 +4569,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
 		if (curr->dev == dev && curr->pasid == pasid) {
-			list_del(&curr->link_domain);
+			list_del_rcu(&curr->link_domain);
 			dev_pasid = curr;
 			break;
 		}
@@ -4579,7 +4579,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 
 	domain_detach_iommu(dmar_domain, iommu);
 	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
-	kfree(dev_pasid);
+	kfree_rcu(dev_pasid, rcu);
 out_tear_down:
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
 	intel_drain_pasid_prq(dev, pasid);
@@ -4629,8 +4629,14 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 
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
2.34.1

