Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196BA24E014
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742350843; cv=none; b=BAG1l2XE75iK2XlfbgnAYFaCU33KvEKb5VFJCo9WDfWHTEVn9SG2lVGGTROKMhRo5wNoVWwvcTZXyy5o6Ic94oZebto+NzWXLezTiBCgdr0wXRnv8c3wBaYvcb6lVyW6gU+loEhrLIAPIFlAvOCFnJsnfqxGMcp6n+Dx0JyO88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742350843; c=relaxed/simple;
	bh=kAWLR5rUwyglBNFMiHrAUO27C72Ztw3iIuXLmxZHb0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s71wUtcedbx0x9v+eDUkK01A1pQrrOIab3liqvW77iGxIArjxsIxWQ4QGUO0GeWvXM3HXGMTCks6qniZx1j9/eNwJ5gNQlLD1Yorvj7j5Dw0ozFiD9ch1Oirt/936x8+tS6MaQ5EE6BZODLhF3W9nvRJ1HFyzl6MhRmG/i1ExPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uy+zU/Cy; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uy+zU/Cy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742350842; x=1773886842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kAWLR5rUwyglBNFMiHrAUO27C72Ztw3iIuXLmxZHb0c=;
  b=Uy+zU/CyWLlDWGQ6UgltqT4fG+LkXt19gi9mH2OBE9MZyMFCa+XfoOc0
   xp8DAiAn5m8NIPyZcVB25SZro2zGuQy97cMVNKWvT9bcRhHf40G+rxgpj
   mGV75uSVxwWi1l5CGG2Fz1Cou2ZXXXjs4rUVpYiYbsA0r2RxJ7j4uExUs
   yS6bYO1qH3rHW0yLBCeP8xsD/sJRAH+qlgm6Q6ScrlBZiJKsAg1P+m98b
   hcpvN3m4meIL5xxZcbWlq/pZs9QjG3JKqz4mqKh4zbrMm7knHL/UfXRyH
   jJWk8t/HKSoIS16+TvAUx8nilnFVz0qytfxLfyw4pMa/XYXK+Y61M0bZI
   w==;
X-CSE-ConnectionGUID: Qr6XFnvzRey6rfo2d8Ky6g==
X-CSE-MsgGUID: 4dIus7y+QgScJoiYuZF3PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42693233"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="42693233"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 19:20:42 -0700
X-CSE-ConnectionGUID: RSlaQ8zRRI2+bnnE4gZa5w==
X-CSE-MsgGUID: KdimuEI0TLqdpJF5IMo6IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="123372402"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 18 Mar 2025 19:20:40 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iommu/vt-d: Don't clobber posted vCPU IRTE when host IRQ affinity changes
Date: Wed, 19 Mar 2025 10:21:00 +0800
Message-ID: <20250319022101.1053133-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319022101.1053133-1-baolu.lu@linux.intel.com>
References: <20250319022101.1053133-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Don't overwrite an IRTE that is posting IRQs to a vCPU with a posted MSI
entry if the host IRQ affinity happens to change.  If/when the IRTE is
reverted back to "host mode", it will be reconfigured as a posted MSI or
remapped entry as appropriate.

Drop the "mode" field, which doesn't differentiate between posted MSIs and
posted vCPUs, in favor of a dedicated posted_vcpu flag.  Note!  The two
posted_{msi,vcpu} flags are intentionally not mutually exclusive; an IRTE
can transition between posted MSI and posted vCPU.

Fixes: ed1e48ea4370 ("iommu/vt-d: Enable posted mode for device MSIs")
Cc: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20250315025135.2365846-3-seanjc@google.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/irq_remapping.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index c495b533103f..ea3ca5203919 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -25,11 +25,6 @@
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
 
-enum irq_mode {
-	IRQ_REMAPPING,
-	IRQ_POSTING,
-};
-
 struct ioapic_scope {
 	struct intel_iommu *iommu;
 	unsigned int id;
@@ -49,8 +44,8 @@ struct irq_2_iommu {
 	u16 irte_index;
 	u16 sub_handle;
 	u8  irte_mask;
-	enum irq_mode mode;
 	bool posted_msi;
+	bool posted_vcpu;
 };
 
 struct intel_ir_data {
@@ -138,7 +133,6 @@ static int alloc_irte(struct intel_iommu *iommu,
 		irq_iommu->irte_index =  index;
 		irq_iommu->sub_handle = 0;
 		irq_iommu->irte_mask = mask;
-		irq_iommu->mode = IRQ_REMAPPING;
 	}
 	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 
@@ -193,8 +187,6 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
 
 	rc = qi_flush_iec(iommu, index, 0);
 
-	/* Update iommu mode according to the IRTE mode */
-	irq_iommu->mode = irte->pst ? IRQ_POSTING : IRQ_REMAPPING;
 	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 
 	return rc;
@@ -1173,9 +1165,18 @@ static void __intel_ir_reconfigure_irte(struct irq_data *irqd, bool force_host)
 {
 	struct intel_ir_data *ir_data = irqd->chip_data;
 
+	/*
+	 * Don't modify IRTEs for IRQs that are being posted to vCPUs if the
+	 * host CPU affinity changes.
+	 */
+	if (ir_data->irq_2_iommu.posted_vcpu && !force_host)
+		return;
+
+	ir_data->irq_2_iommu.posted_vcpu = false;
+
 	if (ir_data->irq_2_iommu.posted_msi)
 		intel_ir_reconfigure_irte_posted(irqd);
-	else if (force_host || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
+	else
 		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
 }
 
@@ -1270,6 +1271,7 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		irte_pi.pda_h = (vcpu_pi_info->pi_desc_addr >> 32) &
 				~(-1UL << PDA_HIGH_BIT);
 
+		ir_data->irq_2_iommu.posted_vcpu = true;
 		modify_irte(&ir_data->irq_2_iommu, &irte_pi);
 	}
 
@@ -1496,6 +1498,9 @@ static void intel_irq_remapping_deactivate(struct irq_domain *domain,
 	struct intel_ir_data *data = irq_data->chip_data;
 	struct irte entry;
 
+	WARN_ON_ONCE(data->irq_2_iommu.posted_vcpu);
+	data->irq_2_iommu.posted_vcpu = false;
+
 	memset(&entry, 0, sizeof(entry));
 	modify_irte(&data->irq_2_iommu, &entry);
 }
-- 
2.43.0

