From: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 02/33] iommu/vt-d: Parse ANDD records
Date: Fri, 21 Mar 2014 17:18:43 +0000
Message-ID: <1395422354-19762-3-git-send-email-David.Woodhouse@intel.com>
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
 drivers/iommu/dmar.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index b19f9f4..eb95020 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -373,6 +373,26 @@ static void dmar_free_drhd(struct dmar_drhd_unit *dmaru)
 	kfree(dmaru);
 }
 
+static int __init dmar_parse_one_andd(struct acpi_dmar_header *header)
+{
+	struct acpi_dmar_andd *andd = (void *)header;
+
+	/* Check for NUL termination within the designated length */
+	if (strnlen(andd->object_name, header->length - 8) == header->length - 8) {
+		WARN_TAINT(1, TAINT_FIRMWARE_WORKAROUND,
+			   "Your BIOS is broken; ANDD object name is not NUL-terminated\n"
+			   "BIOS vendor: %s; Ver: %s; Product Version: %s\n",
+			   dmi_get_system_info(DMI_BIOS_VENDOR),
+			   dmi_get_system_info(DMI_BIOS_VERSION),
+			   dmi_get_system_info(DMI_PRODUCT_VERSION));
+		return -EINVAL;
+	}
+	pr_info("ANDD device: %x name: %s\n", andd->device_number,
+		andd->object_name);
+
+	return 0;
+}
+
 #ifdef CONFIG_ACPI_NUMA
 static int __init
 dmar_parse_one_rhsa(struct acpi_dmar_header *header)
@@ -436,6 +456,10 @@ dmar_table_print_dmar_entry(struct acpi_dmar_header *header)
 		       (unsigned long long)rhsa->base_address,
 		       rhsa->proximity_domain);
 		break;
+	case ACPI_DMAR_TYPE_ANDD:
+		/* We don't print this here because we need to sanity-check
+		   it first. So print it in dmar_parse_one_andd() instead. */
+		break;
 	}
 }
 
@@ -521,6 +545,9 @@ parse_dmar_table(void)
 			ret = dmar_parse_one_rhsa(entry_header);
 #endif
 			break;
+		case ACPI_DMAR_TYPE_ANDD:
+			ret = dmar_parse_one_andd(entry_header);
+			break;
 		default:
 			pr_warn("Unknown DMAR structure type %d\n",
 				entry_header->type);
-- 
1.8.5.3
