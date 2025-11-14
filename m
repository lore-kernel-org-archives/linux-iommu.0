Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3EE2D2489
	for <iommu@lists.linux.dev>; Fri, 14 Nov 2025 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140644; cv=none; b=G8OuXeCei3d7TAiKhCdqP2VYl8ELA/P9p6UjBbtVtnONFBxCdinT2rr8KWcIvAe8ng5BDGZiJusrRkVG6KpNJQZqymyIQ+TUo+gHPthttw3xhCwdf2I0dbNaRybp65UMbsesgHs8i9UG9O2rVK8BcydzP1RBSv/fnUaw1PSl8xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140644; c=relaxed/simple;
	bh=US9L1Trvmn0y+VvGXnKCRNDYcC9DuULSJtfAd/MuljA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NTHhojqRg/U9adpN5cv7NKCLP4wT5rMDRJi3swGSPuV7YpBsvVaNIDGiuudqvW+dZgyDyROUC0I9V9GeHYfpCA2b5x45jrK+ApADbSITtwvL/GkhKcBdXIt5rXNhehJsZq7UyXtuE+KpMy7KRAgRoVOsLPBho5uCI5MfdUqiOZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S8UabaxV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S8UabaxV"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id E0C3A201AE63;
	Fri, 14 Nov 2025 09:17:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0C3A201AE63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763140642;
	bh=RjcuJ/qP9GinAATaCyR9e9OAlSGZ4KstXw1n3mi6ex4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8UabaxVUGYyBcJCNVJ7vazZJPCqmtEru8Soh2Zw+p/c//PCufq3zZo2zQeGy6E4e
	 aOhZibHqQmfw8xdxjBi1WhzmhQfLakQ4Vi3LbnzPjxW7YD1fUhqRhRv6+w+IgiBEWO
	 FTHqC2eJoXBc2RyevzNsTUdFQmPcok0yvge4pQ7g=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: [PATCH v4 2/2] iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency
Date: Fri, 14 Nov 2025 09:17:18 -0800
Message-Id: <20251114171718.42215-3-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114171718.42215-1-jacob.pan@linux.microsoft.com>
References: <20251114171718.42215-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Grest <Alexander.Grest@microsoft.com>

The SMMU CMDQ lock is highly contentious when there are multiple CPUs
issuing commands and the queue is nearly full.

The lock has the following states:
 - 0:		Unlocked
 - >0:		Shared lock held with count
 - INT_MIN+N:	Exclusive lock held, where N is the # of shared waiters
 - INT_MIN:	Exclusive lock held, no shared waiters

When multiple CPUs are polling for space in the queue, they attempt to
grab the exclusive lock to update the cons pointer from the hardware. If
they fail to get the lock, they will spin until either the cons pointer
is updated by another CPU.

The current code allows the possibility of shared lock starvation
if there is a constant stream of CPUs trying to grab the exclusive lock.
This leads to severe latency issues and soft lockups.

Consider the following scenario where CPU1's attempt to acquire the
shared lock is starved by CPU2 and CPU0 contending for the exclusive
lock.

CPU0 (exclusive)  | CPU1 (shared)     | CPU2 (exclusive)    | `cmdq->lock`
--------------------------------------------------------------------------
trylock() //takes |                   |                     | 0
                  | shared_lock()     |                     | INT_MIN
                  | fetch_inc()       |                     | INT_MIN
                  | no return         |                     | INT_MIN + 1
                  | spins // VAL >= 0 |                     | INT_MIN + 1
unlock()          | spins...          |                     | INT_MIN + 1
set_release(0)    | spins...          |                     | 0 see[NOTE]
(done)            | (sees 0)          | trylock() // takes  | 0
                  | *exits loop*      | cmpxchg(0, INT_MIN) | 0
                  |                   | *cuts in*           | INT_MIN
                  | cmpxchg(0, 1)     |                     | INT_MIN
                  | fails // != 0     |                     | INT_MIN
                  | spins // VAL >= 0 |                     | INT_MIN
                  | *starved*         |                     | INT_MIN

[NOTE] The current code resets the exclusive lock to 0 regardless of the
state of the lock. This causes two problems:
1. It opens the possibility of back-to-back exclusive locks and the
   downstream effect of starving shared lock.
2. The count of shared lock waiters are lost.

To mitigate this, we release the exclusive lock by only clearing the sign
bit while retaining the shared lock waiter count as a way to avoid
starving the shared lock waiters.

Also deleted cmpxchg loop while trying to acquire the shared lock as it
is not needed. The waiters can see the positive lock count and proceed
immediately after the exclusive lock is released.

Exclusive lock is not starved in that submitters will try exclusive lock
first when new spaces become available.

Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Alexander Grest <Alexander.Grest@microsoft.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v4:	- No change
v3:
	- Add flow chart for example starvation case (Nicolin)
	  no code change.
v2:
	- Changed shared lock acquire condition from VAL>=0 to VAL>0
	  (Mostafa)
	- Added more comments to explain shared lock change (Nicolin)
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 ++++++++++++++-------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9824bd808725..0b62b3b0f994 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -481,20 +481,26 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
  */
 static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq)
 {
-	int val;
-
 	/*
-	 * We can try to avoid the cmpxchg() loop by simply incrementing the
-	 * lock counter. When held in exclusive state, the lock counter is set
-	 * to INT_MIN so these increments won't hurt as the value will remain
-	 * negative.
+	 * When held in exclusive state, the lock counter is set to INT_MIN
+	 * so these increments won't hurt as the value will remain negative.
+	 * The increment will also signal the exclusive locker that there are
+	 * shared waiters.
 	 */
 	if (atomic_fetch_inc_relaxed(&cmdq->lock) >= 0)
 		return;
 
-	do {
-		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);
-	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1) != val);
+	/*
+	 * Someone else is holding the lock in exclusive state, so wait
+	 * for them to finish. Since we already incremented the lock counter,
+	 * no exclusive lock can be acquired until we finish. We don't need
+	 * the return value since we only care that the exclusive lock is
+	 * released (i.e. the lock counter is non-negative).
+	 * Once the exclusive locker releases the lock, the sign bit will
+	 * be cleared and our increment will make the lock counter positive,
+	 * allowing us to proceed.
+	 */
+	atomic_cond_read_relaxed(&cmdq->lock, VAL > 0);
 }
 
 static void arm_smmu_cmdq_shared_unlock(struct arm_smmu_cmdq *cmdq)
@@ -521,9 +527,14 @@ static bool arm_smmu_cmdq_shared_tryunlock(struct arm_smmu_cmdq *cmdq)
 	__ret;								\
 })
 
+/*
+ * Only clear the sign bit when releasing the exclusive lock this will
+ * allow any shared_lock() waiters to proceed without the possibility
+ * of entering the exclusive lock in a tight loop.
+ */
 #define arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags)		\
 ({									\
-	atomic_set_release(&cmdq->lock, 0);				\
+	atomic_fetch_and_release(~INT_MIN, &cmdq->lock);		\
 	local_irq_restore(flags);					\
 })
 
-- 
2.43.0

