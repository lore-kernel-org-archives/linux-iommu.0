Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA9389DEC
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 08:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202748; cv=none; b=TLRuJKLnfzt+hCaPB2aaEH4R8MRtmAOn1LRoPsOmSY0AyCUerUBDbFDJItNJaqZ8ABoMzQoaoIwJccXwNY0dkzRtG9xb86hb5rX/7ldogWAdriieMIhekLTW7WHqL/B7qc71mphbD5w8f+9wEuJBnyOc8stNMy2tn3WJHPI74u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202748; c=relaxed/simple;
	bh=weI36dBrZRSvtSFbESYh7XC1OFFFZe4YOoHRUWMU6DM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQhGqKXTMoR1F/xTgAXfSK1O+cUDZjE1MsKk5Y+RZt3immdN+rgB/zMdZAT+ChFcJ1cfx+opXi04uyZEA6h8HxLCldCDDMj6naD0tO+3ckLhKN1ZJ+G+beekqaxWtqrK1Vu0Zbr3Ib4DUFd5+Wbv58WNbjMGCmnMoukQNEXl9YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Mz9HN63U; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Mz9HN63U"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-139986373b8so5755184c88.0
        for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782202746; x=1782807546; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTbtFL6V7xdQq2v5wFOMr8PK+R/BJm2uQjBRjFSF9J8=;
        b=Mz9HN63UDsEFnHjahQReWo9ldKMGOBs70ei18lkbtjTat4k1/ssAXP8RlohZenCwup
         SYpq++ekrj3pAW0Y2TVxXds5p8/Mf3rATwmyEZy9XI4+Cbb6rRY4l8SUneQOb4Od8LUQ
         G0BRmMIQyl6KC10FZ1f+/TPOwp30WnzorNt0/+qZ4+I3/uE6zxWm9agrmNpU0f7NKBwu
         yDgjDKNvetbiQQx9b2GQXzAFECMxnGwK6y27gZqN+EiapudegSLqH+qdo1zvpzPigsJx
         +Nw6LQQXjs1fKUuqOjFTZVnaa+HY/UEmmAcgl7G+kGLG9/LX+Ys3U+sjgWl67lY9e7jn
         66/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782202746; x=1782807546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTbtFL6V7xdQq2v5wFOMr8PK+R/BJm2uQjBRjFSF9J8=;
        b=J+mdX63HD0atedVibGBZPrhYSZFm22+RtQpWJdr0JHEWX5e5DDbuEN7yEHTHCoo83x
         nPp2txf78Mda7x80lVUPA3rr42q8q44R5XDIa6i+u0paUitDOLEWMJXDCtbMkPWDQU0R
         da9hhfshukz1QSfzN7gOj2h0/W5uE3ifw+cKSaKNfl7SMqP1j8yfX4YHlrfnpLIHgV8I
         Zftb04HzdsyJK/PBGqATqV/kslv92LK60/HIuZQUqpuPJ8iJbW47cwIL0MwedM2fIMO9
         Muccv7gTrNFf8JKXY+5phpBdprrkWUCdxplBKd9Yq1Pk3ZhSREtvcWbst8qOxeQL/IkR
         AHZA==
X-Forwarded-Encrypted: i=1; AFNElJ9BjyfzLv1gFuH90/CGrEjT3cO9tHeS00PtBu61U7EBwlJhFueIKt4WtPUzuM1iRyu7B/o/CQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyi0MgIn0FeQTB5owH9Qgki2F1mdYfMtsQJDBhx8lr6l+/9JX0x
	NeLTPZCAiDEPebDsQ9U/0dBO8M7UThyHa9cErd4ZqCnbs2zGj5OBDE3i+9kkxH9PfQ8=
X-Gm-Gg: AfdE7clopI7P+OOM/crzi1qHv5dsMzUkakxymd6gXWFxlQCtrojwu815fxYN9xIHOdy
	X09Mf40Y1uVgIbN06WIX7xRGsJTnrd0KZXLtCIe1BOy0tVeFxV0QdBlzzmUqDGBRC4pUwMT1Feg
	A7V+xVk66z3PImQc905j1nEl7dox1mstL7rwd0XPR7y3kpPXF1JPoBZ5d8pE1AAI5LeRDBSxoRI
	MSyL1himQ8qNf5GJh+c+1VlZ4Hscfy6H84JqCcMeU4fJeGTIDzDU3eT2pzQrY6Ijiu4VGgdat2x
	nTHCUcQs1Gjg3i4Ri/xoQZgT3bGMLf6veQu50xLiw34JmLM/pHzzW9N+HqYYUjJAnaLqag3mDdK
	lCn2Khp/9e+umT+JxwnP3qz4p7Xda+BJZeL//V1XiUZT+js9T+7RrsUvtL9/GfSGCiiU9yYDVFe
	/W2FXJiWpLv0G9/bHdjfRvl209ZEk/tK/CB2Y=
X-Received: by 2002:a05:7022:45a6:b0:138:3613:db8 with SMTP id a92af1059eb24-139c6ebfc80mr1045661c88.3.1782202745949;
        Tue, 23 Jun 2026 01:19:05 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adca1b00sm11246236c88.2.2026.06.23.01.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:19:05 -0700 (PDT)
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
Subject: [PATCH] iommu/riscv: Replace illegal command with dummy IOFENCE to prevent hardware lockup
Date: Tue, 23 Jun 2026 01:19:02 -0700
Message-ID: <20260623081902.589810-1-zong.li@sifive.com>
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
 drivers/iommu/riscv/iommu.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index cec3ddd7ab10..6305ec5f467b 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -464,13 +464,35 @@ static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *queue,
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
+		/*
+		 * The head pointer is not updated by the hardware, it
+		 * still points to the index of illegal command
+		 */
+		riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue), head,
+					  !(head & ~queue->mask), 0,
+					  RISCV_IOMMU_QUEUE_TIMEOUT);
+
+		if (ctrl & RISCV_IOMMU_CQCSR_CMD_ILL) {
+			/*
+			 * Use a dummy IOFENCE instead of the illegal command
+			 * to prevent hardware lockup
+			 */
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

