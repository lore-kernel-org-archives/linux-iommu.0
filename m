From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] iommu/amd: Enable ga_log_intr when enabling guest_mode
Date: Wed,  5 Jul 2017 21:29:59 -0500
Message-ID: <1499308199-18266-1-git-send-email-suravee.suthikulpanit@amd.com>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

IRTE[GALogIntr] bit should set when enabling guest_mode, which enables
IOMMU to generate entry in GALog when IRTE[IsRun] is not set, and send
an interrupt to notify IOMMU driver.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Fixes: d98de49a53e48 ('iommu/amd: Enable vAPIC interrupt remapping mode by default')
---
 drivers/iommu/amd_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 0f1219f..28fbc81 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4316,6 +4316,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 		/* Setting */
 		irte->hi.fields.ga_root_ptr = (pi_data->base >> 12);
 		irte->hi.fields.vector = vcpu_pi_info->vector;
+		irte->lo.fields_vapic.ga_log_intr = 1;
 		irte->lo.fields_vapic.guest_mode = 1;
 		irte->lo.fields_vapic.ga_tag = pi_data->ga_tag;
 
-- 
1.8.3.1
