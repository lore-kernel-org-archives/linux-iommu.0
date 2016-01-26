From: Wan Zongshun <vincent.wan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH V2 3/8] iommu/amd: Add new map for storing IVHD dev entry type
	HID
Date: Tue, 26 Jan 2016 18:14:32 -0500
Message-ID: <1453850077-2539-4-git-send-email-vincent.wan@amd.com>
References: <1453850077-2539-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1453850077-2539-1-git-send-email-vincent.wan-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>, Ray Huang <ray.huang-5C7GfCeVMHo@public.gmane.org>, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>, ken.xue-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>

This patch introduces acpihid_map, which is used to store
the new IVHD device entry extracted from BIOS IVRS table.

It also provides a utility function add_acpi_hid_device(),
to add this types of devices to the map.

Signed-off-by: Wan Zongshun <Vincent.Wan-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c       |   1 +
 drivers/iommu/amd_iommu_init.c  | 122 ++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_types.h |  14 +++++
 3 files changed, 137 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 539b0de..8063ab2 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -72,6 +72,7 @@ static DEFINE_SPINLOCK(dev_data_list_lock);
 
 LIST_HEAD(ioapic_map);
 LIST_HEAD(hpet_map);
+LIST_HEAD(acpihid_map);
 
 /*
  * Domain for untranslated devices - only allocated
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 146f3ee..0a8e033 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -60,6 +60,10 @@
 #define IVHD_DEV_SPECIAL		0x48
 #define IVHD_DEV_ACPI_HID		0xf0
 
+#define UID_NOT_PRESENT                 0
+#define UID_IS_INTEGER                  1
+#define UID_IS_CHARACTER                2
+
 #define IVHD_SPECIAL_IOAPIC		1
 #define IVHD_SPECIAL_HPET		2
 
@@ -116,6 +120,11 @@ struct ivhd_entry {
 	u16 devid;
 	u8 flags;
 	u32 ext;
+	u32 hidh;
+	u64 cid;
+	u8 uidf;
+	u8 uidl;
+	u8 uid;
 } __attribute__((packed));
 
 /*
@@ -224,8 +233,12 @@ enum iommu_init_state {
 #define EARLY_MAP_SIZE		4
 static struct devid_map __initdata early_ioapic_map[EARLY_MAP_SIZE];
 static struct devid_map __initdata early_hpet_map[EARLY_MAP_SIZE];
+static struct acpihid_map_entry __initdata early_acpihid_map[EARLY_MAP_SIZE];
+
 static int __initdata early_ioapic_map_size;
 static int __initdata early_hpet_map_size;
+static int __initdata early_acpihid_map_size;
+
 static bool __initdata cmdline_maps;
 
 static enum iommu_init_state init_state = IOMMU_START_STATE;
@@ -760,6 +773,42 @@ static int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
 	return 0;
 }
 
+static int __init add_acpi_hid_device(u8 *hid, u8 *uid, u16 *devid,
+				      bool cmd_line)
+{
+	struct acpihid_map_entry *entry;
+	struct list_head *list = &acpihid_map;
+
+	list_for_each_entry(entry, list, list) {
+		if (strcmp(entry->hid, hid) ||
+		    (*uid && *entry->uid && strcmp(entry->uid, uid)) ||
+		    !entry->cmd_line)
+			continue;
+
+		pr_info("AMD-Vi: Command-line override for hid:%s uid:%s\n",
+			hid, uid);
+		*devid = entry->devid;
+		return 0;
+	}
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	memcpy(entry->uid, uid, strlen(uid));
+	memcpy(entry->hid, hid, strlen(hid));
+	entry->devid = *devid;
+	entry->cmd_line	= cmd_line;
+	entry->root_devid = (entry->devid & (~0x7));
+
+	pr_info("AMD-Vi:%s, add hid:%s, uid:%s, rdevid:%d\n",
+		entry->cmd_line ? "cmd" : "ivrs",
+		entry->hid, entry->uid, entry->root_devid);
+
+	list_add_tail(&entry->list, list);
+	return 0;
+}
+
 static int __init add_early_maps(void)
 {
 	int i, ret;
@@ -782,6 +831,15 @@ static int __init add_early_maps(void)
 			return ret;
 	}
 
+	for (i = 0; i < early_acpihid_map_size; ++i) {
+		ret = add_acpi_hid_device(early_acpihid_map[i].hid,
+					  early_acpihid_map[i].uid,
+					  &early_acpihid_map[i].devid,
+					  early_acpihid_map[i].cmd_line);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -1001,6 +1059,70 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			break;
 		}
+		case IVHD_DEV_ACPI_HID: {
+			u16 devid;
+			u8 hid[ACPIHID_HID_LEN] = {0};
+			u8 uid[ACPIHID_UID_LEN] = {0};
+			int ret;
+
+			if (h->type != 0x40) {
+				pr_err(FW_BUG "Invalid IVHD device type %#x\n",
+				       e->type);
+				break;
+			}
+
+			memcpy(hid, (u8 *)(&e->ext), ACPIHID_HID_LEN - 1);
+			hid[ACPIHID_HID_LEN - 1] = '\0';
+
+			if (!(*hid)) {
+				pr_err(FW_BUG "Invalid HID.\n");
+				break;
+			}
+
+			switch (e->uidf) {
+			case UID_NOT_PRESENT:
+
+				if (e->uidl != 0)
+					pr_warn(FW_BUG "Invalid UID length.\n");
+
+				break;
+			case UID_IS_INTEGER:
+
+				sprintf(uid, "%d", e->uid);
+
+				break;
+			case UID_IS_CHARACTER:
+
+				memcpy(uid, (u8 *)(&e->uid), ACPIHID_UID_LEN - 1);
+				uid[ACPIHID_UID_LEN - 1] = '\0';
+
+				break;
+			default:
+				break;
+			}
+
+			DUMP_printk("  DEV_ACPI_HID(%s[%s])\t\tdevid: %02x:%02x.%x\n",
+				    hid, uid,
+				    PCI_BUS_NUM(devid),
+				    PCI_SLOT(devid),
+				    PCI_FUNC(devid));
+
+			devid  = e->devid;
+			flags = e->flags;
+
+			ret = add_acpi_hid_device(hid, uid, &devid, false);
+			if (ret)
+				return ret;
+
+			/*
+			 * add_special_device might update the devid in case a
+			 * command-line override is present. So call
+			 * set_dev_entry_from_acpi after add_special_device.
+			 */
+			set_dev_entry_from_acpi(iommu, devid, e->flags, 0);
+
+			break;
+		}
 		default:
 			break;
 		}
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd_iommu_types.h
index 9d32b20..b6b14d2 100644
--- a/drivers/iommu/amd_iommu_types.h
+++ b/drivers/iommu/amd_iommu_types.h
@@ -527,6 +527,19 @@ struct amd_iommu {
 #endif
 };
 
+#define ACPIHID_UID_LEN 256
+#define ACPIHID_HID_LEN 9
+
+struct acpihid_map_entry {
+	struct list_head list;
+	u8 uid[ACPIHID_UID_LEN];
+	u8 hid[ACPIHID_HID_LEN];
+	u16 devid;
+	u16 root_devid;
+	bool cmd_line;
+	struct iommu_group *group;
+};
+
 struct devid_map {
 	struct list_head list;
 	u8 id;
@@ -537,6 +550,7 @@ struct devid_map {
 /* Map HPET and IOAPIC ids to the devid used by the IOMMU */
 extern struct list_head ioapic_map;
 extern struct list_head hpet_map;
+extern struct list_head acpihid_map;
 
 /*
  * List with all IOMMUs in the system. This list is not locked because it is
-- 
1.9.1
