From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 01/33] iommu/vt-d: Add ACPI namespace device reporting
	structures
Date: Fri, 21 Mar 2014 17:18:42 +0000
Message-ID: <1395422354-19762-2-git-send-email-David.Woodhouse@intel.com>
References: <1395422354-19762-1-git-send-email-David.Woodhouse@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1395422354-19762-1-git-send-email-David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 include/acpi/actbl2.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 094a906..da5b057 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -424,7 +424,8 @@ enum acpi_dmar_type {
 	ACPI_DMAR_TYPE_RESERVED_MEMORY = 1,
 	ACPI_DMAR_TYPE_ATSR = 2,
 	ACPI_DMAR_HARDWARE_AFFINITY = 3,
-	ACPI_DMAR_TYPE_RESERVED = 4	/* 4 and greater are reserved */
+	ACPI_DMAR_TYPE_ANDD = 4,
+	ACPI_DMAR_TYPE_RESERVED = 5	/* 5 and greater are reserved */
 };
 
 /* DMAR Device Scope structure */
@@ -445,7 +446,8 @@ enum acpi_dmar_scope_type {
 	ACPI_DMAR_SCOPE_TYPE_BRIDGE = 2,
 	ACPI_DMAR_SCOPE_TYPE_IOAPIC = 3,
 	ACPI_DMAR_SCOPE_TYPE_HPET = 4,
-	ACPI_DMAR_SCOPE_TYPE_RESERVED = 5	/* 5 and greater are reserved */
+	ACPI_DMAR_SCOPE_TYPE_ACPI = 5,
+	ACPI_DMAR_SCOPE_TYPE_RESERVED = 6	/* 6 and greater are reserved */
 };
 
 struct acpi_dmar_pci_path {
@@ -507,6 +509,15 @@ struct acpi_dmar_rhsa {
 	u32 proximity_domain;
 };
 
+/* 4: ACPI Namespace Device Declaration Structure */
+
+struct acpi_dmar_andd {
+	struct acpi_dmar_header header;
+	u8 reserved[3];
+	u8 device_number;
+	u8 object_name[];
+};
+
 /*******************************************************************************
  *
  * HPET - High Precision Event Timer table
-- 
1.8.5.3
