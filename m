Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7527A919
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962056; cv=none; b=VML6N/btIs4U2emRgY8pOqpv8UOZATYd12XVgihOJUJsjzD6AZJrJdDm6tqwA6mjUXG6iN+xK/lnBYOt5iWz5MUKYQAz6ragYIu97/3kfla6XQwOp238SVdrUnUIopXGxWeym6/hA+MpEqgZ5iqjZlDv1D6Va0H9SPJGlxmOlSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962056; c=relaxed/simple;
	bh=reLr9P58MSC3wjP35aUgGXuVRmf102/ZPKYE8/pzV1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dSQrRZR1OXjmxiHdIyTcBSu4Y62t2rl/KX5ydjndvj5lnTuxtR0KrMFnHDqBsbOWWqdfxtGGLq2APVFjkYrxTPlaYeRmqiozg8NGcAkaFOk+OL0OGQsSX00e/09uoAfVhEJAYs1D+w5Kqoj6j6sAJ+1RI37l4gvYz6OWGcr3JzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTFZEpMx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTFZEpMx"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e78145dc4so9579138a91.2
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962054; x=1748566854; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FVhvnc/YpYZobtQ9o9NxPodzh+EhVjLEhzCkGWjABzI=;
        b=vTFZEpMxIKBgmNI/XWHIKSLLSzKw563yL5zEkB9pjyiZ+OLyfBjMn9vn3flzUdDohU
         QgEycVnCkg8xN2M1HSC4C3VNBsHRtI7Uc4u8qkfv/qyJAIQbI8uiDuCimDU4wlO7N0Xl
         cDDKWxyFa24W7dCRt+SJuFpCWoJa15HL4EkZDLuy18e8Q8pveQ0cz82F+4hmvDpsooU3
         3Cc7eSEZy3sP3PyLzdjOuvhjvelE1Rs7wBIkcrbvvBan8fqTr7uKPgK7W7l7uCCvPR6R
         jSVVFxNV/2IgYn6yyi+5iqgfVJezQWHt/DcEWqAJRoSY7WT2TfY7BOti2MxDvIox/lSA
         IRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962054; x=1748566854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVhvnc/YpYZobtQ9o9NxPodzh+EhVjLEhzCkGWjABzI=;
        b=JQeAGNHrsaq4CEa4iX03zWhVyVhLuaFI000FnS+VizBPkLp8uX0XfvFejvGSMpLcUv
         Pr+zK5Zndyar9QlmOljv7p1XrflIaivU2lUCe5C4wwr65g7YwgiKcrYy0301onxp2Bgp
         daGrFu11ywcADygrsHHFxe9gWVa10VrVl6hLwtVnDp4XvSESzGOa1yKNx2mkzKzwnIJS
         4oU+wxF0UAkupQoZt7X+VlPdGuhQ07zW1Rtagf4uGeFiHJ194GWHqwbnvxXTQouzkh8d
         92RIFtAGtolyjPfh88fysXhxYourVhS4CYs0OXQ6sam+Xqz1kqvghME9jKZzrEUrCfr4
         X3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXkiy118RhDEGtmlwE1gIU2/nswXkuqmUDADEoaaW+SpLTS6YD9ALTm/dcJYfxtcREeAxV/DA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJblZelMIAhVz2yff8Vm6q63HaFK49n+yjp7SdtUmnmB4hgOLC
	tBuYS0Y2lFptd1X4sPKxHWhwyBTUakSX2ZsEm3RzBEp6M10EPTLRjoko7g37OatmmrPFbfL8UX4
	Ebx+ICQ==
X-Google-Smtp-Source: AGHT+IFnoLSV725ynjIxwWXrWpZxFAUy0Evtj55LS8rKIxU1+INdg2aBUchusqAm0MknijR/iiZNe/0+4Ik=
X-Received: from pjbpl16.prod.google.com ([2002:a17:90b:2690:b0:30e:7003:7604])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c5:b0:2fe:a79e:f56f
 with SMTP id 98e67ed59e1d1-30e7d522165mr38581496a91.13.1747962054379; Thu, 22
 May 2025 18:00:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:31 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-27-seanjc@google.com>
