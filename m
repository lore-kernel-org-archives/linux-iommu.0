Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D608202978
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962015; cv=none; b=WnQucuCoNGpLRh9lMCV6eVyIhdqw3hQN7cXHdTbqy12pBgzsM09g3xxheW5nToSpBoboSw4VsYoaRc2/DGUkVlB8knLPhWVqBcDr7oC9fTlGewIQIYim0wPuSH0pYawZF7YtJ7BupWvEzA2nmMrvwlEycI5rzJg7UzEtU++WzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962015; c=relaxed/simple;
	bh=aqId/MfG7UYKWnmP31wra99FFnDu4Tk8TU75m8cWlHk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s2XOf7OedX8FrDDhAhHdCo2NkzODyjcMfMaD0Zwvy+6OBuyck5hi7E1uBDI1OTkUEgB2FoVBu9hzRBGOE5UTF0Za5OXsoCYhyBWDjlFeGAfFVQZQqE3N0i6jwv0eX69AySzsAXTyS/eyms+PxuFVhwgj9ZykybHIP+hG6zQSF9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TiQhXrTh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TiQhXrTh"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e8346b49cso7253017a91.0
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962012; x=1748566812; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=h6Fi2uGZoFyI+fpVWxb9iu5QelXyEXqpjgp2EpCb/GA=;
        b=TiQhXrThJFw1cLc1KtCoZHTe+1Pftgd12UU7I+P6ccxJRDUi1ChfBYKvpjAXksT7BG
         HiZ1FEsZkUPCqxLqYbz9S8hPIZbsl2I5d0bZWqnKgE5NymtYN0KlYM333UzfCBWANl6I
         bGbB9UoExODFg58cvBwezzSSxiRsG5e4OmlQ5dpXxPhtn7OWCyd/fkaQIIgg95QQH/yj
         jYC19/9bsHWGVtJv48b5dPTHVbKYlU3QH4T+x1yV9ZtrHVaT9CStCdc+JusNXbHb5alx
         K81yuF2QuE0F+Ct1GVOmINKYMJL59YYBiCyT6f9Kktt3v1IERf/E+aUp4Ye1ImTVTEuQ
         d90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962012; x=1748566812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6Fi2uGZoFyI+fpVWxb9iu5QelXyEXqpjgp2EpCb/GA=;
        b=S1Ms/yVI05/KkKwGpSjQKamu84svtdNwzsPx+7E570iYJagDJhN+htXHG/AvkaIwXZ
         AFfrUi8M9d6i/daFWMBHdb9pXBdhHi8MxssYHGJ0zC1m1Nr7Ju0pOkXW1wVP5OgHVUGl
         NCh/P+t3C36DggakCSQ1c4KxEY3wuvXkELGGVQRm9eBJqIubPQim3VWR7oUc/jglQn/V
         eaJNrzQ6xgGTuI7JhppBP6tB+qSWaVpNrzj+N1pgjgazxgkAWcPMYHTU3l+/YQC8Hha/
         XXdPr45/+U+CX6iBDetJBGCthS0ny8q3KkcEfytYo1z6MP943iVjqWe6O3e9qv6v+hGe
         SJXg==
X-Forwarded-Encrypted: i=1; AJvYcCVTSI5UrB+DPHbUnTLDEGq5KRmJTdZwd8aBaxuQIq03lUWgV1YW5NdKbO5p9pPyJdbjk0Ky8w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyU1kTYgKuG3TS80BErugTQRw5j1JqYQBbN2QHWg6JBsOVkXba0
	bCiBeCUUSlIpN/uuGhPd3QFIJlVQS3mslO09y3/DG9mCb0NBCvxl7EAM78j0zL/+uPHT2VjEHYr
	y0kE0kQ==
