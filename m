Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53A4234988
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744147893; cv=none; b=rkQAh14FOqgGYl0asGWyetIYFYDhLpC77DfSTIZ50bM8vLU3eW6wPnqeTs7Um31dwrLTj1uXcPoWwCS+z/nanDxPIl1NxIb88BDm70GJKqi79ahhmlYgvb6CGiU9mQ2Yq68sYvPnXeFwDyPfIReUwHwU4id3YgBRkGwXR5PCtu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744147893; c=relaxed/simple;
	bh=AGINcubrwDHhNZhMG/5qRMWHfMGWmK7tdHB0j9/zR7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tQb7OlGF167CqkqSHDmKQW8OyqbVJ5I6xoBNHpVkgtcA7KKIUMhk1RdKIUuSGLXWlsb3MqEAWtV53UCvyysqx6Q1vjQXX+RBAMvZvJJiADJ4Fd6Jim414+peRbGSVEqXXmNRxhmub8yWFyWlREIFCTzdOJrvmy41qP08HBeJ0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1WQ9VDGX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1WQ9VDGX"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-227e2faab6dso50712665ad.1
        for <iommu@lists.linux.dev>; Tue, 08 Apr 2025 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744147891; x=1744752691; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uam7GnobKmUw9hclFkCECYy0gTHPZztonbEuBIMruls=;
        b=1WQ9VDGXgc7pw0j+KDqmRAYGZBlaTWqD3ddJnh9vrYfkuvb5Sle9LuSkcpTHRzdjbG
         eEkC/msKJfOSNA2BYmHQAMg0UYvWrDW2tUIc4s3oaOOQ7xEMAw77h0PW8YfWPo40Rl7H
         QwvR0rSk+2ECs0egYr8sUywtfkVTsKnZm8fMcnWiY7PR6/p/TBQGciYxfrQ1ZrMAsb5/
         dn3J/k5HjP/xmzYpRvUs+4btaVbVmuJn85QHyrPJtDQLKieDUg8PdMhpEUd0K7nsgobm
         H4mcAwXjeDq6kBif5I/RdhID8exKUJZ65aNiIjUSTe4+JDqFORVqG1YacfTbh3MZNRf/
         3iGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744147891; x=1744752691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uam7GnobKmUw9hclFkCECYy0gTHPZztonbEuBIMruls=;
        b=MWb2sWJDlaHHppgo3VHMQVlcyYGt7V7uDx/9vssaIvylLJKGsj3Z31lTmHbfUTl0+Q
         0KMpzViXrTQPdU5bMS8xDp+5mUc1fA6YetaHDBCkOOidSkOjy5HvP9jkC+C/L1A+al31
         2027F3rcnQkYq0aTjHSqJ05Sq6rx/ZVbNZ3Mn03UgGbUd9/uHh78Ct9TX97iv8uPHHeZ
         y+Dc0pZpFm09mexShX6o9DdSY7f1WLr0CfSdFDwpu8fEN6ItLnvAr2zTs7AdbsROHPlM
         XMpnQuCriHiv8KT64m3aKLPRBJE3AcTVYdIHmAG5by5mvFEdsAObX4ZYQhdy6hpn9glQ
         fIWw==
X-Forwarded-Encrypted: i=1; AJvYcCVj5aQaarErzneZcFYPqNVtiR1DdJMw4RUAcoTMzqf0uMChtyQU71ABXscPYLQJP64QZYoE2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbcrJ9tq43PUpSQiy1O/O1zg5B2p2BCtX2vU6k9Tqgg152aOja
	X8HYojm1aNuSGYNONB8iOEPQ/W6gaYhjP0Pw9I3ovmXys7WpRNHgEDK5lHtsJmDgL2RasWud0AT
	UCA==
