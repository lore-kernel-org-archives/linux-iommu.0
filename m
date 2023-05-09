Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB461990A
	for <iommu@lists.linux.dev>; Tue,  9 May 2023 21:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D5FC433EF;
	Tue,  9 May 2023 21:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683667237;
	bh=xRTjQfqCTQ45bcfNUtsVmgmumXhyrWlLlbjbfwfrJv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+JZQic+huFN67/VPpHCUNhPnEs9ohshrx/5fR1xitkONqvhqwhlnLQWxX0jOMyNF
	 EKYUmTppakO9GQkGSk1ymqYFyCjeyAR9U3yEWh9Zae2gpQooazi1c4xS9uDeyDKU5P
	 OxLIi2ljLPJogg+NDoT91ndINm+4T8xELIEnKOxVSBhJveAwZkC7XVHCfPcN0H7Et4
	 c+NypoApuxM49xlrjcI21Ug8xYaiMaanW3TDvyX3tMl5E4HRF94LelWYVNClyqQdN7
	 /47Lz/Ri4npEc4AfA0WYmThptbAllIzYiHLhvN8TRivFQoiqPq2wfWLxI+Bl6uaiH0
	 uA6iC96Ykz0GA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomas Krcka <krckatom@amazon.de>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	joro@8bytes.org,
	baolu.lu@linux.intel.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	shameerali.kolothum.thodi@huawei.com,
	yangyicong@hisilicon.com,
	nicolinc@nvidia.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 10/13] iommu/arm-smmu-v3: Acknowledge pri/event queue overflow if any
Date: Tue,  9 May 2023 17:20:18 -0400
Message-Id: <20230509212023.22105-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509212023.22105-1-sashal@kernel.org>
References: <20230509212023.22105-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tomas Krcka <krckatom@amazon.de>

[ Upstream commit 67ea0b7ce41844eae7c10bb04dfe66a23318c224 ]

When an overflow occurs in the PRI queue, the SMMU toggles the overflow
flag in the PROD register. To exit the overflow condition, the PRI thread
is supposed to acknowledge it by toggling this flag in the CONS register.
Unacknowledged overflow causes the queue to stop adding anything new.

Currently, the priq thread always writes the CONS register back to the
SMMU after clearing the queue.

The writeback is not necessary if the OVFLG in the PROD register has not
been changed, no overflow has occured.

This commit checks the difference of the overflow flag between CONS and
PROD register. If it's different, toggles the OVACKFLG flag in the CONS
register and write it to the SMMU.

The situation is similar for the event queue.
The acknowledge register is also toggled after clearing the event
queue but never propagated to the hardware. This would only be done the
next time when executing evtq thread.

Unacknowledged event queue overflow doesn't affect the event
queue, because the SMMU still adds elements to that queue when the
overflow condition is active.
But it feel nicer to keep SMMU in sync when possible, so use the same
way here as well.

Signed-off-by: Tomas Krcka <krckatom@amazon.de>
Link: https://lore.kernel.org/r/20230329123420.34641-1-tomas.krcka@gmail.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e7da4a47ce52e..bcdb2cbdda971 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -154,6 +154,18 @@ static void queue_inc_cons(struct arm_smmu_ll_queue *q)
 	q->cons = Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
 }
 
+static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
+{
+	struct arm_smmu_ll_queue *llq = &q->llq;
+
+	if (likely(Q_OVF(llq->prod) == Q_OVF(llq->cons)))
+		return;
+
+	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
+		      Q_IDX(llq, llq->cons);
+	queue_sync_cons_out(q);
+}
+
 static int queue_sync_prod_in(struct arm_smmu_queue *q)
 {
 	u32 prod;
@@ -1564,8 +1576,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	} while (!queue_empty(llq));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
-		    Q_IDX(llq, llq->cons);
+	queue_sync_cons_ovf(q);
 	return IRQ_HANDLED;
 }
 
@@ -1623,9 +1634,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	} while (!queue_empty(llq));
 
 	/* Sync our overflow flag, as we believe we're up to speed */
-	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
-		      Q_IDX(llq, llq->cons);
-	queue_sync_cons_out(q);
+	queue_sync_cons_ovf(q);
 	return IRQ_HANDLED;
 }
 
-- 
2.39.2

