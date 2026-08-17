Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FEE3B6C0C
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976917; cv=none; b=Z/OzoQvfT6oRtp05MuyK5mSeDPBIZnpSHDgjvPLv9PRA/WJ+UvtGCO1icq+MguEMU74sWKePaU35vx/wrAfj/fc/3bd/JNzzmgVMlq/yhtp9r7OpbMSaJvqXeNJhEyB3/9AyhglY62DqxMF/CJVWlhUxGMQ8TZlFYVcQxK+NMso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976917; c=relaxed/simple;
	bh=Jtvo19rIBm9yNZwd+I4NM0mPW5LObGvu96WwM6ZZW78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M1C/IxTFE1Du93K4O/KZ7bfO9yhplLWNCznMTukoQnN1M9LbeUpWHJDPh0WAkF2btk1M6ndnkeu7yeH7UY/zt2XNh97vakKM/Lq9Jdrswfqi81yiVL+WQU3fqBSECYrrpfk+4Z7TPOIE5IJJbL5fbUaLTifhGdfqOru6+Jko1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IHiFtKA8; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IHiFtKA8"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786976906; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aP1uKS6O6CEvKFWqd9T2SU+tlBniH5mDxsxhyUw4zbc=;
	b=IHiFtKA8w6olpkVM0qdBRA+R7SpdDVodjx++F3+xzfKgd5j51fk+nU97qrxR8ZYhtjdBRX7BY2N3T7AhYB9cgHbv92STAdT3odVxLgjI2/b0ZIjQcNrIfmCzuBcCK2MKQxiQzBtWY/finM/hzeKW0wjPmWhbd3PO0h2PxPTbMtI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X9A9H-t_1786976903;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9A9H-t_1786976903 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Aug 2026 22:28:24 +0800
From: fangyu.yu@linux.alibaba.com
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	baolu.lu@linux.intel.com,
	jroedel@suse.de,
	zong.li@sifive.com
Cc: fangyu.yu@linux.alibaba.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 2/3] iommu/riscv: Serialize command queue publishing
Date: Mon, 17 Aug 2026 22:27:27 +0800
Message-Id: <20260817142728.61783-3-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260817142728.61783-1-fangyu.yu@linux.alibaba.com>
References: <20260817142728.61783-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Serialize command queue publishing so software producer state advances only
after a command is written and the hardware tail is updated. Wait for
hardware consumption outside the queue lock when the command queue is full
so other CPUs are not blocked behind a long poll.

Fixes: 856c0cfe5c5f ("iommu/riscv: Command and fault queue support")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c | 104 +++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 2c0dcc90cf85..86cec408be5b 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -382,77 +382,97 @@ static int riscv_iommu_queue_wait(struct riscv_iommu_queue *queue,
 				 (int)(cons - index) > 0, 0, timeout_us);
 }
 
