Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836834887B
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566764; cv=none; b=iSL0Nu7c4PKvNpqthuEnyKXScPxoTUsf0Z5ehm8NN2HmueHgDyNVmID6MlDuskdhR86OmU/lRVS05t33i4DHRW7phLZlFh0iM2kAfvCMv1zviMjPtihAHRv76quo6IAe65P9fpB5lLA6Xdp5Wxm3cIh7TZxP3W/UjHdU65HHJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566764; c=relaxed/simple;
	bh=l3CJmn6ZjvyW+L68/BKzNUhDnOLFNXWnYeypO7nn4Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hesDnzDvMKlVsbIMEsWKVdx6ZsJgyfLJVXbMMslAg7jl75zqBlqKG1qBH9o1tcXuRITnB80DrrJ51AcdphM1E39yON+RXGprtj2vnkK+rm0dNLTZ1ganmaGzL6ioAXP2dNEO8mukVH7aCm+agvQ1vG5OiineucgQD5qq+1tSbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5QMrs45; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5QMrs45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790566763; x=1822102763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l3CJmn6ZjvyW+L68/BKzNUhDnOLFNXWnYeypO7nn4Bs=;
  b=b5QMrs45QDb0Mt4bESKt7hENPLB9rYm0Rrqa1ar82TS7zn+JLz4CISDo
   IPGDv+cxn2Y9cgmas4KG1a+qfNkFrGGRceLGVK6oiuymyS6wrIirNx1Fc
   ZQh2nxwBfqXeGBUlRom8jP9GLd1Ht430O4WGzb/HruqeQuDWmBPA6TIHf
   2eYhpxS4aFYOevLGXAQ3lrNgH0MpK5VMnX+AfNeayw+fM8f/oiuDzGk1H
   khsnZKteIqjIfGbLueFd8vHs1Ua/gTw4rVEwTSp6+w7C1IYRlMLEhxrM6
   RKNQjjMmpE+k+lO02thrT895u0ESc6STUyLWm/FXxKHj79kxXuXiA/amU
   A==;
X-CSE-ConnectionGUID: 787OdjXYTGW7QeFZ0Wt+QA==
X-CSE-MsgGUID: MXy54DJUQhOvGBqa+qVTJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101917206"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="101917206"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:39:22 -0700
X-CSE-ConnectionGUID: HtpZU3qSRLKr5AY0c6Z42w==
X-CSE-MsgGUID: 0RoDq3XxS7ebFHSszRLyEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="283004092"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by fmviesa005.fm.intel.com with ESMTP; 27 Sep 2026 20:39:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] iommu/vt-d: Handle DID reservation errors when copying context tables
Date: Mon, 28 Sep 2026 11:27:17 +0800
Message-ID: <20260928032722.2868623-5-baolu.lu@linux.intel.com>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 39 +++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index bf8b3e3edf3b..85400d0ab334 100644
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

