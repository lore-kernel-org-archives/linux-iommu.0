From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Patch V2 4/4] iommu/vt-d: refine dmar_acpi_dev_scope_init() with
	dmar_walk_dmar_table()
Date: Sun, 20 Mar 2016 13:57:31 +0000
Message-ID: <1458482251-7939-5-git-send-email-richard.weiyang@gmail.com>
References: <1458482251-7939-1-git-send-email-richard.weiyang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1458482251-7939-1-git-send-email-richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

dmar_acpi_dev_scope_init() iterates on the remapping structure and just do
proper job for ANDD structure. This is the what dmar_walk_dmar_table()
does.

This patch improves the code with dmar_walk_dmar_table().

Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/dmar.c |   56 ++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 82f0b92..538e260 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -733,36 +733,44 @@ static void __init dmar_acpi_insert_dev_scope(u8 device_number,
 		device_number, dev_name(&adev->dev));
 }
 
-static int __init dmar_acpi_dev_scope_init(void)
+static int __dmar_acpi_dev_scope_init(struct acpi_dmar_header *header,
+				      void *arg)
 {
 	struct acpi_dmar_andd *andd;
+	acpi_handle h;
+	struct acpi_device *adev;
+
+	andd = (struct acpi_dmar_andd *)header;
+	if (!ACPI_SUCCESS(acpi_get_handle(ACPI_ROOT_OBJECT,
+					  andd->device_name,
+					  &h))) {
+		pr_err("Failed to find handle for ACPI object %s\n",
+		       andd->device_name);
+		return 0;
+	}
+	if (acpi_bus_get_device(h, &adev)) {
+		pr_err("Failed to get device for ACPI object %s\n",
+		       andd->device_name);
+		return 0;
+	}
+	dmar_acpi_insert_dev_scope(andd->device_number, adev);
+	return 0;
+}
+
+static int __init dmar_acpi_dev_scope_init(void)
+{
+	struct acpi_table_dmar *dmar;
+	struct dmar_res_callback cb = {
+		.print_entry = false,
+		.ignore_unhandled = true,
+		.cb[ACPI_DMAR_TYPE_NAMESPACE] = &__dmar_acpi_dev_scope_init,
+	};
 
 	if (dmar_tbl == NULL)
 		return -ENODEV;
 
-	for (andd = (void *)dmar_tbl + sizeof(struct acpi_table_dmar);
-	     ((unsigned long)andd) < ((unsigned long)dmar_tbl) + dmar_tbl->length;
-	     andd = ((void *)andd) + andd->header.length) {
-		if (andd->header.type == ACPI_DMAR_TYPE_NAMESPACE) {
-			acpi_handle h;
-			struct acpi_device *adev;
-
-			if (!ACPI_SUCCESS(acpi_get_handle(ACPI_ROOT_OBJECT,
-							  andd->device_name,
-							  &h))) {
-				pr_err("Failed to find handle for ACPI object %s\n",
-				       andd->device_name);
-				continue;
-			}
-			if (acpi_bus_get_device(h, &adev)) {
-				pr_err("Failed to get device for ACPI object %s\n",
-				       andd->device_name);
-				continue;
-			}
-			dmar_acpi_insert_dev_scope(andd->device_number, adev);
-		}
-	}
-	return 0;
+	dmar = (struct acpi_table_dmar *)dmar_tbl;
+	return dmar_walk_dmar_table(dmar, &cb);
 }
 
 int __init dmar_dev_scope_init(void)
-- 
1.7.9.5