-/* Enqueue an entry and wait to be processed if timeout_us > 0
- *
- * Error handling for IOMMU hardware not responding in reasonable time
- * will be added as separate patch series along with other RAS features.
- * For now, only report hardware failure and continue.
- */
+static int riscv_iommu_queue_wait_for_space(struct riscv_iommu_queue *queue,
+						   unsigned int last)
+{
+	unsigned int head;
+	unsigned int tail;
+	unsigned int hw_head;
+	unsigned long flags;
+	int ret;
+
+	ret = riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue), hw_head,
+					      !(hw_head & ~queue->mask) && hw_head != last,
+					      0, RISCV_IOMMU_QUEUE_TIMEOUT);
+	if (ret)
+		return ret;
+
+	raw_spin_lock_irqsave(&queue->lock, flags);
+	head = atomic_read(&queue->head);
+	tail = atomic_read(&queue->tail);
+	if ((tail - head) >= queue->mask) {
+		last = Q_ITEM(queue, head);
+		/*
+		 * Re-read hw_head under the lock so that it is consistent with
+		 * the freshly computed 'last'.  Using the pre-lock snapshot
+		 * could produce a stale value that wraps around relative to the
+		 * new 'last', advancing the shadow head past entries that have
+		 * not yet been consumed by the hardware.
+		 */
+		hw_head = riscv_iommu_readl(queue->iommu, Q_HEAD(queue));
+		if (!(hw_head & ~queue->mask) && hw_head != last)
+			atomic_add((hw_head - last) & queue->mask, &queue->head);
+	}
+	raw_spin_unlock_irqrestore(&queue->lock, flags);
+
+	return 0;
+}
+
+/* Enqueue an entry and publish it to the hardware queue. */
 static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
 					   void *entry, size_t entry_size)
 {
 	unsigned int prod;
 	unsigned int head;
-	unsigned int tail;
 	unsigned long flags;
+	int ret;
 
-	/* Do not preempt submission flow. */
-	local_irq_save(flags);
+	/* 1. Wait for space availability and reserve the next slot. */
+	for (;;) {
+		raw_spin_lock_irqsave(&queue->lock, flags);
 
-	/* 1. Allocate some space in the queue */
-	prod = atomic_inc_return(&queue->prod) - 1;
-	head = atomic_read(&queue->head);
+		prod = atomic_read(&queue->tail);
+		head = atomic_read(&queue->head);
 
-	/* 2. Wait for space availability. */
-	if ((prod - head) > queue->mask) {
-		if (readx_poll_timeout(atomic_read, &queue->head,
-				       head, (prod - head) < queue->mask,
-				       0, RISCV_IOMMU_QUEUE_TIMEOUT))
-			goto err_busy;
-	} else if ((prod - head) == queue->mask) {
-		const unsigned int last = Q_ITEM(queue, head);
+		if ((prod - head) < queue->mask)
+			break;
+
+		head = Q_ITEM(queue, head);
+		raw_spin_unlock_irqrestore(&queue->lock, flags);
 
-		if (riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue), head,
-					      !(head & ~queue->mask) && head != last,
-					      0, RISCV_IOMMU_QUEUE_TIMEOUT))
+		ret = riscv_iommu_queue_wait_for_space(queue, head);
+		if (ret) {
+			raw_spin_lock_irqsave(&queue->lock, flags);
+			prod = atomic_read(&queue->tail);
 			goto err_busy;
-		atomic_add((head - last) & queue->mask, &queue->head);
+		}
 	}
 
-	/* 3. Store entry in the ring buffer */
+	/* 2. Store entry in the ring buffer. */
 	memcpy(queue->base + Q_ITEM(queue, prod) * entry_size, entry, entry_size);
 
-	/* 4. Wait for all previous entries to be ready */
-	if (readx_poll_timeout(atomic_read, &queue->tail, tail, prod == tail,
-			       0, RISCV_IOMMU_QUEUE_TIMEOUT))
-		goto err_busy;
-
-	/*
-	 * 5. Make sure the ring buffer update (whether in normal or I/O memory) is
-	 *    completed and visible before signaling the tail doorbell to fetch
-	 *    the next command. 'fence ow, ow'
-	 */
+	/* 3. Make sure the entry is visible before updating the queue tail. */
 	dma_wmb();
 	riscv_iommu_writel(queue->iommu, Q_TAIL(queue), Q_ITEM(queue, prod + 1));
 
 	/*
-	 * 6. Make sure the doorbell write to the device has finished before updating
-	 *    the shadow tail index in normal memory. 'fence o, w'
+	 * 4. Make sure the doorbell write to the device has finished before
+	 *    updating the shadow tail index in normal memory. 'fence o, w'
 	 */
 #ifdef CONFIG_MMIOWB
 	mmiowb();
 #endif
-	atomic_inc(&queue->tail);
+	atomic_set(&queue->tail, prod + 1);
+	atomic_set(&queue->prod, prod + 1);
 
-	/* 7. Complete submission and restore local interrupts */
-	local_irq_restore(flags);
+	raw_spin_unlock_irqrestore(&queue->lock, flags);
 
 	return prod;
 
 err_busy:
-	local_irq_restore(flags);
+	raw_spin_unlock_irqrestore(&queue->lock, flags);
+	/* Report the failure and continue; full RAS recovery is not implemented. */
 	dev_err_once(queue->iommu->dev, "Hardware error: command enqueue failed\n");
-
 	return prod;
 }
 
-- 
2.50.1

