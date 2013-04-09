From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 6/9] iommu/amd: Add early maps for ioapic and hpet
Date: Tue,  9 Apr 2013 22:13:01 +0200
Message-ID: <1365538384-12426-7-git-send-email-joro@8bytes.org>
References: <1365538384-12426-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1365538384-12426-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This is needed in a later patch were ioapic_map and hpet_map
entries are created before the slab allocator is initialized
(and thus add_special_device() can't be used).

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 3a210f0..2a3b1b1 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -213,6 +213,13 @@ enum iommu_init_state {
 	IOMMU_INIT_ERROR,
 };
 
+/* Early ioapic and hpet maps from kernel command line */
+#define EARLY_MAP_SIZE		4
+static struct devid_map __initdata early_ioapic_map[EARLY_MAP_SIZE];
+static struct devid_map __initdata early_hpet_map[EARLY_MAP_SIZE];
+static int __initdata early_ioapic_map_size;
+static int __initdata early_hpet_map_size;
+
 static enum iommu_init_state init_state = IOMMU_START_STATE;
 
 static int amd_iommu_enable_interrupts(void);
@@ -738,6 +745,31 @@ static int __init add_special_device(u8 type, u8 id, u16 devid, bool cmd_line)
 	return 0;
 }
 
+static int __init add_early_maps(void)
+{
+	int i, ret;
+
+	for (i = 0; i < early_ioapic_map_size; ++i) {
+		ret = add_special_device(IVHD_SPECIAL_IOAPIC,
+					 early_ioapic_map[i].id,
+					 early_ioapic_map[i].devid,
+					 early_ioapic_map[i].cmd_line);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < early_hpet_map_size; ++i) {
+		ret = add_special_device(IVHD_SPECIAL_HPET,
+					 early_hpet_map[i].id,
+					 early_hpet_map[i].devid,
+					 early_hpet_map[i].cmd_line);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /*
  * Reads the device exclusion range from ACPI and initializes the IOMMU with
  * it
@@ -774,6 +806,12 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	u32 dev_i, ext_flags = 0;
 	bool alias = false;
 	struct ivhd_entry *e;
+	int ret;
+
+
+	ret = add_early_maps();
+	if (ret)
+		return ret;
 
 	/*
 	 * First save the recommended feature enable bits from ACPI
-- 
1.7.9.5
