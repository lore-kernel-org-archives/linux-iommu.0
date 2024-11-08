Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6BD19342F
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032129; cv=none; b=n4/t2qCv81u3shzzf0s8Fp/lkeh3GrMj6PaamVMTzcv1rlbcCkDxwe5kS6uCAn45PMkWroR5GgbMfM1ZQuSwJW1A5QOw09z5cEeMp9f5Gh1bwNXctRyGjFClDiA43GvEAIFHhRQKXIOSDR9KmoLY8bkB+9hmErVeXYJncpY+BOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032129; c=relaxed/simple;
	bh=bzOyekv0clUGynmdW7dlvJLFDi2gKYykZx0AhaRfTPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPb6IhC+dpWWl4Ptt46lxPEM4mqmbUf5LdYOW1ggI6nmXuEd+FKEGRT6ShmszHJr85pjhzd3WQ/MkDGMTheV/zsm5IQnH/IC8mEjhsvt5FMseTH9YmkzNi8wOUJmsqYJI/cgLACWTAb5iUpIiyt0AwaHd9bleNImHtY2yXoWp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejwKYQ5T; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejwKYQ5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032129; x=1762568129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bzOyekv0clUGynmdW7dlvJLFDi2gKYykZx0AhaRfTPk=;
  b=ejwKYQ5Tsy7rqUuhuz+ljgHbV1lpYQga5zALCSHI02ecE0GAHKT1MSwT
   60ZUeLPpl8wAd3Ag2EJjSMD7G0mBQq08A2otGY7r4jgaIUOxH7VyIcslv
   hFNcUiKL8Qi6BG6qDWKtA845F3T29kYW1i+sg3b4Px80jRKilssWhRXed
   h+6kBRlQN5LYLnSj15aGmpoF4v7O9PC63VQh/ROwIUs0IYJkkfFo1jwjJ
   qsLqIrwsNzd8MdflcFT0eVOIH2MgqEeewwlhO4k5M6lAot/Bckpmab4Bn
   aP6TmWcs+/1iorcqF9snGwVH9NaUoZUuwmSZZFqYsefc7Ycu7gzAHEZwC
   w==;
X-CSE-ConnectionGUID: 6V1TI6mNTZW1Rzef/ZS5sQ==
X-CSE-MsgGUID: W/v+MqLsQ0aK76we7CgOHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31007858"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31007858"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:15:20 -0800
X-CSE-ConnectionGUID: 9cKA4ULqSLy7b0vvOVwdTg==
X-CSE-MsgGUID: crUOT37tSMOSb/dVl35N0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="116213840"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2024 18:15:18 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] iommu/vt-d: Add set_dev_pasid callback for nested domain
Date: Fri,  8 Nov 2024 10:14:02 +0800
Message-ID: <20241108021406.173972-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108021406.173972-1-baolu.lu@linux.intel.com>
References: <20241108021406.173972-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

Add intel_nested_set_dev_pasid() to set a nested type domain to a PASID
of a device.

Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20241107122234.7424-12-yi.l.liu@intel.com
---
 drivers/iommu/intel/iommu.c  |  6 -----
 drivers/iommu/intel/iommu.h  |  7 +++++
 drivers/iommu/intel/nested.c | 50 ++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ba984cb4aa44..b380b38315b2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1812,12 +1812,6 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 					  (pgd_t *)pgd, flags, old);
 }
 
-static bool dev_is_real_dma_subdevice(struct device *dev)
-{
-	return dev && dev_is_pci(dev) &&
-	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
-}
-
 static int dmar_domain_attach_device(struct dmar_domain *domain,
 				     struct device *dev)
 {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d23977cc7d90..2cca094c259d 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -22,6 +22,7 @@
 #include <linux/bitfield.h>
 #include <linux/xarray.h>
 #include <linux/perf_event.h>
+#include <linux/pci.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -832,6 +833,12 @@ iommu_domain_did(struct iommu_domain *domain, struct intel_iommu *iommu)
 	return domain_id_iommu(to_dmar_domain(domain), iommu);
 }
 
+static inline bool dev_is_real_dma_subdevice(struct device *dev)
+{
+	return dev && dev_is_pci(dev) &&
+	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
+}
+
 /*
  * 0: readable
  * 1: writable
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 989ca5cc04eb..42c4533a6ea2 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -130,8 +130,58 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 	return ret;
 }
 
+static int domain_setup_nested(struct intel_iommu *iommu,
+			       struct dmar_domain *domain,
+			       struct device *dev, ioasid_t pasid,
+			       struct iommu_domain *old)
+{
+	if (!old)
+		return intel_pasid_setup_nested(iommu, dev, pasid, domain);
+	return intel_pasid_replace_nested(iommu, dev, pasid,
+					  iommu_domain_did(old, iommu),
+					  domain);
+}
+
+static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid,
+				      struct iommu_domain *old)
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
+	if (context_copied(iommu, info->bus, info->devfn))
+		return -EBUSY;
+
+	ret = paging_domain_compatible(&dmar_domain->s2_domain->domain, dev);
+	if (ret)
+		return ret;
+
+	dev_pasid = domain_add_dev_pasid(domain, dev, pasid);
+	if (IS_ERR(dev_pasid))
+		return PTR_ERR(dev_pasid);
+
+	ret = domain_setup_nested(iommu, dmar_domain, dev, pasid, old);
+	if (ret)
+		goto out_remove_dev_pasid;
+
+	domain_remove_dev_pasid(old, dev, pasid);
+
+	return 0;
+
+out_remove_dev_pasid:
+	domain_remove_dev_pasid(domain, dev, pasid);
+	return ret;
+}
+
 static const struct iommu_domain_ops intel_nested_domain_ops = {
 	.attach_dev		= intel_nested_attach_dev,
+	.set_dev_pasid		= intel_nested_set_dev_pasid,
 	.free			= intel_nested_domain_free,
 	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
 };
-- 
2.43.0

