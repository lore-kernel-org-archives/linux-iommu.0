Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C9562F
	for <iommu@lists.linux.dev>; Thu, 13 Apr 2023 04:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681358811; x=1712894811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=svE7EgjquyhwRZbom4QiBGJ7Mxb0NsfSfLHDW+HF/GA=;
  b=bgFriL1MB07Fb7DrfEjlyjrE/cBB2csacfJ+aqMBuflFReuqhWfuw9Ke
   DvvvGBJv+V2yM5dGkxc5Z+9wYfeKGTXrnZ/FZCyPho+wD0PpsCGq+gT3A
   QjqH4hefbjYV2+nTnqYXyWPd+5Fzza3wVNngGnPd+XNj0AZsO8M5Ati5d
   rj40CR0PzZeUEW1EbVYcEjx9gVVtjmwOvca2EcElVarzO9Msln4RLyXwO
   zyPp+kkxIsc2Eq+UX5eqn1Z+KC+l9525ZVxQ7Jhrg0BHFXuyBHAGO9Ttl
   WbYe7kiY22kENNNaERNrBuZLPW/3u63U2qLD9aQLJnE8lHQlMb8yaxAcG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332786539"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332786539"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935360987"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935360987"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 21:06:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/17] iommu/vt-d: Move pfsid and ats_qdep calculation to device probe path
Date: Thu, 13 Apr 2023 12:06:32 +0800
Message-Id: <20230413040645.46157-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413040645.46157-1-baolu.lu@linux.intel.com>
References: <20230413040645.46157-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They should be part of the per-device iommu private data initialization.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230324120234.313643-5-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a6f07c74da2d..6d77b4072fdd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1406,20 +1406,6 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 		return;
 
 	pdev = to_pci_dev(info->dev);
-	/* For IOMMU that supports device IOTLB throttling (DIT), we assign
-	 * PFSID to the invalidation desc of a VF such that IOMMU HW can gauge
-	 * queue depth at PF level. If DIT is not set, PFSID will be treated as
-	 * reserved, which should be set to 0.
-	 */
-	if (!ecap_dit(info->iommu->ecap))
-		info->pfsid = 0;
-	else {
-		struct pci_dev *pf_pdev;
-
-		/* pdev will be returned if device is not a vf */
-		pf_pdev = pci_physfn(pdev);
-		info->pfsid = pci_dev_id(pf_pdev);
-	}
 
 	/* The PCIe spec, in its wisdom, declares that the behaviour of
 	   the device if you enable PASID support after ATS support is
@@ -1438,7 +1424,6 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
 		domain_update_iotlb(info->domain);
-		info->ats_qdep = pci_ats_queue_depth(pdev);
 	}
 }
 
@@ -4521,6 +4506,17 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 		    dmar_ats_supported(pdev, iommu)) {
 			info->ats_supported = 1;
 			info->dtlb_extra_inval = dev_needs_extra_dtlb_flush(pdev);
+
+			/*
+			 * For IOMMU that supports device IOTLB throttling
+			 * (DIT), we assign PFSID to the invalidation desc
+			 * of a VF such that IOMMU HW can gauge queue depth
+			 * at PF level. If DIT is not set, PFSID will be
+			 * treated as reserved, which should be set to 0.
+			 */
+			if (ecap_dit(iommu->ecap))
+				info->pfsid = pci_dev_id(pci_physfn(pdev));
+			info->ats_qdep = pci_ats_queue_depth(pdev);
 		}
 		if (sm_supported(iommu)) {
 			if (pasid_supported(iommu)) {
-- 
2.34.1

