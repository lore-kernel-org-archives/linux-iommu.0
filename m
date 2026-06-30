Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14582F8EA3
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 02:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786650; cv=none; b=f9WJWykScoPFjtDRcL4QDwoOEmfrL//bSrm+F2cJJkATMOJXtXXsPU29+k6AV1uyqqvjvsMWHtEJ5FVQzM5bNJavUKTKuoO4FX1cRTeAJKggGtveI5JzOzEW2YPmwwyU46pHvSWLXr4DN/ZfeDdbV6+26gENPozHv2FSMeQsgEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786650; c=relaxed/simple;
	bh=x9zteWOYr8t/wdjq8tunwABmZZvlLJKRglbc9HCV1GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvqYYZSL7Cg8ZIOB7p37DhnQYn71Zo3V7B+q8HpetPkxlF9wGAFdsoiycvERHwMUnfZDgv8lR8fRHkbyRvkjjPcXmomn8XmetmktBpyq8FkkhPpF4aibQHKaY60sWh83sHD5nVkRcT5BZysg42B7PvtbtdpjDG+BuU1WWJcwKW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=V3Z50ITj; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="V3Z50ITj"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-139b914bab6so5451430c88.1
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 19:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782786645; x=1783391445; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii6UHtihwzsZnK7EsOywu4rokZlizEKakSYZSPed4Ds=;
        b=V3Z50ITjyg6CQ/fgp5ErJJ+yNkeU+Atz2QoMjlXhz03SMBB0LjpxorSBzunrLe/+7P
         byEjIvBKsxTCu9U2Q5fGj0txCrUZ4VIUp8C9CeDXLbFnIee8huzc/aE9Bm/jB/lo1OdM
         t7KRfT1GI0zobS6ebpP0YDJGIp5/eHz3uj6ZBIQ3puyaUcUn4sh7Yx3bmlWOzvTXAr3B
         w1AEzqUqwy7gahiL3XdBwl2qH4KxCjE7MdIhrBwAb4DXlAj5oE36PApC0Hdu3WsRKPx/
         wpVAqCte5KciIPZNBXGgJleOb3f6900lnjKCaofL11PTgw5QsdKfnD22HPlX+eK30qNy
         Qr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782786645; x=1783391445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii6UHtihwzsZnK7EsOywu4rokZlizEKakSYZSPed4Ds=;
        b=nir4834r8Mosh5w51s7iqw+DDBo3pWxbR3n7pL5qvngdPYGAr7J9mH4Uw/h5iTNPPg
         IBxr/M7Po7fUVs7u+7vqgT+R4QNM84jpQL2XCNHdUtoGBj1XO6zVqmssLv0OY9wJdZp6
         n74fru/vXTtk1FVSEf2DugIsUN8OtK2q0ZuZulBRyKABDK0q/oo9m8Xm1nDbwqU7iWoA
         dwFaoGkP5ppBUnY8CCKCvKP5o83YEh/3Qhf8jH8KupJ/5oQBX5AECy266X67p4bvLR7W
         1jTISIMlxnKRw6Ph3ubFF2aYHfkhOX54KIXp3qayp629I+hu6/DHJZWewstVPp8jvh3F
         lZxw==
X-Forwarded-Encrypted: i=1; AFNElJ/wKCaZkhZnPLXuoSj2Lr10LQApb2G5FUvcDxvDh2oIuYuSNJOf3yVNZgzOpNZ0e792RrB2iA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8KUC2v3cBisLu5kjwrTOZ2eKZW9yMQOyWPYKbN7xvK6liboUC
	dlbBj4XrtL3uOerKnEM99BAlT1KyO/gMXhWi/iIKi6S73UpKy22ci1MEBeO/2E3FFjg=
X-Gm-Gg: AfdE7cm1OxxG2sICEMNLGrsu2o+tUYZaT4WNwfkI4uTWvZ+bQzJCV/pG+VBN6K65kU8
	uClYTCT0qibJqP6hCEd/qZ+sOWxPzQr0ArD6RlSYsc2O7kJexQKpKxfni+KBjzFDPpA225LFBFk
	SSeorPx0kLWWxDNnc9wFZ88JgeEffCtRrXDlLnvzYUrumwFY2s7O8/DZplHMsU/LmLWa84CUoXv
	JF9iK2rZkjNsSSqJx7A1E3jZxyhTGbpHtuOhMzl0cUZKgAt9NA0ccDlMgKwU7akC4V3wy5N5Fub
	10Yp+buZwDxSPKTT0WWUzWNR4Yv2xyssr16Ae86nbIQFxgz4Qf3WHcM34099evqj7hfk1pW67G5
	bX7m2Lz9EErWgks6O9zI4fCcV+rqM0Ptwxdf75pzof5BgNYnXLDkVoy/XjHyHFGv0YxvipN/jT+
	pkSFyRTy5NkJt7nr2iFZCLtXDG
X-Received: by 2002:a05:7022:3d18:b0:139:ed5a:eef0 with SMTP id a92af1059eb24-13b2a1cc067mr1088234c88.47.1782786645430;
        Mon, 29 Jun 2026 19:30:45 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b2aba794csm2168488c88.10.2026.06.29.19.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 19:30:44 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH v2] iommu/riscv: Replace illegal command with dummy IOFENCE to prevent hardware lockup
