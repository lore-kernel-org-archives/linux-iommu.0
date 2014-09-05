From: "Su, Friendy" <Friendy.Su-7U/KSKJipcvM1kAEIRd3EQ@public.gmane.org>
Subject: [PATCH v2 1/1] iommu/amd: set iommu for early mapped ioapic/hpet
Date: Fri, 5 Sep 2014 19:25:14 +0800
Message-ID: <053191AD6E9023439BF3970DE870051856D1EF3AC5@APSHAXMS02.ap.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


From: Su Friendy <friendy.su-7U/KSKJipcvM1kAEIRd3EQ@public.gmane.org>

Subject: iommu/amd: make early mapped ioapic/hpet override IVHD

The early mapped ioapic/hpet specified by kernel boot parameter
ivrs_ioapic[ID]/ivrs_hpet[ID] always override the ioapic/hpet with
same ID reported by ACPI IVHD table.

Current driver still uses devid in IVHD to set dte entry, not devid
in early mapped. This patch fixed to use devid in early mapped.

This issue is found on a mother board whose BIOS reports wrong
IOAPIC devid in IVHD table. Without this fix, the early mapped
does not really override IVHD. So that the wrong reported IOAPIC
does not work.

Signed-off-by: Su Friendy <friendy.su-7U/KSKJipcvM1kAEIRd3EQ@public.gmane.org>
Signed-off-by: Saeki Shusuke <shusuke.saeki-7rVYBvDxQfZBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Tamori Masahiro <Masahiro.Tamori-7rVYBvDxQfZBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c |   40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 3c06183..83cb31b 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -715,7 +715,7 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 	set_iommu_for_device(iommu, devid);
 }
 
-static int __init add_special_device(u8 type, u8 id, u16 devid, bool cmd_line)
+static int __init add_special_device(u8 type, u8 id, u16 devid, bool cmd_line, u16 *early_mapped_devid)
 {
 	struct devid_map *entry;
 	struct list_head *list;
@@ -734,6 +734,19 @@ static int __init add_special_device(u8 type, u8 id, u16 devid, bool cmd_line)
 		pr_info("AMD-Vi: Command-line override present for %s id %d - ignoring\n",
 			type == IVHD_SPECIAL_IOAPIC ? "IOAPIC" : "HPET", id);
 
+		/*
+		 * if this special device is added from IVHD and
+		 * its devid in IVHD != devid in early mapped, then
+		 * record early mapped devid.
+		 */
+		if (!cmd_line && devid != entry->devid) {
+			if (early_mapped_devid == NULL)
+				return -EINVAL;
+
+			*early_mapped_devid = entry->devid;
+			return -EEXIST;
+		}
+
 		return 0;
 	}
 
@@ -758,7 +771,8 @@ static int __init add_early_maps(void)
 		ret = add_special_device(IVHD_SPECIAL_IOAPIC,
 					 early_ioapic_map[i].id,
 					 early_ioapic_map[i].devid,
-					 early_ioapic_map[i].cmd_line);
+					 early_ioapic_map[i].cmd_line,
+					 NULL);
 		if (ret)
 			return ret;
 	}
@@ -767,7 +781,8 @@ static int __init add_early_maps(void)
 		ret = add_special_device(IVHD_SPECIAL_HPET,
 					 early_hpet_map[i].id,
 					 early_hpet_map[i].devid,
-					 early_hpet_map[i].cmd_line);
+					 early_hpet_map[i].cmd_line,
+					 NULL);
 		if (ret)
 			return ret;
 	}
@@ -961,7 +976,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_SPECIAL: {
 			u8 handle, type;
 			const char *var;
-			u16 devid;
+			u16 devid, early_mapped_devid;
 			int ret;
 
 			handle = e->ext & 0xff;
@@ -981,10 +996,21 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 				    PCI_SLOT(devid),
 				    PCI_FUNC(devid));
 
-			set_dev_entry_from_acpi(iommu, devid, e->flags, 0);
-			ret = add_special_device(type, handle, devid, false);
-			if (ret)
+			ret = add_special_device(type, handle, devid, false, &early_mapped_devid);
+
+			/*
+			 * if the special device is already early mapped,
+			 * let the early mapped devid override IVHD.
+			 */
+			if (ret == -EEXIST) {
+				devid = early_mapped_devid;
+				ret = 0;
+			}
+
+			if (ret < 0)
 				return ret;
+
+			set_dev_entry_from_acpi(iommu, devid, e->flags, 0);
 			break;
 		}
 		default:
-- 
1.7.9.5
