Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F82E3389
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682063; cv=none; b=cH3PFmaCb7Vl/z5mk2/UWCpvy/dycPRet8N2crKZ7abtQ+KL/YZ/B6hgbEcLPrbasbIypFxAIC47prJ/MrU9fEHEKNyJVhkoeljxkMXMfe0+VSzdbfdjWDi3bc70cuQ3q5KllQmD6ohORUL2QnKbkTKWUdAPr5b8qk8ZPn9rOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682063; c=relaxed/simple;
	bh=vdrb6Ofedf9rqcDtNfZ6TybJs2KP+BrVk0n++PH2euw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W6Wtid4JKU5Q9LI3xk3c83fQWU2PUBw2EMmYi3lwjZZT5SdN16odoj6liklynx+kZ6iRo96a2OO3zIbCyNj7NaONNMzyQ/Y34IdnOLadeOqGwUpeuHohDgu6/a5rbhU7H0zXmNpEv3UIb69HBdbMbaSA4Gauep4PaSnZW19/xP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HeGcE36l; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HeGcE36l"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23494a515e3so1953765ad.2
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682060; x=1750286860; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3R/fidHqC5yeF1RrOI6ocG+diWBEwovSia+ZMiokcw0=;
        b=HeGcE36lTMnOziyFryGIZsVowjOr4mGWRjsWmdcR4kZrAjIElYVqB8mMbhn/+gbOYs
         FyMJS+Mje1TBqZgrHv6f7biePg3fLCSqZZU1FUHYNw2CVJ/wljviK2id9TL+Uzv6rdCz
         63zc6ZXuMdPR9SD75wmuFJ3JoW5qzrccQh2f1gZ2PPfjt8qDAZSSE8VbdbOJ5qEYn/XS
         thx7kVE+ShIw3lwhDm9AwYCmidqLYrJoBnpGPRb+1FPAY1beVoHaJ+gJNSFc3RyznVC5
         wz1AmmE1z5A7w9q3rxDWZm2QeQyiuPdK4HPU3B/Idgc2zdY1Dgt3xhBjn25UadT5iAlz
         wI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682060; x=1750286860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3R/fidHqC5yeF1RrOI6ocG+diWBEwovSia+ZMiokcw0=;
        b=NxGqePok+6UJBsXuuep8nyZX86DJ0VXuYea0ZV/TXccjWd3ZnwW6WeGu9l2OvzuwV7
         VaBRczPZH7It9VuiagTsvKy9QLx2EeSibnH/K5mCIEiVCKWjm8YwPLXjIP5qPWCvwGah
         SOu+IdNRNpO4ONX3mtkeixf0n+9xucWXOhWCR/r8Bol2R+EaiVHxFwbq77SQQ7vZOVp3
         DSgpjxJ07K9QCJ/SehA0pnl2pOAJFjKAwxdyHlvNTyRR2yXyJOFW1fCRXScSu3d6Pcy6
         UHmaFPOp1OjEKoYPwkG6KIdgqcoRiSvvlzqvkiA5pLvGmG86WsCgK2CvwSzouzbkxlml
         MMqg==
X-Forwarded-Encrypted: i=1; AJvYcCVnjKHChbGBgphCshYU4plMrYgc+sa0mk2BqZyu3QbS/wpieXSH9yuHJLIRjL9p/SRH4zrOPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YytWf3BHfFNWm7RehG9bIf2SdXx17eSGoO3li4vymzwBA5AK3Gy
	ku2mnkvAgzy7dGyGySTZtEm/zlZwL3UNTZhopx1W3XWDbecRhE9I9sRlkPzEBMF0HgZWalIF15k
	MhBdWwg==
