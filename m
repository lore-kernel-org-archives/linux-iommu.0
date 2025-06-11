Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD125C6F0
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682027; cv=none; b=lkJHZudx/cO5FiG0C7JgwgnL2dScDF5irBY7uPVUqYb6ODN9z3U1Xx67TXwFJ7nmbHRTM8ECqdTn+NPYpQpdgqP6TNeFMnyMBSNeoFW+z9zOKRjTfEhoXgK2p5yoYXaYiqZFpe2K22Hq59N6OmmMMd2Eg+kr/tisWvOZO5Q8+ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682027; c=relaxed/simple;
	bh=nhO9AJ2DKWgBiI59E4TAe7DzX+Mc4n5YDOeWg7WQ1Ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h6/XerFG/w0LTTwbdC8jBYZ1Cv0pFyZCfZhLyCzLJfYX/BErgf/J6QoSTnfUWPW74jpcFXMBckX8gauXWX707SP2O1A5/RA0tfIxeqbiW+AtxDO+ct+D8a8OLevfHKqduiosN8JvkZ5EfNPHl/qN6BF81D1IgIlvNvnGT/j+OV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ApVu1o/Z; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ApVu1o/Z"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2f5cb0c101so157709a12.1
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682024; x=1750286824; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/l8+b9e0/Q6QTTa/X+Y9bPUN62TvEMYxM1Z2IjZuFKU=;
        b=ApVu1o/ZBAwAiLL63IUPa1BWqE8OvoVcejr2YORP1qJsr9NDO1nSMxEHUf+i4XGFzp
         pdHe++sxk0PmYG+MR1Pp6d0o5nSmNJXvm188F6YRWCJ7w6bCARkClYrhAes902I5tRRO
         KLeKDOtDyMh7iTn/25FnWY2aewvUu3Q5xV+XU6T02sqiOUz5ASXaCu4qFdABNwmLRSmG
         t1Z/GlV/Hw7qB3TeKndOblr7ImnhPcXUEqpAdQ6WyQSr5wv4eMZduP+cld/2SZILAgCr
         TyO09RdJo9IS+2VdoWUCAuq9DwyNfppVaiInaif7lY035N47f0rIgl+qcLb/plNachYB
         40jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682024; x=1750286824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/l8+b9e0/Q6QTTa/X+Y9bPUN62TvEMYxM1Z2IjZuFKU=;
        b=t9FYKEIiHvmobDTQI6tfuImM/ZwFX6y0alwZcxUrJYH/mrCw/nsQeadxLGrDAZ2NNa
         Y2gdBy3F9y/w/G8VnFNT6TxRy0LYZsYW1Dz6nJGWPuJWmwza5vsB4w2Wj79wAFhPxMlv
         U4PZ00yoJQmyqHADhpvU1amnHGMRCZyo9Vu6GfSZneHd7oNefM4ZE7wVNK0lwbvZHwzQ
         hm4vxpQni7X3QGCjTTQvK0mQgpOJaLDOHJdAB3RPQ7yVecz01B7JXfCPXk3UMyS95owx
         yP35pltb7ytnzIBbf9RFsJ7ueC10dL3+5DPqDG7ltljaZnLcqXfCiKUsUKTv9ShaoqCh
         CkqA==
X-Forwarded-Encrypted: i=1; AJvYcCUSRP9htONeJ1jfYU9lSCTBnGTa5448S3mfmKyt79dVYQaQMhWiDe7tZgN43GyEsu1g5OreRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtRg+6TE4UrGSpypaRLXZd0IK8FCVymK96oenvjbq7EJ3I+TyA
	p51Ip880LKIzQAX7xvl10XiOqDJggZ3i0vb8rLvw8jvKPE94/Q7Nc9rHVthEh7IZmjCfCbE1cgk
	YWxuMfQ==
