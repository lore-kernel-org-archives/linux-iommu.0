Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082C82D239B
	for <iommu@lists.linux.dev>; Fri, 14 Nov 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763140643; cv=none; b=VVV57k97uTwX3UhFMb/rx2e9LqAlxNEZcgZd0dulxnB3jwjf8TmuxNgTQQ7JDoWZHiY4NLeWnPsHaBYfqCFSWowYd80XZgHCPU4RzWY5PaRK7XdHhYgG+EiacG2rISzUwHK2M5buxmztc1lG1WJeIKJ2ybVz199Ue+mnZLAYq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763140643; c=relaxed/simple;
	bh=Cn6xB+0nQ4urCZjpRXGTw1YGizhG3cL0bkrGJiqNrtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GKBYAyOsW4YqamvDCwJ1d8SSI20EzIHOilZpvc+/l+8/Lm0y8POTJPxAR+OUF4/a9SwOZvhjd/zrmDjN7AMGRV6i50TuvvEf2uQG7rjf5BMDOpBFoM72iVeVz949yRIFhh/ztGBV4HUa0yfnByXMXl9tnp2RmHXIViDzi1NyeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i96syUEQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i96syUEQ"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1895B201AE60;
	Fri, 14 Nov 2025 09:17:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1895B201AE60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763140641;
	bh=aBS8lir+cm3VLOVniGaHCf962by4RKCDTX/+9GOLH4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i96syUEQA3LhCM3c0DBOhX+IEJC8cb4so4taKwTsg0itsG5OZHsFqdBaUV59+WVpi
	 5dEA0FgPPr0V9O3JEySnxgol/K27mN8mlIMFufTs2YygsmIYOuMzlol/KTgi2/TBmL
	 E/X694JcpLzYdMKngeEgTwcGeH77vP1k6V3FkF7s=
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
Subject: [PATCH v4 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Date: Fri, 14 Nov 2025 09:17:17 -0800
Message-Id: <20251114171718.42215-2-jacob.pan@linux.microsoft.com>
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
Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v4:
    - Deleted non-ETIMEOUT error handling for queue_poll (Nicolin)
v3:
    - Use a helper for cmdq poll instead of open coding (Nicolin)
    - Add more explanation in the commit message (Nicolin)
v2: - Reduced debug print info (Nicolin)
    - Use a separate irq flags for exclusive lock
    - Handle queue_poll err code other than ETIMEOUT
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 ++++++++-------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a8b46b948f0..9824bd808725 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -138,12 +138,6 @@ static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
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
@@ -633,14 +627,13 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
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
@@ -650,19 +643,16 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
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
+		queue_poll_init(smmu, qp);
+	}
+	llq->val = READ_ONCE(cmdq->q.llq.val);
 }
 
 /*
@@ -804,12 +794,13 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	local_irq_save(flags);
 	llq.val = READ_ONCE(cmdq->q.llq.val);
 	do {
+		struct arm_smmu_queue_poll qp;
 		u64 old;
 
+		queue_poll_init(smmu, &qp);
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
-				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
+			arm_smmu_cmdq_poll(smmu, cmdq, &llq, &qp);
 			local_irq_save(flags);
 		}
 
-- 
2.43.0

