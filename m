Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930463D551
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032129; cv=none; b=klgi7QDUDscy1efdWaUJdJMeUf7HSgSbZytSzMyZ6oFe2a2/KG3QHofHSMnM5D/1MeHo+76zr0uQZyLuV4g8WXbat9+bqGLL90/gC4T+YRUvE198rk5EWbC8/hUe61LelQrpQq/h8LfFdLfQfFQkzwn2ESu/K6GOsvAIPapYGn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032129; c=relaxed/simple;
	bh=ovL5X6BKU6X15z7dlOJy3dPt43y7u+VRg9y7JYC2oEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIqJkKfNmp4FApXUU0MeklKvWMOiLMyiwJj1CbbvZlcLyx+tXknBOXaFYFdbJUFkxXB2MCGi7AyVr6iamvBzxf9zxxCYvGCjkV8NtSzwhnq1UhnAnjvOwgBb6b6cUe4iSdOXOk7dVvIdqHx9R4dYSm8nPueyJnYfDw8GNb4Mqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CzcNQs9A; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CzcNQs9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032128; x=1762568128;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ovL5X6BKU6X15z7dlOJy3dPt43y7u+VRg9y7JYC2oEE=;
  b=CzcNQs9A5nxaD7rXYm/d53bfRzersQn97BSxoWxPnZIKmZm21lzbm6v/
   SQm6nnxy4EKIcWejVlMwPMUcCFtv+YtH3Ibla3k636gN3FIGRH4+FUFiO
   GPYTV2f7IjK8aur0P8+lrLWXZGioBlu5J88rSCCJen/TNP8I5mvZ9ys65
   NveSOPv6X0VZNfI0jHqEHM/A37vYQnXhPDuDIgc/YYHk1uPZJrMZGkzuj
   tufFOy+txgeOBp7hX7/HbO4hu8YsUYfkOgS+bGTYN9Hywvh2B0dp3Cs02
   gMfg1jEHMyhSdzIYYgeWLRkaVjeF+BXS83KDcaRu8+ff4h/0IvUT2HqqX
   Q==;
X-CSE-ConnectionGUID: m5MX1mLGTn2RXcUXNAKOtw==
X-CSE-MsgGUID: /UnYgYzQRhaAtdadKF1R9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31007852"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31007852"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:15:20 -0800
X-CSE-ConnectionGUID: DqhSkt81Rv6v9zW/t9tfdw==
X-CSE-MsgGUID: fLFIUv85RlK49Dbpjj3pjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="116213835"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2024 18:15:16 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] iommu/vt-d: Make identity_domain_set_dev_pasid() to handle domain replacement
Date: Fri,  8 Nov 2024 10:14:01 +0800
Message-ID: <20241108021406.173972-11-baolu.lu@linux.intel.com>
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

Let identity_domain_set_dev_pasid() call the pasid replace helpers hence
be able to do domain replacement.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20241107122234.7424-11-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 251cfebe6226..ba984cb4aa44 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1778,6 +1778,17 @@ static int domain_setup_second_level(struct intel_iommu *iommu,
 						pasid);
 }
 
+static int domain_setup_passthrough(struct intel_iommu *iommu,
+				    struct device *dev, ioasid_t pasid,
+				    struct iommu_domain *old)
+{
+	if (!old)
+		return intel_pasid_setup_pass_through(iommu, dev, pasid);
+	return intel_pasid_replace_pass_through(iommu, dev,
+						iommu_domain_did(old, iommu),
+						pasid);
+}
+
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
@@ -4423,11 +4434,17 @@ static int identity_domain_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
+	int ret;
 
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
-	return intel_pasid_setup_pass_through(iommu, dev, pasid);
+	ret = domain_setup_passthrough(iommu, dev, pasid, old);
+	if (ret)
+		return ret;
+
+	domain_remove_dev_pasid(old, dev, pasid);
+	return 0;
 }
 
 static struct iommu_domain identity_domain = {
-- 
2.43.0

