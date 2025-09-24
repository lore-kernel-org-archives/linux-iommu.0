Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271D7315D51
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736488; cv=none; b=g54oRNb7y1VMfyd2Ui7l+9GgDBE90kIDwNe/xfNJ7vn3w8SaJ4pAZ+2DHY9/eOyu30O7CkEdT9uYsnLHorARJkwtImZNsM/9yqePhlNxFcqOIyw4+jVIaPBb1YDQKO4dsbt61ebftXKmOQEU5+D6x/Ok5tddhDjoe2hXdAPpEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736488; c=relaxed/simple;
	bh=YLXso90tsRdDwDwuJ6sh7EPqPtwYLmy7ZdtaYRJfqOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=alTg1kpp02Uko6QohgPmVbld174pUCPzq4AsnRtcDKB78AAJpdVFqQAQKrM1EUBQ4g8v4tQa3BrtSqLZj3Jtz65kZF7w5GczfC+t6sUUOY5AnG036XYPEfLV/fQBme78JvxJbBXFBCTiSGKWBz/MDpJPf1tLFPC+dJSWqAo4Vdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xkzm3L4H; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xkzm3L4H"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id E2368201C966;
	Wed, 24 Sep 2025 10:54:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E2368201C966
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758736481;
	bh=qTz+oGzflPsGNRI6WDrzjyCF8oZe6PRRTzU8HnXOBPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xkzm3L4Hnm2EHHHOcocnbwLVA7ZOqsowSuSWigFRU9DSsjw8ZlbUK6uFmNb13Qsba
	 kS9yzHVGQgnmE2ftjVfn+dRDKKc2CMOnzpkn4SCsz9N8muCDf1BI9R4Ek8C9b+1uTe
	 sGgwWrsIfB+pmhlgpFSARJeJ+IPkD5wQw2Q/jHrQ=
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
Subject: [PATCH 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Date: Wed, 24 Sep 2025 10:54:37 -0700
Message-Id: <20250924175438.7450-2-jacob.pan@linux.microsoft.com>
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

While polling for n spaces in the cmdq, the current code instead checks
if the queue is full. If the queue is almost full but not enough space
(<n), then the CMDQ timeout warning is never triggered even if the
polling has exceeded timeout limit.

This patch polls for the availability of exact space instead of full and
emit timeout warning accordingly.

Fixes: 587e6c10a7ce ("iommu/arm-smmu-v3: Reduce contention during command-queue insertion")
Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 61 +++++++--------------
 1 file changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a8b46b948f0..9b63525c13bb 100644
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
@@ -633,38 +627,6 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
 	__arm_smmu_cmdq_poll_set_valid_map(cmdq, sprod, eprod, false);
 }
 
-/* Wait for the command queue to become non-full */
-static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
-					     struct arm_smmu_cmdq *cmdq,
-					     struct arm_smmu_ll_queue *llq)
-{
-	unsigned long flags;
-	struct arm_smmu_queue_poll qp;
-	int ret = 0;
-
-	/*
-	 * Try to update our copy of cons by grabbing exclusive cmdq access. If
-	 * that fails, spin until somebody else updates it for us.
-	 */
-	if (arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, flags)) {
-		WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));
-		arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
-		llq->val = READ_ONCE(cmdq->q.llq.val);
-		return 0;
-	}
-
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
-}
-
 /*
  * Wait until the SMMU signals a CMD_SYNC completion MSI.
  * Must be called with the cmdq lock held in some capacity.
@@ -796,6 +758,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	unsigned long flags;
 	bool owner;
 	struct arm_smmu_ll_queue llq, head;
+	struct arm_smmu_queue_poll qp;
 	int ret = 0;
 
 	llq.max_n_shift = cmdq->q.llq.max_n_shift;
@@ -806,10 +769,28 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	do {
 		u64 old;
 
+		queue_poll_init(smmu, &qp);
 		while (!queue_has_space(&llq, n + sync)) {
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
-				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
+			/*
+			 * Try to update our copy of cons by grabbing exclusive cmdq access. If
+			 * that fails, spin until somebody else updates it for us.
+			 */
+			if (arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, flags)) {
+				WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));
+				arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
+				llq.val = READ_ONCE(cmdq->q.llq.val);
+				local_irq_save(flags);
+				continue;
+			}
+
+			ret = queue_poll(&qp);
+			if (ret == -ETIMEDOUT) {
+				dev_err_ratelimited(smmu->dev, "CPU %d CMDQ Timeout, C: %08x, CW:%x P: 0x%08x PW: %x cmdq.lock 0x%x\n",
+						    smp_processor_id(), Q_IDX(&llq, llq.cons), Q_WRP(&llq, llq.cons), Q_IDX(&llq, llq.prod), Q_WRP(&llq, llq.prod), atomic_read(&cmdq->lock));
+				queue_poll_init(smmu, &qp);
+			}
+			llq.val = READ_ONCE(cmdq->q.llq.val);
 			local_irq_save(flags);
 		}
 
-- 
2.43.0

