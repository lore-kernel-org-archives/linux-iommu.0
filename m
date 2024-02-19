Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B0132C8E
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347466; cv=none; b=JC+RPMF8PwUml1+/JP8b5aVqYNCzCGEdy47xBn3vBq4Xchv+qDomQ8/8PGy13MLimekRlTjlGxOuXUCEmyT+pDCfTNg22W7LH6ll8U8vefpd+z97lV9UOwrBi5ZAyRJEG9KG4+92Msk6C2bB/aCgXpPKfUYmSxQdo5Oi0Jqerfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347466; c=relaxed/simple;
	bh=aDBFn5kGbXZo5DZK+q8KkVrxffQ83NSGgA8Hwz9evF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f026WBqlbZrp6lNAUn1le4o9twBTgbbE4ursoax/H3D6H0P2fT7N+VzE7yFxIhst5q0ryrttnBgIvpFvA0rhZMkEy7PxZaNNAs91onlvqS8KCKm3Si2MHWKS36V5KfYCd+aNUXQqavAqTagHWBugMv6o1WsPGMzDYb2SP/OL9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kW+hySld; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kW+hySld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708347465; x=1739883465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aDBFn5kGbXZo5DZK+q8KkVrxffQ83NSGgA8Hwz9evF8=;
  b=kW+hySldfV9VOiW3yVU6aP7ZcDEK19YTMkXplF6M+gO1nyyoJz6IiDJX
   hJYlpAwLW+BQu9otvoeXsHvS0GDRM9lSWi4hCe3+ysmHK3TNhtxJs97AV
   7NNIOj/DEBdYEUnNQRf4RlY3X1eHxNuWHOc5OGIXr6lJ4k1odCVg+hiKE
   t6DqRm5tzQupBUCee5PAry+cJmqNsSW1pqmN6DN95EmaDzfx3oC17jVtI
   d0DGYx7cdNGBLE1O6FHcxqqhTlw/vNyPSg9iTwKd1N9qUagxOMYCwTjOR
   8e7rHamGA94/YD60lL2FxfXqYFLH5H3SUYAp0aINebOx7dxr/Mwkm3SEs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="2296433"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2296433"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="4449276"
Received: from zhaojia-mobl2.ccr.corp.intel.com (HELO tinazhan-desk1.www.tendawifi.com) ([10.255.28.137])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 04:57:42 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v2 03/13] iommu/vt-d: Refactor intel_svm_set_dev_pasid function
Date: Mon, 19 Feb 2024 20:57:13 +0800
Message-Id: <20240219125723.1645703-4-tina.zhang@intel.com>
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

Refactor intel_svm_set_dev_pasid() by moving the logic from
intel_svm_bind_mm() into intel_svm_set_dev_pasid() and retire
intel_svm_bind_mm(). No functional change intended.

The motivation is to enable intel_iommu_set_dev_pasid() to serve for both
sva domain's and default domain's set_dev_pasid operations, instead of
duplicating code for them.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/svm.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index a92a9e2239e2..1dd56d4eb88c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -315,10 +315,11 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	return 0;
 }
 
-static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
-			     struct iommu_domain *domain, ioasid_t pasid)
+static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
@@ -796,15 +797,6 @@ int intel_svm_page_response(struct device *dev,
 	return ret;
 }
 
-static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t pasid)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu = info->iommu;
-
-	return intel_svm_bind_mm(iommu, dev, domain, pasid);
-}
-
 static void intel_svm_domain_free(struct iommu_domain *domain)
 {
 	kfree(to_dmar_domain(domain));
-- 
2.34.1

