Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14A74A204A
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940996; cv=none; b=ivNLu1UW7PFw8k0m1twVp1iqQsx9dH60WkCZ/U8sJUSsInw/4/ERowTFEKRlSqOWUiBg7gyPJwaiQcnkbTYpNvf4n6gUiRJezIYVoTvYer+onyyRGGBRFVBSQEqdNEiAuqN+Gr/Xh53kOCnx8zwtbGgd//66ukS0aiw4atAgXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940996; c=relaxed/simple;
	bh=vyYjMjf3vmlIjqvA15FNQsnMHUfwEKOpBSAQ/vbKBjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1aqsNBr28naEOXaAAsw3gEfhrUToSDM7OhLzih9VAXU6sAE9dUfrEW40EJzckQQBQdrXpXV/DCecSZ0lXvhCeW+9KhQd8yq5tNVDzjF7wZVbmH81I5g9KSXVfEoqPhzg747HaBAJ+PYGnqth+/Ui8aSNAawqxgDqK6j8Zc65pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kkuhiy1Q; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kkuhiy1Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788940995; x=1820476995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vyYjMjf3vmlIjqvA15FNQsnMHUfwEKOpBSAQ/vbKBjk=;
  b=Kkuhiy1Ql48Fzin2QgrzMz6CqzIR5E43pAzvd+ruiZjAbSYJCEFxVtri
   Gt/fOOXKw7GJqW66dmQ+vq3QBqbrGHX2UrtQQo8fwxYSEBP1M7piYln3J
   Y3rUwogqwpPojlPxUVgNwMb62ZMSeHhSCu98N4GLl6hv4P+CMp7c0QEgt
   dTXjudPkASUQIqWoXRIRiPev7lE9Q0w1b8h/5Lhv5cq4bf/bRWY/f5f9a
   aYPh+ky1ThlRNTXauwRzaL/Mbzt/aEsrb18VQUB0ozEd3fjTc1F/QU1gz
   7vDT3ccGRs/JBIJyKhbsjuocMQf6PL11N7CwH7yXtP7YxbXZsaGYm8Mna
   w==;
X-CSE-ConnectionGUID: GAPpB1FHRhWLpURUVuaGrg==
X-CSE-MsgGUID: HMND39KNQ4utM7XakpJmiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106726463"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106726463"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:03:14 -0700
X-CSE-ConnectionGUID: uxMEKfikTVqQopMTz5feQg==
X-CSE-MsgGUID: mxELoZJJSMSDa9PAHPVZdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="301119251"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by orviesa002.jf.intel.com with ESMTP; 09 Sep 2026 01:03:12 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/7] iommu/vt-d: Do not ignore context table copy failures
Date: Wed,  9 Sep 2026 15:51:01 +0800
Message-ID: <20260909075106.738691-3-baolu.lu@linux.intel.com>
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

copy_translation_tables() currently logs copy_context_table() failures
but still returns success, so partial copy failures are silently ignored.

That means Intel IOMMU may run with only part of the old tables copied.
Then some old domain IDs may not be reserved, and later may be reused by
new domains. With stale hardware cache entries still around, this can
cause bad DMA translations, DMA faults, or domain aliasing.

Fix by aborting on the first context-table copy failure, freeing temporary
context-table pages, and returning an error so caller falls back to a
clean root table path.

Fixes: f93b4ac5929a ("iommu/vt-d: Use ida to manage domain id")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e3b3ab216f8..38e2a670df9a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1591,7 +1591,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 		if (ret) {
 			pr_err("%s: Failed to copy context table for bus %d\n",
 				iommu->name, bus);
-			continue;
+			goto err_free_ctxt_tbls;
 		}
 	}
 
@@ -1623,11 +1623,27 @@ static int copy_translation_tables(struct intel_iommu *iommu)
 	memunmap(old_rt);
 	return 0;
 
+err_free_ctxt_tbls:
+	/*
+	 * None of these tables have been linked into iommu->root_entry yet,
+	 * so they are unreachable and must be freed here.
+	 */
+	for (bus = 0; bus < ctxt_table_entries; bus++)
+		iommu_free_pages(ctxt_tbls[bus]);
+	kfree(ctxt_tbls);
 out_unmap:
 	memunmap(old_rt);
 err_free_bitmap:
 	bitmap_free(iommu->copied_tables);
 	iommu->copied_tables = NULL;
+
+	/*
+	 * Only reservations taken from the old context entries can be in the
+	 * ida at this point; no domain has been allocated on this IOMMU yet.
+	 * ida_destroy() empties it and leaves it ready for reuse.
+	 */
+	ida_destroy(&iommu->domain_ida);
+
 	return ret;
 }
 
-- 
2.43.0

