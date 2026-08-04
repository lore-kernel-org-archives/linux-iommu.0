Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71E4570FC
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887705; cv=none; b=M97y1Kcz8Xe5y74e57xJJmY6G4poPJqj1wYPzd0Q/M+raP+rBoWMmDDZdUB8dpG/P78PanZ5NRgHK4jptboGkuGnKd9rR37mHTv3vPvnTeJOX0NE+fzhPSG29tiDf314HC9Ybq0DA+ubtrpJTTLyjH/zdutSvHR/IIQ7m0iLU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887705; c=relaxed/simple;
	bh=kGVbd9pnieA+4WkKdGphqkjUnjw6m66qlFoy3/Q6/+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEqDq840ngB6kHAKFhY2uR+YcJZUNDnQzIzRBB3J1nKPs1L4X6mTuzugFcrM22HH9QLLdYURGOSFdWlWmAztyGtC1OPvhM2xfYmDe5/NSID7eWbt2un70X2lWnjom7m3PXCHiFK+Ch0agFX+eQozLazY047AMV3JnJcID3YK/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRJ7uCAx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRJ7uCAx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887703; x=1817423703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kGVbd9pnieA+4WkKdGphqkjUnjw6m66qlFoy3/Q6/+8=;
  b=YRJ7uCAxCRfXBI+xtbeguMFtdUepdkfGhBujEVlZmOssW11Ze+h9XB45
   d1kDv2x2k8zwL1hLiBEzvMJGhSULoo3EY1nVGYuxIBjhB4mUWiYh/aH7C
   zZkPOqjUBAV5CJNf09Tx+GIWk6P18gYStt7NUoR2kbjq6O+gW/Pbwpiaz
   W//kIH1haioXWt94sZ6yiYVgDDSeuh7NGac7wPkTNvXKpOut2UYjPHVUI
   SHJJJCg7Mx3YLZF5phjkJmUXK3t1SmhNtLKPHOxdOkUeF/nIS122VnL+r
   j21IjpLpA5s3Z8q44T7+kzK7TfuErfs73UFl9WujQ2AWH46W+S7Nvmxpd
   A==;
X-CSE-ConnectionGUID: 48JTpWqES16Efn6SCP13tg==
X-CSE-MsgGUID: k6uS5b5ZRRCXkzF5KDIVKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263358"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263358"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:55:01 -0700
X-CSE-ConnectionGUID: JbYPTfqsR56v5E2WkYEcmQ==
X-CSE-MsgGUID: vekvkBkISxe4qA1FECzjzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324405"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:54:58 -0700
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
Subject: [PATCH v2 16/19] iommu/vt-d: Clear Present bit before tearing down copied context entry
Date: Wed,  5 Aug 2026 07:43:10 +0800
Message-ID: <20260804234314.3087110-17-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
References: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

copied_context_tear_down() zeroes the 128-bit context entry with
context_clear_entry() while the Present bit is still set, and only then
issues the context-cache and IOTLB invalidations.  This leaves a window
in which hardware can fetch a torn entry, with some fields already zeroed
while Present is still set, leading to unpredictable behaviour or
spurious faults.  While x86 provides strong write ordering, the compiler
may reorder the writes to the two 64-bit halves of the entry, and the
hardware fetch is not guaranteed to be atomic with respect to multiple
CPU writes.

There is no cacheline flush before the invalidation either, so on an
IOMMU without coherent access to the context table the zeroed entry may
not be visible to hardware at the point the invalidation is submitted.

Apply the same ownership handshake described in the VT-d spec, Section
6.5.3.3 ("Guidance to Software for Invalidations"): clear only the Present
bit, flush it out to the IOMMU, perform the invalidations, and only then
zero the remainder of the entry.

Fixes: c7191984e5aad ("iommu/vt-d: Factor out helpers from domain_context_mapping_one()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260602233426.357499-1-baolu.lu%40linux.intel.com
Assisted-by: Claude:claude-opus-5
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7098a6bf6a40..000b81cf4a7a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1109,7 +1109,8 @@ static void copied_context_tear_down(struct intel_iommu *iommu,
 	assert_spin_locked(&iommu->lock);
 
 	did_old = context_domain_id(context);
-	context_clear_entry(context);
+	context_clear_present(context);
+	__iommu_flush_cache(iommu, context, sizeof(*context));
 
 	if (did_old < iommu->max_domain_id) {
 		iommu->flush.flush_context(iommu, did_old,
@@ -1120,6 +1121,9 @@ static void copied_context_tear_down(struct intel_iommu *iommu,
 					 DMA_TLB_DSI_FLUSH);
 	}
 
+	context_clear_entry(context);
+	__iommu_flush_cache(iommu, context, sizeof(*context));
+
 	clear_context_copied(iommu, bus, devfn);
 }
 
-- 
2.43.0

