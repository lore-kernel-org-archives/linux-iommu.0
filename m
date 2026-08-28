Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C43C1D43
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907508; cv=none; b=WZpknd5NIJ67FCmbwtcjq8KFFgzupqCBiTUeAZ/AVbwcB5w1E0sGRjOzizO3+gCnKDQKOCKnGZ7+xZDj0iMQ+oqSU9PQOJmPwCfDwiuIbENh4IyfaYMEdUGPl6R7UMG7bCRIPoanmrE7v0Qdf/RyLhPd6ygRgSi8zgnY7SU1EXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907508; c=relaxed/simple;
	bh=lsBZYsAG+nr8THk4a+Io/3qdHObvPBkAo1nshLqp2i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hC1e6G69MiJPeldE2RWa162OcMHC0vaipFiH9p/WYQAhcbtUPG+ssBZAkzp93T6dzpf/qhqV8MklfhFYbLKz1DfBogwsb39yN0a8Enq21Oj59o9PggZOU2rcU+qQ7wKuzrM61g98RPGAoAMhZJP9BIcduUZVqcSLoh5Lj29AKmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jWSS4J9i; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jWSS4J9i"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc891373e0so5851065ad.2
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 01:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787907506; x=1788512306; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TRFIKfxO5tXI3eQnrJwwXHHecr77RgRWRC9iwHx3Doo=;
        b=jWSS4J9ig4uQwa+KqpxC3hdtwjRuEuXJjL0QL2szWf+3nbSNq/EPMVebREmP4kVai7
         YI878pfbvk+ylunYODAyJQqat88AUi3wSn+PcIXHKMj43QOfB1dg2er+UqoteedaWyLP
         oPkaSOYLvY1+zxnEdd1MshrWwKFJARJPoVnRQyLadWpXCpUms20d0ygY7VRqc/KTjrRm
         RIt9VRcVhnauiJPG9mxHEpoR/4OF/0H9yAHO3i6sJNOY6sbEVSm8Po+HxjO2q5jBvilN
         RSZPJMGqrkof3Hry1Xyk8B9aL9MWRHVjkoU2KY1rkEKqbgBzRVkCf/vOOxANdulciKmX
         9hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787907506; x=1788512306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TRFIKfxO5tXI3eQnrJwwXHHecr77RgRWRC9iwHx3Doo=;
        b=HpBOzrGV5EmFVuV/mNL8i4HwXtmOvQjwVxdeLytod7X6vV6Ru5V1bZVM0DtZr8qRYc
         BiNgRNbpFr7Nd4SODkJEqXw5YR1Ddf5E/GWMRTEyJj/gtFches30XZVV2Bru/s60ics1
         vo7/2C2aGwV9z6d41CorVIZAX1DnQVdNbCp4/1HfrewTAPRaeBQQlYzRlu4sBYYaXHRo
         0j6HlMkBXQDSxVdNl1SqKxYFX3htlK1ofhANmXWCTovXhR3Gd6kmhanz+DUOI4BC3aVW
         T8KrKoSP4dRCO6zROy1LJNC0tKZ5dyPvGAHmc0Nl/Y6y/KAP14fqEcFw2c16TrMj4S82
         p8VQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxTb+ppnjSSZ44Q/qQM0ZxUoPbO6gRZ01xUvF2JvemYRBrwucBL08gJlfGVFAwXYXYBBHAwA==@lists.linux.dev
X-Gm-Message-State: AFuF++mkv0etuYxWW8hr2JfNuqnMw1e/cRgtuTHJZZygwQT5ttSSMnA6
	38TNl+/18d2t4v11mn0ISxCK26m11O+vT2+Op3pz/5rG0l2IVe1O9qE7tAygt/RKkj4=
