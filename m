From: "Su, Friendy" <Friendy.Su-7U/KSKJipcvM1kAEIRd3EQ@public.gmane.org>
Subject: [PATCH v1 1/1] iommu/amd: set iommu for early mapped ioapic/hpet
Date: Mon, 1 Sep 2014 14:17:44 +0800
Message-ID: <053191AD6E9023439BF3970DE870051856D1EF3AC4@APSHAXMS02.ap.sony.com>
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
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


From: Su Friendy <friendy.su-7U/KSKJipcvM1kAEIRd3EQ@public.gmane.org>

The early mapped ioapic/hpet specified by kernel boot parameter
ivrs_ioapic[ID]/ivrs_hpet[ID] always override the ioapic/hpet with
same ID reported by ACPI IVRS table. Therefore, the early mapped
should be always controlled by iommu.

Current driver did not set iommu for the early mapped. This causes
ivrs_ioapic[ID]/ivrs_hpet[ID] actually are not controlled by iommu.
This patch fixes this problem by setting iommu for early mapped.

Signed-off-by: Su Friendy <friendy.su-7U/KSKJipcvM1kAEIRd3EQ@public.gmane.org>
Signed-off-by: Saeki Shusuke <shusuke.saeki-7rVYBvDxQfZBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Tamori Masahiro <Masahiro.Tamori-7rVYBvDxQfZBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 3783e0b..148ab61 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -747,7 +747,7 @@ static int __init add_special_device(u8 type, u8 id, u16 devid, bool cmd_line)
 	return 0;
 }
 
-static int __init add_early_maps(void)
+static int __init add_early_maps(struct amd_iommu *iommu)
 {
 	int i, ret;
 
@@ -758,6 +758,11 @@ static int __init add_early_maps(void)
 					 early_ioapic_map[i].cmd_line);
 		if (ret)
 			return ret;
+		/*
+		 * early mapped ioapci overrides ACPI IVRS,
+		 * they should be always controlled by iommu.
+		 */
+		set_iommu_for_device(iommu, early_ioapic_map[i].devid);
 	}
 
 	for (i = 0; i < early_hpet_map_size; ++i) {
@@ -767,6 +772,11 @@ static int __init add_early_maps(void)
 					 early_hpet_map[i].cmd_line);
 		if (ret)
 			return ret;
+		/*
+		 * early mapped hpet overrides ACPI IVRS,
+		 * they should be always controlled by iommu.
+		 */
+		set_iommu_for_device(iommu, early_hpet_map[i].devid);
 	}
 
 	return 0;
@@ -811,7 +821,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	int ret;
 
 
-	ret = add_early_maps();
+	ret = add_early_maps(iommu);
 	if (ret)
 		return ret;
 
-- 
1.8.2.1
