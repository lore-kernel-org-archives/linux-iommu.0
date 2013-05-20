From: "Li, Zhen-Hua" <zhen-hual@hp.com>
Subject: [PATCH 1/1] iommu: DMAR reporting table needs at least one DRHD
Date: Mon, 20 May 2013 15:57:32 +0800
Message-ID: <1369036652-20022-1-git-send-email-zhen-hual@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Donald Dutile <ddutile@redhat.com>, Linn Crosetto <linn@hp.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: "Li, Zhen-Hua" <zhen-hual@hp.com>
List-Id: iommu@lists.linux-foundation.org

In intel vt-d spec , chapter 8.1 , DMA Remapping Reporting Structure.
In the end of the table, it says:

Remapping Structures[]
-
A list of structures. The list will contain one or
more DMA Remapping Hardware Unit Definition
(DRHD) structures, and zero or more Reserved
Memory Region Reporting (RMRR) and Root Port
ATS Capability Reporting (ATSR) structures.
These structures are described below.

So, there should be at least one DRHD structure in DMA Remapping
reporting table. If there is no DRHD found, a warning is necessary.

Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
---
 drivers/iommu/dmar.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index a7967ce..4739211 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -309,6 +309,7 @@ parse_dmar_table(void)
 	struct acpi_table_dmar *dmar;
 	struct acpi_dmar_header *entry_header;
 	int ret = 0;
+	int drhd_count = 0;
 
 	/*
 	 * Do it again, earlier dmar_tbl mapping could be mapped with
@@ -347,6 +348,7 @@ parse_dmar_table(void)
 
 		switch (entry_header->type) {
 		case ACPI_DMAR_TYPE_HARDWARE_UNIT:
+			drhd_count++;
 			ret = dmar_parse_one_drhd(entry_header);
 			break;
 		case ACPI_DMAR_TYPE_RESERVED_MEMORY:
@@ -371,6 +373,8 @@ parse_dmar_table(void)
 
 		entry_header = ((void *)entry_header + entry_header->length);
 	}
+	if (drhd_count == 0)
+		pr_warn("There is no DRHD structure.");
 	return ret;
 }
 
-- 
1.7.10.4
