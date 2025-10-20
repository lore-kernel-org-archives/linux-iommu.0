Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777662F3C04
	for <iommu@lists.linux.dev>; Mon, 20 Oct 2025 22:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761000238; cv=none; b=qUfD1ixZGWWsW/Rv3yow4aEWtiqUZEYnhs9uKYc4mStPPa9zRLBNI1WVpyqNBBZggvjepy1pXOlNfYsnyOkc7JHS5jAA9TpkILwcX78Uyakx1yn9fxAMHPXRLYKim14noP4Hk3cHmpwzXoL3ei9a5IKycdbXyd1Iw65b3sUeSac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761000238; c=relaxed/simple;
	bh=32XZ91vU9aHs6FzuV4F05AddOrn3ok96jr3nZdLHa+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WsgXj/5AqRsfrkWtpq0PiuUa+3/RuNJylVlnVRUqy/PJ3n4l9DE61qW533CAaA+d+zaAi3xQSfMx2PLGntyZA7Fb2b/8m4QCAmsBNiye90Sv0aSRcPAbl/gQhQWA4yBQh0jZnHmdSYFzDDgp2PKF6Z5p4gH8jCdSKizrAOrYPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ckb24Xyd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ckb24Xyd"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6A704201DAC4;
	Mon, 20 Oct 2025 15:43:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A704201DAC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761000236;
	bh=Ph3WtohmXgImXfa9CmzZxYK2qUGteeBrfoVhYg+75HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckb24XydlMf4jnD23uFGyHxjxRH1RCFALQfCrH2OwfvseJhjcw91QUNBToptMf2e+
	 dd+Zs0GcructXackizLXES44fEzmilZ0oo9SCd529EmqrCy5H0kLBZzGenZjZ4G6Ct
	 xQwbvOwQ5jgVH1WxnRHvKqhphcGdKM2PkKgukSM8=
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
Subject: [PATCH v2 1/2] iommu/arm-smmu-v3: Fix CMDQ timeout warning
Date: Mon, 20 Oct 2025 15:43:52 -0700
Message-Id: <20251020224353.1408-2-jacob.pan@linux.microsoft.com>
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
v2: - Reduced debug print info (Nicolin)
    - Use a separate irq flags for exclusive lock
    - Handle queue_poll err code other than ETIMEOUT
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 ++++++++-------------
 1 file changed, 26 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bf67d9abc901..6959d99c74a3 100644
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
@@ -612,38 +606,6 @@ static void arm_smmu_cmdq_poll_valid_map(struct arm_smmu_cmdq *cmdq,
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
@@ -775,6 +737,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	unsigned long flags;
 	bool owner;
 	struct arm_smmu_ll_queue llq, head;
+	struct arm_smmu_queue_poll qp;
 	int ret = 0;
 
 	llq.max_n_shift = cmdq->q.llq.max_n_shift;
@@ -785,10 +748,33 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	do {
 		u64 old;
 
+		queue_poll_init(smmu, &qp);
 		while (!queue_has_space(&llq, n + sync)) {
+			unsigned long iflags;
+
 			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, cmdq, &llq))
-				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
+			/*
+			 * Try to update our copy of cons by grabbing exclusive cmdq access. If
+			 * that fails, spin until somebody else updates it for us.
+			 */
+			if (arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, iflags)) {
+				WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));
+				arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, iflags);
+				llq.val = READ_ONCE(cmdq->q.llq.val);
+				local_irq_save(flags);
+				continue;
+			}
+
+			ret = queue_poll(&qp);
+			if (ret == -ETIMEDOUT) {
+				dev_err_ratelimited(smmu->dev, "CPU %d CMDQ Timeout, Cons: %08x, Prod: 0x%08x Lock 0x%x\n",
+						    smp_processor_id(), llq.cons, llq.prod, atomic_read(&cmdq->lock));
+				queue_poll_init(smmu, &qp);
+			} else if (ret) {
+				dev_err_ratelimited(smmu->dev, "CPU %d CMDQ Poll error %d\n",
+						    smp_processor_id(), ret);
+			}
+			llq.val = READ_ONCE(cmdq->q.llq.val);
 			local_irq_save(flags);
 		}
 
-- 
2.43.0

