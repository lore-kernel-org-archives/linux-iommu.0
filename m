Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E976048
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244298; cv=none; b=MhwQdbkM4/ov6rJrk6PlIXt02frrHzNk4wRpRUYUm0nbQCRj1d5K7DP16NKpOxsT7IDlCt+qGev36XIZmDytgBestYEKfy1kTTqsEInDLKqpB7MOXShoK9cWCj5qte2vxZGe9C4GN4H/XgxAitoSjdagqfZXggcBkxssFFHsxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244298; c=relaxed/simple;
	bh=k1FJp+pHiGoDqzd1Mjnm4T+Pc+0t6PtwzNNj/ffy4JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJJO09DnUD5gfLEaQFF/SQ/Ky9B2H8qTZh+r7V1v7RXthX2bsKDQV0LlhjFIOU3kcEVipJqs4J+VBIDSDMZG0OQs1LNcK1g2wLYUVsG+ASb6D+w6rl6mSNYqZ7lyd4eYTSN5HPD34J4wt8khV423juR5fmrLIegAk83QUMhjlxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ss2Gc8i+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ss2Gc8i+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244297; x=1756780297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k1FJp+pHiGoDqzd1Mjnm4T+Pc+0t6PtwzNNj/ffy4JE=;
  b=Ss2Gc8i+R8oo/w8gNChGG/6sB/BXHbqDHw1s7bDYJaImgroh/1n4ALfr
   SKvb0aMctXYv2iPUPcuD9XfVdTwQFfB1SBQgXwMA6qdEObJGeqNzuC3Ht
   su6VWbqDgbQa/wqTkROvh4t+wAUiZaz9FTxEexAf+FlLkEP3iJgADL2ZX
   TIz4cZpJjTGUmF6Fb3Ct/WN8Xwp/xdRdV5+cb3WOz4nqe8n0ZB6PBkCHA
   pgM7gvvRLmLk0+Nri9yZ6x2WYLi8iTL635AETepzYXPiydVoDTqzvem0A
   bsIep1A9RbvQsuraB/hVwyWuL90RswkvD5haaUAapbckTrYYpuBo/975P
   g==;
X-CSE-ConnectionGUID: q5bP/o/jSuGgM0vNwywDbw==
X-CSE-MsgGUID: c1+g08QdQVKlQeDR/Eja2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994327"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994327"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:37 -0700
X-CSE-ConnectionGUID: ZJnEKqF6TSOxMvwDZxB+vQ==
X-CSE-MsgGUID: yqQTWLeAQb2t91J821Eutg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359338"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] iommu/vt-d: Move PCI PASID enablement to probe path
Date: Mon,  2 Sep 2024 10:27:19 +0800
Message-Id: <20240902022724.67059-10-baolu.lu@linux.intel.com>
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

Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
attached to the device and disabled when the device transitions to block
translation mode. This approach is inappropriate as PCI PASID is a device
feature independent of the type of the attached domain.

Enable PCI PASID during the IOMMU device probe and disables it during the
release path.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20240819051805.116936-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 34006b6e89eb..eab87a649804 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1281,15 +1281,6 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 		return;
 
 	pdev = to_pci_dev(info->dev);
-
-	/* The PCIe spec, in its wisdom, declares that the behaviour of
-	   the device if you enable PASID support after ATS support is
-	   undefined. So always enable PASID support on devices which
-	   have it, even if we can't yet know if we're ever going to
-	   use it. */
-	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
-		info->pasid_enabled = 1;
-
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT))
 		info->ats_enabled = 1;
@@ -1308,11 +1299,6 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 		pci_disable_ats(pdev);
 		info->ats_enabled = 0;
 	}
-
-	if (info->pasid_enabled) {
-		pci_disable_pasid(pdev);
-		info->pasid_enabled = 0;
-	}
 }
 
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
@@ -3942,6 +3928,16 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	intel_iommu_debugfs_create_dev(info);
 
+	/*
+	 * The PCIe spec, in its wisdom, declares that the behaviour of the
+	 * device is undefined if you enable PASID support after ATS support.
+	 * So always enable PASID support on devices which have it, even if
+	 * we can't yet know if we're ever going to use it.
+	 */
+	if (info->pasid_supported &&
+	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
+		info->pasid_enabled = 1;
+
 	return &iommu->iommu;
 free_table:
 	intel_pasid_free_table(dev);
@@ -3958,6 +3954,11 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
+	if (info->pasid_enabled) {
+		pci_disable_pasid(to_pci_dev(dev));
+		info->pasid_enabled = 0;
+	}
+
 	mutex_lock(&iommu->iopf_lock);
 	if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
 		device_rbtree_remove(info);
-- 
2.34.1

