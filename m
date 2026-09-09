Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881EB4A1E16
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941000; cv=none; b=omeJ6vzeyTWtau2X3Dr93JQG4creRaiQyS93Ac8NvLYpmIVTj6j3S5p/jdIf2bdTBjDLa/9BTc8Iyw7U1u2WEttCzcGCmskvmWMy7dqKB19YqOtBxV5TXf+uQobiiw+TEp5CzsuUC6McH1CVnFoavixUHvM3SDg1oNfYp7Z+IyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941000; c=relaxed/simple;
	bh=xUrfvEXrKLg0J6GzM68cstBmioplSZGd3x33EWmiOzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYTsWT+tl0lpHAbI0IDo05pCACSQenj5G6dyLajr9aBj4GH/sXfb0h49gV1ItJVr4QuaJOqEvMQ0R8FmoneVL9c9ldULZgV7pfUJNv/fppi2YsPYZXTmUSGyOAl3JtHz3ZBU1duGLAe+TjFT/96nyXdg1BwDnjdwHdabiEgECBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SE+QfwEL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SE+QfwEL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788940999; x=1820476999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xUrfvEXrKLg0J6GzM68cstBmioplSZGd3x33EWmiOzI=;
  b=SE+QfwELdFcd60Ioo+YwT2BSmLeb6m2WsnqO3K55d/KLvjfgBAOtt4id
   J2c6gIQ/KzvFxkOyNxLiNCMbi6b2hsra0mPC2SBKtyqyFyIQ8t33EbVLX
   fe8XVLmltIsgDWVL4IJHYNQUDkUmsmdeAnbYi5PjlmJw5XtRxAcqhsBRQ
   jZudrUV/qPYHp2/B6//ur4QvECoxwHaj94+CdkL5AwQEnPfXRzk6qpjQ6
   vcDS3Lo9K8RmPMHSHOw4Z09HTmensBZ/70Fvhb9MIZjcgIGV+sukMyuiZ
   rbBaC/LtJuwP8cEHbgsWfb5BC212jXVg48ebdxIzj9yzOvCsguVdpZM/U
   w==;
X-CSE-ConnectionGUID: mlLUwS5yR/+VXeAljZGRTA==
X-CSE-MsgGUID: +uJodlXARGeRHUqYuztZOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106726492"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106726492"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:03:19 -0700
X-CSE-ConnectionGUID: yBBZEQGtRSScKxyz8KmUTw==
X-CSE-MsgGUID: 6Q8/AWqET16xnOsxzYGq7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="301119266"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by orviesa002.jf.intel.com with ESMTP; 09 Sep 2026 01:03:16 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/7] iommu/vt-d: Reserve scalable-mode DIDs from PASID entries during copy
Date: Wed,  9 Sep 2026 15:51:03 +0800
Message-ID: <20260909075106.738691-5-baolu.lu@linux.intel.com>
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

copy_context_table() reserves old domain IDs (DIDs) from context entries.
That works for legacy mode, but not for scalable mode: scalable context
entries do not carry DID, so this path ends up reserving the wrong value
(often DID 0) repeatedly.

In scalable mode, real DIDs are stored in PASID table entries. If they
are not reserved during kdump table copy, new domains may reuse old DIDs
while stale PASID/IOTLB cache state still exists, causing translation
conflicts and DMA faults.

Fix this by walking PASID tables in scalable mode, and reserving DIDs
from present PASID entries. If PASID structures cannot be remapped, return
error so caller can fall back safely instead of continuing with an unsafe
DID space.

Fixes: 0c5f6c0d8201 ("iommu/vt-d: Fix kdump kernels boot failure with scalable mode")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 74 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ab46058d76c5..5553c57130f7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1479,6 +1479,70 @@ static int reserve_domain_id(struct intel_iommu *iommu, int did)
 	return ret;
 }
 
+/*
+ * Reserve the domain IDs used by a scalable mode context entry copied from
+ * the previous kernel.
+ */
+static int copy_pasid_table_dids(struct intel_iommu *iommu, struct context_entry *ce)
+{
+	struct pasid_dir_entry *dir;
+	unsigned long dir_size;
+	phys_addr_t dir_phys;
+	int ret = 0;
+	int i, j;
+
+	dir_phys = ce->lo & VTD_PAGE_MASK;
+	if (!dir_phys)
+		return 0;
+
+	dir_size = get_pasid_dir_size(ce);
+	dir = memremap(dir_phys, dir_size * sizeof(*dir), MEMREMAP_WB);
+	if (!dir)
+		return -ENOMEM;
+
+	for (i = 0; i < dir_size; i++) {
+		struct pasid_entry *table;
+		phys_addr_t table_phys;
+
+		if (!pasid_pde_is_present(&dir[i]))
+			continue;
+
+		/*
+		 * Do not use get_pasid_table_from_pde(); that returns a
+		 * phys_to_virt() pointer, which is not valid for memory
+		 * owned by the previous kernel.
+		 */
+		table_phys = READ_ONCE(dir[i].val) & PDE_PFN_MASK;
+		if (!table_phys)
+			continue;
+
+		/* A PASID table is one page: PASID_TBL_ENTRIES * 64 bytes. */
+		table = memremap(table_phys, PAGE_SIZE, MEMREMAP_WB);
+		if (!table) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		for (j = 0; j < PASID_TBL_ENTRIES; j++) {
+			if (!pasid_pte_is_present(&table[j]))
+				continue;
+
+			ret = reserve_domain_id(iommu, pasid_get_domain_id(&table[j]));
+			if (ret) {
+				memunmap(table);
+				goto out;
+			}
+		}
+
+		memunmap(table);
+	}
+
+out:
+	memunmap(dir);
+
+	return ret;
+}
+
 static int copy_context_table(struct intel_iommu *iommu,
 			      struct root_entry *old_re,
 			      struct context_entry **tbl,
@@ -1546,8 +1610,14 @@ static int copy_context_table(struct intel_iommu *iommu,
 
 		if (!context_present(&ce))
 			continue;
-
-		ret = reserve_domain_id(iommu, context_domain_id(&ce));
+		/*
+		 * The context entry only holds a domain ID in legacy mode.
+		 * In scalable mode the IDs are in the PASID table entries.
+		 */
+		if (ext)
+			ret = copy_pasid_table_dids(iommu, &ce);
+		else
+			ret = reserve_domain_id(iommu, context_domain_id(&ce));
 		if (ret) {
 			/* Not yet published through @tbl, so free it here. */
 			iommu_free_pages(new_ce);
-- 
2.43.0

