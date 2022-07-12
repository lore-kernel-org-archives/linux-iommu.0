Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6181FC1
	for <iommu@lists.linux.dev>; Tue, 12 Jul 2022 00:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584870; x=1689120870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+PRn+weX3k7n//TPZyvFREn2hlm1uJvICybl4nuKpt8=;
  b=WBkNWnh+5saCxDNIN3BsUdRXb01wT57m2chVkN01mlq9KGlIYc5MJQ+U
   thk6hohufN0LRQkYFCT26bTt+0x8/EBXjVXjRyNfztWqzdfvs8zDf3yBn
   7Yq2bFV35ZUkw/yi3Olj9OA9aArG4RJCYi9vYC3Vbxr+2ckuh0bBTEXrv
   zg3yugUOIOEMvE3TCiINJPix/Z8/IpN6tv0LCQ9JkpV03DK5VKeU2UmeW
   Z5KtY8BzprVOSkSh58wGP49hmuExlKYNmqciH80POAE5rHIa/6WbQALj7
   UHdLNMVO5muG+KPkcsucDhlqBi7Gl9+ksxsRjIGDWJ8TkqTmDqcxmcaUn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285929320"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="285929320"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445863"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:14:11 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 21/25] iommu/vt-d: Use IDA interface to manage iommu sequence id
Date: Tue, 12 Jul 2022 08:09:04 +0800
Message-Id: <20220712000908.3431936-22-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch dmar unit sequence id allocation and release from bitmap to IDA
interface.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220702015610.2849494-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/dmar.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 2a5e0f91e647..6327b34f5aa7 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -60,7 +60,7 @@ LIST_HEAD(dmar_drhd_units);
 
 struct acpi_table_header * __initdata dmar_tbl;
 static int dmar_dev_scope_status = 1;
-static unsigned long dmar_seq_ids[BITS_TO_LONGS(DMAR_UNITS_SUPPORTED)];
+static DEFINE_IDA(dmar_seq_ids);
 
 static int alloc_iommu(struct dmar_drhd_unit *drhd);
 static void free_iommu(struct intel_iommu *iommu);
@@ -1023,28 +1023,6 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
 	return err;
 }
 
-static int dmar_alloc_seq_id(struct intel_iommu *iommu)
-{
-	iommu->seq_id = find_first_zero_bit(dmar_seq_ids,
-					    DMAR_UNITS_SUPPORTED);
-	if (iommu->seq_id >= DMAR_UNITS_SUPPORTED) {
-		iommu->seq_id = -1;
-	} else {
-		set_bit(iommu->seq_id, dmar_seq_ids);
-		sprintf(iommu->name, "dmar%d", iommu->seq_id);
-	}
-
-	return iommu->seq_id;
-}
-
-static void dmar_free_seq_id(struct intel_iommu *iommu)
-{
-	if (iommu->seq_id >= 0) {
-		clear_bit(iommu->seq_id, dmar_seq_ids);
-		iommu->seq_id = -1;
-	}
-}
-
 static int alloc_iommu(struct dmar_drhd_unit *drhd)
 {
 	struct intel_iommu *iommu;
@@ -1062,11 +1040,14 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	if (!iommu)
 		return -ENOMEM;
 
-	if (dmar_alloc_seq_id(iommu) < 0) {
+	iommu->seq_id = ida_alloc_range(&dmar_seq_ids, 0,
+					DMAR_UNITS_SUPPORTED - 1, GFP_KERNEL);
+	if (iommu->seq_id < 0) {
 		pr_err("Failed to allocate seq_id\n");
-		err = -ENOSPC;
+		err = iommu->seq_id;
 		goto error;
 	}
+	sprintf(iommu->name, "dmar%d", iommu->seq_id);
 
 	err = map_iommu(iommu, drhd->reg_base_addr);
 	if (err) {
@@ -1150,7 +1131,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 err_unmap:
 	unmap_iommu(iommu);
 error_free_seq_id:
-	dmar_free_seq_id(iommu);
+	ida_free(&dmar_seq_ids, iommu->seq_id);
 error:
 	kfree(iommu);
 	return err;
@@ -1183,7 +1164,7 @@ static void free_iommu(struct intel_iommu *iommu)
 	if (iommu->reg)
 		unmap_iommu(iommu);
 
-	dmar_free_seq_id(iommu);
+	ida_free(&dmar_seq_ids, iommu->seq_id);
 	kfree(iommu);
 }
 
-- 
2.25.1

