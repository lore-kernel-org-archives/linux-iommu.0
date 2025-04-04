Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EBE253B59
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795701; cv=none; b=Z+r922ez1OsSSoPcWGXvlvkYsxYatwhBQ4B9CLRKhEZoYbd/5KQDX+KDu7fpfpMBYhL1LHk8mQc+FsQxvLsXi0WrMb6u3a/XqPIRs9b/SVh1jt+p6yrvFJ9l1TdFXMl2Oeu81lgbeas33VbK991ObaTC3E+nfnQy3cbh0aDMOO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795701; c=relaxed/simple;
	bh=Sb4bsa6vo9IYveps+nL7XukC6432K1ulPMRWWP6K8jc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G2N1M1AiF2wqFpwBgCuP7INkesOrky2gXym8sSGi7WJreYpKHVdvFaovq2HEhWoVs21ALpyo6Kkj9qwlVbdn/ZCxmZCsWg4Ggw26rtYgYYjKzSe8ZOaRa/o/asn6bF+vU7qE16Jo2U8NNvgQoZifjAoRTB7qXnHd7yeu5696HGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQ98lUKE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQ98lUKE"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736abba8c5cso3047796b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795699; x=1744400499; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xa2Ve4DPvmz0R4op/e/h5NsuopJcYdvF3WY5dpywXT4=;
        b=IQ98lUKEravcGflC5qtfXz7vHfJQuGkjJpJGBjnWvjOlFFdGqitFOtOpwijxdPmaC3
         T5XnSziW6f/IV9SUnq1aikJamqCbq9J4csFa+xboqlR5VL9pzQaOqmGFVFo9Ehyygx2b
         WGcZ9YGP6hAz1xcKww/8axcOeVk/wlruuPq1DTkeDZVSoc2J373S0UgaEf6vF//ZFbkV
         95ZnenH1xQbJiQf7WQ5NXTsowgfzbmGBJf03SspedEfYc81JglBJ41Zzmscanejbt5FK
         DKbaVk7IT9AB/TL6uWpEoM/ykL6z3YDdwZUxY5iuw9PUstYObNnLqQcg262nGGrnQcee
         90yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795699; x=1744400499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xa2Ve4DPvmz0R4op/e/h5NsuopJcYdvF3WY5dpywXT4=;
        b=wDCF9/zWUANvfYKMjBd3EfhWveesiDQI1TS4flMcqyW6+Ez8uGrGt2qE0vPpNw4rTr
         W2Y9DVVKxMcbGRj/BuKCf4Sa95qwAsbjxrFQblSER45TXiPWBVdWvLHtNUdUTBN9sNsQ
         SYA1JhfT1nJqXqHVpy3241K/aA7jl+6zqUxxLI5agTNQ5uDew+fqw1DFQuTdMeG5XsJd
         X1zvQ8GJWmCskoG/RJRxjjdbk60WAEbtEtE+yFZ9Z9WYNZIADrprzizL78vBbYXDOvTD
         Vt/aLiwuCQawM8KCYUITXEgEsN5PbLEDkJHmWxGO5DAMf7qK6c8MdXWFmaERCoIr5av1
         5nBg==
X-Forwarded-Encrypted: i=1; AJvYcCX6bzel/FvCN4+RvGIaBoOdtZu5ik9UN70hdYuhCcYJnqdSHNew63P+XCz3KhVNVkj2O059SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzs3kmwMQpZz/r+i5hw/MgF1l0PGC1qnu+3uFmNtPQcOoVnODTH
	pdRemJVzkwyyVuHaV2m6vTCwQlZOC32t31eH/cXS2aD7WtzAu1DTmK0mbv2XJwM1lOateYBq+2z
	6AQ==
