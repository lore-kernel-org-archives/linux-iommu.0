Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC9612F
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 07:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667893289; x=1699429289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GHxYMywiMujCB0fUw9PW3w8rIrm70fPSsLe09FLp9ik=;
  b=nQ/cwkPsWpYX1gywRiB+JG8N6hRztXHPgEktZXPfDJ4QMcuICkrX/She
   B1CEPSeXuSeYQALzSgqtJruBgYNsTWIDxPd1yWp4WWtHQRZBUob0Pef8U
   pAj3Sbx9QEiccXV7u7pOrUMOZutjotctfrRIb3wyvDrGYw5mYQ7WOUOsf
   DrXrUuIsZ9ZNPzYTZLBUaLiEqavsIzcbnfTkNJTJTDAJuGNlK0hdOdShD
   93pF74REBuZWgkTm8tr25cffm01tUn3c0RY5pAJBIUdTFllWpcleixjPi
   kVDTdECjwf+o80ktsg4j0J7oPWO0JGgnpbfB5B5Os3jUBDRBUMGpgraEL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290350058"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="290350058"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:41:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699821842"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="699821842"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2022 23:41:03 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/8] iommu/vt-d: Improve iommu_enable_pci_caps()
Date: Tue,  8 Nov 2022 15:34:02 +0800
Message-Id: <20221108073408.1005721-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
References: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI subsystem triggers WARN() if a feature is repeatedly enabled.
This improves iommu_enable_pci_caps() to avoid unnecessary kernel
traces through checking and enabling. This also adds kernel messages
if any feature enabling results in failure. It is worth noting that
PRI depends on ATS. This adds a check as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 86 ++++++++++++++++++++++++++-----------
 1 file changed, 61 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bc42a2c84e2a..978cb7bba2e1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1401,44 +1401,80 @@ static void domain_update_iotlb(struct dmar_domain *domain)
 static void iommu_enable_pci_caps(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
+	int ret;
 
 	if (!info || !dev_is_pci(info->dev))
 		return;
 
 	pdev = to_pci_dev(info->dev);
-	/* For IOMMU that supports device IOTLB throttling (DIT), we assign
-	 * PFSID to the invalidation desc of a VF such that IOMMU HW can gauge
-	 * queue depth at PF level. If DIT is not set, PFSID will be treated as
-	 * reserved, which should be set to 0.
+	/*
+	 * The PCIe spec, in its wisdom, declares that the behaviour of
+	 * the device if you enable PASID support after ATS support is
+	 * undefined. So always enable PASID support on devices which
+	 * have it, even if we can't yet know if we're ever going to
+	 * use it.
 	 */
-	if (!ecap_dit(info->iommu->ecap))
-		info->pfsid = 0;
-	else {
-		struct pci_dev *pf_pdev;
-
-		/* pdev will be returned if device is not a vf */
-		pf_pdev = pci_physfn(pdev);
-		info->pfsid = pci_dev_id(pf_pdev);
+	if (info->pasid_supported && !info->pasid_enabled) {
+		ret = pci_enable_pasid(pdev, info->pasid_supported & ~1);
+		if (ret)
+			pci_info(pdev, "Failed to enable PASID: %d\n", ret);
+		else
+			info->pasid_enabled = 1;
 	}
 
-	/* The PCIe spec, in its wisdom, declares that the behaviour of
-	   the device if you enable PASID support after ATS support is
-	   undefined. So always enable PASID support on devices which
-	   have it, even if we can't yet know if we're ever going to
-	   use it. */
-	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
-		info->pasid_enabled = 1;
+	if (info->ats_supported && !info->ats_enabled) {
+		if (!pci_ats_page_aligned(pdev)) {
+			pci_info(pdev, "Untranslated Addresses not aligned\n");
+			return;
+		}
 
-	if (info->pri_supported &&
-	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)  &&
-	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
-		info->pri_enabled = 1;
+		ret = pci_enable_ats(pdev, VTD_PAGE_SHIFT);
+		if (ret) {
+			pci_info(pdev, "Failed to enable ATS: %d\n", ret);
+			return;
+		}
 
-	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
-	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
 		domain_update_iotlb(info->domain);
 		info->ats_qdep = pci_ats_queue_depth(pdev);
+
+		/*
+		 * For IOMMU that supports device IOTLB throttling (DIT),
+		 * we assign PFSID to the invalidation desc of a VF such
+		 * that IOMMU HW can gauge queue depth at PF level. If DIT
+		 * is not set, PFSID will be treated as reserved, which
+		 * should be set to 0.
+		 */
+		if (ecap_dit(info->iommu->ecap)) {
+			struct pci_dev *pf_pdev;
+
+			/* pdev will be returned if device is not a vf */
+			pf_pdev = pci_physfn(pdev);
+			info->pfsid = pci_dev_id(pf_pdev);
+		} else {
+			info->pfsid = 0;
+		}
+	}
+
+	if (info->pri_supported && !info->pri_enabled && info->ats_enabled) {
+		if (info->pasid_enabled && !pci_prg_resp_pasid_required(pdev)) {
+			pci_info(pdev, "PRG Response PASID Required\n");
+			return;
+		}
+
+		ret = pci_reset_pri(pdev);
+		if (ret) {
+			pci_info(pdev, "Failed to reset PRI: %d\n", ret);
+			return;
+		}
+
+		ret = pci_enable_pri(pdev, PRQ_DEPTH);
+		if (ret) {
+			pci_info(pdev, "Failed to enable PRI: %d\n", ret);
+			return;
+		}
+
+		info->pri_enabled = 1;
 	}
 }
 
-- 
2.34.1

