Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CD426B95C
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771144; cv=none; b=rv7jFf2kD0ZSWNpYjvAeF30boLL7Ejol1CAMfEyegDoWE1pIhhtZRG2kPNJ/h/AvT1F5qobpHOZuCfY742vGULAJ2mvQ7+wzERWdR237OfZOZTE75JnPqMKnNSwVqUf+a21D3Ja0qHk/tQ5uncdQwSDsdgKct0n0eqVRzRyid8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771144; c=relaxed/simple;
	bh=ApPHZMInBbwwMKSHji1AAjrGRiRhajPqlSo4V4Is35o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioC8xrC1aNynuzGe20FiN9lbM1EbjfwguregOOPps8Bw7utKTj90VcwyFx+zx44gYVo1MjEREQSc9HAvBj+eBF3D6cBa+ZOHh7LXWUBTG8dQLKOjyRpf6oEumjyCl7N6sHcZ0vInT8MI71Ol7JI2LG6HMcWbbjVu3Cnt2357cQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cA2g1DwM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cA2g1DwM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746771143; x=1778307143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ApPHZMInBbwwMKSHji1AAjrGRiRhajPqlSo4V4Is35o=;
  b=cA2g1DwMYYRDNX4JdIGz8t5BYQudg6vN/MAl962TGTbDSyWfGVYj54RE
   XAAZpw1srHuBmapyqFWErCPyobMlw+uYqMyFTUCjQzMHhmMOvm+vn02Qk
   1GSducjOrqx35q5rpYxJiq6/rEsAw3/b743Qq+zJr3MYl68TMbDLUsui1
   eR4l8baBeVRKehO2gB823sh8o4hXLMyXDRNfMjL9QfDdR2NeM/Cj6abvq
   1gu1eucrmJWdqrdDnXAt4dZwHjPNY6mfuSTDb21BwIzqYrV+CKBkR92+y
   yAE5UqlbnAUzW5edUc0aPiYpAK5/OkLQ7r/9kz2URz9XpYLc8p2COekrO
   g==;
X-CSE-ConnectionGUID: xVs3pj0OSoKz3SoDNIh5Zw==
X-CSE-MsgGUID: mBCQDowoTXehGjXNT4NIZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59927989"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="59927989"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 23:12:22 -0700
X-CSE-ConnectionGUID: XdDxP9ZtRhKWUPE77zGqfw==
X-CSE-MsgGUID: qmYXEztYRTK1higeCRjwtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136447531"
Received: from ww-dev.sh.intel.com ([10.239.48.95])
  by fmviesa006.fm.intel.com with ESMTP; 08 May 2025 23:12:20 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	yi.l.liu@intel.com,
	jroedel@suse.de,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1 3/3] iommu/vt-d: Fix ATS support check for integrated endpoints
Date: Fri,  9 May 2025 22:00:21 +0800
Message-ID: <20250509140021.4029303-4-wei.w.wang@intel.com>
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

The VT-d spec states that "SATC reporting structure identifies devices
that have address translation cache and that is validated per requirements
described in the 'Device TLB in System-on-Chip (SoC) Integrated Devices'
section. It is recommended that system software enable ATC for this
device". It is possible for an integrated device to have PCI ATC
capability implemented but not validated per the requirements, and thus
not appear in the SATC structure as recommended for ATS enablement.

The current implementation checks ATS support for integrated endpoints in
two places. First, it verifies if the integrated endpoint device is listed
in SATC. If not, it proceeds to the second check that always returns true
for integrated devices. This could result in endpoint devices not
recommended in SATC presenting "supported = true" to the caller.

Add integrated_device_ats_supported() for the integrated device ATS check
in a single location, which improves readability. The above issue is
also fixed in the function via returning false in that case.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/iommu/intel/iommu.c | 42 +++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2778bfe14f36..39abcf4e0f8f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2760,6 +2760,34 @@ static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
 	return satcu;
 }
 
+static bool integrated_device_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
+{
+	struct dmar_satc_unit *satcu = dmar_find_matched_satc_unit(dev);
+
+	/*
+	 * This device supports ATS as it is in SATC table. When IOMMU is in
+	 * legacy mode, enabling ATS is done automatically by HW for the device
+	 * that requires ATS, hence OS should not enable this device ATS to
+	 * avoid duplicated TLB invalidation.
+	 */
+	if (satcu)
+		return !(satcu->atc_required && !sm_supported(iommu));
+
+	/*
+	 * The integrated device isn't enumerated in the SATC structure. For
+	 * example, it has ATS PCI capability implemented but not validated per
+	 * the requirements described in the VT-d specification, specifically
+	 * in the "Device TLB in System-on-Chip (SoC) Integrated Devices"
+	 * section. Therefore, it does not appear in the SATC structure. Return
+	 * false in this case.
+	 *
+	 * On older machines that do not support SATC (i.e., no SATC structure
+	 * present), ATS is considered to be "always" supported for integrated
+	 * endpoints.
+	 */
+	return !list_empty(&dmar_satc_units);
+}
+
 static bool dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 {
 	int i;
@@ -2769,25 +2797,13 @@ static bool dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
 	struct device *tmp;
 	struct acpi_dmar_atsr *atsr;
 	struct dmar_atsr_unit *atsru;
-	struct dmar_satc_unit *satcu;
 
 	dev = pci_physfn(dev);
-	satcu = dmar_find_matched_satc_unit(dev);
-	if (satcu)
-		/*
-		 * This device supports ATS as it is in SATC table.
-		 * When IOMMU is in legacy mode, enabling ATS is done
-		 * automatically by HW for the device that requires
-		 * ATS, hence OS should not enable this device ATS
-		 * to avoid duplicated TLB invalidation.
-		 */
-		return !(satcu->atc_required && !sm_supported(iommu));
 
 	for (bus = dev->bus; bus; bus = bus->parent) {
 		bridge = bus->self;
-		/* If it's an integrated device, allow ATS */
 		if (!bridge)
-			return true;
+			return integrated_device_ats_supported(dev, iommu);
 		/* Connected via non-PCIe: no ATS */
 		if (!pci_is_pcie(bridge) ||
 		    pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE)
-- 
2.43.0

