Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0A26159D
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962042; cv=none; b=ZeMPftdjBFgP/59qJ5r7eJQNWI8Du9wBJi4+77wMHl+NyfERITYMMIsRDW0jpaLP8UoBA81lq0zEZ/6pKwNflP3gUMtG/56UhV5OV5VUYa2PVGRc7TpohKWzLTdwqfMSwoLfygBKXJT8i/HXOEYh+z9E1BhzDgH2TRar88DlJY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962042; c=relaxed/simple;
	bh=4de0q3T14DeT0F0X3ZAAYDHlZ1QD6sh3cOnu2ImrrHk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AzXdZXync5p89Fe12hYJWEjcsoYScB3ll/Tche3msqEbvCs9hZDEmjxQiMMJdyDZcUum4c1TKwum5NrZab9E3RPv6cPXVK1GW+Caus0c50Q87ZxM2zZIDhjLB2RZM0uVWpT4oYYagH7TYUvoFgoD3VJNN5PTW2j+SKRTqbx1Gco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zYjeh0wM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zYjeh0wM"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742c00c9044so4506280b3a.0
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962040; x=1748566840; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aWd9B+cmIuOPKCFRA3Y6+3mZ7hC0+f0rb42YHlM7f7Q=;
        b=zYjeh0wMyAZErSCb+Bq+FcAtleuEm3//F5xp7iSZsayo3nwln/NWR8GMv6NGdL5QI+
         McyHLyoq0bvzu4fb8omZ2PDaTQjqZCil3+cJLTfXu9Uj8AGOQJkE/znSRtJr7O6cnyGT
         zjzqrlninEb9JkA4g+YS9Kz68M/iD8Z/fSzlTpF8JsC0zA/BEXFH1wMg1gB7zKTX1xoE
         YfFN31bYeya/fhWIjatm8X7DObKnS/u05JA/dtxYxOpN4Ynqw9cC75yfWvdBDfEl39zx
         Z1+zqr3EgspCNWUr2fhwOO8uP25CIIF1frHUx+clYVa+I+6+CIMpCDW+8xtoGa/LgDtU
         6hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962040; x=1748566840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWd9B+cmIuOPKCFRA3Y6+3mZ7hC0+f0rb42YHlM7f7Q=;
        b=YBYhZT1CpasH+j+qw5vsUqZH7Mv7ajBlVnKKg7aRapADobKh9onU0rQDG26HGShAfl
         p9ackJS4+DwA468Hs/XNzyokOpAtbWXmSJmBMeGXIyW0yNFBCWU2HTyFk0aHfsHZzvoV
         h3t7qoBH85axvRxhflaPiSXl3KLOUTYfAzYlNoA4T3D9aPuHrq3HaG3XYz1ASObT0URz
         smv9cxflzvU8cZOoMPI3c/fCHP5TNblwLhVOTGvkcTwk2Sk/sR4sZgkditx9pV39sJ+6
         hwwO5oV5xAAYXlvErNlZ05Z7nQykRip8gENgxTkEG+tbQUWgasbuW3S0X6OFeP4oc2bO
         K8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXXt3zSqofUdCuwWPJSiLbsQFDTLdaKAtVa57AgnAavpLccE4lckDAK20HJvuiDfOMF49svxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQPHzhM/RR3rHhwHMlKjCrjxeszlVq4jch1nFCHjm43keZqdge
	n3nAQ/avBD8LIqk19ReH8DZ14isNU0BqgD7yutWiTyJHBtwWLOjXma+P0hQrVLcqj956m5ZFnV8
	vguOo6A==
