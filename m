Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01F3226CF6
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962036; cv=none; b=lDfOXB/yV1YOw8Y1nFufesL8UYXQM8/FE2E+A5XHaMHRmXEB4GTlnvzOfeurkWSu+JwufmasRo3xaoTjTBxrNKC+FZd9lNBeB7+SDS74zVdblwFqqRlNja+e+cdaGC5lj1QyNSNaRcFDE0EaWrRaz1smJjUZzKjS1s1tKRmlSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962036; c=relaxed/simple;
	bh=CI55+D0kEm5O6+xiEBD1DyHjTu/geN9Q80IyZ5PbyXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YGaPOmJVNisVrbgonN89WHvQEmEIvUT4EPKEGJR3/KQKaiHgNGgUWxNKnYtCuWh8UDuI29t84qIFVp5N6Foj1nlm39QCV/2La8GkbVLLiB7FEYcviM7B/8dGY7pRXbOdBmEiOJHbdn9cKSu6Llmq0ccL/5xKsnPitNtKa132ZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YbnKKA1n; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YbnKKA1n"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e0fee541so5210712a12.1
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962033; x=1748566833; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mgom0My0RXyxt3zGYxIwZj5mPyM4HyH/qZA3LIBxvLE=;
        b=YbnKKA1nYZXuYaq44Wt/9hLAXUdfoaYtDNnWKC9wlyVcjZ5sFdlXHRAWH3gUtypbpd
         BHkqgmSQ0RjT435244MwxXMQjlW33IyEge/XA+XpuPNP/Owk+GVfD0E+H5RkL03BQCMZ
         xUNlnqH370By2wIXbbVpMiPDNNqO5fZYM3AL2/surUJRKY2ZyJxG+DAHm/c7zfZb/gjw
         pc1bZNwAuOUlOnq03C+om9et3iNriVaCbp6KLPXZXheyXfQonpt1XuO56JRHMNRrUPJU
         VKInRwcRhtw8aAFki6LSC8N5GB9rB8RG7Oata4ZWkw0F/Kj2QAjRcH5qOuKhBMrtYO1F
         7lrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962033; x=1748566833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgom0My0RXyxt3zGYxIwZj5mPyM4HyH/qZA3LIBxvLE=;
        b=GgzR5SkVlBc2nqmZaM7AJJx0mL69pLIM4mLs3zyCCSzeILXicx0tTPN3svTJVy5Wd/
         KeShsObzmDajWwrxlX6SOvCgfCIXjqzYLICf6NOUvTipRRYFAAlT+kHz5GlosRTduYQ3
         eVbkHd8NgXtTQboZrmU5Rso2uWgP8Lvs+enxq8FHJ6URatkbGIK3D/7OxWsc/rlHZSVg
         egpf5lJmyvIX8bsVzsOtNxWkE7lmCFo95fVG49TNzflRqW75+67krqXA5dvJjNlIP7kL
         dLCTsHUtxdJCTU9Jn032VclJseUuAsha8au/f6E/hO0gpyH5WQ8DgJKI5ZXlS0TdJVgy
         wxIA==
X-Forwarded-Encrypted: i=1; AJvYcCVbwo3Xl7JCk0u0O/xLI1YgfK3s4k+LIedlgz2hb92CiE+j2B0VbNmLwbYO69jIkp/1etLzGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxc/2OJ3Lu0DJCDfwmBwzfJn0dQtGhoAyOsIDg0Ge0/ON1cnOhi
	pMWuOYOs9mw967QL307ZhYNJ+r5qzQ8fi216pxz4Y6N8a3yHXNpauFqcSUZyAvXeQd3anRmo0vv
	zwMFwsg==
