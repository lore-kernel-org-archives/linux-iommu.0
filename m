Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06026AABA
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771142; cv=none; b=RSnpTHnmG9jZ4x2ekdW0y2t95LavXXb9sbyesECvasG6HeHP7qB6MvtdEmle/ofZwvj6O53/y/Wcggb7lhUr+24cIzqGh49Gzm/M+3i4Dvc16TAj+KDUAV0FsMWza2/2aFCol8st8DXIU6ynmI9vrHKYhhX5tPCBeY8vMBGVViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771142; c=relaxed/simple;
	bh=RyiB6bSDdnrAl/ZA2Ghx7G3OxFtQ18NcIegr7K5WEQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJtG8Wvi6N9QHVxCAQu50qaiO9ibRwbGWiXysc/CAN5OMMkfslnWx40zWtbaApFdwo2CZITbbTVTJNT4eIL3aYAjhwrhr8pOcoD5aNw7nReG/OZDgdLPscFKWL/57NIrZ1zqYW4pr2ELp/LCxCm3Irltn0HweQkLHMiUKlgbRpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6qBQWPr; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6qBQWPr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746771140; x=1778307140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RyiB6bSDdnrAl/ZA2Ghx7G3OxFtQ18NcIegr7K5WEQk=;
  b=b6qBQWPrKVkxTj33HUZTC4oFuQ0o1BgKpft5gqOVR7ILHo5+obdgREUG
   O8jJh2ftsqzPZgGmnmoLgcIYF+wMM2eZvgSyTBs0pB9INqj+yyCu0A6hF
   afaHE35sH/4bRGE4Qr84m2dAi3nBMqQvXFOZ9bcBnbZIB7ah18M5SxwP2
   0SUpV7K8sG4uzA454kPDEegZP5v7YgtkxmIonhNfhN5L6DyTPa1Ng4+w1
   3eWi5OeIDe8nA0u00e0KK95Gg8vrXx2GRkz+hSHG7cFnG1s7cb4osAOVV
   3oWczmyl/wSm6Aglxp5p1OzpZ02xQaibTSHzzhXFZMu8oaAgObJu+x38Y
   w==;
X-CSE-ConnectionGUID: 5Mbz9W4rT7OUwJXXpl+ONw==
X-CSE-MsgGUID: 2uqvt1YHSMS2b9bAUnz5NQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59927985"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="59927985"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 23:12:20 -0700
X-CSE-ConnectionGUID: 7iiyLb0gTQKzYgZsQns6qQ==
X-CSE-MsgGUID: YvLAq677T2aT4P0SOnx1/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136447523"
Received: from ww-dev.sh.intel.com ([10.239.48.95])
  by fmviesa006.fm.intel.com with ESMTP; 08 May 2025 23:12:18 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	yi.l.liu@intel.com,
	jroedel@suse.de,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 2/3] iommu/vt-d: Change dmar_ats_supported() to return boolean
Date: Fri,  9 May 2025 22:00:20 +0800
Message-ID: <20250509140021.4029303-3-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509140021.4029303-1-wei.w.wang@intel.com>
References: <20250509140021.4029303-1-wei.w.wang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to "Function return values and names" in coding-style.rst, the
dmar_ats_supported() function should return a boolean instead of an
integer. Also, rename "ret" to "supported" to be more straightforward.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/iommu/intel/iommu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d8aa71305509..2778bfe14f36 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2760,10 +2760,11 @@ static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
 	return satcu;
 }
 
-static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
+static bool dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 {
-	int i, ret = 1;
+	int i;
 	struct pci_bus *bus;
+	bool supported = true;
 	struct pci_dev *bridge = NULL;
 	struct device *tmp;
 	struct acpi_dmar_atsr *atsr;
@@ -2786,11 +2787,11 @@ static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
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
@@ -2809,11 +2810,11 @@ static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
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

