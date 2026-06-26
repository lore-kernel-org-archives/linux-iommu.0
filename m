Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FEA3F7A98
	for <iommu@lists.linux.dev>; Fri, 26 Jun 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481811; cv=none; b=ibdxAKe0VUKoDN4mEOpq5O9Bt0A1dTdg/HahIZ+s6BeRtSKoUgLq80mwI2KT7aur0ch70k+auHvuiQuvqna+3Ce2yJHRsTWMnAxXfCkWBDW5zh10auucXjBKljlDktkovB6D5A4JxeqJAHo508qhbfeVn9TKME3N+DUs2zqBWG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481811; c=relaxed/simple;
	bh=GY62n7kOj+v3reoGpsquGpVEuJ38SBPbfDes6hvQbvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMdI49itfvJVN0gRWQZtK4e0i+IQKJ30RAV5LA3nqzKxInQkMreQspVQhVEl0FlqpZI4oRqFeEAZXw0F9/a82+0/nAB7t7Yduq22sKCmGdA+0ttfJVVxfaYU/DfNpShcbO2BJk6Ft/EK3wlpl9CzRyr69rFCv1T1QbkWlL3dO+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iH/jj4MO; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iH/jj4MO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782481806; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=I0CVDilWnVFHX9aqlzdQFIxfq6rgcaxKjoM/1lCAMnk=;
	b=iH/jj4MO//Fp+s1w3p09x1aH211uwaIsl+N5d7OM3Rm+LYF+nPJJEQ5HKRua51oPGhVyXdEPnudG1R0fNlVtIQZADSc12G/LqI/q1QI4Kptmas1jpvP4kfSbI9RHGgz7iH3fGTWLE66plbaaJBMKmac1r01mt8wc5NSgb/C5GPA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X5f1aMS_1782481803;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X5f1aMS_1782481803 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Jun 2026 21:50:05 +0800
