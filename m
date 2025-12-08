Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F122E11B8
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765229343; cv=none; b=aucHVqfzhSQejtZq/5xDElG42JDpEF/zllxBJBXC6dAJAfhPgPL29MlE42k/ARrUlcDJcZXo3/P2BiI+EIHxy/81H6qs4zDEoHNS5iHu0EQuyAjUYABr+CJK+BzhntNqMs117FDKf1pEtfnrxkF8NponQWY3wpIwJGOBcvFUKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765229343; c=relaxed/simple;
	bh=9Q/YXXzo+fARqttWsIyWO5kdPW4BaLOpYjoDDKMwiHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UBCF3R/7cqR5xE1pbeqdnqaZFgHJgI/FcOwicrO56M1LFls1IwoFWYsBD15t6mIVofG+z/IVJnTLfkXJE39FugxPFl72fpqsxJBnmGr9aKr2E1wnf97NT7s+8+XZ2YTWpnhyURn4wZ8B0dspi9aHynxPvvhvwNIoh9wWAi6r9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OEW/l5L7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OEW/l5L7"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id DD34F2116046;
	Mon,  8 Dec 2025 13:29:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD34F2116046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765229341;
	bh=N7FxBVGBVqKWTD8zmsFUGkccl1/W4n7C/RIF3Ti30jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OEW/l5L7XegnTuBNmOP8tU8abLSIW2zzln5BIjVaJIh19I9pptvg3nh9s2kaGYLai
	 kgNFP2KexTD5/oiMaN/wk52XoHgzLI3BwYvNIdZi4gA7uniHezVi2pizC3QCozWLeK
	 8YFdCrIjNp03oo877KIjND3EvyEAVgCXiQj+gpvY=
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
Subject: [PATCH v5 3/3] iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency
Date: Mon,  8 Dec 2025 13:28:57 -0800
Message-Id: <20251208212857.13101-4-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251208212857.13101-1-jacob.pan@linux.microsoft.com>
References: <20251208212857.13101-1-jacob.pan@linux.microsoft.com>
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
v5:	- Simplify exclusive lock with atomic_fetch_andnot_release (Will)
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
index 3467c10be0d0..7a53177885d7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -460,20 +460,26 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
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
@@ -500,9 +506,14 @@ static bool arm_smmu_cmdq_shared_tryunlock(struct arm_smmu_cmdq *cmdq)
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
+	atomic_fetch_andnot_release(INT_MIN, &cmdq->lock);		\
 	local_irq_restore(flags);					\
 })
 
-- 
2.43.0

