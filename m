From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [Patch V3 3/4] iommu/vt-d: check Register Base Address at the
	beginning of dmar_parse_one_drhd()
Date: Wed, 23 Mar 2016 14:15:48 +0000
Message-ID: <1458742549-28504-4-git-send-email-richard.weiyang@gmail.com>
References: <1458742549-28504-1-git-send-email-richard.weiyang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1458742549-28504-1-git-send-email-richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

A NULL value of Register Base Address in a Hardware Unit Definition means
it is an invalid dmar. Current implementation checks this value in
alloc_iommu(), by when it has already allocated memory to store itself and
device scope.

This patch moves the check at the beginning of dmar_parse_one_drhd(), so
that it notices this is an invalid dmar and avoids related setup jobs.

Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/dmar.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index 6bff602..35fc8fb 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -363,6 +363,18 @@ dmar_find_dmaru(struct acpi_dmar_hardware_unit *drhd)
 	return NULL;
 }
 
+static void warn_invalid_dmar(u64 addr, const char *message)
+{
+	WARN_TAINT_ONCE(
+		1, TAINT_FIRMWARE_WORKAROUND,
+		"Your BIOS is broken; DMAR reported at address %llx%s!\n"
+		"BIOS vendor: %s; Ver: %s; Product Version: %s\n",
+		addr, message,
+		dmi_get_system_info(DMI_BIOS_VENDOR),
+		dmi_get_system_info(DMI_BIOS_VERSION),
+		dmi_get_system_info(DMI_PRODUCT_VERSION));
+}
+
 /**
  * dmar_parse_one_drhd - parses exactly one DMA remapping hardware definition
  * structure which uniquely represent one DMA remapping hardware unit
@@ -379,6 +391,11 @@ static int dmar_parse_one_drhd(struct acpi_dmar_header *header, void *arg)
 	if (dmaru)
 		goto out;
 
+	if (!drhd->address) {
+		warn_invalid_dmar(0, "");
+		return -EINVAL;
+	}
+
 	dmaru = kzalloc(sizeof(*dmaru) + header->length, GFP_KERNEL);
 	if (!dmaru)
 		return -ENOMEM;
@@ -808,18 +825,6 @@ int __init dmar_table_init(void)
 	return dmar_table_initialized < 0 ? dmar_table_initialized : 0;
 }
 
-static void warn_invalid_dmar(u64 addr, const char *message)
-{
-	WARN_TAINT_ONCE(
-		1, TAINT_FIRMWARE_WORKAROUND,
-		"Your BIOS is broken; DMAR reported at address %llx%s!\n"
-		"BIOS vendor: %s; Ver: %s; Product Version: %s\n",
-		addr, message,
-		dmi_get_system_info(DMI_BIOS_VENDOR),
-		dmi_get_system_info(DMI_BIOS_VERSION),
-		dmi_get_system_info(DMI_PRODUCT_VERSION));
-}
-
 static int __ref
 dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
 {
@@ -995,11 +1000,6 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	int msagaw = 0;
 	int err;
 
-	if (!drhd->reg_base_addr) {
-		warn_invalid_dmar(0, "");
-		return -EINVAL;
-	}
-
 	iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
 		return -ENOMEM;
-- 
1.7.9.5
