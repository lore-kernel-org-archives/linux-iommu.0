Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39E3307C
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347481; cv=none; b=ItxeA1+iwGiNB7cKB0ic3iheff6VWNiy5SsmHmFwI3ZO7OKFqxYRl1BFP36Gv1W2EKKJmGTX6NHbC/Q54RU/mZAs+PO71iCkEucoSK8tx38n050QbcYdGUJifEZ1z1NXKHwjFaPHu5lXAEarldaJDpWzfAq8Tp7eyJENmVMgbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347481; c=relaxed/simple;
	bh=EIrw8//x87KHtvsBb1f6C/MXQbL7jFqKRftBnOFg1DE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ODU2fbUbeEpgUwvxQpKLx0Itr4hItL05jEzh6HdKghmnS7x2tehzV7bo9zFrwCXIqJBQNUmNFp+RU2PKUbn0KIQoCrz4uJjEfvDwv/jyuZb00rSsNO3VlFmJOVunbY5ifTVXlNtAJD/0o/Ovb10HOo4oZKQk8hKl+jAYJFwse3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dx6nhA1T; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dx6nhA1T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347480; x=1739883480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EIrw8//x87KHtvsBb1f6C/MXQbL7jFqKRftBnOFg1DE=;
  b=dx6nhA1T/QOlVE+AzARzjkiNZvKi5gsP6mWlzvLvMdUszOegIlp+CLXs
   d2W4fqE0vy6jc2reEuKpgUti1kcwLva3YOJonsEBgqvkx7LmivnSmAoCT
   ZrmmJ/qPSUyydNx4/xD6LAXcRUwvXxj1Q7bg/34nex+eg2hpOuDSoGMa2
   3igistUfcC9PCB61Uuw8iVH/N3y2yKDNuBMjx4JhZUc34uXEf6nClF7A4
   zCTMebnTbrhtHS4WI/Y80nE/mraN83XoMW72I2LGVT2mu1/cDf6c7fsMU
   pmXlM765gJHBvpD9Gjsw/+A0suNHP9IyojQxC7/etWCTxKKVtqUL/7p8E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2296472"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2296472"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4449312"
Received: from zhaojia-mobl2.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.255.28.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:58 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 12/13] iommu/vt-d: Sort dev_pasids list
Date: Mon, 19 Feb 2024 20:57:22 +0800
Message-Id: <20240219125723.1645703-13-tina.zhang@intel.com>
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

Sort dev_pasids list to make the devices behind same IOMMU stay
together.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ebbdbeefc402..f62094fc7512 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4605,7 +4605,7 @@ int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu = info->iommu;
-	struct dev_pasid_info *dev_pasid;
+	struct dev_pasid_info *dev_pasid, *curr;
 	unsigned long flags;
 	int ret;
 
@@ -4645,6 +4645,7 @@ int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_detach_iommu;
 
+	INIT_LIST_HEAD(&dev_pasid->link_domain);
 	dev_pasid->dev = dev;
 	dev_pasid->pasid = pasid;
 	dev_pasid->sid = PCI_DEVID(info->bus, info->devfn);
@@ -4659,7 +4660,15 @@ int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	 * and multiple readers
 	 */
 	spin_lock_irqsave(&dmar_domain->lock, flags);
-	list_add_rcu(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
+		info = dev_iommu_priv_get(curr->dev);
+		if (info->iommu == iommu) {
+			list_add_rcu(&dev_pasid->link_domain, &curr->link_domain);
+			break;
+		}
+	}
+	if (list_empty(&dev_pasid->link_domain))
+		list_add_rcu(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	if (domain->type & __IOMMU_DOMAIN_PAGING)
-- 
2.34.1

