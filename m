Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25E210F53
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962019; cv=none; b=ndnEVH1IbRmZ08ZSkevZmctHgAZ6kdT2YmFhH1qXhmne7T6p+pErBEZAaBDRZhkrGSqL8FgKwZ824Cj5zrh7X2Chh3WGS4wJmNsveLTmhxyGrE66Z6Vqn21gSpO8Yvs1n/WlIM19Z7LTLSBJwT1RBKvYtFYCx8aRZk7+B5btBSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962019; c=relaxed/simple;
	bh=mvkZYjU4uGxDblpZA8nNBV7n4sCKASVs9pybsjf603s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LmxQXZD8Tte7v5i2WlbdXS8LSK9FBhGP8vZkxixprm+VJzMK/4GxNtrv1Mq+OUuGKqzd6zp+F0AHz5U60J01uYTYQ+IUZWNYBvI0TzYuGLX+V8LTnoCqcrJLfogbla58xqB7bL48isGMcij9vX0VSR0pDiKRKBv+I4r3vfxeeAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkqs3Apb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkqs3Apb"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ed6bd1b4cso7453342a91.0
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962014; x=1748566814; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SuttjA1uv1MM8ghxAd18nmuJvf/ZeQZQp2cdIz4Q+kA=;
        b=jkqs3ApbC40qTBDniHR00ZJJA8ZaoXuHsA4V9P0hzSguTDTK3ktYf4YjMk3Q63Yrw+
         4bo8/mG03fc3oEEYWK/1gi0geVx3RFwuDJ6A/9n+AJ8UMw6z9nDPBlrq4BmXzOTvedp3
         rORkHsF4nXAVaDomJ1tZZZYyLDuQuOct8cE4j5UdUJ8ZWmutBZtKbHCMzxhPpx1a1909
         W79s+k1vrBk2oNGmK+49Aldpd7YDAu+AzMb+sXvXVw5R/I/69lBqTO8h1lxqmzlQgqeM
         Nnz2QhvigRbS1pjcECEFgWqwsAN0pEzJubID1Es+TRY0x4W2XUDjELYlOHzIAofnuIKe
         P3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962014; x=1748566814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuttjA1uv1MM8ghxAd18nmuJvf/ZeQZQp2cdIz4Q+kA=;
        b=SCy36fTI9KnWFrzG0mBO12As638sW2aL3xkN/eqG5aLwaLOtGc+C+eDdpt6wVlQr9m
         zMRLbt9/eRy5wsCZ7ojUpMbHdj98eHYfyMkX/CdxfeNDpNs/ecS4XN4r9GwSGXlkcjlQ
         mC6CLndSXsE+tkwxN90GHoolEkjC0qNxkwZOz3jPINmfhD8MYvcHsqWfWQXnw3bVkU0S
         ufHhrgjh9dej4qwIddIzjJJWxUysS5Fkje8coZWh1YCOX/001CHpZ5uAIF1bW00elCuo
         tO9UsLX4Yc0k4KWjPTp2GlyuS6HgMTqY8QiZ+e5Q36CToz75gNYx6CT2jIwplruE/78B
         kTOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW1hB3ctKQ6k7jZx82B2MPxI4h3aUvgZcXM4IPLXpbRGICEBp/Zt5uE9JROz9FACBXIxKoPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmdyiPlZq9nZjKWVgkatXpiSVRrL/3a9qgqFsREwmljYdAeDuR
	ONHqn5u7XD7nntFpmZ+DLsamgx4u5JMQmgwDvXpWglXBm95ps+1AyPz+5akEwqviIM7+qThTqU7
	5HsJ6CA==
X-Google-Smtp-Source: AGHT+IHvGfEkd5Q2ffJqUBN9h8J/z7B3st8B6OlB6B7Gzf7cq9xOto4DtaM1MY5H2e6vi787gSdtHFnKCYE=
X-Received: from pjbqo12.prod.google.com ([2002:a17:90b:3dcc:b0:2ea:3a1b:f493])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54d0:b0:305:2d68:8d57
 with SMTP id 98e67ed59e1d1-30e830ca02bmr33157665a91.5.1747962014026; Thu, 22
 May 2025 18:00:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:07 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-3-seanjc@google.com>