X-Gm-Gg: AR+sD12qECT/r6i7KZkTTOpHrBP27aCKNby5c8C5LsxgDbaEVlGNnK2rPGioWt0YRSK
	xEKVc4s2Wm0AJ11invGLP/93KFf52Vpe1hxSxoDLnj1vux73koyUbrMU1sOhotD3IOJjSe8OVnl
	pUuuUxbmY7Tl+e7PvxEFQUxhg/cZUiYQT4aN7B3QWYQJYMbTigUhpeP07mJI5lVExwXPXWkKLZw
	B98yAlYmLMFlkczIZaeWGEtYvcxqdeTXvZcN9VOn4oGQY9MeELYUJdeaCB2/XR2/7nBiYUlMsoo
	fKkQGRQHqQPfJPZxF1buARdg5G7MPvOKWVAHi/Jx51YOBXFHYuy7lN8j0JXE8J5eW80v01R1yGq
	H1C82zt7JtPe+5+s49wky+ez/UJhIPMQxqbzlgcqJnWJHt7oRhghvggtkHK5YnWP6HHUVaPXZst
	DgRT5zOsJbAShfZ2z3hOWnsYpMcs0LhsDGliX3oKybhopq8A7CyaGtvbzxKfuimF/gGJtCfeCD
X-Received: by 2002:a17:90b:5284:b0:396:4dfb:5890 with SMTP id 98e67ed59e1d1-396d0e5bbc0mr11833357a91.2.1787907505524;
        Fri, 28 Aug 2026 01:58:25 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9ecaa9sm3838814eec.26.2026.08.28.01.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:58:25 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	andrew.jones@oss.qualcomm.com,
	guoren@kernel.org,
	david.laight.linux@gmail.com,
	zhangzhanpeng.jasper@bytedance.com,
	yang.yicong@picoheart.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [PATCH RESEND v7 3/3] drivers/perf: riscv-iommu: protect shared state with a raw spinlock
Date: Fri, 28 Aug 2026 01:58:17 -0700
Message-ID: <20260828085819.4076449-4-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260828085819.4076449-1-zong.li@sifive.com>
References: <20260828085819.4076449-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Events are bound to one CPU and the interrupt is affine to it, so the
perf callbacks running with interrupts disabled would be enough to
exclude the handler.

PCI MSI/MSI-X on IMSIC breaks that: the irqchip sets
IRQCHIP_MOVE_DEFERRED, so irq_set_affinity() reports success while only
recording the request, and the move is applied in interrupt context upon
the next device interrupt. Until then the interrupt is still routed to
the CPU IMSIC picked initially, so the first overflow interrupt can run
concurrently with the perf callbacks on the CPU the events are bound to.

Take a raw spinlock, with interrupts disabled so that the handler can
never interrupt a holder on the same CPU, rather than depending on that
irqchip behaviour. It covers the state which is reachable from both
sides:

 - IOCOUNTINH is read-modify-written by ->start()/->stop() and is saved
   and restored around the whole handler.
 - pmu->events[] is written by ->del() and read by the handler.
 - hw_perf_event::prev_count is updated by both.

->add() and ->del() call the unlocked __riscv_iommu_pmu_start() and
__riscv_iommu_pmu_stop() so the lock is taken once per callback.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/perf/riscv_iommu_pmu.c | 66 ++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pmu.c
index f6acd56f2f61..ee2f6d1fbece 100644
--- a/drivers/perf/riscv_iommu_pmu.c
+++ b/drivers/perf/riscv_iommu_pmu.c
@@ -101,6 +101,7 @@ struct riscv_iommu_pmu {
 	u64 event_cntr_mask;
 	struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
 	DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_NUM);
+	raw_spinlock_t lock;
 };
 
 #define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu, pmu))
@@ -485,7 +486,8 @@ static void riscv_iommu_pmu_update(struct perf_event *event)
 	local64_add(delta, &event->count);
 }
 
-static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
+/* Called with pmu->lock held */
+static void __riscv_iommu_pmu_start(struct perf_event *event, int flags)
 {
 	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
@@ -500,11 +502,22 @@ static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
 	riscv_iommu_pmu_set_period(event);
 	riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
 	riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
+}
+
+static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	unsigned long irqflags;
+
+	raw_spin_lock_irqsave(&pmu->lock, irqflags);
+	__riscv_iommu_pmu_start(event, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
 
 	perf_event_update_userpage(event);
 }
 
