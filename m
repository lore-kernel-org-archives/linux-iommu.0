Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2B1917FA
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 05:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230852; cv=none; b=qoU8C+24LGDZWdWRwe8jJtsF2Ag9e32Wu28ShLZy8r8GmaOnNIOD5ZpHTrAS2q58oTvA56BWOgLBps2t7ESdO2bfxzhtUebm5epGP9mWFL3/KC9zA2hOE4hAm5NiSmEbwJihEKxKTZQ0popQZiPIUevktz7axuuavEJIUdjdj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230852; c=relaxed/simple;
	bh=cVcpJG58ZwwlEe+0JpLEUe88ZZHXyK1Q+Un+3Blnk6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QUjTfHWCmGAGzXA8mSS7apS+pBJwIUQS/AO/v3SdhX6uIlZjOU3cRc9s/utkObC9dSnwl1kxK1u3Nsxz87CHxndQnE5bVofqCPNJzcUH0nfni/+L/MJNtYlqwWidvxF6I2CjJJmKaBvril3XzS21p2JbSGdqCBxdZYxE+2zS4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YviYt36J; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YviYt36J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729230851; x=1760766851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cVcpJG58ZwwlEe+0JpLEUe88ZZHXyK1Q+Un+3Blnk6A=;
  b=YviYt36JcqwNVDzz0NdB4bZzha/FM/gqX/YtmEGCGnJMF2CkvIATrB8+
   dnL9QaAUE9gkjECFGiWcK3yKymecVJZ5zO8MQtZw/FcWV+qXAWE62q/rk
   i9unrBsOcpLlcAnh/ywiTZJz8wGnGY3joz3B/mSafiYuoXEm5UxffSLkS
   tzwHnos4x13o9qUEyMSlEmZIXJp4jal5FNxobAzyg4XAxGWs21WNEhPLy
   sC6qivhgM/ivG+STr4gp4dEdwP25WeQrq3MYaXqVwx9rcvpfVFaa4t9Sf
   h7PaYkLcKEYMYfSZv/J90ZQswOh4oP9+RssKtElxOCNPreB2fsAaTUQNR
   A==;
X-CSE-ConnectionGUID: M19WjLZoT1a3Lbi1rCUCHg==
X-CSE-MsgGUID: 6Q79XV99Rum2gA0LF1EYhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28708827"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28708827"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 22:54:08 -0700
X-CSE-ConnectionGUID: piAgi7oxSI2vf2ZzoDDHOA==
X-CSE-MsgGUID: azzAZwIUS9eq5kPDBjJM2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="79188591"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 17 Oct 2024 22:54:08 -0700
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
Subject: [PATCH v3 7/9] iommu/vt-d: Add set_dev_pasid callback for nested domain
Date: Thu, 17 Oct 2024 22:54:00 -0700
Message-Id: <20241018055402.23277-8-yi.l.liu@intel.com>
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

From: Lu Baolu <baolu.lu@linux.intel.com>

Extend intel_iommu_set_dev_pasid() to set a nested type domain to a PASID
of a device.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c  | 23 ++++++++++++++++++-----
 drivers/iommu/intel/iommu.h  |  3 +++
 drivers/iommu/intel/nested.c |  1 +
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 302260898c36..d089ac148a7e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -284,6 +284,11 @@ static int __init intel_iommu_setup(char *str)
 }
 __setup("intel_iommu=", intel_iommu_setup);
 
+static int domain_type_is_nested(struct dmar_domain *domain)
+{
+	return domain->domain.type == IOMMU_DOMAIN_NESTED;
+}
+
 static int domain_pfn_supported(struct dmar_domain *domain, unsigned long pfn)
 {
 	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
@@ -4304,7 +4309,12 @@ domain_add_dev_pasid(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret;
 
-	ret = domain_attach_device_sanitize(domain, dev);
+	/* Nested type domain should sanitize its parent domain */
+	if (domain_type_is_nested(dmar_domain))
+		ret = domain_attach_device_sanitize(
+				&dmar_domain->s2_domain->domain, dev);
+	else
+		ret = domain_attach_device_sanitize(domain, dev);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -4334,9 +4344,9 @@ domain_add_dev_pasid(struct iommu_domain *domain,
 	return ERR_PTR(ret);
 }
 
-static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
-				     struct device *dev, ioasid_t pasid,
-				     struct iommu_domain *old)
+int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid,
+			      struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
@@ -4357,7 +4367,10 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
 
-	if (dmar_domain->use_first_level)
+	if (domain_type_is_nested(dmar_domain))
+		ret = intel_pasid_setup_nested(iommu, dev, pasid,
+					       dmar_domain);
+	else if (dmar_domain->use_first_level)
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid);
 	else
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b020ae90c47e..d045397b0a4c 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1233,6 +1233,9 @@ void device_block_translation(struct device *dev);
 int domain_attach_device_sanitize(struct iommu_domain *domain,
 				  struct device *dev);
 void domain_update_iommu_cap(struct dmar_domain *domain);
+int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid,
+			      struct iommu_domain *old);
 
 int dmar_ir_support(void);
 
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index c1e97ad6be24..d57abca32810 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -132,6 +132,7 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 
 static const struct iommu_domain_ops intel_nested_domain_ops = {
 	.attach_dev		= intel_nested_attach_dev,
+	.set_dev_pasid		= intel_iommu_set_dev_pasid,
 	.free			= intel_nested_domain_free,
 	.cache_invalidate_user	= intel_nested_cache_invalidate_user,
 };
-- 
2.34.1