Subject: [PATCH v2 26/59] KVM: x86: Dedup AVIC vs. PI code for identifying
 target vCPU
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Hoist the logic for identifying the target vCPU for a posted interrupt
into common x86.  The code is functionally identical between Intel and
AMD.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/irq.c              | 45 +++++++++++++++---
 arch/x86/kvm/svm/avic.c         | 82 ++++++++-------------------------
 arch/x86/kvm/svm/svm.h          |  2 +-
 arch/x86/kvm/vmx/posted_intr.c  | 55 ++++++----------------
 arch/x86/kvm/vmx/posted_intr.h  |  2 +-
 6 files changed, 75 insertions(+), 113 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index cba82d7a701d..c722adfedd96 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1854,7 +1854,7 @@ struct kvm_x86_ops {
 
 	int (*pi_update_irte)(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			      unsigned int host_irq, uint32_t guest_irq,
-			      struct kvm_kernel_irq_routing_entry *new);
+			      struct kvm_vcpu *vcpu, u32 vector);
 	void (*pi_start_assignment)(struct kvm *kvm);
 	void (*apicv_pre_state_restore)(struct kvm_vcpu *vcpu);
 	void (*apicv_post_state_restore)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 6374a7cf8664..92a2137e0402 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -508,6 +508,42 @@ void kvm_arch_irq_routing_update(struct kvm *kvm)
 		kvm_make_scan_ioapic_request(kvm);
 }
 
+static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
+			      struct kvm_kernel_irq_routing_entry *entry)
+{
+	struct kvm *kvm = irqfd->kvm;
+	struct kvm_vcpu *vcpu = NULL;
+	struct kvm_lapic_irq irq;
+
+	if (!irqchip_in_kernel(kvm) ||
+	    !kvm_arch_has_irq_bypass() ||
+	    !kvm_arch_has_assigned_device(kvm))
+		return 0;
+
+	if (entry && entry->type == KVM_IRQ_ROUTING_MSI) {
+		kvm_set_msi_irq(kvm, entry, &irq);
+
+		/*
+		 * Force remapped mode if hardware doesn't support posting the
+		 * virtual interrupt to a vCPU.  Only IRQs are postable (NMIs,
+		 * SMIs, etc. are not), and neither AMD nor Intel IOMMUs support
+		 * posting multicast/broadcast IRQs.  If the interrupt can't be
+		 * posted, the device MSI needs to be routed to the host so that
+		 * the guest's desired interrupt can be synthesized by KVM.
+		 *
+		 * This means that KVM can only post lowest-priority interrupts
+		 * if they have a single CPU as the destination, e.g. only if
+		 * the guest has affined the interrupt to a single vCPU.
+		 */
+		if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu) ||
+		    !kvm_irq_is_postable(&irq))
+			vcpu = NULL;
+	}
+
+	return kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, irqfd->producer->irq,
+					    irqfd->gsi, vcpu, irq.vector);
+}
+
 int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 				      struct irq_bypass_producer *prod)
 {
@@ -522,8 +558,7 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 	irqfd->producer = prod;
 
 	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
-		ret = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, prod->irq,
-						   irqfd->gsi, &irqfd->irq_entry);
+		ret = kvm_pi_update_irte(irqfd, &irqfd->irq_entry);
 		if (ret)
 			kvm_arch_end_assignment(irqfd->kvm);
 	}
@@ -551,8 +586,7 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	spin_lock_irq(&kvm->irqfds.lock);
 
 	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
-		ret = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, prod->irq,
-						   irqfd->gsi, NULL);
+		ret = kvm_pi_update_irte(irqfd, NULL);
 		if (ret)
 			pr_info("irq bypass consumer (token %p) unregistration fails: %d\n",
 				irqfd->consumer.token, ret);
