Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11E22259A
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795607; cv=none; b=ZCwbKNnnEbeHQjH2BctYnKtC4i6c1Qwg0mxNEsgmoAX2dsc5mYECKV14ECVVweS8bpZOetrrTIgdSfjadeJNMJ4mlNSNODmyKA0q0jWFdrtJDbsIBRh+3d1cg17BM195C3b8W60z/ZzV+4vR6Tar6nUv4Uso7GsCA+7KLE5Gi5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795607; c=relaxed/simple;
	bh=oivgLMsYP6m5xV9KLWqFEzyIJWf/41dvsC/fZbkUGSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bjsq665KM01OXUtByb6SnWHsMWnU1PM1ZUo0IgYwX5Gij4rrKGQvsY6YnaCxBJ8+kEJ5zeYuYG+4QzgzXzV99TpZEOCozPE8QHMI8GD9WiZ9+co995uWNEqOUWz4wylZK6O3PupsWUTT0f39eB0+Pb3Lquc5Ljju8ThG4HOhwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MlhTREOh; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MlhTREOh"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7370e73f690so2788739b3a.3
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795604; x=1744400404; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ocleBBvlKr6feyKde42bUZgR4JDW1n63+aHvVvZVcGU=;
        b=MlhTREOhkrC45dlNkZ1ZoPF0m15rgxnSY1JBbeq4E3g1AcWQ/VDmWn3kwufTUhXL3t
         nfNCIFURTJoTe681rvKL7DTwUdxRadFBbLZhD3RZ5rZCqHLSWUQSa1/nWAa1nPDB92SW
         Bf5/c09TEUpXcE5aSapGoCoZbaoJWfnvE2x0aKF2xPyGuOoFzKIXjdThBHhUCp8UesRM
         9kAF7zbKHWUA49XT7b9/h8u3ZnoM+boQjwJfJvrwX8hUXXg980BBkfseQTT2i+KggvDB
         WY1U8gAugrkA2IfMdt4sAy2tgY+DwySOy0YobnyaMQdt6cOGy62Z6O4SBhAKR9qR6MD1
         n5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795604; x=1744400404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ocleBBvlKr6feyKde42bUZgR4JDW1n63+aHvVvZVcGU=;
        b=n/Yy3yAb/Ab8XhaO1Ep0HotY2y/JdXSB03EqtOjS7Uj0h8xxLWD54C1e9k+KwoDRuS
         VXxIK4f1YM+FrQ73LdwrBA7QtuOzFsqSMOduFr96lcpK8BRsNrJ5jnEH93jJ7nFJ0brW
         19Jn8gODAtenfjMnbZdNynUfi+KXG4RP5gebKLRHPeMfemqKE2+lHIKxW1GLX9p7QduC
         3Y0Msm03XwaMEWN1g6NGNWqTaKRDDYJqJGh+hJ4FAP6ncziB6OeYnY8M8und1IOK1oOO
         NgrmlIAkwlTamiSivxd7mjSakyF4vW7Vx957FYG2gvA3yEJL/Tb8tqsBv+xD8i32A0Fk
         iNMw==
X-Forwarded-Encrypted: i=1; AJvYcCWK+JXGAQysMYdq4BB7vpAlWy90dBQ1sBdjaBWU+Jn1X/5035SMpQumjtSLWqjK8ONNe95JTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVnPtyx0HeaWr/vyUn0v8pNVrihLLZilBh2sNnLNA7TLf1EMTd
	5Ia0iaqcXVeo17BfvYwMVjpfuOgNCbmImCZ/NkatOuHGifQC3+cJ1Sr8abVAzktzMEv/C4+K+ch
	CXw==
X-Google-Smtp-Source: AGHT+IH2fhk1BClfEw9pVUM6hqP/FRNe9lFGePO9NibjY1q3A6Bve4xhICh/FTFH3jra1e+6rrGPO6LW4yo=
X-Received: from pfxa29.prod.google.com ([2002:a05:6a00:1d1d:b0:736:a983:dc43])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a04:b0:736:3e50:bfec
 with SMTP id d2e1a72fcca58-73b6aa3d9b9mr861903b3a.8.1743795604041; Fri, 04
 Apr 2025 12:40:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:25 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-11-seanjc@google.com>
Subject: [PATCH 10/67] KVM: SVM: Delete IRTE link from previous vCPU before
 setting new IRTE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Delete the previous per-vCPU IRTE link prior to modifying the IRTE.  If
forcing the IRTE back to remapped mode fails, the IRQ is already broken;
keeping stale metadata won't change that, and the IOMMU should be
sufficiently paranoid to sanitize the IRTE when the IRQ is freed and
reallocated.

This will allow hoisting the vCPU tracking to common x86, which in turn
will allow most of the IRTE update code to be deduplicated.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 61 +++++++++------------------------------
 include/linux/kvm_irqfd.h |  1 +
 2 files changed, 15 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 967618ba743a..02b6f0007436 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -81,6 +81,7 @@ bool x2avic_enabled;
 struct amd_svm_iommu_ir {
 	struct list_head node;	/* Used by SVM for per-vcpu ir_list */
 	void *data;		/* Storing pointer to struct amd_ir_data */
+	struct vcpu_svm *svm;
 };
 
 static void avic_activate_vmcb(struct vcpu_svm *svm)
@@ -774,23 +775,19 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
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
@@ -803,24 +800,7 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
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
@@ -912,6 +892,8 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 
 		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
 
+		svm_ir_list_del(irqfd);
+
 		/**
 		 * Here, we setup with legacy mode in the following cases:
 		 * 1. When cannot target interrupt to a specific vcpu.
@@ -969,21 +951,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
 	} else {
 		ret = 0;
 	}
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
2.49.0.504.g3bcea36a83-goog