Date: Mon, 29 Jun 2026 19:30:42 -0700
Message-ID: <20260630023042.837926-1-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the RISC-V IOMMU encounters an illegal command, the hardware
stops processing and the HEAD register remains pointing at the
illegal command. If software does not handle this properly, the
hardware will be stuck at this index indefinitely, preventing any
further command queue operations.

This patch implements a recovery mechanism by replacing the illegal
command with a dummy IOFENCE instruction (all operands are zero):

1. Prevents hardware lockup: By overwriting the illegal command with
   a valid instruction, the hardware can continue processing from the
   current position instead of being stuck.

2. Enables user recovery: After replacing the illegal command, the
   user/driver has an opportunity to retry the original failed
   operation rather than losing all queued work.

3. Minimal hardware impact: A dummy IOFENCE behaves as a NOP, it
   it performs no cache invalidation operations and has no side
   effects on the system state. This is the safest replacement
   instruction.

Signed-off-by: Zong Li <zong.li@sifive.com>
---

The main goal is to at least prevent the hardware from getting stuck
and crashing the entire system.

Here are the main issues we would need to solve if we fully follow the spec:

1. IOFENCE index shift: After an illegal command, if another thread is
waiting for subsequent IOFENCE to finish, resubmitting commands will
change that IOFENCE's index in the queue. This means the waiting
thread in 'riscv_iommu_cmd_sync' might finish too early because the
'prod' value should be changed as well. We could fix this by making
IOFENCE write a sequence number to a specific address, and having the
thread wait for that data instead.

2. Timeout errors: If an illegal command happens while another thread
is trying to write a command, that thread might be waiting for the
tail to move (in 'riscv_iommu_queue_send'), and exit the wait due to a
timeout. This leads to errors in the caller subsystem (like DMA). So
it seems even if the resubmit finishes later, it might not help much.

3. Queue tail mismatch: Similar to point 2 situation, a thread waiting
in 'riscv_iommu_queue_send' expects prod == queue->tail. If we
resubmit commands quickly, queue->tail is updated asynchronously to a
farther value. The waiting thread might never see the condition met
and time out.

4. Shadow queue overhead: Inside the threading IRQ handler, we cannot
easily know what the illegal command was just by checking the current
command queue. We would need to create a "shadow command queue" to
keep a history. This would break the current driver design. We would
also need to add locks to prevent race conditions on shadow command
queue, which would reduce the driver's performance.

Considering these trade-offs, I prefer not to make the driver much
more complex and slower just to handle rare hardware errors.
Treating this hardware fault as a fatal error without trying to
recover it in software might be too extreme and would require a
hardware reset. Therefore, this patch might be a good middle ground.
It prevents the hardware lockup. Even though we might lose some commands
and cause incorrect results for the user, it at least keeps the system
alive and gives the user a chance to retry their operation again.

Changed in v1:
- Added more comments
- Rebased on v7.2-rc1

 drivers/iommu/riscv/iommu.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index cec3ddd7ab10..c009c1906e23 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -464,13 +464,43 @@ static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
 static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
 {
 	const struct riscv_iommu_queue *queue = (struct riscv_iommu_queue *)data;
-	unsigned int ctrl;
+	struct riscv_iommu_command cmd;
+	unsigned int ctrl, head;
 
 	/* Clear MF/CQ errors, complete error recovery to be implemented. */
 	ctrl = riscv_iommu_readl(queue->iommu, queue->qcr);
 	if (ctrl & (RISCV_IOMMU_CQCSR_CQMF | RISCV_IOMMU_CQCSR_CMD_TO |
 		    RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_FENCE_W_IP)) {
+
+		/*
+		 * Resubmitting all commands submitted since the last IOFENCE that
+		 * successfully completed will introduce various race conditions.
+		 * Use a dummy IOFENCE instead of the illegal command to prevent
+		 * hardware lockup.
+		 * Please note that some commands might be lost, including:
+		 *  - The task from the illegal command itself
+		 *  - The commands submitted between the last IOFENCE and illegal one
+		 * However, this gives the user or driver a chance to retry the
+		 * failed operation without resetting the enitre system
+		 */
+		if (ctrl & RISCV_IOMMU_CQCSR_CMD_ILL) {
+			/*
+			 * The head pointer is not updated by the hardware, it
+			 * still points to the index of illegal command
+			 */
+			riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue), head,
+						  !(head & ~queue->mask), 0,
+						  RISCV_IOMMU_QUEUE_TIMEOUT);
+
+			memset(&cmd, 0, sizeof(cmd));
+			cmd.dword0 = FIELD_PREP(RISCV_IOMMU_CMD0_OPCODE,
+						RISCV_IOMMU_CMD_IOFENCE_OPCODE);
+			memcpy(queue->base + head * sizeof(cmd), &cmd, sizeof(cmd));
+			dma_wmb();
+		}
+
 		riscv_iommu_writel(queue->iommu, queue->qcr, ctrl);
+
 		dev_warn(queue->iommu->dev,
 			 "Queue #%u error; fault:%d timeout:%d illegal:%d fence_w_ip:%d\n",
 			 queue->qid,
-- 
2.43.7