X-Google-Smtp-Source: AGHT+IEOtnEHDa7Bgrp+UndiVZVCJiDQiRFAkA9eta61DTFWTRaWJpwzsbPxucwMY3m/JsIguUfc/GrPZbc=
X-Received: from plhi6.prod.google.com ([2002:a17:903:2ec6:b0:234:7a8f:b8e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b44:b0:233:d1e6:4d12
 with SMTP id d9443c01a7336-23641abc389mr58408685ad.13.1749682060626; Wed, 11
 Jun 2025 15:47:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:29 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-28-seanjc@google.com>
Subject: [PATCH v3 26/62] KVM: x86: Move IRQ routing/delivery APIs from x86.c
 => irq.c
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

Move a bunch of IRQ routing and delivery APIs from x86.c to irq.c.  x86.c
has grown quite fat, and irq.c is the perfect landing spot.

Opportunistically rewrite kvm_arch_irq_bypass_del_producer()'s comment, as
the existing comment has several typos and is rather confusing.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/irq.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c | 87 ---------------------------------------------
 2 files changed, 88 insertions(+), 87 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index a0b1499baf6e..b9d3ec72037c 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -11,6 +11,7 @@
 
 #include <linux/export.h>
 #include <linux/kvm_host.h>
+#include <linux/kvm_irqfd.h>
 
 #include "hyperv.h"
 #include "ioapic.h"
@@ -332,6 +333,18 @@ int kvm_arch_set_irq_inatomic(struct kvm_kernel_irq_routing_entry *e,
 	return -EWOULDBLOCK;
 }
 
+int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
+			bool line_status)
+{
+	if (!irqchip_in_kernel(kvm))
+		return -ENXIO;
+
+	irq_event->status = kvm_set_irq(kvm, KVM_USERSPACE_IRQ_SOURCE_ID,
+					irq_event->irq, irq_event->level,
+					line_status);
+	return 0;
+}
+
 bool kvm_arch_can_set_irq_routing(struct kvm *kvm)
 {
 	return irqchip_in_kernel(kvm);
@@ -495,6 +508,81 @@ void kvm_arch_irq_routing_update(struct kvm *kvm)
 		kvm_make_scan_ioapic_request(kvm);
 }
 
+int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
+				      struct irq_bypass_producer *prod)
+{
+	struct kvm_kernel_irqfd *irqfd =
+		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
+	int ret = 0;
+
+	kvm_arch_start_assignment(irqfd->kvm);
+
+	spin_lock_irq(&kvm->irqfds.lock);
+	irqfd->producer = prod;
+
+	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
+		ret = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, prod->irq,
+						   irqfd->gsi, &irqfd->irq_entry);
+		if (ret)
+			kvm_arch_end_assignment(irqfd->kvm);
+	}
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+	return ret;
+}
+
+void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
+				      struct irq_bypass_producer *prod)
+{
+	struct kvm_kernel_irqfd *irqfd =
+		container_of(cons, struct kvm_kernel_irqfd, consumer);
+	struct kvm *kvm = irqfd->kvm;
+	int ret;
+
+	WARN_ON(irqfd->producer != prod);
+
+	/*
+	 * If the producer of an IRQ that is currently being posted to a vCPU
+	 * is unregistered, change the associated IRTE back to remapped mode as
+	 * the IRQ has been released (or repurposed) by the device driver, i.e.
+	 * KVM must relinquish control of the IRTE.
+	 */
+	spin_lock_irq(&kvm->irqfds.lock);
+	irqfd->producer = NULL;
+
+	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
+		ret = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, prod->irq,
+						   irqfd->gsi, NULL);
+		if (ret)
+			pr_info("irq bypass consumer (token %p) unregistration fails: %d\n",
+				irqfd->consumer.token, ret);
+	}
+
+	spin_unlock_irq(&kvm->irqfds.lock);
+
+
+	kvm_arch_end_assignment(irqfd->kvm);
+}
+
+int kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
+				  struct kvm_kernel_irq_routing_entry *old,
+				  struct kvm_kernel_irq_routing_entry *new)
+{
+	return kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, irqfd->producer->irq,
+					    irqfd->gsi, new);
+}
+
+bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *old,
+				  struct kvm_kernel_irq_routing_entry *new)
+{
+	if (old->type != KVM_IRQ_ROUTING_MSI ||
+	    new->type != KVM_IRQ_ROUTING_MSI)
+		return true;
+
+	return !!memcmp(&old->msi, &new->msi, sizeof(new->msi));
+}
+
 #ifdef CONFIG_KVM_IOAPIC
 #define IOAPIC_ROUTING_ENTRY(irq) \
 	{ .gsi = irq, .type = KVM_IRQ_ROUTING_IRQCHIP,	\
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f1b0dbce9a8b..5ba5e28532de 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6420,18 +6420,6 @@ void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
 		kvm_vcpu_kick(vcpu);
 }
 
