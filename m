Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92836BCED
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890052; cv=none; b=KU44riKnYoQf+7uJ6Bq22VcnAWWTpWscXb235neCdAjMLI3DFD8qjd4XX5GkoYp2zE5zUDEWMUgeEFEFnOzGI90EgeN6qVIsUD/WWjzIZQ5nJ9gOc8yUzDmMQINNjj1bEhsNWo5CPMwxCeAHTdhZ9aCTf1RFzF5DjAaz2hdtMaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890052; c=relaxed/simple;
	bh=/WYsX64qJwlOy49NaeAGZcfXuqecSO9XVNigfGEGZ94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B63/TdNX5Z0w22blTCLd4wuoAJUu9IsWIF/Dii+to+97NEjBCW1BrcVLjpqO2HeAJI4jV+A7Pye+yZjSVXg3HWdxQM9IMK1YfaUgW1meOpn1AwN5qXixkKjEC4ULt1JrMqWLEMdvwOSklSWvZyhLTKvmLxu2hfmGSUFDeW2u52U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2zcjY2y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2zcjY2y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768890050; x=1800426050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/WYsX64qJwlOy49NaeAGZcfXuqecSO9XVNigfGEGZ94=;
  b=F2zcjY2y0CAgPsfWP1g+uE/oiMy8Of527n3ehJtk+xWWJk1/M1ch2GeX
   fn1xqAzfq0vWSJiHL+3+qsFvBm27Uogc9saL1Bpe1rH0n9gO00VBaIzD7
   zL1uuQAgFCZBOXc+z7FNgCiMPq3pZ3x7G9tlyzx2l94prml9hOBL+8/FM
   L5glglECyZAnN0eCg5qzjUiZ0eyjP0pgE8egmFcwRZcbIB2wkboR4KUfE
   pH16EqiWEAgELZBjpKZhOPg5Q68IPcjWiPlWyQNf1vupX8f55TXKInzTC
   +tJIXICT2hSAq0iT4cDwnSPnMESfD7A3CtAa71pI1z0gs9TlCiilJuERB
   Q==;
X-CSE-ConnectionGUID: goXW8fqxQzmEJHgtg8WtVQ==
X-CSE-MsgGUID: b4hgrkHMST2QaKN3c+1GyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69991309"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="69991309"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 22:20:49 -0800
X-CSE-ConnectionGUID: 2LA9h3nxTJqFjkXa+Fi7Pw==
X-CSE-MsgGUID: whgXCnaiTGC4P5LotsOFqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206464267"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa009.fm.intel.com with ESMTP; 19 Jan 2026 22:20:47 -0800
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
Subject: [PATCH v2 1/3] iommu/vt-d: Clear Present bit before tearing down PASID entry
Date: Tue, 20 Jan 2026 14:18:12 +0800
Message-ID: <20260120061816.2132558-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel VT-d Scalable Mode PASID table entry consists of 512 bits (64
bytes). When tearing down an entry, the current implementation zeros the
entire 64-byte structure immediately using multiple 64-bit writes.

Since the IOMMU hardware may fetch these 64 bytes using multiple
internal transactions (e.g., four 128-bit bursts), updating or zeroing
the entire entry while it is active (P=1) risks a "torn" read. If a
hardware fetch occurs simultaneously with the CPU zeroing the entry, the
hardware could observe an inconsistent state, leading to unpredictable
behavior or spurious faults.

Follow the "Guidance to Software for Invalidations" in the VT-d spec
(Section 6.5.3.3) by implementing the recommended ownership handshake:

1. Clear only the 'Present' (P) bit of the PASID entry.
2. Use a dma_wmb() to ensure the cleared bit is visible to hardware
   before proceeding.
3. Execute the required invalidation sequence (PASID cache, IOTLB, and
   Device-TLB flush) to ensure the hardware has released all cached
   references.
4. Only after the flushes are complete, zero out the remaining fields
   of the PASID entry.

Also, add a dma_wmb() in pasid_set_present() to ensure that all other
fields of the PASID entry are visible to the hardware before the Present
bit is set.

Fixes: 0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h | 14 ++++++++++++++
 drivers/iommu/intel/pasid.c |  6 +++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index b4c85242dc79..0b303bd0b0c1 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -234,9 +234,23 @@ static inline void pasid_set_wpe(struct pasid_entry *pe)
  */
 static inline void pasid_set_present(struct pasid_entry *pe)
 {
+	dma_wmb();
 	pasid_set_bits(&pe->val[0], 1 << 0, 1);
 }
 
+/*
+ * Clear the Present (P) bit (bit 0) of a scalable-mode PASID table entry.
+ * This initiates the transition of the entry's ownership from hardware
+ * to software. The caller is responsible for fulfilling the invalidation
+ * handshake recommended by the VT-d spec, Section 6.5.3.3 (Guidance to
+ * Software for Invalidations).
+ */
+static inline void pasid_clear_present(struct pasid_entry *pe)
+{
+	pasid_set_bits(&pe->val[0], 1 << 0, 0);
+	dma_wmb();
+}
+
 /*
  * Setup Page Walk Snoop bit (Bit 87) of a scalable mode PASID
  * entry.
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3e2255057079..eb069aefa4fa 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -272,7 +272,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 
 	did = pasid_get_domain_id(pte);
 	pgtt = pasid_pte_get_pgtt(pte);
-	intel_pasid_clear_entry(dev, pasid, fault_ignore);
+	pasid_clear_present(pte);
 	spin_unlock(&iommu->lock);
 
 	if (!ecap_coherent(iommu->ecap))
@@ -286,6 +286,10 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
 	devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	intel_pasid_clear_entry(dev, pasid, fault_ignore);
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(pte, sizeof(*pte));
+
 	if (!fault_ignore)
 		intel_iommu_drain_pasid_prq(dev, pasid);
 }
-- 
2.43.0

