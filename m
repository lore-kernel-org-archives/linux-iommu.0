Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795867988;
	b=e/GZqzc2XEsvP7tnxxsgkJCrBRS+9HJTofOuhZzr/bQLl3xfKJ3MDBB+4O9wnbt16GMs
	 jnR2KLqpyWu5TaX1uFUMYS1zBQtrQvcT6LVFAPYPTV4R4y2UXP7OhSC/8P7vdRgJNcWF+
	 zOVlobS0664bffzvpTj8vkzr7icmt0jiyWzW1VEyWiOkNl4x47dS6V0Vvqhk8pBjcmU20
	 1z0l1UReKjFNXBgcsFaSyeL31v5YtOJqrshMKKnb+hxODg8RSJt09w9PKHnP5Mo0LY8DZ
	 699UjEFrQhceL1Z6qlvNpNm00Fl0uy+Ft7IQ/SxVgciNORRgX+9JUqdRG1cKidtISHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795867988;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=UT4QFq3/I0Qt6OZwW1g9RS5I8R97iJbFOGCwAOa1pME=;
	b=Omn+r8IR7pXHD+iFeA0Ml+25bzu1m5q5N8IwG2nV4PD/SXwYsVmu4UQJQ2fyRKNDLCMK
	 ky8z9mjJMb5Gbsk0kFcV7KTgHKff3s8FPgXZofXzONGuqLXO5cxdsFUOtCvmYZ9+En3W5
	 NFoyvlpAYj66As99S8ZnEHl18gDvTz+CV+FPdpfZfBa8Y66mFW1CT4zPdWfVb4l6ug+/w
	 MNXv6cvOwPh8GZD7F50AbhKOZMoio0+z217jFbDgot5IOaPLILerjjah0Qk8qGkPNl51I
	 jl136Hkg/5buo3KwasvLS7vwvjtQ3ClPYiwxOoXR2JWngrABICC3aNE8fy26dO98dow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=bIcE0Kce;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E407606A32F
	for <iommu@lists.linux.dev>; Sat, 28 Nov 2026 12:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E407606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=bIcE0Kce
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795867988; x=1827403988;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UT4QFq3/I0Qt6OZwW1g9RS5I8R97iJbFOGCwAOa1pME=;
  b=bIcE0Kce4jl+pqerVkvUVTIkWaI5zlo0xxcGmurQ6zgG4aW7w+eD61jH
   3oq4dCI9x8VBB8PJ7nUrO76XVY0o2xS1iwG1DcUq4xatBR8FaM0POnK9U
   KQXlGqeFAt7FgOvJpeZkEMw3CaK2DJdCj/Z/c+TFwbmQRV6DbYS/rvVr0
   ZT0KPFM3ap/G6xbahLLTI303gGn8mFmoKITvoj7vH8WSv72BViDORJmb0
   Kprv8uM0TucDae2Lssm8Ya9PkflKBUiOt94mJ6NkVW8rsOMLe4QS05Lo2
   vpVOJNbyU0Ira9IjzfAdZgiyYyvUqoYH0Qh0q5DtKHWwj1K7qVS2jEwT3
   A==;
X-CSE-ConnectionGUID: mLw+jaVZSuijQVr8FCv5aA==
X-CSE-MsgGUID: 0sQrJQsXScWkoi33QW3tdg==
X-IronPort-AV: E=Sophos;i="6.27,238,1787011200"; 
   d="scan'208";a="34874357"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2026 12:13:06 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:31104]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.177:2525] with esmtp (Farcaster)
 id d018b670-54d4-413c-95c9-126e656b1bc4; Sat, 28 Nov 2026 12:13:05 +0000 (UTC)
X-Farcaster-Flow-ID: d018b670-54d4-413c-95c9-126e656b1bc4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Sat, 28 Nov 2026 12:13:05 +0000
Received: from dev-dsk-lshahed-1a-d9c3b839.eu-west-1.amazon.com
 (172.19.123.145) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57; Sat, 28 Nov 2026
 12:13:03 +0000
From: Ibrahim Elshahed <lshahed@amazon.de>
To: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, Anselm Busse
	<abusse@amazon.com>
Subject: [PATCH] iommu/vt-d: Validate table addresses in dmar_fault_dump_ptes()
Date: Sat, 28 Nov 2026 12:12:55 +0000
Message-ID: <20261128121255.66061-1-lshahed@amazon.de>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Anselm Busse <abusse@amazon.com>

dmar_fault_dump_ptes() walks the root entry, context entry, PASID
tables and page tables of a device that has just taken a DMA fault.
It translates each table address found in those entries with
phys_to_virt() and dereferences the result, without checking that the
address is backed by memory in the direct map. The walk runs from the
DMAR fault interrupt handler.

