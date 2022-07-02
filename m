Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168471849
	for <iommu@lists.linux.dev>; Sat,  2 Jul 2022 02:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656727242; x=1688263242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DFPmBvFWYw27ZARg+5iSaqlrtN1/1OkiNoJ7ea+BTfU=;
  b=fgic+F8qDXJDaGY93VGtEL3+R6WCo/YDY0zdLHylehKbWGYsmQ5xwwUE
   BvsMicTB6zwmevqOub1tIOb2los4hUzYNF40qi62HbZdYSYET3C4AiUip
   oN4wN1uBNoXa0vQZZVE6TPqwVqa1TtYRjd/QHA59CfAZeSiN/ZzJ5d6Bx
   U2C4YZOQzw33nJX22t5pcmbsER4gR+95z8y1BXcisNBx0X+CUfROMDcPA
   8ScDW1wPaCZcURzngtuIeZlI+efdYxqUXWAj2hS8yR5vlS+07KvrcCst9
   XJiL2fr7ec7YmI4Td0/SUEWfQv+ApQOwRbWnKcwi66bMxX/JowH8DypHC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="281539685"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="281539685"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 19:00:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="589518295"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 01 Jul 2022 19:00:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Steve Wahl <steve.wahl@hpe.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Mike Travis <mike.travis@hpe.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Russ Anderson <russ.anderson@hpe.com>,
	iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/6] iommu/vt-d: Use IDA interface to manage iommu sequence id
Date: Sat,  2 Jul 2022 09:56:06 +0800
Message-ID: <20220702015610.2849494-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
References: <20220702015610.2849494-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220702015606.eYcinqgAk-F60A_R9rBKlcOHdl6ojX-2i7mGWNEsWSM@z>

Switch dmar unit sequence id allocation and release from bitmap to IDA
interface.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
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