X-Google-Smtp-Source: AGHT+IEKRdfCo7P0dOM9nLMdnn/wJxKiZkQkp2kalAXi+Af3MMzb50Othlo0RizKEkwtKlr8YY3PKqUJQ1s=
X-Received: from pfbfc24.prod.google.com ([2002:a05:6a00:2e18:b0:730:7e2d:df69])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ccc8:b0:227:e7c7:d451
 with SMTP id d9443c01a7336-22ac3f9a8fcmr4363085ad.29.1744147891223; Tue, 08
 Apr 2025 14:31:31 -0700 (PDT)
Date: Tue, 8 Apr 2025 14:31:29 -0700
In-Reply-To: <4c396e79-845a-481a-8a3e-4a7f458371b8@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-66-seanjc@google.com>
 <4c396e79-845a-481a-8a3e-4a7f458371b8@redhat.com>
Message-ID: <Z_WVsZQbY23XrhAG@google.com>
Subject: Re: [PATCH 65/67] KVM: SVM: Generate GA log IRQs only if the
 associated vCPUs is blocking
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Joao Martins <joao.m.martins@oracle.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 08, 2025, Paolo Bonzini wrote:
> On 4/4/25 21:39, Sean Christopherson wrote:
> > @@ -892,7 +893,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu, bool toggle_avic)
> >   	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
> > -	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, toggle_avic);
> > +	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, toggle_avic, false);
> >   	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
> >   }
> > @@ -912,7 +913,8 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
> >   	__avic_vcpu_load(vcpu, cpu, false);
> >   }
> > -static void __avic_vcpu_put(struct kvm_vcpu *vcpu, bool toggle_avic)
> > +static void __avic_vcpu_put(struct kvm_vcpu *vcpu, bool toggle_avic,
> > +			    bool is_blocking)
> 
> What would it look like to use an enum { SCHED_OUT, SCHED_IN, ENABLE_AVIC,
> DISABLE_AVIC, START_BLOCKING } for both __avic_vcpu_put and
> __avic_vcpu_load's second argument?

There's gotta be a way to make it look better than this code.  I gave a half-
hearted attempt at using an enum before posting, but wasn't able to come up with
anything decent.

Coming back to it with fresh eyes, what about this (full on-top diff below)?

enum avic_vcpu_action {
	AVIC_SCHED_IN		= 0,
	AVIC_SCHED_OUT		= 0,
	AVIC_START_BLOCKING	= BIT(0),

	AVIC_TOGGLE_ON_OFF	= BIT(1),
	AVIC_ACTIVATE		= AVIC_TOGGLE_ON_OFF,
	AVIC_DEACTIVATE		= AVIC_TOGGLE_ON_OFF,
};

AVIC_SCHED_IN and AVIC_SCHED_OUT are essentially syntactic sugar, as are
AVIC_ACTIVATE and AVIC_DEACTIVATE to a certain extent.  But it's much better than
booleans, and using a bitmask makes avic_update_iommu_vcpu_affinity() slightly
prettier.

> Consecutive bools are ugly...

Yeah, I hated it when I wrote it, and still hate it now.

And more error prone, e.g. the __avic_vcpu_put() call from avic_refresh_apicv_exec_ctrl()
should specify is_blocking=false, not true, as kvm_x86_ops.refresh_apicv_exec_ctrl()
should never be called while the vCPU is blocking.

---
 arch/x86/kvm/svm/avic.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 425674e1a04c..1752420c68aa 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -833,9 +833,20 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	return irq_set_vcpu_affinity(host_irq, NULL);
 }
 
+enum avic_vcpu_action {
+	AVIC_SCHED_IN		= 0,
+	AVIC_SCHED_OUT		= 0,
+	AVIC_START_BLOCKING	= BIT(0),
+
+	AVIC_TOGGLE_ON_OFF	= BIT(1),
+	AVIC_ACTIVATE		= AVIC_TOGGLE_ON_OFF,
+	AVIC_DEACTIVATE		= AVIC_TOGGLE_ON_OFF,
+};
+
 static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
