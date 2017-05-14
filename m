From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [patch 10/18] iommu/vt-d: Adjust system_state checks
Date: Sun, 14 May 2017 20:27:26 +0200
Message-ID: <20170514183613.238367369@linutronix.de>
References: <20170514182716.347236777@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline;
	filename=iommu-vt-d--Adjust-system_state-check.patch
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

To enable smp_processor_id() and might_sleep() debug checks earlier, it's
required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.

Adjust the system_state checks in dmar_parse_one_atsr() and
dmar_iommu_notify_scope_dev() to handle the extra states.

Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
---
 drivers/iommu/intel-iommu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4312,7 +4312,7 @@ int dmar_parse_one_atsr(struct acpi_dmar
 	struct acpi_dmar_atsr *atsr;
 	struct dmar_atsr_unit *atsru;
 
-	if (system_state != SYSTEM_BOOTING && !intel_iommu_enabled)
+	if (system_state >= SYSTEM_RUNNING && !intel_iommu_enabled)
 		return 0;
 
 	atsr = container_of(hdr, struct acpi_dmar_atsr, header);
@@ -4562,7 +4562,7 @@ int dmar_iommu_notify_scope_dev(struct d
 	struct acpi_dmar_atsr *atsr;
 	struct acpi_dmar_reserved_memory *rmrr;
 
-	if (!intel_iommu_enabled && system_state != SYSTEM_BOOTING)
+	if (!intel_iommu_enabled && system_state >= SYSTEM_RUNNING)
 		return 0;
 
 	list_for_each_entry(rmrru, &dmar_rmrr_units, list) {