From: fangyu.yu@linux.alibaba.com
To: zong.li@sifive.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	fangyu.yu@linux.alibaba.com,
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
Date: Fri, 26 Jun 2026 21:50:02 +0800
Message-Id: <20260626135002.65703-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CANXhq0pw5TPSD+p3YnTyEHQTSB-3jmAp3bzRSXvHdVjvevfL7w@mail.gmail.com>
References: <CANXhq0pw5TPSD+p3YnTyEHQTSB-3jmAp3bzRSXvHdVjvevfL7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>On Wed, Jun 24, 2026 at 10:08 PM <fangyu.yu@linux.alibaba.com> wrote:
>>
>> >When the RISC-V IOMMU encounters an illegal command, the hardware
>> >stops processing and the HEAD register remains pointing at the
>> >illegal command. If software does not handle this properly, the
>> >hardware will be stuck at this index indefinitely, preventing any
>> >further command queue operations.
>> >
>> >This patch implements a recovery mechanism by replacing the illegal
>> >command with a dummy IOFENCE instruction (all operands are zero):
>> >
>> >1. Prevents hardware lockup: By overwriting the illegal command with
>> >   a valid instruction, the hardware can continue processing from the
>> >   current position instead of being stuck.
>> >
>> >2. Enables user recovery: After replacing the illegal command, the
>> >   user/driver has an opportunity to retry the original failed
>> >   operation rather than losing all queued work.
>> >
>> >3. Minimal hardware impact: A dummy IOFENCE behaves as a NOP, it
>> >   it performs no cache invalidation operations and has no side
>> >   effects on the system state. This is the safest replacement
>> >   instruction.
>> >
>> >Signed-off-by: Zong Li <zong.li@sifive.com>
>> >---
>> > drivers/iommu/riscv/iommu.c | 24 +++++++++++++++++++++++-
>> > 1 file changed, 23 insertions(+), 1 deletion(-)
>> >
>> >diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> >index cec3ddd7ab10..6305ec5f467b 100644
>> >--- a/drivers/iommu/riscv/iommu.c
>> >+++ b/drivers/iommu/riscv/iommu.c
>> >@@ -464,13 +464,35 @@ static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
>> > static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
>> > {
>> >       const struct riscv_iommu_queue *queue = (struct riscv_iommu_queue *)data;
>> >-      unsigned int ctrl;
>> >+      struct riscv_iommu_command cmd;
>> >+      unsigned int ctrl, head;
>> >
>> >       /* Clear MF/CQ errors, complete error recovery to be implemented. */
>> >       ctrl = riscv_iommu_readl(queue->iommu, queue->qcr);
>> >       if (ctrl & (RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
>> >                   RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_FENCE_W_IP)) {
>> >+              /*
>> >+               * The head pointer is not updated by the hardware, it
>> >+               * still points to the index of illegal command
>> >+               */
>> >+              riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue), head,
>> >+                                        !(head & ~queue->mask), 0,
>> >+                                        RISCV_IOMMU_QUEUE_TIMEOUT);
>> >+
>> >+              if (ctrl & RISCV_IOMMU_CQCSR_CMD_ILL) {
>> >+                      /*
>> >+                       * Use a dummy IOFENCE instead of the illegal command
>> >+                       * to prevent hardware lockup
>> >+                       */
>>
>> The RISC-V IOMMU spec 1.0 (Section 5.15, cqcsr) states:
>>
>>   "If software makes the CQ operational again after a cmd_ill or
>>    cqmf error, then software should resubmit the commands submitted
>>    since the last IOFENCE.C that successfully completed."
>>
>> So it seems that simply replacing the illegal command and letting the
>> queue continue is not sufficient.
>>
>
>Yes, this patch doesn't completly follow what the spec mentioned.
>Initially, I wanted to implement the method suggested by the spec.
>However, there are some synchronization challenges based on current
>driver implementation. Therefore, I chose an approach similar to other
>IOMMU drivers (like SMMU and Intel VT-d). The main goal is to at least
>prevent the hardware from getting stuck and crashing the entire
>system.

Thanks for the detailed explanation. I understand the practical
challenges you described. However, I’d like to note that the ARM
SMMUv3 and Intel VT-d specs appear to provide somewhat different
guarantees from the RISC-V IOMMU spec with regard to error recovery.

ARM SMMUv3 (IHI 0070, Section 7.1):
  "Older commands are unaffected by a later Command queue error."

Intel VT-d (Section 6.5.2.10):
  "Any invalidation commands ahead of the invalid descriptor that
   are already fetched and pending in hardware at the time of
   detecting the invalid descriptor error are completed by
   hardware as normal."

>
>Here are the main issues we would need to solve if we fully follow the spec:
>
>1. IOFENCE index shift: After an illegal command, if another thread is
>waiting for subsequent IOFENCE to finish, re-submitting commands will
>change that IOFENCE's index in the queue. This means the waiting
>thread in 'riscv_iommu_cmd_sync' might finish too early because the
>'prod' value should be changed as well. We could fix this by making
>IOFENCE write a sequence number to a specific address, and having the
>thread wait for that data instead.
>
>2. Timeout errors: If an illegal command happens while another thread
>is trying to write a command, that thread might be waiting for the
>tail to move (in 'riscv_iommu_queue_send'), and exit the wait due to a
>timeout. This leads to errors in the caller subsystem (like DMA). So
>it seems even if the resubmit finishes later, it might not help much.
>
>3. Queue tail mismatch: Similar to point 2 situation, a thread waiting
>in 'riscv_iommu_queue_send' expects prod == queue->tail. If we
>re-submit commands quickly, queue->tail is updated asynchronously to a
>farther value. The waiting thread might never see the condition met
>and time out.
>
>4. Shadow queue overhead: Inside the threading IRQ handler, we cannot
>easily know what the illegal command was just by checking the current
>command queue. We would need to create a "shadow command queue" to
>keep a history. This would break the current driver design. We would
>also need to add locks to prevent race conditions on shadow command
>queue, which would reduce the driver's performance.
>
>Considering these trade-offs, I prefer not to make the driver much
>more complex and slower just to handle rare hardware errors.
>Personally, I lean towards treating this hardware fault as a fatal
>error without trying to recover it in software. However, I understand
>this might be too extreme and would require a hardware reset.
>Therefore, this patch might be a good middle ground. It prevents the
>hardware lockup. Even though we might lose some commands and cause
>incorrect results for the user, it at least keeps the system alive and
>gives the user a chance to retry their operation again.
>

I understand the trade-off. Given the complexity of full spec
compliance, this simplified version may not actually address the
underlying issue very well, so I’d suggest making its limitations
explicit. Specifically, could you document in the commit message or
code comments which scenarios it can handle and which ones may
still remain problematic?

>
>> Thanks,
>> Fangyu
>>
>> >+                      memset(&cmd, 0, sizeof(cmd));
>> >+                      cmd.dword0 = FIELD_PREP(RISCV_IOMMU_CMD0_OPCODE,
>> >+                                              RISCV_IOMMU_CMD_IOFENCE_OPCODE);
>> >+                      memcpy(queue->base + head * sizeof(cmd), &cmd, sizeof(cmd));
>> >+                      dma_wmb();
>> >+              }
>> >+
>> >               riscv_iommu_writel(queue->iommu, queue->qcr, ctrl);
>> >+
>> >               dev_warn(queue->iommu->dev,
>> >                        "Queue #%u error; fault:%d timeout:%d illegal:%d fence_w_ip:%d\n",
>> >                        queue->qid,
>> >--
>> >2.43.7
