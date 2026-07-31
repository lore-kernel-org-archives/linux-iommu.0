Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6F361958
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 05:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477294; cv=none; b=sWQdQP21fEmf1DmoSBNn+t96Wol/6AKUrD49oqcGDAx+TwKWnQJBKjVtLC8dUPf8ZpnmZAZbJ3eZCVRmdy1G0K8uefS/zaumxeKF5LRrZBhfIxvQ/hQZb99GHTr0KeEvEQx/j9ttZjDYNls3mET9TgG2UcBkHA7D/3KP8peOlJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477294; c=relaxed/simple;
	bh=/oApGxpXT2Dh+5iXlhTAd0ujuNkuxeR/SwYYQ008Nbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHoi9KkdZS752O9aeIBc/L6b+ZSIB/3bvSObxttm+BZDyW4OPJthBo7m+D0jGIyunNq1ToTf+MhsuubWhH0nQMkm2PcmAhdpvD8k4VUdRi0raTbGrtO0TtwY3LIrYZ1Yblr8qMFDtHBWvNTsSsW9hISwJyxRcfDqtjgM84O0sas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LDJHNpAu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDJHNpAu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785477292; x=1817013292;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/oApGxpXT2Dh+5iXlhTAd0ujuNkuxeR/SwYYQ008Nbs=;
  b=LDJHNpAudunFacsVtDt64XUPLeY1mx/3QyDw+dJ56HhJJfKYActD4/+r
   /WAWoUGFZBD1p/SML/FXtHAqTuo3JAc86G7kASQ20n3cX/rJjadYGW/Dl
   r2fuk8qdtgo+TLEko136d3s24YF00Z1k+m2aG/KGrpaKnc8vvRQK1oAi3
   kLJq898IXYgyc7DnBjvcAI0Ed9aufdLoR0ZoWbuFBixGS430vVHHsfJPO
   BS7qLCRnaKXzFMbfTZfSZvbA0sjLgvgb5N0xnkZZSCCTgd1Elca7Ma5Jm
   sjKmx+oFrur4Soc9ElvwehF1lxX+WUOw+XpbrVXRIExos+4Pckj5+EXB8
   g==;
X-CSE-ConnectionGUID: 5+SU7oRBSPacq5XRwEqEJQ==
X-CSE-MsgGUID: h5sss2YwQXWQ223lWL1OmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="97615904"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="97615904"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 22:54:51 -0700
X-CSE-ConnectionGUID: 1CcK+V+CSDytip6LlDCpDg==
X-CSE-MsgGUID: q9Ufuxk7RSaZ060tsP6Xfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="298695482"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 30 Jul 2026 22:54:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 5/5] iommu/vt-d: Flush context cache with correct SID when tearing down aliases
Date: Fri, 31 Jul 2026 13:43:29 +0800
Message-ID: <20260731054329.2948252-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
References: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

domain_context_clear_one() and device_pasid_table_teardown() are both
invoked once per DMA alias of a device. Each function locates the context
entry using the bus/devfn pair provided by the pci_for_each_dma_alias()
callback, then calls intel_context_flush_no_pasid(), which constructs a
device-selective context-cache invalidation from info->bus and
info->devfn (that is, always the requester ID of the device itself).

As a result, for every alias other than the device’s own RID, the context
entry that was just cleared in memory is never invalidated in the context
cache. Hardware may continue using that stale cached entry. In the
scalable-mode teardown path, intel_pasid_free_table() can then free the
PASID directory still referenced by that stale entry, allowing the IOMMU
to walk freed memory.

Fix this by passing the source ID of the entry being torn down to
intel_context_flush_no_pasid(), instead of deriving it from @info.

Fixes: f90584f4beb84 ("iommu/vt-d: Add helper to flush caches for context change")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260602233426.357499-1-baolu.lu%40linux.intel.com
Assisted-by: Claude:claude-opus-5
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 2 +-
 drivers/iommu/intel/iommu.c | 2 +-
 drivers/iommu/intel/pasid.c | 9 ++++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 8a59c7c9d0a6..7f01620bf3a1 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1249,7 +1249,7 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 			      unsigned long end);
 
 void intel_context_flush_no_pasid(struct device_domain_info *info,
-				  struct context_entry *context, u16 did);
+				  struct context_entry *context, u16 did, u16 sid);
 
 int intel_iommu_enable_prq(struct intel_iommu *iommu);
 int intel_iommu_finish_prq(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 489e9ab5f698..2e3b3ab216f8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1257,7 +1257,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	context_clear_present(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
-	intel_context_flush_no_pasid(info, context, did);
+	intel_context_flush_no_pasid(info, context, did, PCI_DEVID(bus, devfn));
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 }
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 81353fd46b37..e4f24d3f19a6 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -751,7 +751,7 @@ static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
 	context_clear_present(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 	spin_unlock(&iommu->lock);
-	intel_context_flush_no_pasid(info, context, did);
+	intel_context_flush_no_pasid(info, context, did, PCI_DEVID(bus, devfn));
 	context_clear_entry(context);
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 }
@@ -955,9 +955,12 @@ static void __context_flush_dev_iotlb(struct device_domain_info *info)
  * This helper can only be used when IOMMU is working in the legacy mode or
  * IOMMU is in scalable mode but all PASID table entries of the device are
  * non-present.
+ *
+ * @sid identifies the context entry that was modified, which may be a DMA
+ * alias of @info->dev rather than its own requester ID.
  */
 void intel_context_flush_no_pasid(struct device_domain_info *info,
-				  struct context_entry *context, u16 did)
+				  struct context_entry *context, u16 did, u16 sid)
 {
 	struct intel_iommu *iommu = info->iommu;
 
@@ -967,7 +970,7 @@ void intel_context_flush_no_pasid(struct device_domain_info *info,
 	 * when operating in scalable mode. Therefore the @did value doesn't
 	 * matter in scalable mode.
 	 */
-	iommu->flush.flush_context(iommu, did, PCI_DEVID(info->bus, info->devfn),
+	iommu->flush.flush_context(iommu, did, sid,
 				   DMA_CCMD_MASK_NOBIT, DMA_CCMD_DEVICE_INVL);
 
 	/*
-- 
2.43.0

