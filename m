Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42052C43464
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D5220C56
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S90AruaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D5220C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8D32C877F4;
	Fri, 18 Sep 2020 10:20:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RQHgypT9nt9r; Fri, 18 Sep 2020 10:20:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 47D5E877F8;
	Fri, 18 Sep 2020 10:20:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28900C0891;
	Fri, 18 Sep 2020 10:20:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F84EC0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6B64187691
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:20:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18TMrWv1WQ4D for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 10:20:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0B6CF87683
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 10:20:01 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id r7so7328656ejs.11
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 03:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AEV16NDJGTM7XqSMn6JieZzSV8SZ84xCpMhaKhX/5mU=;
 b=S90AruaZ1mwZkAKEMeNU+c5XlqJnlb8d8HmLqZhKhUnd70VBSB/ulp92s5z8d+gB3m
 ArXG1HXSsPL7j1BourPnlBxg/swlAR+0j0Uco1brUhGhx2hFpJ6iWTkRo45CESZbFRlu
 9h3o/4qXO92Nj7i+9LSf2Cf6A6ssmg4Vjx+t16bmKuc/oOmTQtS5L5WgrPIFl5/YAXOi
 x//n4q+m5cMtXCLkNPZZeq60LqUYDoLdXpxKKF8oZXAm+buf9TK8JqBplPxSUhlxvqRA
 BBr7MjEigC0SHxtBiv54W8jQG+7Q5u8b56lW+kpG13Twz+8muayFnfJJ6B5BDUd42ROm
 7lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AEV16NDJGTM7XqSMn6JieZzSV8SZ84xCpMhaKhX/5mU=;
 b=K4uNuKX9q25pMPXCWW/sVKc+E3Se7aaOGanPRBdGpBKjxE5tfgopc6mzZkijeTBa3d
 WdxA8H/asF+wVKKDEAO62LS4+JoplmOhDBckT/3QQznoqn6rUGqmuulnMjJNVqchEFsi
 x1HdRLKfR1PiokGrRvwNXUZVYtgGXX/hsg2cNP+DcmdGcNfXf8MaX0k8VokWzi/vocjQ
 YW89RhMqlONb8glKG/mpNhy0wupWIqGb4pDx+/hNs5Z7DQLNgDH1rXu7OBE9blROPni6
 d4HcOx6I9cj02JAsx3w7zAP4Da+6o87JGB7KWcTgEmdqN3VqKwAPFVhKLzPyIPTG/yMe
 2Auw==
X-Gm-Message-State: AOAM5327jLvsSgEqmj/kH6DQpRLxLlVQEY30JlERcgyGby2PvxEQb/8D
 7WABQKnKrGw7EnYZv0RTweXqqJpnL7lpmZ9W
X-Google-Smtp-Source: ABdhPJyXqGDWlcufEF95+0zsxMabZUA7+iwul16wn9fpoIAw4nF4GGVvByfiKstK0D6A8STkXAl6wQ==
X-Received: by 2002:a17:906:b04a:: with SMTP id
 bj10mr34988731ejb.303.1600424398955; 
 Fri, 18 Sep 2020 03:19:58 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r16sm1940674edc.57.2020.09.18.03.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 03:19:58 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
Subject: [PATCH v10 04/13] arm64: mm: Pin down ASIDs for sharing mm with
 devices
Date: Fri, 18 Sep 2020 12:18:44 +0200
Message-Id: <20200918101852.582559-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918101852.582559-1-jean-philippe@linaro.org>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 catalin.marinas@arm.com, robin.murphy@arm.com, zhangfei.gao@linaro.org,
 will@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

To enable address space sharing with the IOMMU, introduce
arm64_mm_context_get() and arm64_mm_context_put(), that pin down a
context and ensure that it will keep its ASID after a rollover. Export
the symbols to let the modular SMMUv3 driver use them.

Pinning is necessary because a device constantly needs a valid ASID,
unlike tasks that only require one when running. Without pinning, we would
need to notify the IOMMU when we're about to use a new ASID for a task,
and it would get complicated when a new task is assigned a shared ASID.
Consider the following scenario with no ASID pinned:

