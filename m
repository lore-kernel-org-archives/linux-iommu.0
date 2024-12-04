Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4A31BC08B
	for <iommu@lists.linux.dev>; Wed,  4 Dec 2024 12:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315377; cv=none; b=DQozlP0N/EUH9J66WPBRcxGgJZ9B768IxGwZ7AUVR4EaJmc0o6Sz9OHI6qwzsd+mCkOOlcURxIbSY8RSC4QolwZ2fP4Kz2rl+obp13lkcsRjg7/Ai3Bm0zDXT7loN7pN3Q8wNvn+Z3ZdOmYpGt8G+mktAHyJ0y3Jb9H6WVgssH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315377; c=relaxed/simple;
	bh=ixl4NVgGRwnFbA2YeAKjSw/niLGNUvw+ItsuN8Jk+ac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GEIdEA+QOlesEpkv7k6q+iCGSpnU0HgawSlo/lfDUucB6PWuSl7gDG+oLF6UXZfOirFsIdERldFkXYvFRedetOPMwCwS8LPyxxiwkinCgjg+Mk3ZTyejx9LX/6bQV4rq19Uo0kzNVQLXLy7eHUu4bgG8bCvTuO5wxD80lx2VX/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fk0Dks8A; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fk0Dks8A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733315376; x=1764851376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ixl4NVgGRwnFbA2YeAKjSw/niLGNUvw+ItsuN8Jk+ac=;
  b=Fk0Dks8AzBUjzWxXPVehtiC7iNAE94BgHRpInUzCC/fJ9IzkLt7BdgTN
   jsfMLvtTL+Fsul54JCmPOLNi8YmKHSF808SWqngOlmkfCCRFxZfZ+n7wM
   Fw5KwyBPL9e9wWrYcEoLkTmJ0SJg0pxMEL9nj+fpmLZfaANqRilfkUJBC
   G4rW8YD3iujlymtUdjeGtE61e05VDDyNxMal8tr70QrhJY3QZAoY3jjJ6
   mQXb8HQtUXYpp24RNy1Dm/TaLW0A6YEqzQkmKeKhM1hfkZylvrlQyrXjx
   pq0m0ZtrnXG+HYvWIg/R/YUpoBbmRZNkAfuGb3Z3fflIPTS7Y/X5mra8C
   g==;
X-CSE-ConnectionGUID: q51rA+FgR4qYT0dImQWpTQ==
X-CSE-MsgGUID: 2/DzwdO+TNmo10II8uNIlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32937911"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="32937911"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 04:29:33 -0800
X-CSE-ConnectionGUID: DS6hbnLrSm6zqQU3b1fdTQ==
X-CSE-MsgGUID: 6g8d+j1uRqWT8yi1LYC1Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93599079"
Received: from unknown (HELO 984fee00a4c6.jf.intel.com) ([10.165.58.231])
  by orviesa010.jf.intel.com with ESMTP; 04 Dec 2024 04:29:33 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v6 5/7] iommu/vt-d: Make the blocked domain support PASID
Date: Wed,  4 Dec 2024 04:29:26 -0800
Message-Id: <20241204122928.11987-6-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204122928.11987-1-yi.l.liu@intel.com>
References: <20241204122928.11987-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocked domain can be extended to park PASID of a device to be the
DMA blocking state. By this the remove_dev_pasid() op is dropped.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7d0acb74d5a5..e0c835a9831f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3248,10 +3248,15 @@ static int blocking_domain_attach_dev(struct iommu_domain *domain,
 	return 0;
 }
 
+static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *old);
+
 static struct iommu_domain blocking_domain = {
 	.type = IOMMU_DOMAIN_BLOCKED,
 	.ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= blocking_domain_attach_dev,
+		.set_dev_pasid	= blocking_domain_set_dev_pasid,
 	}
 };
 
@@ -4097,13 +4102,16 @@ void domain_remove_dev_pasid(struct iommu_domain *domain,
 	kfree(dev_pasid);
 }
 
-static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
-					 struct iommu_domain *domain)
+static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t pasid,
+					 struct iommu_domain *old)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
 	intel_pasid_tear_down_entry(info->iommu, dev, pasid, false);
-	domain_remove_dev_pasid(domain, dev, pasid);
+	domain_remove_dev_pasid(old, dev, pasid);
+
+	return 0;
 }
 
 struct dev_pasid_info *
@@ -4476,7 +4484,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
-	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
 	.pgsize_bitmap		= SZ_4K,
 	.page_response		= intel_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.34.1

