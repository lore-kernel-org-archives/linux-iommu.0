Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D52DFA25
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682059; cv=none; b=e6NYKcI6FKoOKvamFULNg4Sh6wvA+LvIiyvt3A1RJUgsaXo8LT88h0lxzA3lkAsArrKZHzSWOzRzlsj9MN9TH7kp/hpJBZw0RLUqPrlTj/7Zeg34ooBhn5V4573f+AvRq068BOXtfKR2jjsbJgd7SYwYbUuGqDoC5wo+Rx8/DlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682059; c=relaxed/simple;
	bh=kDWWk5Cm8hFBiObudWZIfYHjqEvfY5WfyYyH2K/VN5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q9LXN4IZbU5ySzRYaaIi7jl2vZfZ3uT6MQ3zjEzuvR6QroQZxzxuS/eKnpLmElRhYtZWPvSbWW4HL5oouWPs0ZSiOlcuQ+7/H81arn0PSzoefZmp3bJRIfqyJAIJvRBIs7DiKdKDpARHqoNPiSccUvpxI8OLHOHljkfJxSgg43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBPjSt9/; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBPjSt9/"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-235e7550f7bso2125855ad.3
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682057; x=1750286857; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nC93RHTPJR0hYLcAds88MrDeKfUjJXJiIT9n5WyFK68=;
        b=LBPjSt9/b3rZmXRJnv2xZGz0HFKNuBBw4QVucn1C8pqmEyfQwx0sSeXb+4Kayy8/Ox
         ZNy49yeUkTVNibXh0/oHHgTd7zFicDkgu//gVtV2QwAhJYiny/3gi9h4bqHqcEIfPeBW
         VOsc6Pm0832WvDjEvUL9hb1zVuO0p02rloYa6r9w7N+QBjLEm4PkKFrss03C70V9lJV5
         th3/BHaxZ3YX51ADs/8T+GXQOXKyywV94SbBz5gRF4vXOlpnsqQ5jmprHqyK/d/e+GiY
         oE+ycihrfykoPWxAI4ddh4Qgk+Jz6VHZE/dWa8RLgvuOdytPUwDnYB83iwURn8UZlajI
         hLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682057; x=1750286857;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nC93RHTPJR0hYLcAds88MrDeKfUjJXJiIT9n5WyFK68=;
        b=gmpjH9bPhATktB0dX6jlyG5oqUBK8NXK4FCM1Lya5H+Q/+6fFr3alvXsuP9+2oJHO5
         AG9d3AybITHmn+Sx1wS/rXYQdRA977crd2cWeqDWSvyZWrY/mJ0L7bYn2L+M3A88CRzF
         CXKCESeNbaSj/VEAL2aLz2KY+UxM7+fSiPfsG6cIf5CjuhQLn4jlwQlJThhlivWUk3Cg
         3z1Tloy1lCITKRR+jftbOEbuEZsgrU72UAeD6WuirTp1lpZJ0Q3L7ct6hXTPXyyltMhe
         mzXeCvxcd4xs/TczIR9pzdnuPrexlGzEJi9lnxjVPaL171Il1+hiK+PmPyaSMPeYJ1n4
         um4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVK4qgj4Cq90mERywpyMKfAMooUOPmiGM6NKBPU88WoJyZ+C9G3S8xU7B5H8yk/aERwiWigBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9omHK5kmSiIBK3/AgItndMmHjWT3fGqbKSu/vUNN1dFhXEFqg
	7U83A3XheZ9shV8hbCJPKOrLhFvakoEP5FgTzgOrpBmvUs5PVjiCbEA0VCgzeUDYfYD42CBArrT
	fvO0PoQ==
X-Google-Smtp-Source: AGHT+IHC+tL/ohPatgcKOK+9NRFx6tDroVAP77vbD+LWVMPFcp/p0UPjT16l7BqZ0WY1gMWbfEU6vC1Hc9s=
X-Received: from plhb13.prod.google.com ([2002:a17:903:228d:b0:235:eb8d:8024])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94f:b0:234:bc4e:4eb8
 with SMTP id d9443c01a7336-2364caba922mr14235635ad.46.1749682056865; Wed, 11
 Jun 2025 15:47:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:27 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-26-seanjc@google.com>
Subject: [PATCH v3 24/62] KVM: VMX: Stop walking list of routing table entries
 when updating IRTE
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

