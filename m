Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01413285C8B
	for <iommu@lists.linux.dev>; Wed, 24 Jun 2026 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310088; cv=none; b=bMxjh50jRi46iKi+87VRRwUSiqugso9fA7m75oMbVLL9wG3kp+Ph5CvyhBeLfIA7fo+7G4oj/8BSlFbH3KzVHg8NSYE83T5/VnOzuv+BiZ8yMO4bmJBoGrW40PoHrn+J29MfhltkRVzAaPgTupDIUpPerWtcNwdQv1IhisIw6RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310088; c=relaxed/simple;
	bh=/W2rJ/IshxKQPF9RZxOatH1cRK6HzDfPC4W2WLFV4u8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INRgjR2x2mGPjWI9pZqf6Q/0YzSnsevSSU+zjx4qx7H6RzyqqAsp7Nm38PYjUj6ngwfLGFseJ0xmWrmvrwHbKbnXRAu+SoND/CPVElTcFe7FvsrrqQ48guy9gkrFII+EASLmoIkey2xfTt+01o4EHom5OPg2WBKV4KtoW0FWov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eC1UQahP; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eC1UQahP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782310078; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=t2xQXxgCnfhWmSGFXL1x7sR0Wlz3vICx5yrBNlLkLO8=;
	b=eC1UQahPo+I7mOceq4AcJFnHpMue0z0Man1IPF5y+9ufxgo3qE4PyG1zYyP3Kfmb2e/rXHDxSdTvBcHEinDe1vqbvcpM2rHM7Tk5NPg63IWl5vZmlC3+kKooxv4KyfGBHM+8xgpXRinYlcIDH0Xj0dpv9P1BET908UPg7W0wprE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X5YSeF8_1782310075;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X5YSeF8_1782310075 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Jun 2026 22:07:57 +0800
From: fangyu.yu@linux.alibaba.com
To: zong.li@sifive.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tomasz.jeznach@linux.dev,
	will@kernel.org
Subject: Re: [PATCH] iommu/riscv: Replace illegal command with dummy IOFENCE to prevent hardware lockup 
Date: Wed, 24 Jun 2026 22:07:52 +0800
Message-Id: <20260624140752.31155-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260623081902.589810-1-zong.li@sifive.com>
References: <20260623081902.589810-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>When the RISC-V IOMMU encounters an illegal command, the hardware
>stops processing and the HEAD register remains pointing at the
>illegal command. If software does not handle this properly, the
>hardware will be stuck at this index indefinitely, preventing any
>further command queue operations.
>
>This patch implements a recovery mechanism by replacing the illegal
>command with a dummy IOFENCE instruction (all operands are zero):
>
>1. Prevents hardware lockup: By overwriting the illegal command with
>   a valid instruction, the hardware can continue processing from the
>   current position instead of being stuck.
>
>2. Enables user recovery: After replacing the illegal command, the
>   user/driver has an opportunity to retry the original failed
>   operation rather than losing all queued work.
>
>3. Minimal hardware impact: A dummy IOFENCE behaves as a NOP, it
>   it performs no cache invalidation operations and has no side
>   effects on the system state. This is the safest replacement
>   instruction.
>
>Signed-off-by: Zong Li <zong.li@sifive.com>
>---
> drivers/iommu/riscv/iommu.c | 24 +++++++++++++++++++++++-
> 1 file changed, 23 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>index cec3ddd7ab10..6305ec5f467b 100644
>--- a/drivers/iommu/riscv/iommu.c
>+++ b/drivers/iommu/riscv/iommu.c
>@@ -464,13 +464,35 @@ static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
> static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
> {
> 	const struct riscv_iommu_queue *queue = (struct riscv_iommu_queue *)data;
>-	unsigned int ctrl;
>+	struct riscv_iommu_command cmd;
>+	unsigned int ctrl, head;
> 
> 	/* Clear MF/CQ errors, complete error recovery to be implemented. */
> 	ctrl = riscv_iommu_readl(queue->iommu, queue->qcr);
> 	if (ctrl & (RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
> 		    RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_FENCE_W_IP)) {
>+		/*
>+		 * The head pointer is not updated by the hardware, it
>+		 * still points to the index of illegal command
>+		 */
>+		riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue), head,
>+					  !(head & ~queue->mask), 0,
>+					  RISCV_IOMMU_QUEUE_TIMEOUT);
>+
>+		if (ctrl & RISCV_IOMMU_CQCSR_CMD_ILL) {
>+			/*
>+			 * Use a dummy IOFENCE instead of the illegal command
>+			 * to prevent hardware lockup
>+			 */

The RISC-V IOMMU spec 1.0 (Section 5.15, cqcsr) states:

  "If software makes the CQ operational again after a cmd_ill or
   cqmf error, then software should resubmit the commands submitted
   since the last IOFENCE.C that successfully completed."

So it seems that simply replacing the illegal command and letting the
queue continue is not sufficient.

Thanks,
Fangyu

>+			memset(&cmd, 0, sizeof(cmd));
>+			cmd.dword0 = FIELD_PREP(RISCV_IOMMU_CMD0_OPCODE,
>+						RISCV_IOMMU_CMD_IOFENCE_OPCODE);
>+			memcpy(queue->base + head * sizeof(cmd), &cmd, sizeof(cmd));
>+			dma_wmb();
>+		}
>+
> 		riscv_iommu_writel(queue->iommu, queue->qcr, ctrl);
>+
> 		dev_warn(queue->iommu->dev,
> 			 "Queue #%u error; fault:%d timeout:%d illegal:%d fence_w_ip:%d\n",
> 			 queue->qid,
>-- 
>2.43.7