X-Google-Smtp-Source: AGHT+IEwLPp9ZwKHHJvdCNATCEbEk7/i7MtOM/rrdXxEjxE0o72kz2eYLC0EZSMjrHeYRytdHRQAnkeACcE=
X-Received: from pfva20.prod.google.com ([2002:a05:6a00:c94:b0:746:2414:11ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d9a:b0:21f:5532:1e53
 with SMTP id adf61e73a8af0-21f9b938a55mr541389637.33.1749682024419; Wed, 11
 Jun 2025 15:47:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:08 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-7-seanjc@google.com>
Subject: [PATCH v3 05/62] KVM: SVM: Delete IRTE link from previous vCPU before
 setting new IRTE
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Delete the previous per-vCPU IRTE link prior to modifying the IRTE.  If
forcing the IRTE back to remapped mode fails, the IRQ is already broken;
keeping stale metadata won't change that, and the IOMMU should be
sufficiently paranoid to sanitize the IRTE when the IRQ is freed and
reallocated.

This will allow hoisting the vCPU tracking to common x86, which in turn
will allow most of the IRTE update code to be deduplicated.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 60 +++++++++------------------------------
 include/linux/kvm_irqfd.h |  1 +
 2 files changed, 14 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d33c01379421..ed7374f0bd5a 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -766,23 +766,19 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 	return ret;
 }
 
-static void svm_ir_list_del(struct vcpu_svm *svm,
-			    struct kvm_kernel_irqfd *irqfd,
-			    struct amd_iommu_pi_data *pi)
+static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
 {
+	struct kvm_vcpu *vcpu = irqfd->irq_bypass_vcpu;
 	unsigned long flags;
-	struct kvm_kernel_irqfd *cur;
 
-	spin_lock_irqsave(&svm->ir_list_lock, flags);
-	list_for_each_entry(cur, &svm->ir_list, vcpu_list) {
-		if (cur->irq_bypass_data != pi->ir_data)
-			continue;
-		if (WARN_ON_ONCE(cur != irqfd))
-			continue;
-		list_del(&irqfd->vcpu_list);
-		break;
-	}
-	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
+	if (!vcpu)
+		return;
+
+	spin_lock_irqsave(&to_svm(vcpu)->ir_list_lock, flags);
+	list_del(&irqfd->vcpu_list);
+	spin_unlock_irqrestore(&to_svm(vcpu)->ir_list_lock, flags);
+
+	irqfd->irq_bypass_vcpu = NULL;
 }
 
 static int svm_ir_list_add(struct vcpu_svm *svm,
@@ -795,24 +791,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
 	if (WARN_ON_ONCE(!pi->ir_data))
 		return -EINVAL;
 
-	/**
-	 * In some cases, the existing irte is updated and re-set,
-	 * so we need to check here if it's already been * added
-	 * to the ir_list.
-	 */
-	if (pi->prev_ga_tag) {
-		struct kvm *kvm = svm->vcpu.kvm;
-		u32 vcpu_id = AVIC_GATAG_TO_VCPUID(pi->prev_ga_tag);
-		struct kvm_vcpu *prev_vcpu = kvm_get_vcpu_by_id(kvm, vcpu_id);
-		struct vcpu_svm *prev_svm;
-
-		if (!prev_vcpu)
-			return -EINVAL;
-
-		prev_svm = to_svm(prev_vcpu);
-		svm_ir_list_del(prev_svm, irqfd, pi);
-	}
-
+	irqfd->irq_bypass_vcpu = &svm->vcpu;
 	irqfd->irq_bypass_data = pi->ir_data;
 
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
@@ -904,6 +883,8 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 
 		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
 
+		svm_ir_list_del(irqfd);
+
 		/**
 		 * Here, we setup with legacy mode in the following cases:
 		 * 1. When cannot target interrupt to a specific vcpu.
@@ -962,21 +943,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		pi.prev_ga_tag = 0;
 		pi.is_guest_mode = false;
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
-
-		/**
-		 * Check if the posted interrupt was previously
-		 * setup with the guest_mode by checking if the ga_tag
-		 * was cached. If so, we need to clean up the per-vcpu
-		 * ir_list.
-		 */
-		if (!ret && pi.prev_ga_tag) {
-			int id = AVIC_GATAG_TO_VCPUID(pi.prev_ga_tag);
-			struct kvm_vcpu *vcpu;
-
-			vcpu = kvm_get_vcpu_by_id(kvm, id);
-			if (vcpu)
-				svm_ir_list_del(to_svm(vcpu), irqfd, &pi);
-		}
 	}
 out:
 	srcu_read_unlock(&kvm->irq_srcu, idx);
diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
index 6510a48e62aa..361c07f4466d 100644
--- a/include/linux/kvm_irqfd.h
+++ b/include/linux/kvm_irqfd.h
@@ -60,6 +60,7 @@ struct kvm_kernel_irqfd {
 	struct irq_bypass_consumer consumer;
 	struct irq_bypass_producer *producer;
 
+	struct kvm_vcpu *irq_bypass_vcpu;
 	struct list_head vcpu_list;
 	void *irq_bypass_data;
 };
-- 
2.50.0.rc1.591.g9c95f17f64-goog

