Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02687276038
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962049; cv=none; b=evBt6OX6d3RfPx2aTDmQ2MTcFdoT7WJAobqR2bPHs7XMKQfGAp3YCBugMBo+RjmE2e7/zVQnl8l0uxcov5C3Xra9PXRrYjHRM4/qBjz+ypxlcskihwGgZLuOyhhEuouFphNk8e1IUENxlXJsDH8DJGKjqVyxoJDBLzW9mxsw00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962049; c=relaxed/simple;
	bh=srDOFDWE3P2VL5WlCjbeOnuh/V7VTaVfjbBhk5s85qM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nR9Igse/uOG3M9hCA2b9KPKZMnBvtkHqUTpwdD255z063yf1f1aWwJF/aa4Lp1Wrr9IwiC+XlYzeVgc74x3DhZH70B4OvNg5UuSKa0ulTwNQhsqPkrsCGOTaJ6osi48kD+hX3doXpgslHJpLUt7SjVSNEfrfJW4nlNWQMFQDL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A1XEf9nO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1XEf9nO"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30eac9886ffso4645452a91.1
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962047; x=1748566847; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9WMm03XHcPOkUVkdGVy3jRNjqSu09sZJKxdu9rxT7Kc=;
        b=A1XEf9nOOY7gU1midnEsR6xlqC2skRas5wcIdnunhsU00sRZfI3C/Nwue1Y7L3tTIZ
         zZc4e9J+kqs+e9OzGuHkMXag0IR8rhJ4H6fBoYcapF6syNSisvaCvE6hrxme2O1sG4GQ
         gMKbURbvCYR4+BKAGpxBisxKuFIkY+3uel/3hEL8l1KV67RYmr5qcM5q7tqAzgZUCXr9
         IUuybg138vRi33FhiA3ywVlUY5heHGdGMixsBUEZH4VCPFJSVleREwnAzY7ksHOkzxMa
         XoIto9Jfw325iorR5XB2GZyaMzFsUDBwBLPcJXQlvRQjjki5Xk9QG4FOpoPdGcRLeN2E
         BfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962047; x=1748566847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9WMm03XHcPOkUVkdGVy3jRNjqSu09sZJKxdu9rxT7Kc=;
        b=NE0kuZ/U2BM4JPxfG16iEo4hQlwQc48I7aD05pJLKSa1EAZXiH/LDfT70l8B1zlsZx
         zYOb2wnHcBcmwp/3dGyJZfEUZei8n6wlZK5QGdJ2fpTIxpl2OC5xvEjA0QSyBYybOTTH
         Dfyv7YjRK/+z8eCsvNynYGNmSLrgGNfUd9bjotivQBHRVcFiI3YszUquoz3/eOcswhne
         bkGDivgUWuAN5bUbSfWaLGFMf3z5DuU0NeA8bTuiPuDnfAiWCLsJI1xq+dUIaj/T0d49
         id+xbphS7f1IYdnrRgHyCDACeIpN5Ix9L8c6aYcyWz0QUnHsU1agzH+PcszyvylcAuDo
         2q1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBultCQg49hB6VSlhxyqBuioA50i5wvNLBVXFj2hpZUSB3Cj3necYceYeSDZhzTZyLaojtVg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4WvXiWHBN6Vc6PBOtO8JY6w8A2lieSRyD4+QJBpdQiiG4e/u+
	dMTv8V82g2AiyNtltk6lrNAoqG5tbllBvUlJsboaHXS+UX5620e/wBcD9Jj0zd4DtXAXlikl8tu
	THZMELw==
X-Google-Smtp-Source: AGHT+IHScxVo8921NDXHfwYzbnuN/lZJlpUOiAfvprIuuohbUElxMDY5rmt5M3Lf2Xtm0bYMmcmAvG8AwgQ=
X-Received: from pjbhl12.prod.google.com ([2002:a17:90b:134c:b0:30a:7da4:f075])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5143:b0:310:cf8f:6724
 with SMTP id 98e67ed59e1d1-310e9740405mr1799767a91.30.1747962047581; Thu, 22
 May 2025 18:00:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:27 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-23-seanjc@google.com>
Subject: [PATCH v2 22/59] KVM: VMX: Stop walking list of routing table entries
 when updating IRTE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
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
2.49.0.1151.ga128411c76-goog

