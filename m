Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761D41401C
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 05:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719206866; cv=none; b=LEfhLEej7pQFWU0Z8Gu734FYuhd7rAEFwmdyPfKimcdAfR/UyUEJiRtfiJPvblp5m0lNxcZCyu4SQJcC1qK2eN+7gQLF+GhQTT2fHreAK57DofYyYRfWyG3jN+tcM0m+Np05mcuQlsoEdJXtoKxEauNNZ5hbo7sQJazUhoY2aI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719206866; c=relaxed/simple;
	bh=EMBbbwpXQyzzTBSb3XSF6LyxrJxE19zkDQ9IoyXTsuc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lTkpQEWzoQG3O7LH8r+lzL0xSH2ACaoQxiTDs/WHAU/YgdfKCSZ7fslh3+cAoDw+IVaObhP+AAadxNEDuiTICg2Y/CZ8sm2XwKLyFenLoUPDjCh3/5LdjWibp7cn5uFuvqZGRSz+3gGpkW5wR34xDoL32DGtvyjCUqs/ah3m0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQlHzOQr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQlHzOQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719206863; x=1750742863;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EMBbbwpXQyzzTBSb3XSF6LyxrJxE19zkDQ9IoyXTsuc=;
  b=dQlHzOQrClshl8klaKy+/jcHPi/knPksRi9C7TPinrXsNJlyY9Ep6Qlb
   LK8Xji8hxehy2jo1pOZoKQ5EL2JefsucoGa7rkBzjTD8XVstkTKk02RIb
   emdrJ2qsVOo+vfQJpob/r0ioVkgFf+wSTVFgY4BOhfcRiGyX0I/HXLRcF
   Loyy9czEPq8A17XrhTvyLYYx5Xj1G+cfDTlGdoVjLtmGoLn9ush8y3bTF
   pYwK8bFb56Yk1Uqzz5jH9bkeqiw+b3XPwAS0C6J61GV2GIlK+R2QEfJp3
   FGOb+aDturlKdWJOPlho8OWtNiZvntxarnVpeyAKBUG7LXzXpr3uqhr2A
   A==;
X-CSE-ConnectionGUID: zOjREQWlQYuQ7uxTuBdIlA==
X-CSE-MsgGUID: ADC9i/m8SyGHw0f5Kwx0kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16040075"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="16040075"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 22:27:43 -0700
X-CSE-ConnectionGUID: 5oOb+apCTJOB987AnT6oqw==
X-CSE-MsgGUID: aJF5fRRgRXOmdGHy9t300A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="48133382"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa005.jf.intel.com with ESMTP; 23 Jun 2024 22:27:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/2] iommu/vt-d: Convert dmar_ats_supported() to return bool
Date: Mon, 24 Jun 2024 13:25:00 +0800
Message-Id: <20240624052501.253405-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dmar_ats_supported() returns an integer that is used as a boolean. Since
it all it needs is to return true or false, change the return type from
int to bool to make it a bit more readable and obvious.

Cleanup this helper accordingly with no functional change intended.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 38cda454fc64..07e394dfccc1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3043,15 +3043,15 @@ static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
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
+	struct pci_bus *bus;
+	struct device *tmp;
+	int i;
 
 	dev = pci_physfn(dev);
 	satcu = dmar_find_matched_satc_unit(dev);
@@ -3069,11 +3069,11 @@ static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
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
@@ -3085,18 +3085,21 @@ static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 		if (atsr->segment != pci_domain_nr(dev->bus))
 			continue;
 
-		for_each_dev_scope(atsru->devices, atsru->devices_cnt, i, tmp)
-			if (tmp == &bridge->dev)
-				goto out;
+		for_each_dev_scope(atsru->devices, atsru->devices_cnt, i, tmp) {
+			if (tmp == &bridge->dev) {
+				rcu_read_unlock();
+				return true;
+			}
+		}
 
-		if (atsru->include_all)
-			goto out;
+		if (atsru->include_all) {
+			rcu_read_unlock();
+			return true;
+		}
 	}
-	ret = 0;
-out:
 	rcu_read_unlock();
 
-	return ret;
+	return false;
 }
 
 int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
-- 
2.34.1

