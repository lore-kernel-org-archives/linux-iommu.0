Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EA31DF258
	for <iommu@lists.linux.dev>; Tue, 13 May 2025 03:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105624; cv=none; b=fcZtkhNRBuvUFFqb14YvVzwop+yQxv3BlEDAK46msKDfr8PxVJ6k2e/IPlnBDVz8GHQPV9jrDP1JcGfru8DZTy6zBXLlR9WCHW4HFLJ3arpvT1VffvVuJQa4C/sIRr8/gE+fBJ7LDiJ+8B5+7XZkgOyJH0ArAFgbKL7CHeX00aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105624; c=relaxed/simple;
	bh=GnPsA1x6WcR5RqgSCerE1Dq6vGOAihMYVqG+yIbsoLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jt+VwAOwSD2bi7CDeXodWkN29qRv9hYNFKqOWI43Ht2HHKIGdiIzj7YcWPSFj7elNpnvXzXfTkzdE95a8Ba+FkdMnuFh7aQAFzfwzOFe2qDmSZ3tM4jpH1Vd4GTdfuA+AfMgKmsk6YjWaiX5uhyRzHLa0DqoSPiY9Q6+ZOB5kDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgomjRPJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgomjRPJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747105623; x=1778641623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GnPsA1x6WcR5RqgSCerE1Dq6vGOAihMYVqG+yIbsoLs=;
  b=HgomjRPJh7lTArkLG6eClZm7LjVfrjaoqpEUuC1kaGfv0cYGbm+LQ7ji
   r0iAdser8UCkcP7Sg6rCP7JSq7SdkpKYXN38bPHAVALz56LncgoI0CA7P
   JQrweEqx4hwaTLJK+HOWuJNlw/cI0wonyNoPqgO//9wV5Z3vHZ6GwJrVc
   fL3Aq1lFzLv3I0YvnqR+N2KbVGd4XvPgJPJHV1ojW4tUlUD8UxVLXOrUY
   +qcbEQXcKn3D7m0fFK7oLpsWtqi9v9bA/IEFbbVLJH4UgcmeQxXaVNonf
   0W4ULOj6Dw1z6igRhU2Hw0qLTUc5v3oMimyBKCQzifAHtd9u5zSAD3WU6
   A==;
X-CSE-ConnectionGUID: s4ETe2kEQ12IZyt8wyva4g==
X-CSE-MsgGUID: zVqFEzGaSxKnPJpZ+xMfBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52735291"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="52735291"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 20:07:02 -0700
X-CSE-ConnectionGUID: xugzxBpOTeqqt6Kr4BIn2A==
X-CSE-MsgGUID: w93EyBDgScKO94TVoR6FUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="138522224"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa009.fm.intel.com with ESMTP; 12 May 2025 20:07:01 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] iommu/vt-d: Change dmar_ats_supported() to return boolean
Date: Tue, 13 May 2025 11:07:39 +0800
Message-ID: <20250513030739.2718555-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513030739.2718555-1-baolu.lu@linux.intel.com>
References: <20250513030739.2718555-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Wang <wei.w.wang@intel.com>

According to "Function return values and names" in coding-style.rst, the
dmar_ats_supported() function should return a boolean instead of an
integer. Also, rename "ret" to "supported" to be more straightforward.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20250509140021.4029303-3-wei.w.wang@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2258814ffc70..7f2d68103b3c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2702,15 +2702,16 @@ static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
 	return satcu;
 }
 
-static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
+static bool dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 {
-	int i, ret = 1;
-	struct pci_bus *bus;
 	struct pci_dev *bridge = NULL;
-	struct device *tmp;
-	struct acpi_dmar_atsr *atsr;
 	struct dmar_atsr_unit *atsru;
 	struct dmar_satc_unit *satcu;
+	struct acpi_dmar_atsr *atsr;
+	bool supported = true;
+	struct pci_bus *bus;
+	struct device *tmp;
+	int i;
 
 	dev = pci_physfn(dev);
 	satcu = dmar_find_matched_satc_unit(dev);
@@ -2728,11 +2729,11 @@ static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 		bridge = bus->self;
 		/* If it's an integrated device, allow ATS */
 		if (!bridge)
-			return 1;
+			return true;
 		/* Connected via non-PCIe: no ATS */
 		if (!pci_is_pcie(bridge) ||
 		    pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE)
-			return 0;
+			return false;
 		/* If we found the root port, look it up in the ATSR */
 		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
 			break;
@@ -2751,11 +2752,11 @@ static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 		if (atsru->include_all)
 			goto out;
 	}
-	ret = 0;
+	supported = false;
 out:
 	rcu_read_unlock();
 
-	return ret;
+	return supported;
 }
 
 int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
-- 
2.43.0

