Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20221A76C7
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146782; cv=none; b=tku86wIXq8yaRVSd6/niJfXPM7doqYG7S8SVWqJ0oLasYpyRtc8042Qc58CRbn0yUmUcr0SJG74BUsaczISFdGjgIfBvDGreJy9Hpto+vJlucxv3fgOexnSk09pOr/CCTyCveWl0J2C1zrpKdw/Q9Y0sy19ijGKEL1PXRJWSDj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146782; c=relaxed/simple;
	bh=eJnbdXSVn+GEBiW5+Hj1FPgapl74+6kqW5Y3FX6tTVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d7rWx9vK1oDdnxccRRdCdWYj2yHb+VhOGt5hsWxQn4ZXj7PtkLOm7XZzMXJRBvt1nRF6POBCSCBZOv0nTNRzGjeWXxSlW97evXd7EV/12RyPEwq61C9aBqseSA41FZqhB0E3hQ5Otavu6ueyzAXrH9EYNgCAq7vNNqQNelo1jVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8j0njSW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8j0njSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146781; x=1757682781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eJnbdXSVn+GEBiW5+Hj1FPgapl74+6kqW5Y3FX6tTVU=;
  b=T8j0njSWIEHJQXkW9FKDLRBhA756Kv+pMnyJgIFW7RxlwF2jsnAfai+2
   DsSdRZLVvpcOtLqZg6OEslqMdgD1J1xOHX0p4il2o53GvJRYne0mb++kc
   Z2ifMWaJWMNJBRIi6iL7fhcNBlrWtMv+uDjN2CwZvuySUUaSn1lFJn+6X
   G90ZqhL1sxGHM2b+3bRfvSBgoZHj4ogp837L88pv+SG2462MDfr7s9eW5
   FKc+T+iJum0Nt9OW9kmbN7dyKtHCqD/JYxsTMH0b0ZgS4J+sS2UJZ8/gt
   4FmhQ2P1sxlIFs7m4PJlrUkORVczVX4Q8PUWAw8BtO9vwmd/JFUIHPSNb
   Q==;
X-CSE-ConnectionGUID: SAqmWvJvTvWikwfiwoayQA==
X-CSE-MsgGUID: rtqEi3foRa2x5pd8GhOCFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="27911217"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="27911217"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:12:59 -0700
X-CSE-ConnectionGUID: Jb0cNorTQgyRdvnwVXzi+g==
X-CSE-MsgGUID: Asi1SK7lS2mN0cooJ7f7jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67996560"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2024 06:12:59 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v4 04/10] iommufd: Always pass iommu_attach_handle to iommu core
Date: Thu, 12 Sep 2024 06:12:49 -0700
Message-Id: <20240912131255.13305-5-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912131255.13305-1-yi.l.liu@intel.com>
References: <20240912131255.13305-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu_attach_handle is optional in the RID attach/replace API and the
PASID attach APIs. But it is a mandatory argument for the PASID replace API.
Without it, the PASID replace path cannot get the old domain. Hence, the
PASID path (attach/replace) requires the attach handle. As iommufd is the
major user of the RID attach/replace with iommu_attach_handle, this also
makes the iommufd always pass the attach handle for the RID path as well.
This keeps the RID and PASID path much aligned.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/fault.c           | 21 +++++++--------------
 drivers/iommu/iommufd/iommufd_private.h | 19 ++++++++++++++++---
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 50ce6c6e61be..9fa56b3c2b7d 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -121,7 +121,7 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 {
 	bool iopf_off = !hwpt->fault && old->fault;
 	bool iopf_on = hwpt->fault && !old->fault;
-	struct iommufd_attach_handle *curr = NULL;
+	struct iommufd_attach_handle *curr;
 	int ret;
 
 	if (iopf_on) {
@@ -130,24 +130,17 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 			return ret;
 	}
 
-	if (hwpt->fault) {
-		curr = iommufd_dev_replace_handle(idev, hwpt, old);
-		ret = IS_ERR(curr) ? PTR_ERR(curr) : 0;
-	} else {
-		ret = iommu_replace_group_handle(idev->igroup->group,
-						 hwpt->domain, NULL);
-	}
-
-	if (ret) {
+	curr = iommufd_dev_replace_handle(idev, hwpt, old);
+	if (IS_ERR(curr)) {
 		if (iopf_on)
 			iommufd_fault_iopf_disable(idev);
-		return ret;
+		return PTR_ERR(curr);
 	}
 
-	if (curr) {
+	if (old->fault)
 		iommufd_auto_response_faults(old, curr);
-		kfree(curr);
-	}
+
+	kfree(curr);
 
 	if (iopf_off)
 		iommufd_fault_iopf_disable(idev);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 7039c86d9981..30696936a926 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -499,6 +499,8 @@ iommufd_dev_replace_handle(struct iommufd_device *idev,
 	int ret;
 
 	curr = iommufd_device_get_attach_handle(idev);
+	if (!curr)
+		return ERR_PTR(-EINVAL);
 
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
@@ -541,28 +543,39 @@ static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	if (hwpt->fault)
 		return iommufd_fault_domain_attach_dev(hwpt, idev);
 
-	return iommu_attach_group(hwpt->domain, idev->igroup->group);
+	return iommufd_dev_attach_handle(hwpt, idev);
 }
 
 static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 					      struct iommufd_device *idev)
 {
+	struct iommufd_attach_handle *handle;
+
 	if (hwpt->fault) {
 		iommufd_fault_domain_detach_dev(hwpt, idev);
 		return;
 	}
 
-	iommu_detach_group(hwpt->domain, idev->igroup->group);
+	handle = iommufd_device_get_attach_handle(idev);
+	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+	kfree(handle);
 }
 
 static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 					      struct iommufd_hw_pagetable *hwpt,
 					      struct iommufd_hw_pagetable *old)
 {
+	struct iommufd_attach_handle *curr;
+
 	if (old->fault || hwpt->fault)
 		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
 
-	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
+	curr = iommufd_dev_replace_handle(idev, hwpt, old);
+	if (IS_ERR(curr))
+		return PTR_ERR(curr);
+
+	kfree(curr);
+	return 0;
 }
 
 #ifdef CONFIG_IOMMUFD_TEST
-- 
2.34.1

