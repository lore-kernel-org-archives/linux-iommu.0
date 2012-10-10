From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [git pull] IOMMU Updates for v3.7-rc1
Date: Wed, 10 Oct 2012 15:32:49 +0200
Message-ID: <20121010133249.GC16151@8bytes.org>
References: <20121005152312.GA4649@8bytes.org>
	<20121009224532.1e515664@ado-amd-gentoo.moore.slainvet.net>
	<20121010073022.GB16151@8bytes.org>
	<20121010095823.140fdd98@ado-amd-gentoo.moore.slainvet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121010095823.140fdd98-IjT0q3EH84DI7ueSY2wKCeWwSe/Luo9VmGrBRn/+eNheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Oakley <andrew-WCNZvuCk18ErewFq2K+F1F6hYfS7NtTn@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 10, 2012 at 09:58:23AM +0100, Andrew Oakley wrote:
> On Wed, 10 Oct 2012 09:30:22 +0200
> Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> AMD-Vi:   DEV_SPECIAL(IOAPIC[2])		devid: 00:00.1

Okay, got it. This is the problem. The device id seems to be wrong. The
BIOS should configure your IOAPIC as device id 00:14.0 and not 00:00.1.
The current checking code does not check for this particular situation.
But the attached diff should change that. Can you please test it and
reports if the machine boots for you? Interrupt remapping will be
disabled automatically, though.

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 18b0d99..81837b0 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -1599,21 +1599,46 @@ static void __init free_on_init_error(void)
 #endif
 }
 
+/* SB IOAPIC is always on this device in AMD systems */
+#define IOAPIC_SB_DEVID		((0x00 << 8) | PCI_DEVFN(0x14, 0))
+
 static bool __init check_ioapic_information(void)
 {
+	bool ret, has_sb_ioapic;
 	int idx;
 
-	for (idx = 0; idx < nr_ioapics; idx++) {
-		int id = mpc_ioapic_id(idx);
+	has_sb_ioapic = false;
+	ret           = false;
 
-		if (get_ioapic_devid(id) < 0) {
-			pr_err(FW_BUG "AMD-Vi: IO-APIC[%d] not in IVRS table\n", id);
-			pr_err("AMD-Vi: Disabling interrupt remapping due to BIOS Bug\n");
-			return false;
+	for (idx = 0; idx < nr_ioapics; idx++) {
+		int devid, id = mpc_ioapic_id(idx);
+
+		devid = get_ioapic_devid(id);
+		if (devid < 0) {
+			pr_err(FW_BUG "AMD-Vi: IOAPIC[%d] not in IVRS table\n", id);
+			ret = false;
+		} else if (devid == IOAPIC_SB_DEVID) {
+			has_sb_ioapic = true;
+			ret           = true;
 		}
 	}
 
-	return true;
+	if (!has_sb_ioapic) {
+		/*
+		 * We expect the SB IOAPIC to be listed in the IVRS
+		 * table. The system timer is connected to the SB IOAPIC
+		 * and if we don't have it in the list the system will
+		 * panic at boot time.  This situation usually happens
+		 * when the BIOS is buggy and provides us the wrong
+		 * device id for the IOAPIC in the system.
+		 */
+		pr_err(FW_BUG "AMD-Vi: No southbridge IOAPIC found in IVRS table\n");
+	}
+
+	if (!ret)
+		pr_err("AMD-Vi: Disabling interrupt remapping due to BIOS Bug(s)\n");
+
+	return ret;
 }
 
 static void __init free_dma_resources(void)
