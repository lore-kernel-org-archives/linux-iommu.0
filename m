Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773C5947E3
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887845; cv=none; b=gl/7wnr+rm8mXyT4VRV6SbFxqqJ1HDbf1KIgbnxkrn5IZ8X841kYa8NyBKReq14xKMiCthUH+SkZbaSibkZdDexPVXTl1+eqsZWuk7puvN5gbnulMoQApVaBtb42an6zWk92XWNuBLaIBR4KiPk3FvXcwfJLvj56T3iyGFHpCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887845; c=relaxed/simple;
	bh=Dwyc+5KFatPgqOfM6fiICZd6cFIS58K7bYSDTZtCAtE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pi6BSoApudTSDvOrCrmiuyHtxFQbZsJaXMX6UIiu+DRPiK98hN0yA39+UfgmHCtZ3ip9MIGeHBIqluVDrpXA5trVHN+jONRDfNsPvhi66xQY+fA5G4S9EwZoGxXVcIHYqQ0NqmfmykhZfJ4S2WQz4eN2KJ9Agip0oCEOgajub7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BtSV1lw5; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BtSV1lw5"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso3285703a91.2
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 10:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887843; x=1789492643; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MSlHq0SmvCt51JoCh9r13XuOzmtJA9g6nMobC24S5K0=;
        b=BtSV1lw5xLO9AyPFsQ/Rek4i/qD2xPYrqpLywK7rUS0sEFB+RM+P88eKYCpkuy3yqL
         bxrsV72m6l92ap1jZhVxfiUwZ/zcMzKgvjJd0swJaW9+QhiYKjYF2HjucLN+sPtPmV6O
         +7g4mPdRMsqTrxyo9MAJUfPSYCw1sl3Lk+Wmh9PwPARKjavkuaqMn5o8N9aSNv93lmQL
         z9k4GneopfidllytZRrxvCXXU5CnKTxO+3j7fjwxSm5+IYuaspzNMDTZH9KTpAmDYu9R
         pH+VQsm+kQtzQtwz11OBykOmDuFWb7yhxabejg+UaZn5FBNoiF6UtUV/7vqUnHHiw6es
         JIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887843; x=1789492643;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MSlHq0SmvCt51JoCh9r13XuOzmtJA9g6nMobC24S5K0=;
        b=bKyGDoYi2jcQ5mL4pknWHYlfpMALk5zWxQP61Kg2CjdLDkZk0yrA/5Ca6D7ZY2fjf8
         Htxvhs2TJdnQrAKqHRmM4A2+HrL2s+GU3he3Vsz/9vW4VA7VbwjuyyjmnBFu1ITSQ4hz
         mm+Dq6j1vvHcQQ39lZ+0WkFw+Xe4X4mgJ4MJyt4/JmC2qd4oenMM58Tzpa+yFhK7chuC
         5SBihXRn8BsOjdFb1Ded0pxq/uBkgM/Mnxq3KWWm8acisDAK+biym/FAF/NMpBszqaxO
         fzmCU+eOJGtORqag9nFB44WwljabQ96eyZWGqdTIFHVilytvIz+C31Sx1YTXNE0xx/pY
         bsMA==
X-Gm-Message-State: AFuF++mecQ37eBTDdmrywT3K8MRDb2E5zYgRyVcBem1LZ3Qvk8gczA/f
	+/ByUK3eXRVE0YVqn68a8zUAuwhCdS5Rkph6UqxEeb5msycKO2J3PDd8L+6//nLHuoWZaAqdk7i
	a3nQcOAPAqjcBbu0sB3a4QkYPhThHTKC00MCYFygKDA2NR3gLAq2EBN8k1LItB8+vvXirdruxLg
	aQKDN9VjnsAlFPMPNA+jJcp+K28/8SSg==
X-Received: from pjbfh16.prod.google.com ([2002:a17:90b:350:b0:39b:9fad:2ae7])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c8b:b0:398:9bd5:490c
 with SMTP id 98e67ed59e1d1-39b26214502mr42288900a91.19.1788887842174; Tue, 08
 Sep 2026 10:17:22 -0700 (PDT)
Date: Tue,  8 Sep 2026 17:16:59 +0000
In-Reply-To: <20260908171712.356645-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260908171712.356645-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908171712.356645-4-praan@google.com>
Subject: [PATCH v10 03/15] iommu/arm-smmu-v3: Add arm_smmu_drain_queue() helper
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Nicolin Chen <nicolinc@nvidia.com>

