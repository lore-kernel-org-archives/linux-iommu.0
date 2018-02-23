From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: [PATCH 03/10] iommu/amd: split domain id out of
	amd_iommu_devtable_lock
Date: Fri, 23 Feb 2018 23:27:29 +0100
Message-ID: <20180223222736.18542-4-bigeasy@linutronix.de>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180223222736.18542-1-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

domain_id_alloc() and domain_id_free() is used for id management. Those
two function share a bitmap (amd_iommu_pd_alloc_bitmap) and set/clear
bits based on id allocation. There is no need to share this with
amd_iommu_devtable_lock, it can use its own lock for this operation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 53aece41ddf2..958efe311057 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -81,6 +81,7 @@
 #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
 
 static DEFINE_RWLOCK(amd_iommu_devtable_lock);
+static DEFINE_SPINLOCK(pd_bitmap_lock);
 
 /* List of all available dev_data structures */
 static LLIST_HEAD(dev_data_list);
@@ -1599,29 +1600,26 @@ static void del_domain_from_list(struct protection_domain *domain)
 
 static u16 domain_id_alloc(void)
 {
-	unsigned long flags;
 	int id;
 
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock(&pd_bitmap_lock);
 	id = find_first_zero_bit(amd_iommu_pd_alloc_bitmap, MAX_DOMAIN_ID);
 	BUG_ON(id == 0);
 	if (id > 0 && id < MAX_DOMAIN_ID)
 		__set_bit(id, amd_iommu_pd_alloc_bitmap);
 	else
 		id = 0;
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock(&pd_bitmap_lock);
 
 	return id;
 }
 
 static void domain_id_free(int id)
 {
-	unsigned long flags;
-
-	write_lock_irqsave(&amd_iommu_devtable_lock, flags);
+	spin_lock(&pd_bitmap_lock);
 	if (id > 0 && id < MAX_DOMAIN_ID)
 		__clear_bit(id, amd_iommu_pd_alloc_bitmap);
-	write_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
+	spin_unlock(&pd_bitmap_lock);
 }
 
 #define DEFINE_FREE_PT_FN(LVL, FN)				\
-- 
2.16.1
