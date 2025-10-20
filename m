Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E83F2F3C26
	for <iommu@lists.linux.dev>; Mon, 20 Oct 2025 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761000239; cv=none; b=S8Fr9h1K7JAP+XHR8eUUk5wlpRxmrgsNwN4woO2Y9defySdZSG4pHKEyJiWXk3e371m/OF2wjko4+StMG44Huh3Na7LIMQhzY+9dTGMH4G83gEtMLqPW1nUMkm9a8xB8scSOwjhWeK9VetJrIr3vysRgc9NcNAxMgPTXmVue4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761000239; c=relaxed/simple;
	bh=+cbkIGf51wu+dKYaAbvM2BvLqB684l7hmHUlZdt7yPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUROmUmnpB5WVqgPzU1MbMWoAQWwkMIDQsRvt96b+MUXN3rLDqTzddDn6ux7ZwrOqg3vAHESP5POZr9ZSeVOc3eZWDaz7gqfcnABtEEN9TbRDPcbEuUkajeiX5lEtAE+79fzf5wCIv8/28PkyHhRCI8T5oW+P6Xo+d/aH9dDCbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZECwyy//; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZECwyy//"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B5BD201DAC2;
	Mon, 20 Oct 2025 15:43:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B5BD201DAC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761000237;
	bh=gqIaDRBc7A1MoNCB58t4c+4ECYr6ZJnpkTgiwo2Dv/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZECwyy//cK1BvEWFcJd7VU11EbY5v2cEiXuBmPZ6RNA/mbM/0iLK4BJ3k+h4iuEFK
	 Bfze1YLQbzTqwDTpIWSSAoHCaodSfdIDlV9LcR2dDNwlzOONrs8xo6A8XzIYf3+Lrb
	 BhU0VMW8cRfCfAvUEWZ4BX9D67q8gB8Lbmgrnk1I=
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
Subject: [PATCH v2 2/2] iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency
Date: Mon, 20 Oct 2025 15:43:53 -0700
Message-Id: <20251020224353.1408-3-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020224353.1408-1-jacob.pan@linux.microsoft.com>
References: <20251020224353.1408-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Grest <Alexander.Grest@microsoft.com>

The SMMU CMDQ lock is highly contentious when there are multiple CPUs
issuing commands on an architecture with small queue sizes e.g 256
entries.

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

To mitigate this, we release the exclusive lock by only clearing the sign
bit while retaining the shared lock waiter count as a way to avoid
starving the shared lock waiters.

Also deleted cmpxchg loop while trying to acquire the shared lock as it
is not needed. The waiters can see the positive lock count and proceed
immediately after the exclusive lock is released.

Exclusive lock is not starved in that submitters will try exclusive lock
first when new spaces become available.

In a staged test where 32 CPUs issue SVA invalidations simultaneously on
a system with a 256 entry queue, the madvise (MADV_DONTNEED) latency
dropped by 50% with this patch and without soft lockups.

Reviewed-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Alexander Grest <Alexander.Grest@microsoft.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v2:
	- Changed shared lock acquire condition from VAL>=0 to VAL>0
	  (Mostafa)
	- Added more comments to explain shared lock change (Nicolin)
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 ++++++++++++++-------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6959d99c74a3..9e632bb022fe 100644
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
+	atomic_fetch_and_release(~INT_MIN, &cmdq->lock);				\
 	local_irq_restore(flags);					\
 })
 
-- 
2.43.0

