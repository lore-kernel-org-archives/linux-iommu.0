Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183426AF3
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244283; cv=none; b=N/cU62J9GRDhPwZY/T2RqTeVMD9s+Me+iT42cqcytHO6cIoPurxkACAgPf3TnftZl3sfC2qy8KqmKUvYfZdVXgWUE4hRocb0ieoDO0ik7mZe1resmXNXvdbxlJVAD6WoELIibWBsJk+Z2MZyn1R4KLWAInyo9xBZgAj84LPxfV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244283; c=relaxed/simple;
	bh=ykFlqs93OMeUXErJ6XEMUhvHlg6YaH6RSHAwXe9P3rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9SjlzBq49oPzaz7osFCINlYRN9ue55qNqjzbTrOPdKtwoIdK+1PVB6pc9apnKxij8DP6aWg/n1s11WmSvFhT71e0PWNFO0YHTkYICCHE4wwiNaH9TIxDwsTkn6Le1LJB6AjBOvUqsLJb2YdBLa2n4SVQwLjoWEJb/pJzjgd6Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgaycs/N; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgaycs/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244281; x=1756780281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ykFlqs93OMeUXErJ6XEMUhvHlg6YaH6RSHAwXe9P3rk=;
  b=dgaycs/N760yWkcyWaepZ2+RJj515aczIGuDeeIEucIY9osS3EbE4ARB
   mhH0I9IrtaJ3fQvx4g+S35mWFiIocLDZVW/nE8BJTqQ/26ji30QK9hQIX
   2zNi5W+xC/mVgkrTOFVDlKspTYMMjVzPiCwa+V1mXeolDTK+PXGo4vPhw
   GpQ5eyPNlBkVz45U4bje+8PZnGWyl9y1EfnHyBFHU0eh6OWYlPfkYnoXh
   2C9PqlUALgIfKteQs17DLU6j0FpRaRZJg3Ct/fgv1QDGUwWOxJloKj46s
   nVZ0MLfcTHVpqW+aXG+SKnZYpv9jb1/AWxAyQt3Jrb/OviGvDwFxwEGVw
   w==;
X-CSE-ConnectionGUID: OUi3dfyBRTCGBDj4pwRFNA==
X-CSE-MsgGUID: 4QcZrHozRpq0aV3kdZ4jTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994272"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994272"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:21 -0700
X-CSE-ConnectionGUID: GHeDYdzBS7OvEimuGsBzgg==
X-CSE-MsgGUID: s3hzxfAARnOzKCylySHNAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359266"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] iommu/vt-d: Require DMA domain if hardware not support passthrough
Date: Mon,  2 Sep 2024 10:27:11 +0800
Message-Id: <20240902022724.67059-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902022724.67059-1-baolu.lu@linux.intel.com>
References: <20240902022724.67059-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu core defines the def_domain_type callback to query the iommu
driver about hardware capability and quirks. The iommu driver should
declare IOMMU_DOMAIN_DMA requirement for hardware lacking pass-through
capability.

Earlier VT-d hardware implementations did not support pass-through
translation mode. The iommu driver relied on a paging domain with all
physical system memory addresses identically mapped to the same IOVA
to simulate pass-through translation before the def_domain_type was
introduced and it has been kept until now. It's time to adjust it now
to make the Intel iommu driver follow the def_domain_type semantics.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Link: https://lore.kernel.org/r/20240809055431.36513-2-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4aa070cf56e7..5193986e420b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2151,6 +2151,16 @@ static bool device_rmrr_is_relaxable(struct device *dev)
 
 static int device_def_domain_type(struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+
+	/*
+	 * Hardware does not support the passthrough translation mode.
+	 * Always use a dynamaic mapping domain.
+	 */
+	if (!ecap_pass_through(iommu->ecap))
+		return IOMMU_DOMAIN_DMA;
+
 	if (dev_is_pci(dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev);
 
-- 
2.34.1