X-Google-Smtp-Source: AGHT+IGYu/yYBkSf+6Tq2bLTJpJywO70pYjALzEs/kBx6J6iNAtgjLKV0RF85EP9hys6qFZmYCGLhDM/+UY=
X-Received: from pfbho2.prod.google.com ([2002:a05:6a00:8802:b0:736:b315:f15e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:10ce:b0:736:5b85:a911
 with SMTP id d2e1a72fcca58-739e6ff6b96mr5876430b3a.8.1743795699069; Fri, 04
 Apr 2025 12:41:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:20 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-66-seanjc@google.com>
Subject: [PATCH 65/67] KVM: SVM: Generate GA log IRQs only if the associated
 vCPUs is blocking
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Configure IRTEs to GA log interrupts for device posted IRQs that hit
non-running vCPUs if and only if the target vCPU is blocking, i.e.
actually needs a wake event.  If the vCPU has exited to userspace or was
preempted, generating GA log entries and interrupts is wasteful and
unnecessary, as the vCPU will be re-loaded and/or scheduled back in
irrespective of the GA log notification (avic_ga_log_notifier() is just a
fancy wrapper for kvm_vcpu_wake_up()).

Use a should-be-zero bit in the vCPU's Physical APIC ID Table Entry to
track whether or not the vCPU's associated IRTEs are configured to
generate GA logs, but only set the synthetic bit in KVM's "cache", i.e.
never set the should-be-zero bit in tables that are used by hardware.
Use a synthetic bit instead of a dedicated boolean to minimize the odds
of messing up the locking, i.e. so that all the existing rules that apply
to avic_physical_id_entry for IS_RUNNING are reused verbatim for
GA_LOG_INTR.

Note, because KVM (by design) "puts" AVIC state in a "pre-blocking"
phase, using kvm_vcpu_is_blocking() to track the need for notifications
isn't a viable option.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/svm.h |  7 ++++++
 arch/x86/kvm/svm/avic.c    | 49 +++++++++++++++++++++++++++-----------
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 8b07939ef3b9..be6e833bf92c 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -246,6 +246,13 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define AVIC_LOGICAL_ID_ENTRY_VALID_BIT			31
 #define AVIC_LOGICAL_ID_ENTRY_VALID_MASK		(1 << 31)
 
+/*
+ * GA_LOG_INTR is a synthetic flag that's never propagated to hardware-visible
+ * tables.  GA_LOG_INTR is set if the vCPU needs device posted IRQs to generate
+ * GA log interrupts to wake the vCPU (because it's blocking or about to block).
+ */
+#define AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR		BIT_ULL(61)
+
 #define AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK	GENMASK_ULL(11, 0)
 #define AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK	GENMASK_ULL(51, 12)
 #define AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK		(1ULL << 62)
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 1466e66cca6c..0d2a17a74be6 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -798,7 +798,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			pi_data.cpu = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
 		} else {
 			pi_data.cpu = -1;
-			pi_data.ga_log_intr = true;
+			pi_data.ga_log_intr = entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
 		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
@@ -823,7 +823,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 }
 
 static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
-					    bool toggle_avic)
+					    bool toggle_avic, bool ga_log_intr)
 {
 	struct amd_svm_iommu_ir *ir;
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -839,9 +839,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
 
 	list_for_each_entry(ir, &svm->ir_list, node) {
 		if (!toggle_avic)
-			WARN_ON_ONCE(amd_iommu_update_ga(ir->data, cpu, true));
+			WARN_ON_ONCE(amd_iommu_update_ga(ir->data, cpu, ga_log_intr));
 		else if (cpu >= 0)
-			WARN_ON_ONCE(amd_iommu_activate_guest_mode(ir->data, cpu, true));
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(ir->data, cpu, ga_log_intr));
 		else
 			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(ir->data));
 	}
@@ -875,7 +875,8 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu, bool toggle_avic)
 	entry = svm->avic_physical_id_entry;
 	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
 
-	entry &= ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
+	entry &= ~(AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK |
+		   AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
 	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
 	entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 
@@ -892,7 +893,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu, bool toggle_avic)
 
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, toggle_avic);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, toggle_avic, false);
 
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
@@ -912,7 +913,8 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	__avic_vcpu_load(vcpu, cpu, false);
 }
 
-static void __avic_vcpu_put(struct kvm_vcpu *vcpu, bool toggle_avic)
+static void __avic_vcpu_put(struct kvm_vcpu *vcpu, bool toggle_avic,
+			    bool is_blocking)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -934,14 +936,28 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, bool toggle_avic)
 	 */
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
 
-	avic_update_iommu_vcpu_affinity(vcpu, -1, toggle_avic);
+	avic_update_iommu_vcpu_affinity(vcpu, -1, toggle_avic, is_blocking);
 
+	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
+
+	/*
+	 * Keep the previouv APIC ID in the entry so that a rogue doorbell from
+	 * hardware is at least restricted to a CPU associated with the vCPU.
+	 */
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
-	svm->avic_physical_id_entry = entry;
 
 	if (enable_ipiv)
 		WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
+	/*
+	 * Note!  Don't set AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR in the table as
+	 * it's a synthetic flag that usurps an unused a should-be-zero bit.
+	 */
+	if (is_blocking)
+		entry |= AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
+
+	svm->avic_physical_id_entry = entry;
+
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
 
@@ -957,10 +973,15 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	u64 entry = to_svm(vcpu)->avic_physical_id_entry;
 
 	/* Nothing to do if IsRunning == '0' due to vCPU blocking. */
-	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
-		return;
+	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)) {
+		if (WARN_ON_ONCE(!kvm_vcpu_is_blocking(vcpu)))
+			return;
 
-	__avic_vcpu_put(vcpu, false);
+		if (!(WARN_ON_ONCE(!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR))))
+			return;
+	}
+
+	__avic_vcpu_put(vcpu, false, kvm_vcpu_is_blocking(vcpu));
 }
 
 void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu)
@@ -997,7 +1018,7 @@ void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 	if (kvm_vcpu_apicv_active(vcpu))
 		__avic_vcpu_load(vcpu, vcpu->cpu, true);
 	else
-		__avic_vcpu_put(vcpu, true);
+		__avic_vcpu_put(vcpu, true, true);
 }
 
 void avic_vcpu_blocking(struct kvm_vcpu *vcpu)
@@ -1023,7 +1044,7 @@ void avic_vcpu_blocking(struct kvm_vcpu *vcpu)
 	 * CPU and cause noisy neighbor problems if the VM is sending interrupts
 	 * to the vCPU while it's scheduled out.
 	 */
-	avic_vcpu_put(vcpu);
+	__avic_vcpu_put(vcpu, false, true);
 }
 
 void avic_vcpu_unblocking(struct kvm_vcpu *vcpu)
-- 
2.49.0.504.g3bcea36a83-goog