-static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
+/* Called with pmu->lock held */
+static void __riscv_iommu_pmu_stop(struct perf_event *event, int flags)
 {
 	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
@@ -521,13 +534,26 @@ static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
 	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
 }
 
+static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
+{
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	unsigned long irqflags;
+
+	raw_spin_lock_irqsave(&pmu->lock, irqflags);
+	__riscv_iommu_pmu_stop(event, flags);
+	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
+}
+
 static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
 {
 	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned int num_counters = pmu->num_counters;
+	unsigned long irqflags;
 	unsigned int idx;
 
+	raw_spin_lock_irqsave(&pmu->lock, irqflags);
+
 	/* Reserve index zero for iohpmcycles */
 	if (is_cycle_event(event->attr.config))
 		idx = RISCV_IOMMU_HPM_CYCLE_IDX;
@@ -535,8 +561,10 @@ static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
 		idx = find_next_zero_bit(pmu->used_counters, num_counters, 1);
 
 	/* All event counters or cycle counter are in use */
-	if (idx == num_counters || pmu->events[idx])
+	if (idx == num_counters || pmu->events[idx]) {
+		raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
 		return -EAGAIN;
+	}
 
 	set_bit(idx, pmu->used_counters);
 
@@ -546,7 +574,9 @@ static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
 	local64_set(&hwc->prev_count, 0);
 
 	if (flags & PERF_EF_START)
-		riscv_iommu_pmu_start(event, flags);
+		__riscv_iommu_pmu_start(event, flags);
+
+	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
 
 	/* Propagate changes to the userspace mapping. */
 	perf_event_update_userpage(event);
@@ -556,18 +586,26 @@ static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
 
 static void riscv_iommu_pmu_read(struct perf_event *event)
 {
+	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
+	unsigned long irqflags;
+
+	raw_spin_lock_irqsave(&pmu->lock, irqflags);
 	riscv_iommu_pmu_update(event);
+	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
 }
 
 static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
 {
 	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	unsigned long irqflags;
 	int idx = hwc->idx;
 
-	riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
+	raw_spin_lock_irqsave(&pmu->lock, irqflags);
+	__riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
 	pmu->events[idx] = NULL;
 	clear_bit(idx, pmu->used_counters);
+	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
 
 	perf_event_update_userpage(event);
 }
@@ -635,12 +673,24 @@ static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
 {
 	struct riscv_iommu_pmu *pmu = (struct riscv_iommu_pmu *)dev_id;
 	DECLARE_BITMAP(ovf_bitmap, BITS_PER_TYPE(u64));
+	unsigned long irqflags;
 	u32 ovf, idx, inhibit;
 
-	/* Check whether this interrupt is for PMU */
+	/*
+	 * Check whether this interrupt is for PMU. Done outside the lock so
+	 * that a shared interrupt line is left alone as cheaply as possible.
+	 */
 	if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IOMMU_IPSR_PMIP))
 		return IRQ_NONE;
 
+	/*
+	 * Hold the lock across the whole sequence below. Stopping the
+	 * counters, processing them and restoring the previous inhibit state
+	 * has to be atomic against ->start()/->stop(), otherwise a counter
+	 * enabled in between would be inhibited again by the restore.
+	 */
+	raw_spin_lock_irqsave(&pmu->lock, irqflags);
+
 	/* Process PMU IRQ */
 	inhibit = riscv_iommu_pmu_stop_all(pmu);
 
@@ -672,6 +722,8 @@ static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
 
 	riscv_iommu_pmu_start_all(pmu, inhibit);
 
+	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
+
 	return IRQ_HANDLED;
 }
 
@@ -735,6 +787,8 @@ static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
 
 	iommu_pmu->reg = iommu_dev->reg;
 
+	raw_spin_lock_init(&iommu_pmu->lock);
+
 	/*
 	 * Counter number and width are hardware-implemented, detect them by
 	 * writing 1s and reading back which bits stuck.
-- 
2.43.7