Now that KVM provides the to-be-updated routing entry, stop walking the
routing table to find that entry.  KVM, via setup_routing_entry() and
sanity checked by kvm_get_msi_route(), disallows having a GSI configured
to trigger multiple MSIs, i.e. the for-loop can only process one entry.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 100 +++++++++++----------------------
 1 file changed, 33 insertions(+), 67 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index d4826a6b674f..e59eae11f476 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -302,78 +302,44 @@ int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		       unsigned int host_irq, uint32_t guest_irq,
 		       struct kvm_kernel_irq_routing_entry *new)
 {
-	struct kvm_kernel_irq_routing_entry *e;
-	struct kvm_irq_routing_table *irq_rt;
-	bool enable_remapped_mode = true;
 	struct kvm_lapic_irq irq;
 	struct kvm_vcpu *vcpu;
 	struct vcpu_data vcpu_info;
-	bool set = !!new;
-	int idx, ret = 0;
 
 	if (!vmx_can_use_vtd_pi(kvm))
 		return 0;
 
-	idx = srcu_read_lock(&kvm->irq_srcu);
-	irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
-	if (guest_irq >= irq_rt->nr_rt_entries ||
-	    hlist_empty(&irq_rt->map[guest_irq])) {
-		pr_warn_once("no route for guest_irq %u/%u (broken user space?)\n",
-			     guest_irq, irq_rt->nr_rt_entries);
-		goto out;
-	}
-
-	hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
-		if (e->type != KVM_IRQ_ROUTING_MSI)
-			continue;
-
-		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
-
-		/*
-		 * VT-d PI cannot support posting multicast/broadcast
-		 * interrupts to a vCPU, we still use interrupt remapping
-		 * for these kind of interrupts.
-		 *
-		 * For lowest-priority interrupts, we only support
-		 * those with single CPU as the destination, e.g. user
-		 * configures the interrupts via /proc/irq or uses
-		 * irqbalance to make the interrupts single-CPU.
-		 *
-		 * We will support full lowest-priority interrupt later.
-		 *
-		 * In addition, we can only inject generic interrupts using
-		 * the PI mechanism, refuse to route others through it.
-		 */
-
-		kvm_set_msi_irq(kvm, e, &irq);
-		if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu) ||
-		    !kvm_irq_is_postable(&irq))
-			continue;
-
-		vcpu_info.pi_desc_addr = __pa(vcpu_to_pi_desc(vcpu));
-		vcpu_info.vector = irq.vector;
-
-		trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, e->gsi,
-				vcpu_info.vector, vcpu_info.pi_desc_addr, set);
-
-		if (!set)
-			continue;
-
-		enable_remapped_mode = false;
-
-		ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
-		if (ret < 0) {
-			printk(KERN_INFO "%s: failed to update PI IRTE\n",
-					__func__);
-			goto out;
-		}
-	}
-
-	if (enable_remapped_mode)
-		ret = irq_set_vcpu_affinity(host_irq, NULL);
-
-	ret = 0;
-out:
-	srcu_read_unlock(&kvm->irq_srcu, idx);
-	return ret;
+	/*
+	 * VT-d PI cannot support posting multicast/broadcast
+	 * interrupts to a vCPU, we still use interrupt remapping
+	 * for these kind of interrupts.
+	 *
+	 * For lowest-priority interrupts, we only support
+	 * those with single CPU as the destination, e.g. user
+	 * configures the interrupts via /proc/irq or uses
+	 * irqbalance to make the interrupts single-CPU.
+	 *
+	 * We will support full lowest-priority interrupt later.
+	 *
+	 * In addition, we can only inject generic interrupts using
+	 * the PI mechanism, refuse to route others through it.
+	 */
+	if (!new || new->type != KVM_IRQ_ROUTING_MSI)
+		goto do_remapping;
+
+	kvm_set_msi_irq(kvm, new, &irq);
+
+	if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu) ||
+	    !kvm_irq_is_postable(&irq))
+		goto do_remapping;
+
+	vcpu_info.pi_desc_addr = __pa(vcpu_to_pi_desc(vcpu));
+	vcpu_info.vector = irq.vector;
+
+	trace_kvm_pi_irte_update(host_irq, vcpu->vcpu_id, guest_irq,
+				 vcpu_info.vector, vcpu_info.pi_desc_addr, true);
+
+	return irq_set_vcpu_affinity(host_irq, &vcpu_info);
+do_remapping:
+	return irq_set_vcpu_affinity(host_irq, NULL);
 }
-- 
2.50.0.rc1.591.g9c95f17f64-goog