1. Task t1 is running on CPUx with shared ASID (gen=1, asid=1)
2. Task t2 is scheduled on CPUx, gets ASID (1, 2)
3. Task tn is scheduled on CPUy, a rollover occurs, tn gets ASID (2, 1)
   We would now have to immediately generate a new ASID for t1, notify
   the IOMMU, and finally enable task tn. We are holding the lock during
   all that time, since we can't afford having another CPU trigger a
   rollover. The IOMMU issues invalidation commands that can take tens of
   milliseconds.

It gets needlessly complicated. All we wanted to do was schedule task tn,
that has no business with the IOMMU. By letting the IOMMU pin tasks when
needed, we avoid stalling the slow path, and let the pinning fail when
we're out of shareable ASIDs.

After a rollover, the allocator expects at least one ASID to be available
in addition to the reserved ones (one per CPU). So (NR_ASIDS - NR_CPUS -
1) is the maximum number of ASIDs that can be shared with the IOMMU.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/include/asm/mmu.h         |   3 +
 arch/arm64/include/asm/mmu_context.h |  11 ++-
 arch/arm64/mm/context.c              | 105 +++++++++++++++++++++++++--
 3 files changed, 112 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index a7a5ecaa2e83..0fda85b2cc1b 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -17,11 +17,14 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/refcount.h>
+
 typedef struct {
 	atomic64_t	id;
 #ifdef CONFIG_COMPAT
 	void		*sigpage;
 #endif
+	refcount_t	pinned;
 	void		*vdso;
 	unsigned long	flags;
 } mm_context_t;
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index f2d7537d6f83..0672236e1aea 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -177,7 +177,13 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
 #define destroy_context(mm)		do { } while(0)
 void check_and_switch_context(struct mm_struct *mm);
 
-#define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
+static inline int
+init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	atomic64_set(&mm->context.id, 0);
+	refcount_set(&mm->context.pinned, 0);
+	return 0;
+}
 
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 static inline void update_saved_ttbr0(struct task_struct *tsk,
@@ -248,6 +254,9 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
 
+unsigned long arm64_mm_context_get(struct mm_struct *mm);
+void arm64_mm_context_put(struct mm_struct *mm);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* !__ASM_MMU_CONTEXT_H */
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 9b11c096a042..001737a8f309 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -27,6 +27,10 @@ static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
 static cpumask_t tlb_flush_pending;
 
+static unsigned long max_pinned_asids;
+static unsigned long nr_pinned_asids;
+static unsigned long *pinned_asid_map;
+
 #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
 #define ASID_FIRST_VERSION	(1UL << asid_bits)
 
@@ -72,7 +76,7 @@ void verify_cpu_asid_bits(void)
 	}
 }
 
-static void set_kpti_asid_bits(void)
+static void set_kpti_asid_bits(unsigned long *map)
 {
 	unsigned int len = BITS_TO_LONGS(NUM_USER_ASIDS) * sizeof(unsigned long);
 	/*
@@ -81,13 +85,15 @@ static void set_kpti_asid_bits(void)
 	 * is set, then the ASID will map only userspace. Thus
 	 * mark even as reserved for kernel.
 	 */
-	memset(asid_map, 0xaa, len);
+	memset(map, 0xaa, len);
 }
 
 static void set_reserved_asid_bits(void)
 {
-	if (arm64_kernel_unmapped_at_el0())
-		set_kpti_asid_bits();
+	if (pinned_asid_map)
+		bitmap_copy(asid_map, pinned_asid_map, NUM_USER_ASIDS);
+	else if (arm64_kernel_unmapped_at_el0())
+		set_kpti_asid_bits(asid_map);
 	else
 		bitmap_clear(asid_map, 0, NUM_USER_ASIDS);
 }
@@ -165,6 +171,14 @@ static u64 new_context(struct mm_struct *mm)
 		if (check_update_reserved_asid(asid, newasid))
 			return newasid;
 
