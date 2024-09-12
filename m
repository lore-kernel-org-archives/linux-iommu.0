Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01311A76A6
	for <iommu@lists.linux.dev>; Thu, 12 Sep 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146279; cv=none; b=VHkaUQfGLX5rFQoY+7XkxtPzkL9aTzZPgW2KmsH/nA2C50KslFqBiLL3JZuM06sFP8252HAL/pPzW6080eZhC9oF1cU/Kq8zNUkma0muAR6SxRASqUa2FLBoRbe9iUSsRQuI8nFcRZFMM8P4Jf/hqT7NiRS/r48WCmCPZLuKYjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146279; c=relaxed/simple;
	bh=pOcQU08N3lTvDhVfmas/O1+D4tqbqbVhqCIeSVYwjvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2xOtD3c4xgVgCNfPDdgrld5/2yTaEWujcKY8jVhTNKfBkJbezwuzl9IJs1gYUfHME/B8Ng6UkGrayDdDHBqkfT82jTBzPKFhUkWxH39hwma9nGQDGcG0/Ul6T5ASWSpnLKgJozCnnOyndWOw1U0mcDwmA4Nd1G+8rlgI23lVJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGyamm9m; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGyamm9m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726146278; x=1757682278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pOcQU08N3lTvDhVfmas/O1+D4tqbqbVhqCIeSVYwjvw=;
  b=FGyamm9mAEBj9CANypj86w1itJ+Kfpc3FAU64C0u4wK5WoAUoks08SDu
   1b3eGKxWu9ILIDe5gFZXnIIfjIXlEbZhqPHQ4F4Ezw5B0YO1eP0YH+8OK
   b1BoLdfVqF9guOlCa9c0Xm5Wub85EdKSiuP29279eW5Zy8P62OzNLGR0p
   Q6O480TnNQIGjCBROb/jvIY75gd8QsJ1E/PEeU8t6HPPOTq+hz5R8D3Uu
   5q4UTtU1yKJurY7FJlG6J4y7/tAr+Hycyq0vEtGVWyCGqqW9lnEjOOyjo
   AOCkz2xn/MfnJ66KpYK1xB9LhodfVan/zvpHZ6VbJTguxXIx/P79dvBZd
   A==;
X-CSE-ConnectionGUID: LMdj+iqeTGuFMkuRkT0m0Q==
X-CSE-MsgGUID: ng1V12TMQO2enI0JX8yZbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36380568"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="36380568"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 06:04:37 -0700
X-CSE-ConnectionGUID: X2m9O3BmS7aeLajwak7SsQ==
X-CSE-MsgGUID: LKbIz317Q1O8OKN0VEIhPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72509976"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 12 Sep 2024 06:04:37 -0700
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
Subject: [PATCH v2 6/6] iommu: Make set_dev_pasid op support domain replacement
Date: Thu, 12 Sep 2024 06:04:27 -0700
Message-Id: <20240912130427.10119-7-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912130427.10119-1-yi.l.liu@intel.com>
References: <20240912130427.10119-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu core is going to support domain replacement for pasid, it needs
to make the set_dev_pasid op support replacing domain and keep the old
domain config in the failure case.

AMD iommu driver does not support domain replacement for pasid yet, so it
would fail the set_dev_pasid op to keep the old config if the input @old
is non-NULL.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/amd/pasid.c | 3 +++
 include/linux/iommu.h     | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index 77bf5f5f947a..30e27bda3fac 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -109,6 +109,9 @@ int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret = -EINVAL;
 
+	if (old)
+		return -EOPNOTSUPP;
+
 	/* PASID zero is used for requests from the I/O device without PASID */
 	if (!is_pasid_valid(dev_data, pasid))
 		return ret;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32dce80aa7fd..27f923450a7c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -616,7 +616,8 @@ struct iommu_ops {
  * * EBUSY	- device is attached to a domain and cannot be changed
  * * ENODEV	- device specific errors, not able to be attached
  * * <others>	- treated as ENODEV by the caller. Use is discouraged
- * @set_dev_pasid: set an iommu domain to a pasid of device
+ * @set_dev_pasid: set or replace an iommu domain to a pasid of device. The pasid of
+ *                 the device should be left in the old config in error case.
  * @map_pages: map a physically contiguous set of pages of the same size to
  *             an iommu domain.
  * @unmap_pages: unmap a number of pages of the same size from an iommu domain
-- 
2.34.1