If an entry is corrupt and points at an address that has no struct
page, such as one past the end of RAM, phys_to_virt() returns an
unmapped virtual address and the dump faults in the interrupt handler.
A recoverable device fault becomes a panic. Pointing a device's
context entry past the end of RAM and letting the device DMA gives:

  DMAR: [DMA Read NO_PASID] Request device [0000:00:03.0] fault addr 0x100000 [fault reason 0x03] Invalid context entry
  DMAR: Dump dmar0 table entries for IOVA 0x100000
  DMAR: root entry: 0x0000000100e0e001
  DMAR: context entry: hi 0x0000000000000502, low 0x0000000400000001
  BUG: unable to handle page fault for address: ffff9fb940000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Oops: Oops: 0000 [#1] SMP NOPTI
  RIP: 0010:dmar_fault_dump_ptes+0x216/0x263

Check each table address with pfn_valid() before dereferencing it and
stop the dump with a message when the check fails. Open-code the PASID
table lookup instead of using get_pasid_table_from_pde() so the
pointer taken from the PASID directory entry gets the same check.

Fixes: 914ff7719e8a ("iommu/vt-d: Dump DMAR translation structure when DMA fault occurs")
Cc: stable@vger.kernel.org
Signed-off-by: Anselm Busse <abusse@amazon.com>
Co-developed-by: Ibrahim Elshahed <lshahed@amazon.de>
Signed-off-by: Ibrahim Elshahed <lshahed@amazon.de>
---
Reproduced with a test-only hook that rewrites a device's context
entry before the device DMAs. In QEMU (q35, intel-iommu, legacy mode)
on iommu/next, a context entry pointing past the end of RAM or at the
local APIC oopses without this patch; with it the dump prints "legacy
mode page table address is invalid" and the system keeps running.

 drivers/iommu/intel/iommu.c | 47 +++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a2e705a2f2e..2f3122b1f4a3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -552,6 +552,18 @@ static void free_context_table(struct intel_iommu *iommu)
 }
 
 #ifdef CONFIG_DMAR_DEBUG
+/*
+ * A faulting device's table entries may hold garbage or point outside
+ * the direct map. Return NULL if @addr cannot be dereferenced.
+ */
+static void *dmar_fault_table_virt(u64 addr)
+{
+	if (!pfn_valid(PHYS_PFN(addr)))
+		return NULL;
+
+	return phys_to_virt(addr);
+}
+
 static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn,
 			 u8 bus, u8 devfn, struct dma_pte *parent, int level)
 {
@@ -572,7 +584,12 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn,
 		if (level == 1 || dma_pte_superpage(pte))
 			break;
 
-		parent = phys_to_virt(dma_pte_addr(pte));
+		parent = dmar_fault_table_virt(dma_pte_addr(pte));
+		if (!parent) {
+			pr_info("page table address is invalid at level %d\n",
+				level - 1);
+			break;
+		}
 		level--;
 	}
 }
@@ -621,7 +638,11 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 			return;
 		}
 		level = agaw_to_level(ctx_entry->hi & 7);
-		pgtable = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
+		pgtable = dmar_fault_table_virt(ctx_entry->lo & VTD_PAGE_MASK);
+		if (!pgtable) {
+			pr_info("legacy mode page table address is invalid\n");
+			return;
+		}
 		goto pgtable_walk;
 	}
 
@@ -631,7 +652,11 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	}
 
 	/* get the pointer to pasid directory entry */
-	dir = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
+	dir = dmar_fault_table_virt(ctx_entry->lo & VTD_PAGE_MASK);
+	if (!dir) {
+		pr_info("pasid directory table address is invalid\n");
+		return;
+	}
 
 	/* For request-without-pasid, get the pasid from context entry */
 	if (intel_iommu_sm && pasid == IOMMU_PASID_INVALID)
@@ -642,11 +667,15 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	pr_info("pasid dir entry: 0x%016llx\n", pde->val);
 
 	/* get the pointer to the pasid table entry */
-	entries = get_pasid_table_from_pde(pde);
-	if (!entries) {
+	if (!pasid_pde_is_present(pde)) {
 		pr_info("pasid table is not present\n");
 		return;
 	}
+	entries = dmar_fault_table_virt(READ_ONCE(pde->val) & PDE_PFN_MASK);
+	if (!entries) {
+		pr_info("pasid table address is invalid\n");
+		return;
+	}
 	index = pasid & PASID_PTE_MASK;
 	pte = &entries[index];
 	for (i = 0; i < ARRAY_SIZE(pte->val); i++)
@@ -659,10 +688,14 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 
 	if (pasid_pte_get_pgtt(pte) == PASID_ENTRY_PGTT_FL_ONLY) {
 		level = pte->val[2] & BIT_ULL(2) ? 5 : 4;
-		pgtable = phys_to_virt(pte->val[2] & VTD_PAGE_MASK);
+		pgtable = dmar_fault_table_virt(pte->val[2] & VTD_PAGE_MASK);
 	} else {
 		level = agaw_to_level((pte->val[0] >> 2) & 0x7);
-		pgtable = phys_to_virt(pte->val[0] & VTD_PAGE_MASK);
+		pgtable = dmar_fault_table_virt(pte->val[0] & VTD_PAGE_MASK);
+	}
+	if (!pgtable) {
+		pr_info("scalable mode page table address is invalid\n");
+		return;
 	}
 
 pgtable_walk:

base-commit: 1ec7c5bbcabf9a75ba3b0bc0c0e64134a965abe7
-- 
2.47.3

