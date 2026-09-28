Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376C342CB2
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566762; cv=none; b=ZGyC9vcH3WN+kXqb7s2cu0iQ/kblBnl0uRQRE0U+fCCMQTzzDMmaiYgFP25CrtjmuRjiGCd3/JuMZvcC1YLF6TZh5f0lAte0eEy/Fmu860Jt8Lt1/uUODModOeQm+CX1RDYH21C3x2fD39D0Qm/iA3MiwlHO3cLbuJvFRobsgn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566762; c=relaxed/simple;
	bh=MhUZ8KkDZPCfhpKmHfyUq7Rin2L6vS4R+tOGRiOX5ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBz3z/O21MNmu7wOzfa/tgSov8EpocLovQJREOIHvWVsCaCvvwfqqRr9D+DI5CAo36ott8j9BlfXv2OMG6qSSjzTq+seQ57cS8JFvo+QAppC16pYfbs2uNjvyrrXbhxMRQnqES48Dkd617JXIuxK8q+FawRasxXozokqMFXVIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8lSvszY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8lSvszY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790566761; x=1822102761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MhUZ8KkDZPCfhpKmHfyUq7Rin2L6vS4R+tOGRiOX5ag=;
  b=N8lSvszY7L6CCum8FKWazR7BfBf2VdOcVxYL8B8S07MLggNa2FsOfbl5
   v1/hUZMxVMTs8/ZCy+w56NERo0+SsM2Z0M4wKRNchBGu+IDC0xWjSqhKH
   t+ng9flI5JVqw7qoAG90clCoLDYeG8qN+0xtjOKevq7F6eDu6KnxmuDio
   9MDGJs39S/uUr6+DW2J0cRM3tcM0Ee98XxrMI5vpOWUQX7BaNeG/1CAAn
   MBuDqsoHQh51W0HRSge+BDJ0q3Xv/m3RnaPzmgmu4U+f/w25l6c6nUbi7
   tc+UmM1UDy9AnZJK+7UlaQBn3dIw1rphKLZyPOdQwLjBM+/J09Ra7lYw3
   g==;
X-CSE-ConnectionGUID: 6/A2wCPtRRi05Oxg1pb8/Q==
X-CSE-MsgGUID: o3sIkJGzTD6mE8Q71e0LGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101917199"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="101917199"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:39:21 -0700
X-CSE-ConnectionGUID: TJFRBr6nTZ2/6Lf3gdQ/pA==
X-CSE-MsgGUID: 6eDXyjJ1TGeo/x8J9iYeiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="283004088"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa005.fm.intel.com with ESMTP; 27 Sep 2026 20:39:19 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] iommu/vt-d: Do not ignore context table copy failures
Date: Mon, 28 Sep 2026 11:27:16 +0800
Message-ID: <20260928032722.2868623-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
References: <20260928032722.2868623-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 05f351833d0b..bf8b3e3edf3b 100644
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

