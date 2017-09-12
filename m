From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] iommu: dmar: fix harmless section mismatch warning
Date: Tue, 12 Sep 2017 22:10:21 +0200
Message-ID: <20170912201032.3661566-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jani Nikula <jani.nikula@intel.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Lv Zheng <lv.zheng@intel.com>, Ashok Raj <ashok.raj@intel.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Building with gcc-4.6 results in this warning due to
dmar_table_print_dmar_entry being inlined as in newer compiler versions:

WARNING: vmlinux.o(.text+0x5c8bee): Section mismatch in reference from the function dmar_walk_remapping_entries() to the function .init.text:dmar_table_print_dmar_entry()
The function dmar_walk_remapping_entries() references
the function __init dmar_table_print_dmar_entry().
This is often because dmar_walk_remapping_entries lacks a __init
annotation or the annotation of dmar_table_print_dmar_entry is wrong.

This removes the __init annotation to avoid the warning. On compilers
that don't show the warning today, this should have no impact since the
function gets inlined anyway.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iommu/dmar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index ca5ebaeafd6a..57c920c1372d 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -497,7 +497,7 @@ static int dmar_parse_one_rhsa(struct acpi_dmar_header *header, void *arg)
 #define	dmar_parse_one_rhsa		dmar_res_noop
 #endif
 
-static void __init
+static void
 dmar_table_print_dmar_entry(struct acpi_dmar_header *header)
 {
 	struct acpi_dmar_hardware_unit *drhd;
-- 
2.9.0
