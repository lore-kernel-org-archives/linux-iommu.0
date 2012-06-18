From: "Jan Beulich" <JBeulich-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH] intel_irq_remapping.c: ir_parse_..._scope() can be
 __init
Date: Mon, 18 Jun 2012 11:16:16 +0100
Message-ID: <4FDF1C10020000780008A648@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Even though just referenced once, we shouldn't rely on the compiler
inlining them into their __init-annotaed caller.

Signed-off-by: Jan Beulich <jbeulich-IBi9RG/b67k@public.gmane.org>

---
 drivers/iommu/intel_irq_remapping.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- 3.5-rc3/drivers/iommu/intel_irq_remapping.c
+++ 3.5-rc3-intel-ir-sections/drivers/iommu/intel_irq_remapping.c
@@ -628,8 +628,8 @@ error:
 	return -1;
 }
 
-static void ir_parse_one_hpet_scope(struct acpi_dmar_device_scope *scope,
-				      struct intel_iommu *iommu)
+static void __init ir_parse_one_hpet_scope(struct acpi_dmar_device_scope *scope,
+					   struct intel_iommu *iommu)
 {
 	struct acpi_dmar_pci_path *path;
 	u8 bus;
@@ -656,8 +656,8 @@ static void ir_parse_one_hpet_scope(stru
 	ir_hpet_num++;
 }
 
-static void ir_parse_one_ioapic_scope(struct acpi_dmar_device_scope *scope,
-				      struct intel_iommu *iommu)
+static void __init ir_parse_one_ioapic_scope(struct acpi_dmar_device_scope *scope,
+					     struct intel_iommu *iommu)
 {
 	struct acpi_dmar_pci_path *path;
 	u8 bus;
@@ -685,8 +685,8 @@ static void ir_parse_one_ioapic_scope(st
 	ir_ioapic_num++;
 }
 
-static int ir_parse_ioapic_hpet_scope(struct acpi_dmar_header *header,
-				      struct intel_iommu *iommu)
+static int __init ir_parse_ioapic_hpet_scope(struct acpi_dmar_header *header,
+					     struct intel_iommu *iommu)
 {
 	struct acpi_dmar_hardware_unit *drhd;
 	struct acpi_dmar_device_scope *scope;
