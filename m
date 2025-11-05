Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D70C31D371
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369604; cv=none; b=nmCbbICHwqbIjA8/hy+pY64fGkTfhNm0b81gBboRID7e+Gsjp2oFZd/BvTRAnSU3+hDPz33kWLgPlrQbikieqvskfDTzRP+ajFvU1w3FoTFlYNEdqBp/hfJUAsWhJ0jyyWg/1Gw49DB18ON78bzITJxD7M+iOY4faJv7UbpgT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369604; c=relaxed/simple;
	bh=RYe/If3PsHwZz/rCLCuzwgwWY7iLmzRWSdIDURVa7A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z/3WvhtEaQLXuMDO6zzeghEtiCAWrmZAYtY8AcAjLxgVfX1nhDTUq9oHuqdtXE2WjnwjM9bOTfnGU/KkxnfradAsXaZQ88MTZqoKQb4SmjWo6+RjLO+kN4h3P3p9+1RvP9BusnPvaJVp3Qn8Nd718YuXIPTo2sfFK0eEsQ7trE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QQtE0+9W; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QQtE0+9W"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0AA3C211E327;
	Wed,  5 Nov 2025 11:06:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0AA3C211E327
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762369602;
	bh=EFJ4UdqVGukQrPXaao8kzmaswKZEei/7I1BdA506Z2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQtE0+9W4fJq2vYBUgq6ZZFjrdFkBx/7x0Gb9Rq+oOLnDfDU8UYQt5FmVkMOnosPh
	 Fip0Jd2ML7UQowF5GNbe0XZ/IJUeaD5vDyjoDa5LySJcs2WPoS9o/Wey/DoSeTlpuZ
	 0AUecMQsfRzhmqo5RqupKXx8N/LHOqg1wbyPPGPg=
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
Subject: [PATCH v3 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Date: Wed,  5 Nov 2025 11:06:37 -0800
Message-Id: <20251105190638.23172-2-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105190638.23172-1-jacob.pan@linux.microsoft.com>
References: <20251105190638.23172-1-jacob.pan@linux.microsoft.com>
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
v3:
    - Use a helper for cmdq poll instead of open coding (Nicolin)
    - Add more explanation in the commit message (Nicolin)
v2: - Reduced debug print info (Nicolin)
    - Use a separate irq flags for exclusive lock
    - Handle queue_poll err code other than ETIMEOUT
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 43 +++++++++------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bf67d9abc901..86be84c14036 100644
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
@@ -612,13 +606,13 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
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
 	int ret = 0;
 
 	/*
@@ -629,19 +623,19 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
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
+	ret = queue_poll(qp);
+	if (ret == -ETIMEDOUT) {
+		dev_err_ratelimited(smmu->dev, "CMDQ timed out, cons: %08x, prod: 0x%08x\n",
+				    llq->cons, llq->prod);
+		/* Restart the timer */
+		queue_poll_init(smmu, qp);
+	} else if (ret) {
+		dev_err_ratelimited(smmu->dev, "CMDQ poll error %d\n", ret);
+	}
+	llq->val = READ_ONCE(cmdq->q.llq.val);
 }
 
 /*
@@ -783,12 +777,13 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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