-int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_event,
-			bool line_status)
-{
-	if (!irqchip_in_kernel(kvm))
-		return -ENXIO;
-
-	irq_event->status = kvm_set_irq(kvm, KVM_USERSPACE_IRQ_SOURCE_ID,
-					irq_event->irq, irq_event->level,
-					line_status);
-	return 0;
-}
-
 int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 			    struct kvm_enable_cap *cap)
 {
@@ -13504,81 +13492,6 @@ bool kvm_arch_has_noncoherent_dma(struct kvm *kvm)
 }
 EXPORT_SYMBOL_GPL(kvm_arch_has_noncoherent_dma);
 
-int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,
-				      struct irq_bypass_producer *prod)
-{
-	struct kvm_kernel_irqfd *irqfd =
-		container_of(cons, struct kvm_kernel_irqfd, consumer);
-	struct kvm *kvm = irqfd->kvm;
-	int ret = 0;
-
-	kvm_arch_start_assignment(irqfd->kvm);
-
-	spin_lock_irq(&kvm->irqfds.lock);
-	irqfd->producer = prod;
-
-	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
-		ret = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, prod->irq,
-						   irqfd->gsi, &irqfd->irq_entry);
-		if (ret)
-			kvm_arch_end_assignment(irqfd->kvm);
-	}
-	spin_unlock_irq(&kvm->irqfds.lock);
-
-	return ret;
-}
-
-void kvm_arch_irq_bypass_del_producer(struct irq_bypass_consumer *cons,
-				      struct irq_bypass_producer *prod)
-{
-	struct kvm_kernel_irqfd *irqfd =
-		container_of(cons, struct kvm_kernel_irqfd, consumer);
-	struct kvm *kvm = irqfd->kvm;
-	int ret;
-
-	WARN_ON(irqfd->producer != prod);
-
-	/*
-	 * When producer of consumer is unregistered, we change back to
-	 * remapped mode, so we can re-use the current implementation
-	 * when the irq is masked/disabled or the consumer side (KVM
-	 * int this case doesn't want to receive the interrupts.
-	*/
-	spin_lock_irq(&kvm->irqfds.lock);
-	irqfd->producer = NULL;
-
-	if (irqfd->irq_entry.type == KVM_IRQ_ROUTING_MSI) {
-		ret = kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, prod->irq,
-						   irqfd->gsi, NULL);
-		if (ret)
-			pr_info("irq bypass consumer (token %p) unregistration fails: %d\n",
-				irqfd->consumer.token, ret);
-	}
-
-	spin_unlock_irq(&kvm->irqfds.lock);
-
-
-	kvm_arch_end_assignment(irqfd->kvm);
-}
-
-int kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
-				  struct kvm_kernel_irq_routing_entry *old,
-				  struct kvm_kernel_irq_routing_entry *new)
-{
-	return kvm_x86_call(pi_update_irte)(irqfd, irqfd->kvm, irqfd->producer->irq,
-					    irqfd->gsi, new);
-}
-
-bool kvm_arch_irqfd_route_changed(struct kvm_kernel_irq_routing_entry *old,
-				  struct kvm_kernel_irq_routing_entry *new)
-{
-	if (old->type != KVM_IRQ_ROUTING_MSI ||
-	    new->type != KVM_IRQ_ROUTING_MSI)
-		return true;
-
-	return !!memcmp(&old->msi, &new->msi, sizeof(new->msi));
-}
-
 bool kvm_vector_hashing_enabled(void)
 {
 	return vector_hashing;
-- 
2.50.0.rc1.591.g9c95f17f64-goog