X-Google-Smtp-Source: AGHT+IEmQ/iBobSURg+CBZvIq2SLSqxNOv+mYEeHW+hSWn3teTRHzGk20jzFX4bEh5sFDD0AsX6zHW7sN2o=
X-Received: from pjbdy5.prod.google.com ([2002:a17:90b:6c5:b0:2fc:1356:bcc3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3dc7:b0:310:8d73:d9d9
 with SMTP id 98e67ed59e1d1-3108d73da51mr17092365a91.18.1747962012532; Thu, 22
 May 2025 18:00:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:06 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-2-seanjc@google.com>
Subject: [PATCH v2 01/59] KVM: x86: Pass new routing entries and irqfd when
 updating IRTEs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

When updating IRTEs in response to a GSI routing or IRQ bypass change,
pass the new/current routing information along with the associated irqfd.
This will allow KVM x86 to harden, simplify, and deduplicate its code.

Since adding/removing a bypass producer is now conveniently protected with
irqfds.lock, i.e. can't run concurrently with kvm_irq_routing_update(),
use the routing information cached in the irqfd instead of looking up
the information in the current GSI routing tables.

Opportunistically convert an existing printk() to pr_info() and put its
string onto a single line (old code that strictly adhered to 80 chars).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  6 ++++--
 arch/x86/kvm/svm/avic.c         | 18 +++++++----------
 arch/x86/kvm/svm/svm.h          |  5 +++--
 arch/x86/kvm/vmx/posted_intr.c  | 19 ++++++++---------
 arch/x86/kvm/vmx/posted_intr.h  |  8 ++++++--
 arch/x86/kvm/x86.c              | 36 ++++++++++++++++++---------------
 include/linux/kvm_host.h        |  7 +++++--
 virt/kvm/eventfd.c              | 11 +++++-----
 8 files changed, 58 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 21ccb122ab76..2a6ef1398da7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -296,6 +296,7 @@ enum x86_intercept_stage;
  */
 #define KVM_APIC_PV_EOI_PENDING	1
 
+struct kvm_kernel_irqfd;
 struct kvm_kernel_irq_routing_entry;
 
 /*
@@ -1844,8 +1845,9 @@ struct kvm_x86_ops {
 	void (*vcpu_blocking)(struct kvm_vcpu *vcpu);
 	void (*vcpu_unblocking)(struct kvm_vcpu *vcpu);
 
-	int (*pi_update_irte)(struct kvm *kvm, unsigned int host_irq,
-			      uint32_t guest_irq, bool set);
+	int (*pi_update_irte)(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
+			      unsigned int host_irq, uint32_t guest_irq,
+			      struct kvm_kernel_irq_routing_entry *new);
 	void (*pi_start_assignment)(struct kvm *kvm);
 	void (*apicv_pre_state_restore)(struct kvm_vcpu *vcpu);
 	void (*apicv_post_state_restore)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 7338879d1c0c..adacf00d6664 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -18,6 +18,7 @@
 #include <linux/hashtable.h>
 #include <linux/amd-iommu.h>
 #include <linux/kvm_host.h>
+#include <linux/kvm_irqfd.h>
 
 #include <asm/irq_remapping.h>
 
@@ -885,21 +886,14 @@ get_pi_vcpu_info(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
 	return 0;
 }
 
-/*
- * avic_pi_update_irte - set IRTE for Posted-Interrupts
- *
- * @kvm: kvm
- * @host_irq: host irq of the interrupt
- * @guest_irq: gsi of the interrupt
- * @set: set or unset PI
- * returns 0 on success, < 0 on failure
- */
-int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
-			uint32_t guest_irq, bool set)
+int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
+			unsigned int host_irq, uint32_t guest_irq,
+			struct kvm_kernel_irq_routing_entry *new)
 {
 	struct kvm_kernel_irq_routing_entry *e;
 	struct kvm_irq_routing_table *irq_rt;
 	bool enable_remapped_mode = true;
+	bool set = !!new;
 	int idx, ret = 0;
 
 	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
@@ -925,6 +919,8 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 		if (e->type != KVM_IRQ_ROUTING_MSI)
 			continue;
 
+		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
+
 		/**
 		 * Here, we setup with legacy mode in the following cases:
 		 * 1. When cannot target interrupt to a specific vcpu.
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e6f3c6a153a0..b35fce30d923 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -736,8 +736,9 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void avic_vcpu_put(struct kvm_vcpu *vcpu);
 void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu);
 void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu);
-int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
-			uint32_t guest_irq, bool set);
+int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
+			unsigned int host_irq, uint32_t guest_irq,
+			struct kvm_kernel_irq_routing_entry *new);
 void avic_vcpu_blocking(struct kvm_vcpu *vcpu);
 void avic_vcpu_unblocking(struct kvm_vcpu *vcpu);
 void avic_ring_doorbell(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 5c615e5845bf..110fb19848ab 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kvm_host.h>
+#include <linux/kvm_irqfd.h>
 
 #include <asm/irq_remapping.h>
 #include <asm/cpu.h>
@@ -294,17 +295,9 @@ void vmx_pi_start_assignment(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_UNBLOCK);
 }
 
-/*
- * vmx_pi_update_irte - set IRTE for Posted-Interrupts
- *
- * @kvm: kvm
- * @host_irq: host irq of the interrupt
- * @guest_irq: gsi of the interrupt
- * @set: set or unset PI
- * returns 0 on success, < 0 on failure
- */
-int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
-		       uint32_t guest_irq, bool set)
+int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
+		       unsigned int host_irq, uint32_t guest_irq,
+		       struct kvm_kernel_irq_routing_entry *new)
 {
 	struct kvm_kernel_irq_routing_entry *e;
 	struct kvm_irq_routing_table *irq_rt;
@@ -312,6 +305,7 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 	struct kvm_lapic_irq irq;
 	struct kvm_vcpu *vcpu;
 	struct vcpu_data vcpu_info;
+	bool set = !!new;
 	int idx, ret = 0;
 
 	if (!vmx_can_use_vtd_pi(kvm))
@@ -329,6 +323,9 @@ int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 	hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
 		if (e->type != KVM_IRQ_ROUTING_MSI)
 			continue;
+
+		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
+
 		/*
 		 * VT-d PI cannot support posting multicast/broadcast
 		 * interrupts to a vCPU, we still use interrupt remapping
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index 80499ea0e674..a94afcb55f7f 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -3,6 +3,9 @@
 #define __KVM_X86_VMX_POSTED_INTR_H
 
 #include <linux/bitmap.h>
+#include <linux/find.h>
+#include <linux/kvm_host.h>
+
 #include <asm/posted_intr.h>
 
 void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
@@ -11,8 +14,9 @@ void pi_wakeup_handler(void);
 void __init pi_init_cpu(int cpu);
 void pi_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
 bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu);
-int vmx_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
-		       uint32_t guest_irq, bool set);
+int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
+		       unsigned int host_irq, uint32_t guest_irq,
+		       struct kvm_kernel_irq_routing_entry *new);
 void vmx_pi_start_assignment(struct kvm *kvm);
 
 static inline int pi_find_highest_vector(struct pi_desc *pi_desc)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3ac6f7c83a06..8a4662bc2521 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13630,31 +13630,31 @@ int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
 	struct kvm *kvm = irqfd->kvm;
-	int ret;
+	int ret = 0;
 
 	kvm_arch_start_assignment(irqfd->kvm);
 
 	spin_lock_irq(&kvm->irqfds.lock);
 	irqfd->producer = prod;
 
-	ret = kvm_x86_call(pi_update_irte)(irqfd->kvm,
-					   prod->irq, irqfd->gsi, 1);
-	if (ret)
-		kvm_arch_end_assignment(irqfd->kvm);
-
+	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
+		ret = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, prod->irq,
+						   irqfd->gsi, &irqfd->irq_entry);
+		if (ret)
+			kvm_arch_end_assignment(irqfd->kvm);
+	}
 	spin_unlock_irq(&kvm->irqfds.lock);
 
-
 	return ret;
 }
 
 void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 				      struct irq_bypass_producer *prod)
 {
-	int ret;
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
 	struct kvm *kvm = irqfd->kvm;
+	int ret;
 
 	WARN_ON(irqfd->producer != prod);
 
@@ -13667,11 +13667,13 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	spin_lock_irq(&kvm->irqfds.lock);
 	irqfd->producer = NULL;
 
-	ret = kvm_x86_call(pi_update_irte)(irqfd->kvm,
-					   prod->irq, irqfd->gsi, 0);
-	if (ret)
-		printk(KERN_INFO "irq bypass consumer (token %p) unregistration"
-		       " fails: %d\n", irqfd->consumer.token, ret);
+	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
+		ret = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, prod->irq,
+						   irqfd->gsi, NULL);
+		if (ret)
+			pr_info("irq bypass consumer (token %p) unregistration fails: %d\n",
+				irqfd->consumer.token, ret);
+	}
 
 	spin_unlock_irq(&kvm->irqfds.lock);
 
@@ -13679,10 +13681,12 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
 	kvm_arch_end_assignment(irqfd->kvm);
 }
 
-int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
-				   uint32_t guest_irq, bool set)
+int kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
+				  struct kvm_kernel_irq_routing_entry *old,
+				  struct kvm_kernel_irq_routing_entry *new)
 {
-	return kvm_x86_call(pi_update_irte)(kvm, host_irq, guest_irq, set);
+	return kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, irqfd->producer->irq,
+					    irqfd->gsi, new);
 }
 
 bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *old,
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 0e151db44ecd..27c7087820cb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2397,6 +2397,8 @@ struct kvm_vcpu *kvm_get_running_vcpu(void);
 struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
 
 #if IS_ENABLED(CONFIG_HAVE_KVM_IRQ_BYPASS)
+struct kvm_kernel_irqfd;
+
 bool kvm_arch_has_irq_bypass(void);
 int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *,
 			   struct irq_bypass_producer *);
@@ -2404,8 +2406,9 @@ void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *,
 			   struct irq_bypass_producer *);
 void kvm_arch_irq_bypass_stop(struct irq_bypass_consumer *);
 void kvm_arch_irq_bypass_start(struct irq_bypass_consumer *);
-int kvm_arch_update_irqfd_routing(struct kvm *kvm, unsigned int host_irq,
-				  uint32_t guest_irq, bool set);
+int kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
+				  struct kvm_kernel_irq_routing_entry *old,
+				  struct kvm_kernel_irq_routing_entry *new);
 bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *,
 				  struct kvm_kernel_irq_routing_entry *);
 #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 11e5d1e3f12e..85581550dc8d 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -285,9 +285,9 @@ void __attribute__((weak)) kvm_arch_irq_bypass_start(
 {
 }
 
-int  __attribute__((weak)) kvm_arch_update_irqfd_routing(
-				struct kvm *kvm, unsigned int host_irq,
-				uint32_t guest_irq, bool set)
+int __weak kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
+					 struct kvm_kernel_irq_routing_entry *old,
+					 struct kvm_kernel_irq_routing_entry *new)
 {
 	return 0;
 }
@@ -619,9 +619,8 @@ void kvm_irq_routing_update(struct kvm *kvm)
 #if IS_ENABLED(CONFIG_HAVE_KVM_IRQ_BYPASS)
 		if (irqfd->producer &&
 		    kvm_arch_irqfd_route_changed(&old, &irqfd->irq_entry)) {
-			int ret = kvm_arch_update_irqfd_routing(
-					irqfd->kvm, irqfd->producer->irq,
-					irqfd->gsi, 1);
+			int ret = kvm_arch_update_irqfd_routing(irqfd, &old, &irqfd->irq_entry);
+
 			WARN_ON(ret);
 		}
 #endif
-- 
2.49.0.1151.ga128411c76-goog

