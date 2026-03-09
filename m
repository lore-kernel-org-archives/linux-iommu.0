Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272F34EF1B
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036589; cv=none; b=mZMMY+BIZibtuDFZC4I0bb7TiA39bQ6WA9SeWyxhzbQ49MY2tNV4NUoXO5tuSD/02d9hnGHJ9Fvs6YySpCDlH4w3saobHbnGIvgndDDvoyplu41bssCsXkVJOwFDqXYR32Ol2dlN5lkN2LTlYKFFgRRjtqaYWHG2RxNsAmq5134=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036589; c=relaxed/simple;
	bh=YY6Oan1TxDQ3pXt0pTXICCe0X+YwI1YxncTCoF+aR1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PR4/XWK56eGf9jdetQAbiw3PT7m1MHx+y6HdW1SswGpD/PHh+264oaOohOC8GJ3EYfDRcIOHVGpwM33XUcEPEu+HXUY72aa38ABEA7sUGjUrAks36/vnGyJvUIBpJezqGZEfQ5xtmi52NlF4gVK0dokMz/5KXmpIG8zV/L4GRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwwvTLdB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwwvTLdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773036588; x=1804572588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YY6Oan1TxDQ3pXt0pTXICCe0X+YwI1YxncTCoF+aR1Y=;
  b=CwwvTLdBViQzlWOkABh3cOBTnwjOqnpVrWsrT+H6wcuqdJNIjrKajqsN
   k4LhOM3vfxhEa1E2x1BEpGDPyY0r/QJDbTk5lQRvHbAXnNkXBo9ky/Xwe
   SvO6A5ivgyIyEUGJB2YlLYbeNoiE6It9REKQm0SQX6NXfJGBqkAyFit/P
   N8vq2ohP1SSqr1MgFTHt5mxtnaj/Nlqh+gICTORiYDnVLmSXqslD94uED
   oJ9KhUTmT/ItST6q+3j0sy2dpSH0VDRwTiSSToz5waXFUxuaUFUCEtTLd
   Wys+sruLDa+U46t3Uf70ec7zBE9VPPbJNf7FLyjNQzQD6jojXNE1eZaOz
   w==;
X-CSE-ConnectionGUID: XcrgfT/CRSmlhf8Jz96SCQ==
X-CSE-MsgGUID: Cfq0ezmpSaCVNWHC8Fi4Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73248253"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73248253"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 23:09:48 -0700
X-CSE-ConnectionGUID: syalacKYQ1+5r6FnV/S0Wg==
X-CSE-MsgGUID: CHhAKf8TTbGoCV+7E1KxSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="245669162"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2026 23:09:45 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/8] iommu/vt-d: Add entry_sync support for PASID entry updates
Date: Mon,  9 Mar 2026 14:06:42 +0800
Message-ID: <20260309060648.276762-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309060648.276762-1-baolu.lu@linux.intel.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Updating PASID table entries while the device hardware is possibly
performing DMA concurrently is complex. Traditionally, this required
a "clear-then-update" approach — clearing the Present bit, flushing
caches, updating the entry, and then restoring the Present bit. This
causes unnecessary latency or interruptions for transactions that might
not even be affected by the specific bits being changed.

Plumb this driver into the generic entry_sync library to modernize
this process. The library uses the concept of "Used bits" to determine
if a transition can be performed "hitlessly" (via a single atomic
128-bit swap) or if a disruptive 3-step update is truly required.

The implementation includes:

- intel_pasid_get_used(): Defines which bits the IOMMU hardware is
  sensitive to based on the PGTT.
- intel_pasid_sync(): Handles the required clflushes, PASID cache
  invalidations, and IOTLB/Dev-TLB flushes required between update
  steps.
- 128-bit atomicity: Depends on IOMMU_ENTRY_SYNC128 to ensure that
  256-bit PASID entries are updated in atomic 128-bit quanta,
  preventing the hardware from ever seeing a "torn" entry.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/Kconfig |   2 +
 drivers/iommu/intel/pasid.c | 173 ++++++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 5471f814e073..7fa31b9d4ef4 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -26,6 +26,8 @@ config INTEL_IOMMU
 	select PCI_ATS
 	select PCI_PRI
 	select PCI_PASID
