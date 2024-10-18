Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584F91917D4
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 05:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230851; cv=none; b=DnZOIIhGkQwOfAVmHIlIT1oKXwJ3ReYwWMknA+F+orxvQSPUjoDEEtsxvzED0bteWnmzg+XAcoKT0mzfIgt9fxlGnWufueHg9qzXH+i4hLzcU+XAeie0TXsVPywVH4uS5sGZw5m3ugMbtfA/J5ocZeOVgFGqscIOulDQ6O0oRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230851; c=relaxed/simple;
	bh=+v7YQiQRiD5rjUn63mo5ukVlDTvOBshKA37K6keqEiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eLvwcXP1hP5nhvQUNKV/DBW0mHG3yo/bXFfYUR8pVTWDKHeXi5QuhzfN7CJ+Fx16DtElpxWh7X2V7GxkV2gQpXy211CHhTgo7gV4GUO0EQA4CHX72IgzE/1IcoR3CJeAv/jIXonKc6w4fgzlYghF56uofJijjJBRFwq1KFRJySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huRqEZZf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huRqEZZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729230849; x=1760766849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+v7YQiQRiD5rjUn63mo5ukVlDTvOBshKA37K6keqEiU=;
  b=huRqEZZfJ728q1VZzbJH4lZ/AFa1gRy82ZprWgcCNgttCPz2uTVgSsfb
   lMhYfzEFOBJDr14iDZm70IO0NVGhAN0Fcc2XbyYQKAvQY6npiW5u/eqde
   +Bv3KBd61oxXPUKfPzCSsrKPqTnahFb+fgArX4VoppGHqQ5Z9/GkJ0xuz
   kqJDVHkTFD0cmC0FhrbsdEuBQbbK//EXF5nH9woOdATeNVWdbfH9g4Odw
   xKixhK9rkFAEwi4PuSVQ7FNQpELa3PCxSDYSKAQ7lCTwz190gLqqCXhKp
   t/j1/jaiu6M3XhTwkBh1Uh+iv1z0aUrcXfJlieWjRQYQFAdIFPc0LXOu9
   w==;
X-CSE-ConnectionGUID: BxY8qhuqSnWjTQ/zPHUjbw==
X-CSE-MsgGUID: 1RZcOiL4QQy/kEcHQqgcpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28708820"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28708820"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 22:54:08 -0700
X-CSE-ConnectionGUID: x/8J1aRuQSym+na740XC2A==
X-CSE-MsgGUID: DpDrvVEIRmGahxGtCPFfrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="79188587"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 17 Oct 2024 22:54:07 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	will@kernel.org
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com
Subject: [PATCH v3 6/9] iommu/vt-d: Make intel_iommu_set_dev_pasid() to handle domain replacement
Date: Thu, 17 Oct 2024 22:53:59 -0700
Message-Id: <20241018055402.23277-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018055402.23277-1-yi.l.liu@intel.com>
References: <20241018055402.23277-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_dev_pasid op is going to support domain replacement and keep the old
hardware configuration if it fails. Make the Intel iommu driver be prepared
for it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 97 ++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8d92a221d020..302260898c36 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4250,8 +4250,8 @@ static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	return 0;
 }
 
-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-					 struct iommu_domain *domain)
+static void domain_remove_dev_pasid(struct iommu_domain *domain,
+				    struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dev_pasid_info *curr, *dev_pasid = NULL;
@@ -4259,11 +4259,6 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	struct dmar_domain *dmar_domain;
 	unsigned long flags;
 
-	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
-		intel_pasid_tear_down_entry(iommu, dev, pasid, 0);
-		return;
-	}
-
 	dmar_domain = to_dmar_domain(domain);
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
@@ -4280,13 +4275,27 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
 	domain_detach_iommu(dmar_domain, iommu);
 	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
 	kfree(dev_pasid);
+}
+
+static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *domain)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
 	intel_pasid_tear_down_entry(iommu, dev, pasid,
 				    INTEL_PASID_TEARDOWN_DRAIN_PRQ);
+
+	/* Identity domain has no meta data for pasid. */
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		return;
+
+	domain_remove_dev_pasid(domain, dev, pasid);
 }
 
-static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
-				     struct device *dev, ioasid_t pasid,
-				     struct iommu_domain *old)
+static struct dev_pasid_info *
+domain_add_dev_pasid(struct iommu_domain *domain,
+		     struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -4295,22 +4304,13 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret;
 
-	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
-		return -EOPNOTSUPP;
-
-	if (domain->dirty_ops)
-		return -EINVAL;
-
-	if (context_copied(iommu, info->bus, info->devfn))
-		return -EBUSY;
-
 	ret = domain_attach_device_sanitize(domain, dev);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
 	if (!dev_pasid)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	ret = domain_attach_iommu(dmar_domain, iommu);
 	if (ret)
@@ -4320,6 +4320,43 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_detach_iommu;
 
+	dev_pasid->dev = dev;
+	dev_pasid->pasid = pasid;
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+
+	return dev_pasid;
+out_detach_iommu:
+	domain_detach_iommu(dmar_domain, iommu);
+out_free:
+	kfree(dev_pasid);
+	return ERR_PTR(ret);
+}
+
+static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+				     struct device *dev, ioasid_t pasid,
+				     struct iommu_domain *old)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_iommu *iommu = info->iommu;
+	struct dev_pasid_info *dev_pasid;
+	int ret;
+
+	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
+		return -EOPNOTSUPP;
+
+	if (domain->dirty_ops)
+		return -EINVAL;
+
+	if (context_copied(iommu, info->bus, info->devfn))
+		return -EBUSY;
+
+	dev_pasid = domain_add_dev_pasid(domain, dev, pasid);
+	if (IS_ERR(dev_pasid))
+		return PTR_ERR(dev_pasid);
+
 	if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid);
@@ -4327,24 +4364,18 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
 						     dev, pasid);
 	if (ret)
-		goto out_unassign_tag;
+		goto out_remove_dev_pasid;
 
-	dev_pasid->dev = dev;
-	dev_pasid->pasid = pasid;
-	spin_lock_irqsave(&dmar_domain->lock, flags);
-	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
-	spin_unlock_irqrestore(&dmar_domain->lock, flags);
+	if (old)
+		domain_remove_dev_pasid(old, dev, pasid);
 
 	if (domain->type & __IOMMU_DOMAIN_PAGING)
 		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
 
 	return 0;
-out_unassign_tag:
-	cache_tag_unassign_domain(dmar_domain, dev, pasid);
-out_detach_iommu:
-	domain_detach_iommu(dmar_domain, iommu);
-out_free:
-	kfree(dev_pasid);
+
+out_remove_dev_pasid:
+	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
 }
 
-- 
2.34.1

