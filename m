Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38D224898
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742350842; cv=none; b=LhnzieAU11RkuHgC6k6txnKtSfia/ctQjl++LDaNXa56HzXkZH4f9/vDFmeHomi6YJVnL340J7inRwEq06JEj7vVmb/oXSnjxcCH6d5GT7O/iJD3WRCNxmHP1i7NJ0TO0sjGy0hkGPnmiLEMZ2GB1gFo8hktqspkiY1HetK3v8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742350842; c=relaxed/simple;
	bh=TcFOaMBC3GdcjOyQV2RecoDfdc6RUJknTRvdya4AKys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wvh04ql0eOBTB7Hfdpxf3rHDgWmlBe4dpHeyICrWdlQYQU/tVXPdgYi/ffK3uYnBizkwERUL0fkr7QK/xRC1Pb6zlDIXEeua5ADveOuKA0ATmkNGYYoeOd1dzPN6tG2W5xuQhaBRPfV/j2xezr7TNUN3yXFgLmLeAGYrQt/VHsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFe5GliK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFe5GliK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742350841; x=1773886841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TcFOaMBC3GdcjOyQV2RecoDfdc6RUJknTRvdya4AKys=;
  b=VFe5GliKf6c4+U8vslI48O2WsyK0svSiDExCR8sQOwM8IF2cBHw6QC5n
   YmUL3YRtpjbzFPM7/twpfLcAG6Lk/EqqiBnZnpOwXnpSdOxO6u2vSPzoI
   QHGDPtegjpQC+Xlmy0QL1yDQGJlTFtdF0gHPlzNGfkWLRQ2R8KUshNPFx
   LHEcCN1RKlYHxW+EP08qZ2Ifwi4oYWpLRsQo+XNDwLme0Ay8o1NNicmib
   ZU0ADtJkFBZ0trS5XXG68aBBng6H1OoMfC1bEnVhzbIYbSIFzmke7PZsp
   XGJkx4Z6KQ4tOAA7r16wHKErliwEL0tp2Z37CDjpQCbFlWyC7plldHzVr
   Q==;
X-CSE-ConnectionGUID: d1X7ohrqSfSVd1dNzMFtsw==
X-CSE-MsgGUID: CqcZ+AGCSsSkdNzxT9WKwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42693230"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="42693230"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 19:20:40 -0700
X-CSE-ConnectionGUID: zME7LeUqQ3updjLGzdwjTQ==
X-CSE-MsgGUID: loUmRC3sQxqg7KwWaHBMDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="123372401"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 18 Mar 2025 19:20:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iommu/vt-d: Put IRTE back into posted MSI mode if vCPU posting is disabled
Date: Wed, 19 Mar 2025 10:20:59 +0800
Message-ID: <20250319022101.1053133-2-baolu.lu@linux.intel.com>
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

Add a helper to take care of reconfiguring an IRTE to deliver IRQs to the
host, i.e. not to a vCPU, and use the helper when an IRTE's vCPU affinity
is nullified, i.e. when KVM puts an IRTE back into "host" mode.  Because
posted MSIs use an ephemeral IRTE, using modify_irte() puts the IRTE into
full remapped mode, i.e. unintentionally disables posted MSIs on the IRQ.

Fixes: ed1e48ea4370 ("iommu/vt-d: Enable posted mode for device MSIs")
Cc: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20250315025135.2365846-2-seanjc@google.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/irq_remapping.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index ad795c772f21..c495b533103f 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1169,7 +1169,17 @@ static void intel_ir_reconfigure_irte_posted(struct irq_data *irqd)
 static inline void intel_ir_reconfigure_irte_posted(struct irq_data *irqd) {}
 #endif
 
-static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
+static void __intel_ir_reconfigure_irte(struct irq_data *irqd, bool force_host)
+{
+	struct intel_ir_data *ir_data = irqd->chip_data;
+
+	if (ir_data->irq_2_iommu.posted_msi)
+		intel_ir_reconfigure_irte_posted(irqd);
+	else if (force_host || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
+		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
+}
+
+static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force_host)
 {
 	struct intel_ir_data *ir_data = irqd->chip_data;
 	struct irte *irte = &ir_data->irte_entry;
@@ -1182,10 +1192,7 @@ static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
 	irte->vector = cfg->vector;
 	irte->dest_id = IRTE_DEST(cfg->dest_apicid);
 
-	if (ir_data->irq_2_iommu.posted_msi)
-		intel_ir_reconfigure_irte_posted(irqd);
-	else if (force || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
-		modify_irte(&ir_data->irq_2_iommu, irte);
+	__intel_ir_reconfigure_irte(irqd, force_host);
 }
 
 /*
@@ -1240,7 +1247,7 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 
 	/* stop posting interrupts, back to the default mode */
 	if (!vcpu_pi_info) {
-		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
+		__intel_ir_reconfigure_irte(data, true);
 	} else {
 		struct irte irte_pi;
 
-- 
2.43.0

