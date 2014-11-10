From: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] iommu/amd: fix accounting of device_state
Date: Mon, 10 Nov 2014 12:21:39 +0200
Message-ID: <1415614899-12602-1-git-send-email-oded.gabbay@amd.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch fixes a bug in the accounting of the device_state.
In the current code, the device_state was put (decremented) too many times,
which sometimes lead to the driver getting stuck permanently in
put_device_state_wait(). That happen because the device_state->count would go
below zero, which is never supposed to happen.

The root cause is that the device_state was decremented in put_pasid_state()
and put_pasid_state_wait() but also in all the functions that call those
functions. Therefore, the device_state was decremented twice in each of these
code paths.

The fix is to decouple the device_state accounting from the pasid_state
accounting - remove the call to put_device_state() from the
put_pasid_state() and the put_pasid_state_wait())

Signed-off-by: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 0d387db..7e0614b 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -272,10 +272,8 @@ static void free_pasid_state(struct pasid_state *pasid_state)
 
 static void put_pasid_state(struct pasid_state *pasid_state)
 {
-	if (atomic_dec_and_test(&pasid_state->count)) {
-		put_device_state(pasid_state->device_state);
+	if (atomic_dec_and_test(&pasid_state->count))
 		wake_up(&pasid_state->wq);
-	}
 }
 
 static void put_pasid_state_wait(struct pasid_state *pasid_state)
@@ -284,9 +282,7 @@ static void put_pasid_state_wait(struct pasid_state *pasid_state)
 
 	prepare_to_wait(&pasid_state->wq, &wait, TASK_UNINTERRUPTIBLE);
 
-	if (atomic_dec_and_test(&pasid_state->count))
-		put_device_state(pasid_state->device_state);
-	else
+	if (!atomic_dec_and_test(&pasid_state->count))
 		schedule();
 
 	finish_wait(&pasid_state->wq, &wait);
-- 
1.9.1
