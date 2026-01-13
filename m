Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EE82BEFFB
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273416; cv=none; b=Z2uNRAfX386ePQ9V2XI4m5TfHsws+SwKRDn00XEHJjlB2P0X8m5d3J97Ac+sgQesMZ2nEQnf60uWbtjsyRCfGVRG2xpfyBZh5g5Mg1CZCBm11iqIcTS62LVBN0X6dieJta1p9bzwiaOq4zRX5sW1gQjXDQ50HR8PbR33ZG792Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273416; c=relaxed/simple;
	bh=MIIhWR4vBhh2o7JgHxWJW94m+6vioakDa3UmZAXRkMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/W/r+EaMwTahCz54Wks1y2SVp+MX8tI2o5yLmj5N7koiqnGfF3VcMyZhNHLJUxqc5guSxsLdLmSN+bL97pTq8qT/UHVzDk5pnJ8x/zBnALLGzZBnKTwF2mg4XrSlR0NOL+vdLHBzK1ht0IVa8tIv72En4qKuxQ+W3bN4TXJSEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YkJv2ZCz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkJv2ZCz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768273415; x=1799809415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MIIhWR4vBhh2o7JgHxWJW94m+6vioakDa3UmZAXRkMU=;
  b=YkJv2ZCz4diTAsZ9n3vdVXYvlLak5Hv9vBGlt3KMcwwh1mo5uJxbN24h
   KO8zJ8cHDtqqiS6K+BfxSFYOPmqNS0H8GJ4bTlUbLQVysx2vmWiS+zREr
   3e21XYvWVxg84/FuDyN4UkjzLNFN3WkjNsWOSphyE8gh4+ah7MVQZTPst
   I/SvzIgHe0K24w42VpN6GzfAP0LEP2pXK0UlQGzgdc81vZWe5zrP9j3FF
   tOH7MgysaJC9QlJMBxSmaTlajLudLY9CwTCF/S5dQaiJEdL59S/Wd7H5L
   k0nD6lrblJEezwV5cGhsYRxoP/cgCRCX07KGLsAfiItH/lG0uiOxzLR2q
   Q==;
X-CSE-ConnectionGUID: 4NNxqCGkQkOgjb4C7QwPyA==
X-CSE-MsgGUID: izJ5n0K/TuOdrIheds/JSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69607496"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69607496"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 19:03:34 -0800
X-CSE-ConnectionGUID: 87FOyLLZQ7qMRrg971BXgA==
X-CSE-MsgGUID: imsc+Ri0TRSvon5n3WZsCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="203466953"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa010.jf.intel.com with ESMTP; 12 Jan 2026 19:03:31 -0800
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
Subject: [PATCH 2/3] iommu/vt-d: Clear Present bit before tearing down PASID entry
Date: Tue, 13 Jan 2026 11:00:47 +0800
Message-ID: <20260113030052.977366-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113030052.977366-1-baolu.lu@linux.intel.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Intel VT-d Scalable Mode PASID table entry consists of 512 bits (64
bytes). When tearing down an entry, the current implementation zeros the
entire 64-byte structure immediately.

However, the IOMMU hardware may fetch these 64 bytes using multiple
internal transactions (e.g., four 128-bit bursts). If a hardware fetch
occurs simultaneously with the CPU zeroing the entry, the hardware could
observe a "torn" entry — where some chunks are zeroed and others still
contain old data — leading to unpredictable behavior or spurious faults.

Follow the "Guidance to Software for Invalidations" in the VT-d spec
(Section 6.5.3.3) by implementing a proper ownership handshake:

1. Clear only the 'Present' (P) bit of the PASID entry. This tells the
   hardware that the entry is no longer valid.
2. Execute the required invalidation sequence (PASID cache, IOTLB, and
   Device-TLB flush) to ensure the hardware has released all cached
   references to the entry.
3. Only after the flushes are complete, zero out the remaining fields of
   the PASID entry.

Additionally, add an explicit clflush in intel_pasid_clear_entry() to
ensure that the cleared entry is visible to the IOMMU on systems where
memory coherency (ecap_coherent) is not supported.

Fixes: 0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h | 12 ++++++++++++
 drivers/iommu/intel/pasid.c |  9 +++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index b4c85242dc79..35de1d77355f 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -237,6 +237,18 @@ static inline void pasid_set_present(struct pasid_entry *pe)
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
+}
+
 /*
  * Setup Page Walk Snoop bit (Bit 87) of a scalable mode PASID
  * entry.
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 298a39183996..4f36138448d8 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -178,7 +178,8 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
  * Interfaces for PASID table entry manipulation:
  */
 static void
-intel_pasid_clear_entry(struct device *dev, u32 pasid, bool fault_ignore)
+intel_pasid_clear_entry(struct intel_iommu *iommu, struct device *dev,
+			u32 pasid, bool fault_ignore)
 {
 	struct pasid_entry *pe;
 
@@ -190,6 +191,9 @@ intel_pasid_clear_entry(struct device *dev, u32 pasid, bool fault_ignore)
 		pasid_clear_entry_with_fpd(pe);
 	else
 		pasid_clear_entry(pe);
+
+	if (!ecap_coherent(iommu->ecap))
+		clflush_cache_range(pe, sizeof(*pe));
 }
 
 static void
@@ -272,7 +276,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 
 	did = pasid_get_domain_id(pte);
 	pgtt = pasid_pte_get_pgtt(pte);
-	intel_pasid_clear_entry(dev, pasid, fault_ignore);
+	pasid_clear_present(pte);
 	spin_unlock(&iommu->lock);
 
 	if (!ecap_coherent(iommu->ecap))
@@ -286,6 +290,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
 	devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	intel_pasid_clear_entry(iommu, dev, pasid, fault_ignore);
 	if (!fault_ignore)
 		intel_iommu_drain_pasid_prq(dev, pasid);
 }
-- 
2.43.0

