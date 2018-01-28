From: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu/amd: Don't use dev_data in irte_ga_set_affinity()
Date: Sun, 28 Jan 2018 14:22:19 -0600
Message-ID: <20180128202219.27005-1-swood@redhat.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Luis Claudio R. Goncalves" <lgoncalv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

search_dev_data() acquires a non-raw lock, which can't be done
from atomic context on PREEMPT_RT.  There is no need to look at
dev_data because guest_mode should never be set if use_vapic is
not set.

Signed-off-by: Scott Wood <swood-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
This is a followup to the patches below:

https://patchwork.codeaurora.org/patch/433611/
https://patchwork.codeaurora.org/patch/433613/

 drivers/iommu/amd_iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 84e99097dfe3..a933c26df652 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3861,10 +3861,8 @@ static void irte_ga_set_affinity(void *entry, u16 devid, u16 index,
 				 u8 vector, u32 dest_apicid)
 {
 	struct irte_ga *irte = (struct irte_ga *) entry;
-	struct iommu_dev_data *dev_data = search_dev_data(devid);
 
-	if (!dev_data || !dev_data->use_vapic ||
-	    !irte->lo.fields_remap.guest_mode) {
+	if (!irte->lo.fields_remap.guest_mode) {
 		irte->hi.fields.vector = vector;
 		irte->lo.fields_remap.destination = dest_apicid;
 		modify_irte_ga(devid, index, irte, NULL);
-- 
1.8.3.1