+	select IOMMU_ENTRY_SYNC
+	select IOMMU_ENTRY_SYNC128
 	help
 	  DMA remapping (DMAR) devices support enables independent address
 	  translations for Direct Memory Access (DMA) from devices.
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 9d30015b8940..5b9eb5c8f42d 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -21,12 +21,185 @@
 #include "iommu.h"
 #include "pasid.h"
 #include "../iommu-pages.h"
+#include "../entry_sync.h"
 
 /*
  * Intel IOMMU system wide PASID name space:
  */
 u32 intel_pasid_max_id = PASID_MAX;
 
+/*
+ * Plumb into the generic entry_sync library:
+ */
+static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid);
+static void pasid_flush_caches(struct intel_iommu *iommu, struct pasid_entry *pte,
+			       u32 pasid, u16 did);
+static void intel_pasid_flush_present(struct intel_iommu *iommu, struct device *dev,
+				      u32 pasid, u16 did, struct pasid_entry *pte);
+static void pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
+						u16 did, u32 pasid);
+static void devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
+					   struct device *dev, u32 pasid);
+
+struct intel_pasid_writer {
+	struct entry_sync_writer128 writer;
+	struct intel_iommu *iommu;
+	struct device *dev;
+	u32 pasid;
+	struct pasid_entry orig_pte;
+	bool was_present;
+};
+
+/*
+ * Identify which bits of the 256-bit entry the HW is using. The "Used" bits
+ * are those that, if changed, would cause the IOMMU to behave differently
+ * for an active transaction.
+ */
+static void intel_pasid_get_used(const u128 *entry, u128 *used)
+{
+	struct pasid_entry *pe = (struct pasid_entry *)entry;
+	struct pasid_entry *ue = (struct pasid_entry *)used;
+	u16 pgtt;
+
+	/* Initialize used bits to 0. */
+	memset(ue, 0, sizeof(*ue));
+
+	/* Present bit always matters. */
+	ue->val[0] |= PASID_PTE_PRESENT;
+
+	/* Nothing more for non-present entries. */
+	if (!(pe->val[0] & PASID_PTE_PRESENT))
+		return;
+
+	pgtt = pasid_pte_get_pgtt(pe);
+	switch (pgtt) {
+	case PASID_ENTRY_PGTT_FL_ONLY:
+		/* AW, PGTT */
+		ue->val[0] |= GENMASK_ULL(4, 2) | GENMASK_ULL(8, 6);
+		/* DID, PWSNP, PGSNP */
+		ue->val[1] |= GENMASK_ULL(24, 23) | GENMASK_ULL(15, 0);
+		/* FSPTPTR, FSPM */
+		ue->val[2] |= GENMASK_ULL(63, 12) | GENMASK_ULL(3, 2);
+		break;
+	case PASID_ENTRY_PGTT_NESTED:
+		/* FPD, AW, PGTT, SSADE, SSPTPTR*/
+		ue->val[0] |= GENMASK_ULL(63, 12) | GENMASK_ULL(9, 6) |
+				GENMASK_ULL(4, 1);
+		/* PGSNP, DID, PWSNP */
+		ue->val[1] |= GENMASK_ULL(24, 23) | GENMASK_ULL(15, 0);
+		/* FSPTPTR, FSPM, EAFE, WPE, SRE */
+		ue->val[2] |= GENMASK_ULL(63, 12) | BIT_ULL(7) |
+				GENMASK_ULL(4, 2) | BIT_ULL(0);
+		break;
+	case PASID_ENTRY_PGTT_SL_ONLY:
+		/* FPD, AW, PGTT, SSADE, SSPTPTR */
+		ue->val[0] |= GENMASK_ULL(63, 12) | GENMASK_ULL(9, 6) |
+				GENMASK_ULL(4, 1);
+		/* DID, PWSNP */
+		ue->val[1] |= GENMASK_ULL(15, 0) | BIT_ULL(23);
+		break;
+	case PASID_ENTRY_PGTT_PT:
+		/* FPD, AW, PGTT */
+		ue->val[0] |= GENMASK_ULL(4, 2) | GENMASK_ULL(8, 6) | BIT_ULL(1);
+		/* DID, PWSNP */
+		ue->val[1] |= GENMASK_ULL(15, 0) | BIT_ULL(23);
+		break;
+	default:
+		WARN_ON(true);
+	}
+}
+
+static void intel_pasid_sync(struct entry_sync_writer128 *writer)
+{
+	struct intel_pasid_writer *p_writer = container_of(writer,
+			struct intel_pasid_writer, writer);
+	struct intel_iommu *iommu = p_writer->iommu;
+	struct device *dev = p_writer->dev;
+	bool was_present, is_present;
+	u32 pasid = p_writer->pasid;
+	struct pasid_entry *pte;
+	u16 old_did, old_pgtt;
+
+	pte = intel_pasid_get_entry(dev, pasid);
+	was_present = p_writer->was_present;
+	is_present = pasid_pte_is_present(pte);
+	old_did = pasid_get_domain_id(&p_writer->orig_pte);
+	old_pgtt = pasid_pte_get_pgtt(&p_writer->orig_pte);
+
+	/* Update the last present state: */
+	p_writer->was_present = is_present;
+
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(pte, sizeof(*pte));
+
+	/* Sync for "P=0" to "P=1": */
+	if (!was_present) {
+		if (is_present)
+			pasid_flush_caches(iommu, pte, pasid,
+					   pasid_get_domain_id(pte));
+
+		return;
+	}
+
+	/* Sync for "P=1" to "P=1": */
+	if (is_present) {
+		intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
+		return;
+	}
+
+	/* Sync for "P=1" to "P=0": */
+	pasid_cache_invalidation_with_pasid(iommu, old_did, pasid);
+
+	if (old_pgtt == PASID_ENTRY_PGTT_PT || old_pgtt == PASID_ENTRY_PGTT_FL_ONLY)
+		qi_flush_piotlb(iommu, old_did, pasid, 0, -1, 0);
+	else
+		iommu->flush.flush_iotlb(iommu, old_did, 0, 0, DMA_TLB_DSI_FLUSH);
+
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
+}
+
+static const struct entry_sync_writer_ops128 writer_ops128 = {
+	.get_used = intel_pasid_get_used,
+	.sync = intel_pasid_sync,
+};
+
+#define INTEL_PASID_SYNC_MEM_COUNT	12
+
+static int __maybe_unused intel_pasid_write(struct intel_iommu *iommu,
+					    struct device *dev, u32 pasid,
+					    u128 *target)
+{
+	struct pasid_entry *pte = intel_pasid_get_entry(dev, pasid);
+	struct intel_pasid_writer p_writer = {
+		.writer = {
+			.ops = &writer_ops128,
+			/* 512 bits total (4 * 128-bit chunks) */
+			.num_quantas = 4,
+			/* The 'P' bit is in the first 128-bit chunk */
+			.vbit_quanta = 0,
+		},
+		.iommu = iommu,
+		.dev = dev,
+		.pasid = pasid,
+	};
+	u128 memory[INTEL_PASID_SYNC_MEM_COUNT];
+
+	if (!pte)
+		return -ENODEV;
+
+	p_writer.orig_pte = *pte;
+	p_writer.was_present = pasid_pte_is_present(pte);
+
+	/*
+	 * The library now does the heavy lifting:
+	 * 1. Checks if it can do a 1-quanta hitless flip.
+	 * 2. If not, it does a 3-step V=0 (disruptive) update.
+	 */
+	entry_sync_write128(&p_writer.writer, (u128 *)pte, target, memory, sizeof(memory));
+
+	return 0;
+}
+
 /*
  * Per device pasid table management:
  */
-- 
2.43.0