Add a counting-based arm_smmu_drain_queue() helper, to replace queue
specific polling loops. Its until_empty mode serves the suspend and
runtime PM routines that would drain the CMDQ. Any timed-out drain fires
a WARN_ON as well, since reaching the timeout would take some stuck
consumer in any realistic case.

The existing queue_poll() API is not reusable for such a drain: it is the
atomic busy-wait for the command issuing paths, and it assumes a hardware
consumer making progress. A drain caller is sleepable, in contrast, while
the EVTQ/PRIQ consumer is a threaded IRQ handler that needs the CPU: such
a busy wait would starve the handler throughout an entire timeout, whenever
the waiter and the handler shared one CPU on a non-preemptible kernel. So,
this new sleeping helper is marked with a might_sleep() as well, given that
an atomic-context misuse would otherwise hide behind an empty queue.

Note that a drained event is dequeued, but not necessarily handled, since
queue_remove_raw() moves the MMIO CONS before the threaded IRQ handler gets
to push the event onto the IOPF workqueue. A subsequent change will invoke
synchronize_irq() and iopf_queue_flush_dev() to close that gap, and it will
act on the errno of a timed-out drain too.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 81 +++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 06b7de2e6e4b..84b56849f6dc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -948,6 +948,87 @@ static int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 					   cmds->num, true);
 }
 
+/**
+ * arm_smmu_drain_queue - Drain an SMMU queue
+ * @smmu: the SMMU device
+ * @q: the queue to drain
+ * @until_empty: target selection
+ *
+ * With @until_empty == true (for CMDQ), exit once the queue is observed empty:
+ *
+ *   cons0                cons                                prod
+ *     |                   |                                   |
+ *  ---+###################+=====================+=============+--->
+ *                         |<--------- undrained==0? --------->|
+ *
+ * With @until_empty == false (for EVTQ/PRIQ), exit once "drained" reaches its
+ * target: "pending" (i.e. prod0 - cons0, frozen at the entry time):
+ *
+ *   cons0                cons                 prod0         (prod)
+ *     |<---- drained ---->|                     |             |
+ *  ---+###################+=====================+=============+--->
+ *     |<--------------- pending --------------->|
+ *
+ * Note that a drained entry is dequeued, but not necessarily handled: the
+ * EVTQ/PRIQ callers must follow up with a synchronize_irq() to wait for the
+ * threaded IRQ handler to finish handling the dequeued entries.
+ *
+ * Context: Process context; may sleep.
+ * Return: 0 on success or a negative errno on timeout.
+ */
+static int __maybe_unused arm_smmu_drain_queue(struct arm_smmu_device *smmu,
+					       struct arm_smmu_queue *q,
+					       bool until_empty)
+{
+	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_POLL_TIMEOUT_US);
+	u32 cons, prod, prev, undrained;
+	u32 drained = 0, pending;
+
+	might_sleep();
+
+	cons = readl_relaxed(q->cons_reg);
+	prod = readl_relaxed(q->prod_reg);
+	/* The exit target: the number of entries in the queue at entry */
+	pending = Q_POS(&q->llq, prod - cons);
+
+	while (true) {
+		/* Accumulate the entries consumed since the last poll */
+		prev = cons;
+		cons = readl_relaxed(q->cons_reg);
+		drained += Q_POS(&q->llq, cons - prev);
+
+		prod = readl_relaxed(q->prod_reg);
+		undrained = Q_POS(&q->llq, prod - cons);
+
+		/* Exit on an empty queue, regardless of until_empty */
+		if (!undrained)
+			return 0;
+
+		/* Snapshot mode: exit once the pending entries are drained */
+		if (!until_empty && drained >= pending)
+			return 0;
+
+		/*
+		 * A timeout means the consumer might be stuck. In theory, if it
+		 * moves 2 * qsize entries or more within a single poll interval
+		 * Q_POS() would wrap and undercount drained: that could trigger
+		 * a spurious warning too, if the queue was never once observed
+		 * empty. Yet, that much consumption in such a short interval is
+		 * unrealistic. WARN it only, as a stuck consumer is a real bug.
+		 */
+		if (WARN_ON(ktime_compare(ktime_get(), timeout) > 0))
+			break;
+
+		/* The consumer might be a threaded IRQ handler. Yield to it */
+		usleep_range(100, 200);
+	}
+
+	dev_warn_ratelimited(smmu->dev,
+			     "queue drain timed out at prod=0x%x cons=0x%x\n",
+			     prod, cons);
+	return -ETIMEDOUT;
+}
+
 static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused,
 				   struct iommu_page_response *resp)
 {
-- 
2.55.0.979.g7e5102b832-goog

