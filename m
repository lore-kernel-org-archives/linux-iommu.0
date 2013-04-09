From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 7/9] iommu/amd: Add ioapic and hpet ivrs override
Date: Tue,  9 Apr 2013 22:13:02 +0200
Message-ID: <1365538384-12426-8-git-send-email-joro@8bytes.org>
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

Add two new kernel commandline parameters ivrs_ioapic and
ivrs_hpet to override the Id->DeviceId mapping from the IVRS
ACPI table. This can be used to work around broken BIOSes to
get interrupt remapping working on AMD systems.

Signed-off-by: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/amd_iommu_init.c |   64 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 2a3b1b1..030d6ab 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2145,8 +2145,68 @@ static int __init parse_amd_iommu_options(char *str)
 	return 1;
 }
 
-__setup("amd_iommu_dump", parse_amd_iommu_dump);
-__setup("amd_iommu=", parse_amd_iommu_options);
+static int __init parse_ivrs_ioapic(char *str)
+{
+	unsigned int bus, dev, fn;
+	int ret, id, i;
+	u16 devid;
+
+	ret = sscanf(str, "[%d]=%x:%x.%x", &id, &bus, &dev, &fn);
+
+	if (ret != 4) {
+		pr_err("AMD-Vi: Invalid command line: ivrs_ioapic%s\n", str);
+		return 1;
+	}
+
+	if (early_ioapic_map_size == EARLY_MAP_SIZE) {
+		pr_err("AMD-Vi: Early IOAPIC map overflow - ignoring ivrs_ioapic%s\n",
+			str);
+		return 1;
+	}
+
+	devid = ((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
+
+	i				= early_ioapic_map_size++;
+	early_ioapic_map[i].id		= id;
+	early_ioapic_map[i].devid	= devid;
+	early_ioapic_map[i].cmd_line	= true;
+
+	return 1;
+}
+
+static int __init parse_ivrs_hpet(char *str)
+{
+	unsigned int bus, dev, fn;
+	int ret, id, i;
+	u16 devid;
+
+	ret = sscanf(str, "[%d]=%x:%x.%x", &id, &bus, &dev, &fn);
+
+	if (ret != 4) {
+		pr_err("AMD-Vi: Invalid command line: ivrs_hpet%s\n", str);
+		return 1;
+	}
+
+	if (early_hpet_map_size == EARLY_MAP_SIZE) {
+		pr_err("AMD-Vi: Early HPET map overflow - ignoring ivrs_hpet%s\n",
+			str);
+		return 1;
+	}
+
+	devid = ((bus & 0xff) << 8) | ((dev & 0x1f) << 3) | (fn & 0x7);
+
+	i				= early_hpet_map_size++;
+	early_hpet_map[i].id		= id;
+	early_hpet_map[i].devid		= devid;
+	early_hpet_map[i].cmd_line	= true;
+
+	return 1;
+}
+
+__setup("amd_iommu_dump",	parse_amd_iommu_dump);
+__setup("amd_iommu=",		parse_amd_iommu_options);
+__setup("ivrs_ioapic",		parse_ivrs_ioapic);
+__setup("ivrs_hpet",		parse_ivrs_hpet);
 
 IOMMU_INIT_FINISH(amd_iommu_detect,
 		  gart_iommu_hole_init,
-- 
1.7.9.5
