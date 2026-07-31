Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E7360ED2
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 05:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477286; cv=none; b=W0Sr6iY7T0Oic6cMbZ6D76aO8YvyFwJq8IeCRZ4QTGvor1xNhpaGw1wVx1Hg1lpSwIXaBD7fO5pA+3a6jY+WDvm8S1an3N6PkKKroeA/zikJ7T/weAFcuo30vo24bh2iYsCixRB2esUKwiTlH1QuzfVK+5XczEqwsRUT1dxct8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477286; c=relaxed/simple;
	bh=Y/X/Ba6YIuDetywzLYJFUFjzzynh/RHM+bsBpMwRxzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHEre+pNu/6AoAbf8C2UyuAGnH/toH1Kh9z1Keg1YCxluXLrboZqWaLw0gjEx8zhF5e+BDQj1/9Cb+LCMZoTCJivXOeXsZFXKbEifoEGsWjfkeN3t6m0+OdGy+d/x1Te3TwgAi7GMdTimsiPYukBu02wGePOzZJxhmeHDe2X0bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eF3V2wYJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eF3V2wYJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785477285; x=1817013285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y/X/Ba6YIuDetywzLYJFUFjzzynh/RHM+bsBpMwRxzE=;
  b=eF3V2wYJMlaNfYz+SymZve8+YOOTlmu25lC9gcWEMJTDxSZB0/z4/TvW
   5B2aynLgduR781FGeSlnK4Df3q7VbedyU4FDwfWTJhsT2nhnNpU4woDWS
   yVp7BmMFxW0skd+sI7z+c73tkpXkhcRk59TDljwHXejwy6A9s3K9P5QKC
   dnm6GvM8kAX0poqkJNuOsvqw/HHKFHCqWIHR28QfJgoDUCYwtNlMFdQtW
   cvqCg7UV1lKjVjq4peYdVBaBhHYNfC0CnEgaz8e9jLvqizIRYkkKnWEhc
   ZWgTADeqzSjHj9v0TGZcyHpYOsS/ekwaEurZFXyX4DNvuV22OtidQioIg
   A==;
X-CSE-ConnectionGUID: DTJxZuhUQ5SudNlHeRYhXA==
X-CSE-MsgGUID: 0QnogjAgQDapgYN32YL3UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="97615884"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="97615884"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 22:54:45 -0700
X-CSE-ConnectionGUID: Cjc+GTTeSrK4LjrmUwfBkg==
X-CSE-MsgGUID: WnNwPufJTRyiVIBTMiFIWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="298695472"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa001.jf.intel.com with ESMTP; 30 Jul 2026 22:54:43 -0700
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
Subject: [PATCH 2/5] iommu/vt-d: Clear Present bit before tearing down copied context entry
Date: Fri, 31 Jul 2026 13:43:26 +0800
Message-ID: <20260731054329.2948252-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
References: <20260731054329.2948252-1-baolu.lu@linux.intel.com>
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
index 058967b669d9..528b59e5f4ce 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1115,7 +1115,8 @@ static void copied_context_tear_down(struct intel_iommu *iommu,
 	assert_spin_locked(&iommu->lock);
 
 	did_old = context_domain_id(context);
-	context_clear_entry(context);
+	context_clear_present(context);
+	__iommu_flush_cache(iommu, context, sizeof(*context));
 
 	if (did_old < iommu->max_domain_id) {
 		iommu->flush.flush_context(iommu, did_old,
@@ -1126,6 +1127,9 @@ static void copied_context_tear_down(struct intel_iommu *iommu,
 					 DMA_TLB_DSI_FLUSH);
 	}
 
+	context_clear_entry(context);
+	__iommu_flush_cache(iommu, context, sizeof(*context));
+
 	clear_context_copied(iommu, bus, devfn);
 }
 
-- 
2.43.0

