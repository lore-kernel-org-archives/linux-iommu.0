Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CC7F3
	for <iommu@lists.linux.dev>; Tue, 31 Jan 2023 07:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151170; x=1706687170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5j0AQLikYlRRnQOHzKRdwcTeWDE/SCGwovkljtCjx10=;
  b=kgPClQZsPt+T0YNHYe6xJFewDVOvMOHXZ4mRp+hiI/vVUppxqurzcmul
   3YbQn7O9SSBCYd8emmKmabZ1a1SpBho7JBk97uFqAOE9xmnqVD+NNq+Xb
   AhWnaVmd/CubUqgPg6BTZ8HOXZc9OFnCpnul/3RliuXrGl7pdVXgsZkbE
   vVHGs1HHH3cEmCV9ICFbiqsggzu5voZoRTj66bclr25ElbR/MpvNSqrfo
   zqJYlNnpBRDwL6BHLX2ZxGjJXbnarv+DzbTPU4+SAz5sh11bSit5pV5ZE
   qY9MZ+kkhnTbuvtni82lThSG0yl1vVpdDCxOeoLdBIeSnKMjworJc8hjO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315736613"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315736613"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:46:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657775532"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657775532"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 23:46:00 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: kan.liang@linux.intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] iommu/vt-d: Support size of the register set in DRHD
Date: Tue, 31 Jan 2023 15:37:34 +0800
Message-Id: <20230131073740.378984-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131073740.378984-1-baolu.lu@linux.intel.com>
References: <20230131073740.378984-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

A new field, which indicates the size of the remapping hardware register
set for this remapping unit, is introduced in the DMA-remapping hardware
unit definition (DRHD) structure with the VT-d Spec 4.0. With this
information, SW doesn't need to 'guess' the size of the register set
anymore.

Update the struct acpi_dmar_hardware_unit to reflect the field. Store the
size of the register set in struct dmar_drhd_unit for each dmar device.

The 'size' information is ResvZ for the old BIOS and platforms. Fall back
to the old guessing method. There is nothing changed.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20230128200428.1459118-2-kan.liang@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/dmar.h       |  1 +
 include/acpi/actbl1.h      |  2 +-
 drivers/iommu/intel/dmar.c | 11 +++++++----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index d81a51978d01..725d5e6acec0 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -39,6 +39,7 @@ struct dmar_drhd_unit {
 	struct list_head list;		/* list of drhd units	*/
 	struct  acpi_dmar_header *hdr;	/* ACPI header		*/
 	u64	reg_base_addr;		/* register base address*/
+	unsigned long reg_size;		/* size of register set */
 	struct	dmar_dev_scope *devices;/* target device array	*/
 	int	devices_cnt;		/* target device count	*/
 	u16	segment;		/* PCI domain		*/
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 4175dce3967c..bdded0ac46eb 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -802,7 +802,7 @@ struct acpi_dmar_pci_path {
 struct acpi_dmar_hardware_unit {
 	struct acpi_dmar_header header;
 	u8 flags;
-	u8 reserved;
+	u8 size;		/* Size of the register set */
 	u16 segment;
 	u64 address;		/* Register Base Address */
 };
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index b00a0ceb2d13..3a40fef1ec1b 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -427,6 +427,8 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
 	memcpy(dmaru->hdr, header, header->length);
 	dmaru->reg_base_addr = drhd->address;
 	dmaru->segment = drhd->segment;
+	/* The size of the register set is 2 ^ N 4 KB pages. */
+	dmaru->reg_size = 1UL << (drhd->size + 12);
 	dmaru->include_all = drhd->flags & 0x1; /* BIT0: INCLUDE_ALL */
 	dmaru->devices = dmar_alloc_dev_scope((void *)(drhd + 1),
 					      ((void *)drhd) + drhd->header.length,
@@ -956,17 +958,18 @@ static void unmap_iommu(struct intel_iommu *iommu)
 /**
  * map_iommu: map the iommu's registers
  * @iommu: the iommu to map
- * @phys_addr: the physical address of the base resgister
+ * @drhd: DMA remapping hardware definition structure
  *
  * Memory map the iommu's registers.  Start w/ a single page, and
  * possibly expand if that turns out to be insufficent.
  */
-static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
+static int map_iommu(struct intel_iommu *iommu, struct dmar_drhd_unit *drhd)
 {
+	u64 phys_addr = drhd->reg_base_addr;
 	int map_size, err=0;
 
 	iommu->reg_phys = phys_addr;
-	iommu->reg_size = VTD_PAGE_SIZE;
+	iommu->reg_size = drhd->reg_size;
 
 	if (!request_mem_region(iommu->reg_phys, iommu->reg_size, iommu->name)) {
 		pr_err("Can't reserve memory\n");
@@ -1050,7 +1053,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	}
 	sprintf(iommu->name, "dmar%d", iommu->seq_id);
 
-	err = map_iommu(iommu, drhd->reg_base_addr);
+	err = map_iommu(iommu, drhd);
 	if (err) {
 		pr_err("Failed to map %s\n", iommu->name);
 		goto error_free_seq_id;
-- 
2.34.1