X-Google-Smtp-Source: AGHT+IGxjUT6ZTFdn1fL46e7uP64GFmrOiUImY5wsG9IiTzQ4jbxEpbauT01oNGyrrPeVaV1B6nroWQExuI=
X-Received: from pjuw7.prod.google.com ([2002:a17:90a:d607:b0:308:867e:1ced])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c90:b0:30a:a50e:349c
 with SMTP id 98e67ed59e1d1-30e83226f25mr38441643a91.30.1747962033065; Thu, 22
 May 2025 18:00:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:18 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-14-seanjc@google.com>
Subject: [PATCH v2 13/59] KVM: SVM: Drop superfluous "cache" of AVIC Physical
 ID entry pointer
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop the vCPU's pointer to its AVIC Physical ID entry, and simply index
the table directly.  Caching a pointer address is completely unnecessary
for performance, and while the field technically caches the result of the
pointer calculation, it's all too easy to misinterpret the name and think
that the field somehow caches the _data_ in the table.

No functional change intended.

Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 27 +++++++++++++++------------
 arch/x86/kvm/svm/svm.h  |  1 -
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index bf18b0b643d9..0c0be274d29e 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -294,8 +294,6 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[id], new_entry);
 
-	svm->avic_physical_id_cache = &kvm_svm->avic_physical_id_table[id];
-
 	return 0;
 }
 
@@ -770,13 +768,16 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
 			   struct kvm_kernel_irqfd *irqfd,
 			   struct amd_iommu_pi_data *pi)
 {
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
 	unsigned long flags;
 	u64 entry;
 
 	if (WARN_ON_ONCE(!pi->ir_data))
 		return -EINVAL;
 
-	irqfd->irq_bypass_vcpu = &svm->vcpu;
+	irqfd->irq_bypass_vcpu = vcpu;
 	irqfd->irq_bypass_data = pi->ir_data;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
@@ -787,7 +788,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
 	 * will update the pCPU info when the vCPU awkened and/or scheduled in.
 	 * See also avic_vcpu_load().
 	 */
-	entry = READ_ONCE(*(svm->avic_physical_id_cache));
+	entry = READ_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id]);
 	if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
 		amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
 				    true, pi->ir_data);
@@ -964,17 +965,18 @@ avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu, bool r)
 
 void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	u64 entry;
+	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	int h_physical_id = kvm_cpu_get_apicid(cpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned long flags;
+	u64 entry;
 
 	lockdep_assert_preemption_disabled();
 
 	if (WARN_ON(h_physical_id & ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
 		return;
 
-	if (WARN_ON_ONCE(!svm->avic_physical_id_cache))
+	if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >= PAGE_SIZE))
 		return;
 
 	/*
@@ -996,14 +998,14 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	 */
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
 
-	entry = READ_ONCE(*(svm->avic_physical_id_cache));
+	entry = READ_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id]);
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
 	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
 	entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 
-	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
+	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, true);
 
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
@@ -1011,13 +1013,14 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 void avic_vcpu_put(struct kvm_vcpu *vcpu)
 {
-	u64 entry;
+	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned long flags;
+	u64 entry;
 
 	lockdep_assert_preemption_disabled();
 
-	if (WARN_ON_ONCE(!svm->avic_physical_id_cache))
+	if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >= PAGE_SIZE))
 		return;
 
 	/*
@@ -1027,7 +1030,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	 * can't be scheduled out and thus avic_vcpu_{put,load}() can't run
 	 * recursively.
 	 */
-	entry = READ_ONCE(*(svm->avic_physical_id_cache));
+	entry = READ_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id]);
 
 	/* Nothing to do if IsRunning == '0' due to vCPU blocking. */
 	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
@@ -1046,7 +1049,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	avic_update_iommu_vcpu_affinity(vcpu, -1, 0);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
-	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
+	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ec5d77d42a49..f225d0bed152 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -306,7 +306,6 @@ struct vcpu_svm {
 
 	u32 ldr_reg;
 	u32 dfr_reg;
-	u64 *avic_physical_id_cache;
 
 	/*
 	 * Per-vCPU list of irqfds that are eligible to post IRQs directly to
-- 
2.49.0.1151.ga128411c76-goog

