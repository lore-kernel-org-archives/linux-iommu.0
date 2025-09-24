Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEDA315D5F
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736489; cv=none; b=V132fsUEGNvOOrYIL6Aj4kVp/QWdx8i4+jShay51s+e8x2MvGA5KfmXb2DzaEbDLMcU0qqK68WPXiq9L7c2JEdd+GbpLVCvo3TJ/Is+REuJKqtLPlyGDUaT2coGmj1ThC7Tr+b5NHseuVTU2H+tCwSp9m8/fgyFLij+/0GkLhTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736489; c=relaxed/simple;
	bh=j1nqorovabHpPBeidLxWfAUdqw9bBAsSZQNFfq22sFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nvDfsGQCYAdmJQ7JgN1kYy2VGcotQNE7zChkIDCpgfU1SmNRF9YX3o1+KbrWdGJHxh4ht+469Fr/Xxb2dMJSzCfH8Xit0CEKTHUX7LDXxPtwCVlY9if3ZoMCAD6l8FNTBwdwTwLR76cPbHgTgleodQX/eXZ9dD7Xos2RV2hfqPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=soH7ToqA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="soH7ToqA"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id B60D4201C965;
	Wed, 24 Sep 2025 10:54:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B60D4201C965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758736482;
	bh=EJY0Jw5zCxz3ZhWCH5fZfNvFWLeuk339Ye6YtAA9a7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=soH7ToqAmMiCzqxymla9oXpKg8DrX1nyjOTfrOQgt6ZYFT5/zc40UXTFY2LOSXb27
	 1iYZN87Tt7CYWkP/3Vkw5FnEg63TIfb9ydSzVNykc8RPvDDHjKLOhGZ5t5R/Eajlcp
	 rRtqNjgXJ60pxViNAIQTtk7MQPzZEAZc55DxwwvI=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Alexander Grest <Alexander.Grest@microsoft.com>
Subject: [PATCH 2/2] iommu/arm-smmu-v3: Improve CMDQ lock fairness and efficiency
Date: Wed, 24 Sep 2025 10:54:38 -0700
Message-Id: <20250924175438.7450-3-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
References: <20250924175438.7450-1-jacob.pan@linux.microsoft.com>
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

Signed-off-by: Alexander Grest <Alexander.Grest@microsoft.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 ++++++++++++---------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b63525c13bb..9b7c01b731df 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -481,20 +481,19 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
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
+	 * We can simply increment the lock counter. When held in exclusive
+	 * state, the lock counter is set to INT_MIN so these increments won't
+	 * hurt as the value will remain negative. This will also signal the
+	 * exclusive locker that there are shared waiters. Once the exclusive
+	 * locker releases the lock, the sign bit will be cleared and our
+	 * increment will make the lock counter positive, allowing us to
+	 * proceed.
 	 */
 	if (atomic_fetch_inc_relaxed(&cmdq->lock) >= 0)
 		return;
 
-	do {
-		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);
-	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1) != val);
+	atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);
 }
 
 static void arm_smmu_cmdq_shared_unlock(struct arm_smmu_cmdq *cmdq)
@@ -521,9 +520,14 @@ static bool arm_smmu_cmdq_shared_tryunlock(struct arm_smmu_cmdq *cmdq)
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

