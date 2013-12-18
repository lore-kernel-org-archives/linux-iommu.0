From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 1/3] drivers: iommu: Mark functions as static in dmar.c
Date: Wed, 18 Dec 2013 12:01:46 +0530
Message-ID: <6d0cb39e3d1128669e7740943efce3996ab0d8ab.1387265904.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, josh@joshtriplett.org
List-Id: iommu@lists.linux-foundation.org

Mark the functions check_zero_address() and dmar_get_fault_reason() as
static in dmar.c because they are not used outside this file.

This eliminates the following warnings in dmar.c:
drivers/iommu/dmar.c:491:12: warning: no previous prototype for =E2=80=98=
check_zero_address=E2=80=99 [-Wmissing-prototypes]
drivers/iommu/dmar.c:1116:13: warning: no previous prototype for =E2=80=
=98dmar_get_fault_reason=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/iommu/dmar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 8b452c9..fb35d1b 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -488,7 +488,7 @@ static void warn_invalid_dmar(u64 addr, const char =
*message)
 		dmi_get_system_info(DMI_PRODUCT_VERSION));
 }
=20
-int __init check_zero_address(void)
+static int __init check_zero_address(void)
 {
 	struct acpi_table_dmar *dmar;
 	struct acpi_dmar_header *entry_header;
@@ -1113,7 +1113,7 @@ static const char *irq_remap_fault_reasons[] =3D
=20
 #define MAX_FAULT_REASON_IDX 	(ARRAY_SIZE(fault_reason_strings) - 1)
=20
-const char *dmar_get_fault_reason(u8 fault_reason, int *fault_type)
+static const char *dmar_get_fault_reason(u8 fault_reason, int *fault_t=
ype)
 {
 	if (fault_reason >=3D 0x20 && (fault_reason - 0x20 <
 					ARRAY_SIZE(irq_remap_fault_reasons))) {
--=20
1.7.9.5
