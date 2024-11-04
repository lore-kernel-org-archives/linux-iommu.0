Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A8A18C336
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684496; cv=none; b=HcmAfXxEYiNTuXeM4apW4Fg6HbckeNT/eux6ctJ/F72WW6nyB3FMP//Ef7x1A/wTmEnJqXV5i7VrlYTXUF56ymqiXlzT6uWHDJjLyVZ8YbNbuboZNAML+QKIz9qqA3WhjVuciP7Hacyv64uwtA6wMy4WV7LpBQlzkptDTA82MOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684496; c=relaxed/simple;
	bh=CNdQf3c8BnF3uaSXPEHvfh++THuZ5RA8EOj2F3gufF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDs+0EoJpfOiO5Gm6dkXPojcFI0HjAflxna+CI+qNVwG95HBB06rYpatY1W/jou3u9UPadm3+lWvwBHXwsEp+0+ljoZ3xaqZ0f6jyl/HT9cR04lCDVHfUj9Xs+3HKd+JmviJD/LF3GRgf6+2XP9iKpeomZyEFw0O3AweGpyfRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJLG7ELV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJLG7ELV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684494; x=1762220494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CNdQf3c8BnF3uaSXPEHvfh++THuZ5RA8EOj2F3gufF4=;
  b=HJLG7ELVA1tvrrYWPoQcJzCBgL7zXPChPtGEjyE8tXLj9xiDQz0h3gnC
   RHWH7psGggmLnQUzvFpfaq2hFSPv94RenYwiFPPcjLT4rKpFga+vDjo2k
   akOyLqycFQqwc2deMQp1iDsJMosA66kjj0BSvN+/Z9cc+KAF3kt9qxpuq
   292CR+TI4SvnAjN+C71kfeZqyvXXGvn5cClDwUK8pTT9qyvDEnadek4YB
   M3pOT3x8IP0QUUoJ4UUWA7+vQ5ZAOC0O5eLFRf6vV5ZuB0ZdTyTob9zri
   L47U3aoUVINRADoB+vHM8OJDxpduTw4jZuB8KaygncctromzuUQ2/JU77
   g==;
X-CSE-ConnectionGUID: qBQdvbt+S/2UGfaYE2SEFw==
X-CSE-MsgGUID: 6YQi2ekvRyStNwa6dwZDqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221933"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221933"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:34 -0800
X-CSE-ConnectionGUID: cKXURNujTBGgcd7VjwRb2w==
X-CSE-MsgGUID: PB8aPC28Q7iAFgHcGdU2sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020886"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:33 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/19] iommu/vt-d: Use PCI_DEVID() macro
Date: Mon,  4 Nov 2024 09:40:28 +0800
Message-ID: <20241104014040.106100-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinjie Ruan <ruanjinjie@huawei.com>

The macro PCI_DEVID() can be used instead of compose it manually.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20240829021011.4135618-1-ruanjinjie@huawei.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c         | 4 ++--
 drivers/iommu/intel/irq_remapping.c | 4 ++--
 drivers/iommu/intel/pasid.c         | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5fbf1237188c..a2212d15371d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1452,7 +1452,7 @@ static void copied_context_tear_down(struct intel_iommu *iommu,
 
 	if (did_old < cap_ndoms(iommu->cap)) {
 		iommu->flush.flush_context(iommu, did_old,
-					   (((u16)bus) << 8) | devfn,
+					   PCI_DEVID(bus, devfn),
 					   DMA_CCMD_MASK_NOBIT,
 					   DMA_CCMD_DEVICE_INVL);
 		iommu->flush.flush_iotlb(iommu, did_old, 0, 0,
@@ -1473,7 +1473,7 @@ static void context_present_cache_flush(struct intel_iommu *iommu, u16 did,
 {
 	if (cap_caching_mode(iommu->cap)) {
 		iommu->flush.flush_context(iommu, 0,
-					   (((u16)bus) << 8) | devfn,
+					   PCI_DEVID(bus, devfn),
 					   DMA_CCMD_MASK_NOBIT,
 					   DMA_CCMD_DEVICE_INVL);
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 7a6d188e3bea..466c1412dd45 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -312,7 +312,7 @@ static int set_ioapic_sid(struct irte *irte, int apic)
 
 	for (i = 0; i < MAX_IO_APICS; i++) {
 		if (ir_ioapic[i].iommu && ir_ioapic[i].id == apic) {
-			sid = (ir_ioapic[i].bus << 8) | ir_ioapic[i].devfn;
+			sid = PCI_DEVID(ir_ioapic[i].bus, ir_ioapic[i].devfn);
 			break;
 		}
 	}
@@ -337,7 +337,7 @@ static int set_hpet_sid(struct irte *irte, u8 id)
 
 	for (i = 0; i < MAX_HPET_TBS; i++) {
 		if (ir_hpet[i].iommu && ir_hpet[i].id == id) {
-			sid = (ir_hpet[i].bus << 8) | ir_hpet[i].devfn;
+			sid = PCI_DEVID(ir_hpet[i].bus, ir_hpet[i].devfn);
 			break;
 		}
 	}
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 53157e1194f4..7ef157615e0f 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -220,7 +220,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	if (pci_dev_is_disconnected(to_pci_dev(dev)))
 		return;
 
-	sid = info->bus << 8 | info->devfn;
+	sid = PCI_DEVID(info->bus, info->devfn);
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
 
-- 
2.43.0

