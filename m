From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2] iommu/amd: Use wait_event in put_pasid_state_wait
Date: Thu, 5 Feb 2015 12:40:20 +0100
Message-ID: <20150205114020.GQ3702@8bytes.org>
References: <1423062622-28257-1-git-send-email-joro@8bytes.org>
 <20150204163450.GD5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150204163450.GD5029@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: iommu@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-aio@kvack.org, linux-kernel@vger.kernel.org, Oded Gabbay <oded.gabbay@amd.com>, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 04, 2015 at 05:34:50PM +0100, Peter Zijlstra wrote:
> You just lost your atomic_dec.

So this should be the correct version then.

>From 2a52250e542d8964c8285a37b71fe838a44c05c4 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Wed, 4 Feb 2015 15:50:38 +0100
Subject: [PATCH 1/2] iommu/amd: Use wait_event in put_pasid_state_wait

Now that I learned about possible spurious wakeups this
place needs fixing too. Replace the self-coded sleep variant
with the generic wait_event() helper.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu_v2.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index b6398d7..e01bc8f 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -266,14 +266,13 @@ static void put_pasid_state(struct pasid_state *pasid_state)
 
 static void put_pasid_state_wait(struct pasid_state *pasid_state)
 {
-	DEFINE_WAIT(wait);
+	/* Drop our reference */
+	atomic_dec(&pasid_state->count);
 
-	prepare_to_wait(&pasid_state->wq, &wait, TASK_UNINTERRUPTIBLE);
+	/* Wait for others to drop their references */
+	wait_event(pasid_state->wq, !atomic_read(&pasid_state->count));
 
-	if (!atomic_dec_and_test(&pasid_state->count))
-		schedule();
-
-	finish_wait(&pasid_state->wq, &wait);
+	/* Get rid of it */
 	free_pasid_state(pasid_state);
 }
 
-- 
1.8.4.5
