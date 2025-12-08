Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7992E0402
	for <iommu@lists.linux.dev>; Mon,  8 Dec 2025 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765229342; cv=none; b=WqFDCzBegRvAn7r3w5VtNezlfvbNbEPPO4UpLdhFNbjHm0ZC6PQUh2ULHmt0owyJUJfZoHkKbYVcRA34kDf8Ouf+JxJ5CFMfALJLFbgc/ersWxvT5f0DNQJQlFHPSu3KuqTSG+futKXMJPDPBHdS7BCDLCYMbZzSg3W7aLV6f7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765229342; c=relaxed/simple;
	bh=jkLNDnkRaXqCwYooZ/ixh1iiVmjDcuyCf79AWlzVh04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bd1Gx/2A0uqHzCUuZFJ7s0ECNFTXUzJM8fSRVTX+ilT4DYSePEPyqdUH9tpSES91chTF6sPa4TVE4pnr3SFxe7z/r6xAj8SyHaCvtYyqn29sCkNZhvoRmX0GzSBU2YpYdrrl6xPuZ7fWxE6/VxP3xEYSB6RlagxzQ63vPYRRIvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KQP6nBzI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KQP6nBzI"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 02F502116043;
	Mon,  8 Dec 2025 13:28:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 02F502116043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765229340;
	bh=7mposCvgLsIXBQqq0/lL5X38LxRY9SCNj57FNM4//FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQP6nBzIK5rG+it4en5g69++E2gXWh5BmQdGN6mIDE1uLsMENRpJJZEcN9mdJPN2A
	 FDMH9qdF5ytxqQWRNF2VWdTBifd0HJuIi+LVyjmOTtGt45Zq2v5chVFUK4zxWhcp/4
	 a2LMTJMh2AHXKvLtkZy7E3OgupdBBOXlUvallZfY=
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
Subject: [PATCH v5 2/3] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Date: Mon,  8 Dec 2025 13:28:56 -0800
Message-Id: <20251208212857.13101-3-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251208212857.13101-1-jacob.pan@linux.microsoft.com>
References: <20251208212857.13101-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While polling for n spaces in the cmdq, the current code instead checks
if the queue is full. If the queue is almost full but not enough space
(<n), then the CMDQ timeout warning is never triggered even if the
polling has exceeded timeout limit.

The existing arm_smmu_cmdq_poll_until_not_full() doesn't fit efficiently
nor ideally to the only caller arm_smmu_cmdq_issue_cmdlist():
 - It uses a new timer at every single call, which fails to limit to the
   preset ARM_SMMU_POLL_TIMEOUT_US per issue.
- It has a redundant internal queue_full(), which doesn't detect whether
   there is a enough space for number of n commands.

This patch polls for the availability of exact space instead of full and
emit timeout warning accordingly.

Fixes: 587e6c10a7ce ("iommu/arm-smmu-v3: Reduce contention during command-queue insertion")
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v5:
    - Disable WFE for queue space polling (Robin, Will)
v4:
    - Deleted non-ETIMEOUT error handling for queue_poll (Nicolin)
v3:
    - Use a helper for cmdq poll instead of open coding (Nicolin)
    - Add more explanation in the commit message (Nicolin)
v2: - Reduced debug print info (Nicolin)
    - Use a separate irq flags for exclusive lock
    - Handle queue_poll err code other than ETIMEOUT
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 49 ++++++++++-----------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d637a5dcf48a..3467c10be0d0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -117,12 +117,6 @@ static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
 	return space >= n;
 }
 
-static bool queue_full(struct arm_smmu_ll_queue *q)
-{
-	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
-	       Q_WRP(q, q->prod) != Q_WRP(q, q->cons);
-}
-
 static bool queue_empty(struct arm_smmu_ll_queue *q)
 {
 	return Q_IDX(q, q->prod) == Q_IDX(q, q->cons) &&
@@ -612,14 +606,13 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
 	__arm_smmu_cmdq_poll_set_valid_map(cmdq, sprod, eprod, false);
 }
 
-/* Wait for the command queue to become non-full */
-static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
-					     struct arm_smmu_cmdq *cmdq,
-					     struct arm_smmu_ll_queue *llq)
+
+static inline void arm_smmu_cmdq_poll(struct arm_smmu_device *smmu,
+				       struct arm_smmu_cmdq *cmdq,
+				       struct arm_smmu_ll_queue *llq,
+				       struct arm_smmu_queue_poll *qp)
 {
 	unsigned long flags;
-	struct arm_smmu_queue_poll qp;
-	int ret = 0;
 
 	/*
 	 * Try to update our copy of cons by grabbing exclusive cmdq access. If
@@ -629,19 +622,16 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
 		WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));
 		arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
 		llq->val = READ_ONCE(cmdq->q.llq.val);
-		return 0;
+		return;
 	}
 
-	queue_poll_init(smmu, &qp);
-	do {
-		llq->val = READ_ONCE(cmdq->q.llq.val);
-		if (!queue_full(llq))
-			break;
-
-		ret = queue_poll(&qp);
-	} while (!ret);
-
-	return ret;
+	if (queue_poll(qp) == -ETIMEDOUT) {
+		dev_err_ratelimited(smmu->dev, "CMDQ timed out, cons: %08x, prod: 0x%08x\n",
+				    llq->cons, llq->prod);
+		/* Restart the timer */
+		queue_poll_init(smmu, qp, false);
+	}
+	llq->val = READ_ONCE(cmdq->q.llq.val);
 }
 
 /*
@@ -781,12 +771,21 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	local_irq_save(flags);
 	llq.val = READ_ONCE(cmdq->q.llq.val);
 	do {
+		struct arm_smmu_queue_poll qp;
 		u64 old;
 
+		/*
+		 * Poll without WFE because:
+		 * 1) Running out of space should be rare. Power saving is not
+		 *    an issue.
+		 * 2) WFE depends on queue full break events, which occur only
+		 *    when the queue is full, but here we’re polling for
+		 *    sufficient space, not just queue full condition.
+		 */
+		queue_poll_init(smmu, &qp, false);
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
-				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
+			arm_smmu_cmdq_poll(smmu, cmdq, &llq, &qp);
 			local_irq_save(flags);
 		}
 
-- 
2.43.0