@@ -568,8 +602,7 @@ int kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 				  struct kvm_kernel_irq_routing_entry *old,
 				  struct kvm_kernel_irq_routing_entry *new)
 {
-	return kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, irqfd->producer->irq,
-					    irqfd->gsi, new);
+	return kvm_pi_update_irte(irqfd, new);
 }
 
 bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *old,
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 3bbd565dcd0f..14a1544af192 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -803,52 +803,12 @@ static int svm_ir_list_add(struct vcpu_svm *svm,
 	return 0;
 }
 
-/*
- * Note:
- * The HW cannot support posting multicast/broadcast
- * interrupts to a vCPU. So, we still use legacy interrupt
- * remapping for these kind of interrupts.
- *
- * For lowest-priority interrupts, we only support
- * those with single CPU as the destination, e.g. user
- * configures the interrupts via /proc/irq or uses
- * irqbalance to make the interrupts single-CPU.
- */
-static int
-get_pi_vcpu_info(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
-		 struct vcpu_data *vcpu_info, struct kvm_vcpu **vcpu)
-{
-	struct kvm_lapic_irq irq;
-	*vcpu = NULL;
-
-	kvm_set_msi_irq(kvm, e, &irq);
-
-	if (!kvm_intr_is_single_vcpu(kvm, &irq, vcpu) ||
-	    !kvm_irq_is_postable(&irq)) {
-		pr_debug("SVM: %s: use legacy intr remap mode for irq %u\n",
-			 __func__, irq.vector);
-		return -1;
-	}
-
-	pr_debug("SVM: %s: use GA mode for irq %u\n", __func__,
-		 irq.vector);
-	vcpu_info->vector = irq.vector;
-
-	return 0;
-}
-
 int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			unsigned int host_irq, uint32_t guest_irq,
-			struct kvm_kernel_irq_routing_entry *new)
+			struct kvm_vcpu *vcpu, u32 vector)
 {
-	bool enable_remapped_mode = true;
-	struct vcpu_data vcpu_info;
-	struct kvm_vcpu *vcpu = NULL;
 	int ret = 0;
 
-	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
-		return 0;
-
 	/*
 	 * If the IRQ was affined to a different vCPU, remove the IRTE metadata
 	 * from the *previous* vCPU's list.
@@ -856,7 +816,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	svm_ir_list_del(irqfd);
 
 	pr_debug("SVM: %s: host_irq=%#x, guest_irq=%#x, set=%#x\n",
-		 __func__, host_irq, guest_irq, !!new);
+		 __func__, host_irq, guest_irq, !!vcpu);
 
 	/**
 	 * Here, we setup with legacy mode in the following cases:
@@ -865,23 +825,23 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	 * 3. APIC virtualization is disabled for the vcpu.
 	 * 4. IRQ has incompatible delivery mode (SMI, INIT, etc)
 	 */
-	if (new && new->type == KVM_IRQ_ROUTING_MSI &&
-	    !get_pi_vcpu_info(kvm, new, &vcpu_info, &vcpu) &&
-	    kvm_vcpu_apicv_active(vcpu)) {
-		struct amd_iommu_pi_data pi;
-
-		enable_remapped_mode = false;
-
-		vcpu_info.pi_desc_addr = avic_get_backing_page_address(to_svm(vcpu));
-
+	if (vcpu && kvm_vcpu_apicv_active(vcpu)) {
 		/*
 		 * Try to enable guest_mode in IRTE.  Note, the address
 		 * of the vCPU's AVIC backing page is passed to the
 		 * IOMMU via vcpu_info->pi_desc_addr.
 		 */
-		pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id, vcpu->vcpu_id);
-		pi.is_guest_mode = true;
-		pi.vcpu_data = &vcpu_info;
+		struct vcpu_data vcpu_info = {
+			.pi_desc_addr = avic_get_backing_page_address(to_svm(vcpu)),
+			.vector = vector,
+		};
+
+		struct amd_iommu_pi_data pi = {
+			.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id, vcpu->vcpu_id),
+			.is_guest_mode = true,
+			.vcpu_data = &vcpu_info,
+		};
+
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
 
 		/**
@@ -893,12 +853,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 */
 		if (!ret)
 			ret = svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
-	}
 