Subject: [PATCH v2 02/59] KVM: SVM: Track per-vCPU IRTEs using
 kvm_kernel_irqfd structure
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Track the IRTEs that are posting to an SVM vCPU via the associated irqfd
structure and GSI routing instead of dynamically allocating a separate
data structure.  In addition to eliminating an atomic allocation, this
will allow hoisting much of the IRTE update logic to common x86.

Cc: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 71 +++++++++++++++------------------------
 arch/x86/kvm/svm/svm.h    | 10 +++---
 include/linux/kvm_irqfd.h |  3 ++
 3 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index adacf00d6664..d33c01379421 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -75,14 +75,6 @@ static bool next_vm_id_wrapped = 0;
 static DEFINE_SPINLOCK(svm_vm_data_hash_lock);
 bool x2avic_enabled;
 
-/*
- * This is a wrapper of struct amd_iommu_ir_data.
- */
-struct amd_svm_iommu_ir {
-	struct list_head node;	/* Used by SVM for per-vcpu ir_list */
-	void *data;		/* Storing pointer to struct amd_ir_data */
-};
-
 static void avic_activate_vmcb(struct vcpu_svm *svm)
 {
 	struct vmcb *vmcb = svm->vmcb01.ptr;
@@ -746,8 +738,8 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 {
 	int ret = 0;
 	unsigned long flags;
-	struct amd_svm_iommu_ir *ir;
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct kvm_kernel_irqfd *irqfd;
 
 	if (!kvm_arch_has_assigned_device(vcpu->kvm))
 		return 0;
@@ -761,11 +753,11 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 	if (list_empty(&svm->ir_list))
 		goto out;
 
-	list_for_each_entry(ir, &svm->ir_list, node) {
+	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list) {
 		if (activate)
-			ret = amd_iommu_activate_guest_mode(ir->data);
+			ret = amd_iommu_activate_guest_mode(irqfd->irq_bypass_data);
 		else
-			ret = amd_iommu_deactivate_guest_mode(ir->data);
+			ret = amd_iommu_deactivate_guest_mode(irqfd->irq_bypass_data);
 		if (ret)
 			break;
 	}
@@ -774,27 +766,30 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 	return ret;
 }
 
-static void svm_ir_list_del(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
+static void svm_ir_list_del(struct vcpu_svm *svm,
+			    struct kvm_kernel_irqfd *irqfd,
+			    struct amd_iommu_pi_data *pi)
 {
 	unsigned long flags;
-	struct amd_svm_iommu_ir *cur;
+	struct kvm_kernel_irqfd *cur;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
-	list_for_each_entry(cur, &svm->ir_list, node) {
-		if (cur->data != pi->ir_data)
+	list_for_each_entry(cur, &svm->ir_list, vcpu_list) {
+		if (cur->irq_bypass_data != pi->ir_data)
 			continue;
-		list_del(&cur->node);
-		kfree(cur);
+		if (WARN_ON_ONCE(cur != irqfd))
+			continue;
+		list_del(&irqfd->vcpu_list);
 		break;
 	}
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
 
-static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
+static int svm_ir_list_add(struct vcpu_svm *svm,
+			   struct kvm_kernel_irqfd *irqfd,
+			   struct amd_iommu_pi_data *pi)
 {
-	int ret = 0;
 	unsigned long flags;
-	struct amd_svm_iommu_ir *ir;
 	u64 entry;
 
 	if (WARN_ON_ONCE(!pi->ir_data))
@@ -811,25 +806,14 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 		struct kvm_vcpu *prev_vcpu = kvm_get_vcpu_by_id(kvm, vcpu_id);
 		struct vcpu_svm *prev_svm;
 
-		if (!prev_vcpu) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!prev_vcpu)
+			return -EINVAL;
 
 		prev_svm = to_svm(prev_vcpu);
-		svm_ir_list_del(prev_svm, pi);
+		svm_ir_list_del(prev_svm, irqfd, pi);
 	}
 
-	/**
-	 * Allocating new amd_iommu_pi_data, which will get
-	 * add to the per-vcpu ir_list.
-	 */
-	ir = kzalloc(sizeof(struct amd_svm_iommu_ir), GFP_ATOMIC | __GFP_ACCOUNT);
-	if (!ir) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	ir->data = pi->ir_data;
+	irqfd->irq_bypass_data = pi->ir_data;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
 
@@ -844,10 +828,9 @@ static int svm_ir_list_add(struct vcpu_svm *svm, struct amd_iommu_pi_data *pi)
 		amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
 				    true, pi->ir_data);
 
-	list_add(&ir->node, &svm->ir_list);
+	list_add(&irqfd->vcpu_list, &svm->ir_list);
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
-out:
-	return ret;
+	return 0;
 }
 
 /*
@@ -951,7 +934,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			 * scheduling information in IOMMU irte.
 			 */
 			if (!ret && pi.is_guest_mode)
-				svm_ir_list_add(svm, &pi);
+				svm_ir_list_add(svm, irqfd, &pi);
 		}
 
 		if (!ret && svm) {
@@ -992,7 +975,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 
 			vcpu = kvm_get_vcpu_by_id(kvm, id);
 			if (vcpu)
-				svm_ir_list_del(to_svm(vcpu), &pi);
+				svm_ir_list_del(to_svm(vcpu), irqfd, &pi);
 		}
 	}
 out:
