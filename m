Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13604A2A6A
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940998; cv=none; b=izxX8A88KTaGgoP6utddmKNpp/hqsux/PINnTUwbf7KCnEivO5M+xT0rOu0BS5NvwY/5V256rBascZiYCmOwFKXSi+tjo+UjklqPr6nm8MZAL2Xyg/GRqHghvAGazvGKRs/bmmBe84xBdFXIOigR6T+Jgsl2dh8jFGEwz7PlEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940998; c=relaxed/simple;
	bh=hjfteaZqC12weU18xsMmHWkuS6sYcfnjD+saZE1p+XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPFQmrLB7xe0QXlWlj03oWrxcxeJAQHiWJ7/hKd3+YnjHZeUFUudsKlK8nI7l/ufqEyQp5s7qZRg8hvXVC6Ms8edegn2d12i+HuPWBnLuncpNOdfhWyMNUo37IRdxMiWNaa+CIejvKhBx0GPQqIHbX0MUz7thop928tM4KroFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DHIOMpjx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DHIOMpjx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788940997; x=1820476997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hjfteaZqC12weU18xsMmHWkuS6sYcfnjD+saZE1p+XI=;
  b=DHIOMpjxYfFzlIogSj7hbghHbYm1eedTQEcYsLTlcmvklaDkIODukgO5
   e58cnumkK7bTNedAj5nKsrab5iQnGBaB9PegMCNXyon5/vtJvWUK7sHBo
   OYEtt/EvB1TiDPxG7axkltEodtUwb/L7oySZmssZZuU5iCIsh1HGmE3D7
   rPbZHOid+vOJeTdwSFylMP9R8GUQIAES2x/p9kQKkkxMafmO78XeUmDom
   xt0nICDkRxIf83FJCXOasuMuMC59IrxktpXDfv7hu/CuRNLlshx1h1GfI
   R8Dr8cAhGkFzGBAk2ktfgeVad60T2w7qzVw4waf7yylAAQRZhMEHWeBUI
   Q==;
X-CSE-ConnectionGUID: 2KrvwsIsTPSNDcgf6904xw==
X-CSE-MsgGUID: NxV2geviRx6JjYFMbdsk/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106726478"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106726478"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:03:17 -0700
X-CSE-ConnectionGUID: RZea4bPDQdiTA5gwnNFf6w==
X-CSE-MsgGUID: pbcXGBZ2RNiib8FxlR1NhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="301119257"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by orviesa002.jf.intel.com with ESMTP; 09 Sep 2026 01:03:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/7] iommu/vt-d: Handle DID reservation errors when copying context tables
Date: Wed,  9 Sep 2026 15:51:02 +0800
Message-ID: <20260909075106.738691-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909075106.738691-1-baolu.lu@linux.intel.com>
References: <20260909075106.738691-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kdump reuses old translation tables, all old domain IDs (DIDs) must
be reserved in the new kernel before new domains are created. Today
copy_context_table() ignores ida_alloc_range() return values, so a real
-ENOMEM can be missed and an ID may stay unreserved.

That can allow DID reuse while stale hardware cache entries still exist,
risking domain aliasing.

Fix this by moving DID reservation into a helper that:

- treats duplicate reservations (-ENOSPC) as expected success,
- skips out-of-range IDs as success,
- propagates real allocation failures (like -ENOMEM), and
- normalize successful return values.

On failure, unwind as in existing copy-allocation failure paths.

Fixes: f93b4ac5929a ("iommu/vt-d: Use ida to manage domain id")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 39 +++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 38e2a670df9a..ab46058d76c5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1452,12 +1452,39 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
 	}
 }
 
+/*
+ * Reserve a domain ID inherited from the previous kernel so that it is not
+ * handed out again while the copied translation structures are still live.
+ *
+ * Returns 0 when the ID is reserved, was already reserved, or cannot be
+ * re-assigned, and a negative errno for a genuine allocation failure.
+ */
+static int reserve_domain_id(struct intel_iommu *iommu, int did)
+{
+	int ret;
+
+	if (did < 0 || did >= iommu->max_domain_id)
+		return 0;
+
+	ret = ida_alloc_range(&iommu->domain_ida, did, did, GFP_KERNEL);
+	/*
+	 * Devices sharing a domain share its ID, so the same ID is seen in
+	 * more than one context entry; -ENOSPC merely reports that it is
+	 * already reserved.  On success the allocated ID is returned, which
+	 * is not an error either.
+	 */
+	if (ret == -ENOSPC || ret >= 0)
+		return 0;
+
+	return ret;
+}
+
 static int copy_context_table(struct intel_iommu *iommu,
 			      struct root_entry *old_re,
 			      struct context_entry **tbl,
 			      int bus, bool ext)
 {
-	int tbl_idx, tbl_slot = 0, idx, devfn, ret = 0, did;
+	int tbl_idx, tbl_slot = 0, idx, devfn, ret = 0;
 	struct context_entry *new_ce = NULL, ce;
 	struct context_entry *old_ce = NULL;
 	struct root_entry re;
@@ -1520,9 +1547,13 @@ static int copy_context_table(struct intel_iommu *iommu,
 		if (!context_present(&ce))
 			continue;
 
-		did = context_domain_id(&ce);
-		if (did >= 0 && did < iommu->max_domain_id)
-			ida_alloc_range(&iommu->domain_ida, did, did, GFP_KERNEL);
+		ret = reserve_domain_id(iommu, context_domain_id(&ce));
+		if (ret) {
+			/* Not yet published through @tbl, so free it here. */
+			iommu_free_pages(new_ce);
+			new_ce = NULL;
+			goto out_unmap;
+		}
 
 		set_context_copied(iommu, bus, devfn);
 		new_ce[idx] = ce;
-- 
2.43.0

