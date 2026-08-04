Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B0645D5C5
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887709; cv=none; b=cdyq3i3Pd2tHR4QS6P582gyV8VDJiH4dSIdCVHoqWchX3EfreMdOyaG1Om6TFtpldUAx25vSpvQSHOtfYLCfF4r0AMM17ggOsyrdJCk5IJYVfCa8FqbRtM0HIlJaqX6rW2PRj4oi5tXD3KQ81+DRkkSmN5cN8seMCStE7o58RAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887709; c=relaxed/simple;
	bh=Eb4X54a9JEu/mnegCruXzqQKDfrycys2omgDV3RSDWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vq9gxvR743/UnACUvErmvI3PYyGcZDL+OW1cM4zdJhL9K2cQCIJ650B/y8//9CcBVm1lE9VnX8WFMXwk/MXGrR4ORMlW2KZ0x+dyvrH8qhbUhQQHbm5juXwYMo02xty1Ve27cbdyZxrOSfZP5fJDuFk9Ui6AXnQtRI4h8+oxgS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PcmoaFvp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PcmoaFvp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887708; x=1817423708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eb4X54a9JEu/mnegCruXzqQKDfrycys2omgDV3RSDWA=;
  b=PcmoaFvprTj5kPkWxF1pm6nM70R4JHnBE+M4mhhwrpo7V6fUAW1sJ7rd
   qqejo7CDf4xTrQIfaKvhCbO845utKJMd/dxbxm8W7OPSxRO/8tD58iuBz
   Qfkr2TSYr8pZelUJU3Qa84NHj4mvsZRLnpO509IQAHf8Vsi9Wme/rTVxU
   8TyY19LMOzWfSqIijDO5cRCK5x7Vfjs1WvatTCSIWYPuJNFVAYwm7NLJz
   nt8vqnj02cb6kLF7FO04/hooJOjCY1jWWm9xBeLFl2x43tt+oQJSYs42D
   NPuBE6Y7XI5eK0M+8NaVp98NmgqEWxpEnhkdmfI5O20CYxnC+qCLMZHyj
   A==;
X-CSE-ConnectionGUID: /wi8uKYRQPmojPFo8DHfBA==
X-CSE-MsgGUID: JTPHYrq4QQm4i+5PX9oJbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263390"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263390"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:55:08 -0700
X-CSE-ConnectionGUID: vRkYKsBcQQiCNnYV+2Ji5Q==
X-CSE-MsgGUID: iDkfASHXTOuB5bCa45yTBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324434"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:55:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Desnes Nunes <desnesn@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/19] iommu/vt-d: Flush context cache with correct SID when tearing down aliases
Date: Wed,  5 Aug 2026 07:43:13 +0800
Message-ID: <20260804234314.3087110-20-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
References: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.h | 2 +-
 drivers/iommu/intel/iommu.c | 2 +-
 drivers/iommu/intel/pasid.c | 9 ++++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index c00f44db0020..23dbe6c24439 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1241,7 +1241,7 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 			      unsigned long end);
 
 void intel_context_flush_no_pasid(struct device_domain_info *info,
-				  struct context_entry *context, u16 did);
+				  struct context_entry *context, u16 did, u16 sid);
 
 int intel_iommu_enable_prq(struct intel_iommu *iommu);
 int intel_iommu_finish_prq(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 489bab4999fb..6d81644c66bc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1251,7 +1251,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
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