-					    bool toggle_avic, bool ga_log_intr)
+					    enum avic_vcpu_action action)
 {
+	bool ga_log_intr = (action & AVIC_START_BLOCKING);
 	struct amd_svm_iommu_ir *ir;
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -849,7 +860,7 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
 		return;
 
 	list_for_each_entry(ir, &svm->ir_list, node) {
-		if (!toggle_avic)
+		if (!(action & AVIC_TOGGLE_ON_OFF))
 			WARN_ON_ONCE(amd_iommu_update_ga(ir->data, cpu, ga_log_intr));
 		else if (cpu >= 0)
 			WARN_ON_ONCE(amd_iommu_activate_guest_mode(ir->data, cpu, ga_log_intr));
@@ -858,7 +869,8 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
 	}
 }
 
-static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu, bool toggle_avic)
+static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
+			     enum avic_vcpu_action action)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	int h_physical_id = kvm_cpu_get_apicid(cpu);
@@ -904,7 +916,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu, bool toggle_avic)
 
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, toggle_avic, false);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, action);
 
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
@@ -921,11 +933,10 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (kvm_vcpu_is_blocking(vcpu))
 		return;
 
-	__avic_vcpu_load(vcpu, cpu, false);
+	__avic_vcpu_load(vcpu, cpu, AVIC_SCHED_IN);
 }
 
-static void __avic_vcpu_put(struct kvm_vcpu *vcpu, bool toggle_avic,
-			    bool is_blocking)
+static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -947,7 +958,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, bool toggle_avic,
 	 */
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
 
-	avic_update_iommu_vcpu_affinity(vcpu, -1, toggle_avic, is_blocking);
+	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
 
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
 
@@ -964,7 +975,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, bool toggle_avic,
 	 * Note!  Don't set AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR in the table as
 	 * it's a synthetic flag that usurps an unused a should-be-zero bit.
 	 */
-	if (is_blocking)
+	if (action & AVIC_START_BLOCKING)
 		entry |= AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
 
 	svm->avic_physical_id_entry = entry;
@@ -992,7 +1003,8 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 			return;
 	}
 
-	__avic_vcpu_put(vcpu, false, kvm_vcpu_is_blocking(vcpu));
+	__avic_vcpu_put(vcpu, kvm_vcpu_is_blocking(vcpu) ? AVIC_START_BLOCKING :
+							   AVIC_SCHED_OUT);
 }
 
 void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu)
@@ -1024,12 +1036,15 @@ void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 	if (!enable_apicv)
 		return;
 
+	/* APICv should only be toggled on/off while the vCPU is running. */
+	WARN_ON_ONCE(kvm_vcpu_is_blocking(vcpu));
+
 	avic_refresh_virtual_apic_mode(vcpu);
 
 	if (kvm_vcpu_apicv_active(vcpu))
-		__avic_vcpu_load(vcpu, vcpu->cpu, true);
+		__avic_vcpu_load(vcpu, vcpu->cpu, AVIC_ACTIVATE);
 	else
-		__avic_vcpu_put(vcpu, true, true);
+		__avic_vcpu_put(vcpu, AVIC_DEACTIVATE);
 }
 
 void avic_vcpu_blocking(struct kvm_vcpu *vcpu)
@@ -1055,7 +1070,7 @@ void avic_vcpu_blocking(struct kvm_vcpu *vcpu)
 	 * CPU and cause noisy neighbor problems if the VM is sending interrupts
 	 * to the vCPU while it's scheduled out.
 	 */
-	__avic_vcpu_put(vcpu, false, true);
+	__avic_vcpu_put(vcpu, AVIC_START_BLOCKING);
 }
 
 void avic_vcpu_unblocking(struct kvm_vcpu *vcpu)

base-commit: fe5b44cf46d5444ff071bc2373fbe7b109a3f60b
-- 
