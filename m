From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] iommu/amd: Fix interrupt remapping when disable guest_mode
Date: Fri, 23 Jun 2017 06:56:47 -0500
Message-ID: <1498219007-17605-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Pass-through devices to VM guest can get updated affinity
information via irq_set_affinity(). Currently, AMD IOMMU driver
in GA mode ignores the updated information if the pass-through
device is setup to use vAPIC, which could cause invalid interrupt
remapping when not running in guest_mode.

Also, the guest_mode bit should be set and cleared only when
SVM updates posted-interrupt information via irq_set_vcpu_affinity().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b17536d6..1055863 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3883,7 +3883,6 @@ static void irte_ga_prepare(void *entry,
 
 	irte->lo.val                      = 0;
 	irte->hi.val                      = 0;
-	irte->lo.fields_remap.guest_mode  = dev_data ? dev_data->use_vapic : 0;
 	irte->lo.fields_remap.int_type    = delivery_mode;
 	irte->lo.fields_remap.dm          = dest_mode;
 	irte->hi.fields.vector            = vector;
@@ -3939,10 +3938,10 @@ static void irte_ga_set_affinity(void *entry, u16 devid, u16 index,
 	struct irte_ga *irte = (struct irte_ga *) entry;
 	struct iommu_dev_data *dev_data = search_dev_data(devid);
 
-	if (!dev_data || !dev_data->use_vapic) {
+	if (!dev_data || !dev_data->use_vapic ||
+	    !irte->lo.fields_remap.guest_mode) {
 		irte->hi.fields.vector = vector;
 		irte->lo.fields_remap.destination = dest_apicid;
-		irte->lo.fields_remap.guest_mode = 0;
 		modify_irte_ga(devid, index, irte, NULL);
 	}
 }
-- 
1.8.3.1