@@ -1004,8 +987,8 @@ static inline int
 avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu, bool r)
 {
 	int ret = 0;
-	struct amd_svm_iommu_ir *ir;
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct kvm_kernel_irqfd *irqfd;
 
 	lockdep_assert_held(&svm->ir_list_lock);
 
@@ -1019,8 +1002,8 @@ avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu, bool r)
 	if (list_empty(&svm->ir_list))
 		return 0;
 
-	list_for_each_entry(ir, &svm->ir_list, node) {
-		ret = amd_iommu_update_ga(cpu, r, ir->data);
+	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list) {
+		ret = amd_iommu_update_ga(cpu, r, irqfd->irq_bypass_data);
 		if (ret)
 			return ret;
 	}
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index b35fce30d923..cc27877d69ae 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -310,10 +310,12 @@ struct vcpu_svm {
 	u64 *avic_physical_id_cache;
 
 	/*
-	 * Per-vcpu list of struct amd_svm_iommu_ir:
-	 * This is used mainly to store interrupt remapping information used
-	 * when update the vcpu affinity. This avoids the need to scan for
-	 * IRTE and try to match ga_tag in the IOMMU driver.
+	 * Per-vCPU list of irqfds that are eligible to post IRQs directly to
+	 * the vCPU (a.k.a. device posted IRQs, a.k.a. IRQ bypass).  The list
+	 * is used to reconfigure IRTEs when the vCPU is loaded/put (to set the
+	 * target pCPU), when AVIC is toggled on/off (to (de)activate bypass),
+	 * and if the irqfd becomes ineligible for posting (to put the IRTE
+	 * back into remapped mode).
 	 */
 	struct list_head ir_list;
 	spinlock_t ir_list_lock;
diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index 8ad43692e3bb..6510a48e62aa 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -59,6 +59,9 @@ struct kvm_kernel_irqfd {
 	struct work_struct shutdown;
 	struct irq_bypass_consumer consumer;
 	struct irq_bypass_producer *producer;
+
+	struct list_head vcpu_list;
+	void *irq_bypass_data;
 };
 
 #endif /* __LINUX_KVM_IRQFD_H */
-- 
2.49.0.1151.ga128411c76-goog