X-Google-Smtp-Source: AGHT+IHIoGb2eWkztEC9ZxX2CyQRptApdmezXKPQEhifuGSkSLTWTrhoDwK2W6RjGyel2aIvam5GJ+N3m38=
X-Received: from pgar23.prod.google.com ([2002:a05:6a02:2e97:b0:b26:bb7f:b0d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:350d:b0:215:e9ec:81d2
 with SMTP id adf61e73a8af0-216219bd5c3mr48285536637.32.1747962039674; Thu, 22
 May 2025 18:00:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:22 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-18-seanjc@google.com>
Subject: [PATCH v2 17/59] KVM: VMX: Suppress PI notifications whenever the
 vCPU is put
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Suppress posted interrupt notifications (set PID.SN=1) whenever the vCPU
is put, i.e. unloaded, not just when the vCPU is preempted, as KVM doesn't
do anything in response to a notification IRQ that arrives in the host,
nor does KVM rely on the Outstanding Notification (PID.ON) flag when the
vCPU is unloaded.  And, the cost of scanning the PIR to manually set PID.ON
when loading the vCPU is quite small, especially relative to the cost of
loading (and unloading) a vCPU.

On the flip side, leaving SN clear means a notification for the vCPU will
result in a spurious IRQ for the pCPU, even if vCPU task is scheduled out,
running in userspace, etc.  Even worse, if the pCPU is running a different
vCPU, the spurious IRQ could trigger posted interrupt processing for the
wrong vCPU, which is technically a violation of the architecture, as
setting bits in PIR aren't supposed to be propagated to the vIRR until a
notification IRQ is received.

The saving grace of the current behavior is that hardware sends
notification interrupts if and only if PID.ON=0, i.e. only the first
posted interrupt for a vCPU will trigger a spurious IRQ (for each window
where the vCPU is unloaded).

Ideally, KVM would suppress notifications before enabling IRQs in the
VM-Exit, but KVM relies on PID.ON as an indicator that there is a posted
interrupt pending in PIR, e.g. in vmx_sync_pir_to_irr(), and sadly there
is no way to ask hardware to set PID.ON, but not generate an interrupt.
That could be solved by using pi_has_pending_interrupt() instead of
checking only PID.ON, but it's not at all clear that would be a performance
win, as KVM would end up scanning the entire PIR whenever an interrupt
isn't pending.

And long term, the spurious IRQ window, i.e. where a vCPU is loaded with
IRQs enabled, can effectively be made smaller for hot paths by moving
performance critical VM-Exit handlers into the fastpath, i.e. by never
enabling IRQs for hot path VM-Exits.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 110fb19848ab..d4826a6b674f 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -73,13 +73,10 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 	/*
 	 * If the vCPU wasn't on the wakeup list and wasn't migrated, then the
 	 * full update can be skipped as neither the vector nor the destination
-	 * needs to be changed.
+	 * needs to be changed.  Clear SN even if there is no assigned device,
+	 * again for simplicity.
 	 */
 	if (pi_desc->nv != POSTED_INTR_WAKEUP_VECTOR && vcpu->cpu == cpu) {
-		/*
-		 * Clear SN if it was set due to being preempted.  Again, do
-		 * this even if there is no assigned device for simplicity.
-		 */
 		if (pi_test_and_clear_sn(pi_desc))
 			goto after_clear_sn;
 		return;
@@ -225,17 +222,23 @@ void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
 	if (!vmx_needs_pi_wakeup(vcpu))
 		return;
 
-	if (kvm_vcpu_is_blocking(vcpu) &&
+	/*
+	 * If the vCPU is blocking with IRQs enabled and ISN'T being preempted,
+	 * enable the wakeup handler so that notification IRQ wakes the vCPU as
+	 * expected.  There is no need to enable the wakeup handler if the vCPU
+	 * is preempted between setting its wait state and manually scheduling
+	 * out, as the task is still runnable, i.e. doesn't need a wake event
+	 * from KVM to be scheduled in.
+	 *
+	 * If the wakeup handler isn't being enabled, Suppress Notifications as
+	 * the cost of propagating PIR.IRR to PID.ON is negligible compared to
+	 * the cost of a spurious IRQ, and vCPU put/load is a slow path.
+	 */
+	if (!vcpu->preempted && kvm_vcpu_is_blocking(vcpu) &&
 	    ((is_td_vcpu(vcpu) && tdx_interrupt_allowed(vcpu)) ||
 	     (!is_td_vcpu(vcpu) && !vmx_interrupt_blocked(vcpu))))
 		pi_enable_wakeup_handler(vcpu);
-
-	/*
-	 * Set SN when the vCPU is preempted.  Note, the vCPU can both be seen
-	 * as blocking and preempted, e.g. if it's preempted between setting
-	 * its wait state and manually scheduling out.
-	 */
-	if (vcpu->preempted)
+	else
 		pi_set_sn(pi_desc);
 }
 
-- 
2.49.0.1151.ga128411c76-goog

