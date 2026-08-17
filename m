Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E6A40DB22
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976920; cv=none; b=ObJuIorzTnUZ0/hwaKpo2X9p1wy2CjZdS63jg6B8l2STiVtBjG+QRQE1iJ4TXwrqV6f+k1iwSv+6AcTExPsrSgtK36Bi98u/z33F/VzUFe7mgKK5cn8rEhl4Q0+vaeQkGSuZpTIv7tntALUEhsvCGjziwYf+MXWkUOsMyzzs3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976920; c=relaxed/simple;
	bh=drFqM0UHHD3hILUHh08HSPHe3MqcsQM5z31wtT/ohlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDXY1MXEcTEqNru+DXATvF/G8Kx6kYHh0/gRz2IIc7e9ZuiRBQOYdzzYRSPUskAw9SvbXD0aS/5jTUvXXR9fBRLeyKT7l/JCI/3PNlUBIKZC+FFCc8lWxLYLTbBYhPfzzDIe7eUWkxs47FlvOmU9DpJiqzHpqGVBBSyOy7G9ZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=esvbCK+5; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="esvbCK+5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786976907; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=elSQcfZeblurM3/OL+mlSXqqGCSbGGx49NKsTqTo6v4=;
	b=esvbCK+5p3mzHXgt3lsXQMcXtO7fjCX1fZjAVWqub6FiIoqyVqsi6bGIAEBknXg5zdX/w32Sz78WJ/CEZ1QU9N0O3EA1eV2bswJPdbsaSGbOOKRYlzg4MWOZvjS3W0f3/xxmZUR7nprv1NVyF4hYu3h7qGDbO2yb2xr4XpOy1n0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X9A9H.G_1786976904;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X9A9H.G_1786976904 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Aug 2026 22:28:25 +0800
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
Subject: [PATCH 3/3] iommu/riscv: Avoid waiting on failed command enqueue
Date: Mon, 17 Aug 2026 22:27:28 +0800
Message-Id: <20260817142728.61783-4-fangyu.yu@linux.alibaba.com>
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

Do not wait for IOFENCE.C completion when the command failed to enter the
queue. The command was not published to hardware, so waiting for its
producer index can only report a misleading execution timeout.

Fixes: 856c0cfe5c5f ("iommu/riscv: Command and fault queue support")
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/iommu/riscv/iommu.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 86cec408be5b..2b3dc63536d5 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -419,8 +419,9 @@ static int riscv_iommu_queue_wait_for_space(struct riscv_iommu_queue *queue,
 }
 
 /* Enqueue an entry and publish it to the hardware queue. */
-static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
-					   void *entry, size_t entry_size)
+static int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
+					  void *entry, size_t entry_size,
+					  unsigned int *out_prod)
 {
 	unsigned int prod;
 	unsigned int head;
@@ -465,15 +466,17 @@ static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
 	atomic_set(&queue->tail, prod + 1);
 	atomic_set(&queue->prod, prod + 1);
 
-	raw_spin_unlock_irqrestore(&queue->lock, flags);
+	if (out_prod)
+		*out_prod = prod;
 
-	return prod;
+	raw_spin_unlock_irqrestore(&queue->lock, flags);
+	return 0;
 
 err_busy:
 	raw_spin_unlock_irqrestore(&queue->lock, flags);
 	/* Report the failure and continue; full RAS recovery is not implemented. */
 	dev_err_once(queue->iommu->dev, "Hardware error: command enqueue failed\n");
-	return prod;
+	return ret;
 }
 
 /*
@@ -512,7 +515,7 @@ static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
 static void riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
 				 struct riscv_iommu_command *cmd)
 {
-	riscv_iommu_queue_send(&iommu->cmdq, cmd, sizeof(*cmd));
+	riscv_iommu_queue_send(&iommu->cmdq, cmd, sizeof(*cmd), NULL);
 }
 
 /* Send IOFENCE.C command and wait for all scheduled commands to complete. */
@@ -521,9 +524,12 @@ static void riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu,
 {
 	struct riscv_iommu_command cmd;
 	unsigned int prod;
+	int ret;
 
 	riscv_iommu_cmd_iofence(&cmd);
-	prod = riscv_iommu_queue_send(&iommu->cmdq, &cmd, sizeof(cmd));
+	ret = riscv_iommu_queue_send(&iommu->cmdq, &cmd, sizeof(cmd), &prod);
+	if (ret)
+		return;
 
 	if (!timeout_us)
 		return;
-- 
2.50.1