-	if (!ret && vcpu) {
-		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id,
-					 guest_irq, vcpu_info.vector,
-					 vcpu_info.pi_desc_addr, !!new);
+		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, guest_irq,
+					 vector, vcpu_info.pi_desc_addr, true);
+	} else {
+		ret = irq_set_vcpu_affinity(host_irq, NULL);
 	}
 
 	if (ret < 0) {
@@ -906,10 +865,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		goto out;
 	}
 
-	if (enable_remapped_mode)
-		ret = irq_set_vcpu_affinity(host_irq, NULL);
-	else
-		ret = 0;
+	ret = 0;
 out:
 	return ret;
 }
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 939ff0e35a2b..b5cd1927b009 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -747,7 +747,7 @@ void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu);
 void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
 int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			unsigned int host_irq, uint32_t guest_irq,
-			struct kvm_kernel_irq_routing_entry *new);
+			struct kvm_vcpu *vcpu, u32 vector);
 void avic_vcpu_blocking(struct kvm_vcpu *vcpu);
 void avic_vcpu_unblocking(struct kvm_vcpu *vcpu);
 void avic_ring_doorbell(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index e59eae11f476..3de767c5d6b2 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -300,46 +300,19 @@ void vmx_pi_start_assignment(struct kvm *kvm)
 
 int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		       unsigned int host_irq, uint32_t guest_irq,
-		       struct kvm_kernel_irq_routing_entry *new)
+		       struct kvm_vcpu *vcpu, u32 vector)
 {
-	struct kvm_lapic_irq irq;
-	struct kvm_vcpu *vcpu;
-	struct vcpu_data vcpu_info;
-
-	if (!vmx_can_use_vtd_pi(kvm))
-		return 0;
-
-	/*
-	 * VT-d PI cannot support posting multicast/broadcast
-	 * interrupts to a vCPU, we still use interrupt remapping
-	 * for these kind of interrupts.
-	 *
-	 * For lowest-priority interrupts, we only support
-	 * those with single CPU as the destination, e.g. user
-	 * configures the interrupts via /proc/irq or uses
-	 * irqbalance to make the interrupts single-CPU.
-	 *
-	 * We will support full lowest-priority interrupt later.
-	 *
-	 * In addition, we can only inject generic interrupts using
-	 * the PI mechanism, refuse to route others through it.
-	 */
-	if (!new || new->type != KVM_IRQ_ROUTING_MSI)
-		goto do_remapping;
-
-	kvm_set_msi_irq(kvm, new, &irq);
-
-	if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu) ||
-	    !kvm_irq_is_postable(&irq))
-		goto do_remapping;
-
-	vcpu_info.pi_desc_addr = __pa(vcpu_to_pi_desc(vcpu));
-	vcpu_info.vector = irq.vector;
-
-	trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, guest_irq,
-				 vcpu_info.vector, vcpu_info.pi_desc_addr, true);
-
-	return irq_set_vcpu_affinity(host_irq, &vcpu_info);
-do_remapping:
-	return irq_set_vcpu_affinity(host_irq, NULL);
+	if (vcpu) {
+		struct vcpu_data vcpu_info = {
+			.pi_desc_addr = __pa(vcpu_to_pi_desc(vcpu)),
+			.vector = vector,
+		};
+
+		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, guest_irq,
+					 vcpu_info.vector, vcpu_info.pi_desc_addr, true);
+
+		return irq_set_vcpu_affinity(host_irq, &vcpu_info);
+	} else {
+		return irq_set_vcpu_affinity(host_irq, NULL);
+	}
 }
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index a94afcb55f7f..94ed66ea6249 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -16,7 +16,7 @@ void pi_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
 bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu);
 int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		       unsigned int host_irq, uint32_t guest_irq,
-		       struct kvm_kernel_irq_routing_entry *new);
+		       struct kvm_vcpu *vcpu, u32 vector);
 void vmx_pi_start_assignment(struct kvm *kvm);
 
 static inline int pi_find_highest_vector(struct pi_desc *pi_desc)
-- 
2.49.0.1151.ga128411c76-goog

