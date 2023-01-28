Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C80D747C
	for <iommu@lists.linux.dev>; Sat, 28 Jan 2023 20:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674936271; x=1706472271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ly7I2AMZF1X9UxOSQU+el8N/ZPjprD8B1/oy+xJtQbk=;
  b=TWKPOK/J6frCtynnylhKqbQsfd5deGq5RewLh1gVmjcfYd+EIfnSaalV
   YFhZDLiP4SA7NZ55K3v9fLqphYhEo/WL+YCCJv/iG1DeNT5jRr/njunH1
   ucYOnx/TIMh02YNDqCHAK6W2lCtpf0x8lUlqpXi0AoppT2lmV2QzV9zeP
   5HA13WDbWmzZ2O4kSPDRzv7pd2OSvV2I0j/RpqeoTupSMOGDS3zz2vwcI
   tYU1kY/PqBagV7pZIQMEmYbuK4G+Fe3nH8eGamXUMXc70HBqoffuYMwG/
   K6O60iEy3XEQaz+niLyamMLlPow0xtNNKIPiFjBEUoxXPjvPyXZffSuDl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325022494"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325022494"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 12:04:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="909038360"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="909038360"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jan 2023 12:04:29 -0800
From: kan.liang@linux.intel.com
To: joro@8bytes.org,
	will@kernel.org,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	robin.murphy@arm.com,
	robert.moore@intel.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: yu-cheng.yu@intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 1/7] iommu/vt-d: Support size of the register set in DRHD
Date: Sat, 28 Jan 2023 12:04:22 -0800
Message-Id: <20230128200428.1459118-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230128200428.1459118-1-kan.liang@linux.intel.com>
References: <20230128200428.1459118-1-kan.liang@linux.intel.com>
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
---
 drivers/iommu/intel/dmar.c | 11 +++++++----
 include/acpi/actbl1.h      |  2 +-
 include/linux/dmar.h       |  1 +
 3 files changed, 9 insertions(+), 5 deletions(-)

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
-- 
2.35.1