+		/*
+		 * If it is pinned, we can keep using it. Note that reserved
+		 * takes priority, because even if it is also pinned, we need to
+		 * update the generation into the reserved_asids.
+		 */
+		if (refcount_read(&mm->context.pinned))
+			return newasid;
+
 		/*
 		 * We had a valid ASID in a previous life, so try to re-use
 		 * it if possible.
@@ -256,6 +270,71 @@ void check_and_switch_context(struct mm_struct *mm)
 		cpu_switch_mm(mm->pgd, mm);
 }
 
+unsigned long arm64_mm_context_get(struct mm_struct *mm)
+{
+	unsigned long flags;
+	u64 asid;
+
+	if (!pinned_asid_map)
+		return 0;
+
+	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+
+	asid = atomic64_read(&mm->context.id);
+
+	if (refcount_inc_not_zero(&mm->context.pinned))
+		goto out_unlock;
+
+	if (nr_pinned_asids >= max_pinned_asids) {
+		asid = 0;
+		goto out_unlock;
+	}
+
+	if (!asid_gen_match(asid)) {
+		/*
+		 * We went through one or more rollover since that ASID was
+		 * used. Ensure that it is still valid, or generate a new one.
+		 */
+		asid = new_context(mm);
+		atomic64_set(&mm->context.id, asid);
+	}
+
+	nr_pinned_asids++;
+	__set_bit(asid2idx(asid), pinned_asid_map);
+	refcount_set(&mm->context.pinned, 1);
+
+out_unlock:
+	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+
+	asid &= ~ASID_MASK;
+
+	/* Set the equivalent of USER_ASID_BIT */
+	if (asid && arm64_kernel_unmapped_at_el0())
+		asid |= 1;
+
+	return asid;
+}
+EXPORT_SYMBOL_GPL(arm64_mm_context_get);
+
+void arm64_mm_context_put(struct mm_struct *mm)
+{
+	unsigned long flags;
+	u64 asid = atomic64_read(&mm->context.id);
+
+	if (!pinned_asid_map)
+		return;
+
+	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+
+	if (refcount_dec_and_test(&mm->context.pinned)) {
+		__clear_bit(asid2idx(asid), pinned_asid_map);
+		nr_pinned_asids--;
+	}
+
+	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+}
+EXPORT_SYMBOL_GPL(arm64_mm_context_put);
+
 /* Errata workaround post TTBRx_EL1 update. */
 asmlinkage void post_ttbr_update_workaround(void)
 {
@@ -296,8 +375,11 @@ static int asids_update_limit(void)
 {
 	unsigned long num_available_asids = NUM_USER_ASIDS;
 
-	if (arm64_kernel_unmapped_at_el0())
+	if (arm64_kernel_unmapped_at_el0()) {
 		num_available_asids /= 2;
+		if (pinned_asid_map)
+			set_kpti_asid_bits(pinned_asid_map);
+	}
 	/*
 	 * Expect allocation after rollover to fail if we don't have at least
 	 * one more ASID than CPUs. ASID #0 is reserved for init_mm.
@@ -305,6 +387,13 @@ static int asids_update_limit(void)
 	WARN_ON(num_available_asids - 1 <= num_possible_cpus());
 	pr_info("ASID allocator initialised with %lu entries\n",
 		num_available_asids);
+
+	/*
+	 * There must always be an ASID available after rollover. Ensure that,
+	 * even if all CPUs have a reserved ASID and the maximum number of ASIDs
+	 * are pinned, there still is at least one empty slot in the ASID map.
+	 */
+	max_pinned_asids = num_available_asids - num_possible_cpus() - 2;
 	return 0;
 }
 arch_initcall(asids_update_limit);
@@ -319,13 +408,17 @@ static int asids_init(void)
 		panic("Failed to allocate bitmap for %lu ASIDs\n",
 		      NUM_USER_ASIDS);
 
+	pinned_asid_map = kcalloc(BITS_TO_LONGS(NUM_USER_ASIDS),
+				  sizeof(*pinned_asid_map), GFP_KERNEL);
+	nr_pinned_asids = 0;
+
 	/*
 	 * We cannot call set_reserved_asid_bits() here because CPU
 	 * caps are not finalized yet, so it is safer to assume KPTI
 	 * and reserve kernel ASID's from beginning.
 	 */
 	if (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0))
-		set_kpti_asid_bits();
+		set_kpti_asid_bits(asid_map);
 	return 0;
 }
 early_initcall(asids_init);
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
