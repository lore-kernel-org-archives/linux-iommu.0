Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAA834EF0E
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 06:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036599; cv=none; b=WBP8gIQkTudk0Fpx36muimmoHiCqEBHJ9zBzimo/IyR8I+fm9XVvGcs9wWAbn/cRPUtPbDkwO+rtwjwyvzcyEyEdHl6T1vAV/lLukmGwNd4lJ2cKJ48H+4OkxDsKE3t32vMQNiuxn2jjsc+aZSwzO3K9auDqRSb/Pd8Kb0BthKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036599; c=relaxed/simple;
	bh=15cuIjNmzRhJGbEOchA9KN71cU83CCr7Ainh+JmETF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqgAZcLjExpFa9FJE6r3uqlQ1ncxRvMJtaY1kdoXd/3gecBfXkHYLl3+gcIL+KsY2m+Z2gfyAp+bVKp4QZyX3tlxchSg8/ahIxl3agEgkJ8PQ3EGuEyUl2WyjQsB6az2P4ZqyzX5x7DHl6ZUwC29g6cLazaxG6m0+gzclAztOXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcSQMCGQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcSQMCGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773036598; x=1804572598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=15cuIjNmzRhJGbEOchA9KN71cU83CCr7Ainh+JmETF4=;
  b=dcSQMCGQRSi73y4a7d1Z7N15AMOq0eevE3qfFgJjiexncwDCV+8iWcjm
   3tg7vJVZy4FPWO8a9+mBmAKM4bYec2xqYqVfIqoDv9xcUH0j/gj4/t0Rd
   J1wwbn3zhzVwbjBfjNoRP0bP2Cj2dSOJ8TSTHE8wft3FuEvOY8J1E05UG
   kDVr1wWQDPb9QJUmt2PB0W4XVncnDWHUIUMjg+Ys/xnHMb7OxbbCBHDvE
   egI4I7wjTOYlDqTUVcQbX3gGbtDedWalxAUnpV0ltRmOSicqmF48pUcwK
   G+ZXwI150pnVngHv00W1tqv/9tnqp4CKCp7MAl2BR0EvasOTWKFXN3JU2
   g==;
X-CSE-ConnectionGUID: QLLechVfS3OZ2oVe5XkBRQ==
X-CSE-MsgGUID: Z0UZLnZoSYGhWUGoflszjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73248296"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73248296"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 23:09:57 -0700
X-CSE-ConnectionGUID: QjNyrwwFTI2k3U1exs2qbQ==
X-CSE-MsgGUID: WhLy3t6GSqK+lBkjuDwqJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="245669174"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2026 23:09:55 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 6/8] iommu/vt-d: Use intel_pasid_write() for second-stage setup
Date: Mon,  9 Mar 2026 14:06:46 +0800
Message-ID: <20260309060648.276762-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309060648.276762-1-baolu.lu@linux.intel.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor intel_pasid_setup_second_level() to utilize the
intel_pasid_write() helper. Similar to the first-stage setup, moves the
second stage setup logic to the entry_sync library by constructing the
target PASID entry in a local buffer and committing it via
intel_pasid_write().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 19 ++++---------------
 drivers/iommu/intel/pasid.c | 26 ++++----------------------
 2 files changed, 8 insertions(+), 37 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index db5e8dad50dc..b98020ac9de2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1248,17 +1248,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 }
 
-static int domain_setup_second_level(struct intel_iommu *iommu,
-				     struct dmar_domain *domain,
-				     struct device *dev, ioasid_t pasid,
-				     struct iommu_domain *old)
-{
-	if (old)
-		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
-
-	return intel_pasid_setup_second_level(iommu, domain, dev, pasid);
-}
-
 static int domain_setup_passthrough(struct intel_iommu *iommu,
 				    struct device *dev, ioasid_t pasid,
 				    struct iommu_domain *old)
@@ -1323,8 +1312,8 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 		ret = domain_setup_first_level(iommu, domain, dev,
 					       IOMMU_NO_PASID, NULL);
 	else if (intel_domain_is_ss_paging(domain))
-		ret = domain_setup_second_level(iommu, domain, dev,
-						IOMMU_NO_PASID, NULL);
+		ret = intel_pasid_setup_second_level(iommu, domain,
+						     dev, IOMMU_NO_PASID);
 	else if (WARN_ON(true))
 		ret = -EINVAL;
 
@@ -3634,8 +3623,8 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid, old);
 	else if (intel_domain_is_ss_paging(dmar_domain))
-		ret = domain_setup_second_level(iommu, dmar_domain,
-						dev, pasid, old);
+		ret = intel_pasid_setup_second_level(iommu, dmar_domain,
+						     dev, pasid);
 	else if (WARN_ON(true))
 		ret = -EINVAL;
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 8ea1ac8cbf5e..3084afb3d4a1 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -590,10 +590,7 @@ static void pasid_pte_config_second_level(struct intel_iommu *iommu,
 {
 	struct pt_iommu_vtdss_hw_info pt_info;
 
-	lockdep_assert_held(&iommu->lock);
-
 	pt_iommu_vtdss_hw_info(&domain->sspt, &pt_info);
-	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
 	pasid_set_slptr(pte, pt_info.ssptptr);
 	pasid_set_address_width(pte, pt_info.aw);
@@ -611,9 +608,10 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 				   struct dmar_domain *domain,
 				   struct device *dev, u32 pasid)
 {
-	struct pasid_entry *pte;
+	struct pasid_entry new_pte = {0};
 	u16 did;
 
+	iommu_group_mutex_assert(dev);
 
 	/*
 	 * If hardware advertises no support for second level
@@ -626,25 +624,9 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	}
 
 	did = domain_id_iommu(domain, iommu);
+	pasid_pte_config_second_level(iommu, &new_pte, domain, did);
 
-	spin_lock(&iommu->lock);
-	pte = intel_pasid_get_entry(dev, pasid);
-	if (!pte) {
-		spin_unlock(&iommu->lock);
-		return -ENODEV;
-	}
-
-	if (pasid_pte_is_present(pte)) {
-		spin_unlock(&iommu->lock);
-		return -EBUSY;
-	}
-
-	pasid_pte_config_second_level(iommu, pte, domain, did);
-	spin_unlock(&iommu->lock);
-
-	pasid_flush_caches(iommu, pte, pasid, did);
-
-	return 0;
+	return intel_pasid_write(iommu, dev, pasid, (u128 *)&new_pte);
 }
 
 /*
-- 
2.43.0

