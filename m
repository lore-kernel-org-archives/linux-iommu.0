Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1B2750ED
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962048; cv=none; b=PTNaDoS/SVobUWWIEvH4Cfo41/+WmsUaNRG0+UPKlNTCAqTP8Ay2rXdbSrf4VOiomRQpd7GQq2ROlmnfRfGjpbTFbrVYxnEwYgxI6+xj0FETx4SkNAsSS18xw0XDB3kr5aLAI5Eq3t6ohYzAOpGmg1HVZ8TKyB951wIAAGJGvnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962048; c=relaxed/simple;
	bh=XTKaQxa4npnh2rWsQb6P4+FcVAHho6ewDy41tUd6na8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PfABxpd35z6B/govudZMPihmKRNogkvljwgsDde0AfI1WOqmTnAcN6Bj+v407H849fqFN7InPTPUS+t3qF6+YBInSQc6zNzg5OWY7EI2sai58b4ZxA01aka3QtZdHRvvYamr+zO0es32P+MAEHZonYQdD7fcTcAU3oYZRbgvGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MrU95wwJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MrU95wwJ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-310a3196132so1832600a91.3
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962046; x=1748566846; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=W1PAenioYvdV3EBJg7xX9kzyF9B21do+ZbIq4hvNUSI=;
        b=MrU95wwJ6OVAiPMK7mbSFSDLTI6w0X6J3AXybqL79fth7UcwxtiCSIKAx0rMVZ+Mw8
         mag7UG2VfiXz8Kbggg+83e7mY/bx4ybt4Be6i5RSMih1U7UpU6ZyoldfmNUDIRX0t+I3
         o9Z6LDvSrQbJ1bwYSBAjaDFys0TIaebiyD6oPZtNQTqUqH0Q8ESDFvogvqqc6vR4fcFx
         PD0fhK+mEasHpP/F0uH8K2tkEKHhLgNfm+5FkBCTe08qMxefUPMo3DGKMLyUnIJ40Fgm
         aHQECL+4zbXPjHm0HUa0WSQeOdERzUDHC2ne7e9aG42eVR/lwXZFOEi6vkkgz/qjW1qc
         wx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962046; x=1748566846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W1PAenioYvdV3EBJg7xX9kzyF9B21do+ZbIq4hvNUSI=;
        b=vtnZ7PBMZqZrhrpVTRcBJTHXxy0F22j06vVGd+5iITXMq8DNdGYaLh1in6bD+648K4
         Sn1YoRxIfoUW8BUI382QTZsLLrrQ09Yzf8CJi030NtcRpKSnOkSN4gdt+bhE/pUImnrJ
         6oz72MSCE2Se8yRzZmcG39S/QRSVMJ0+aDvEKG7KcFV0K+V2VgalhgxsLeyUZMSjK12j
         ZZSj666tfk7CjWhKGxssUOUC4cpWQ9NQTVH2xHf6JxQ9yOlMTHdzQRacFb1gaLwv3klz
         O+LVBTCE+DmBUgxGMdNZ5S7hIzgWLuabND/KjlHykUWAp3hoxsEd0UdmFNQYt9J2vnTg
         KlMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr+pVa0ZvmzY2eY1ctwCfMvOBgvjWZiG0gb4ZuPwVAx4l8/OnCtBQsnC6IOSHBRSbPhlkZkw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzd9lmnqfloLgRwOJGOib0/8QTDRL1e9+116+c0cleEBFmWakkd
	lTZWqy4IXTJ0lXKE41V2hUiu5ODdNa4RX83uQ18miZKGaFtcwGntUIvUnEPWvom/x3CkDL1XYzx
	WoREEVA==
X-Google-Smtp-Source: AGHT+IF50BW7eNbKLTes6wg+6QoUM4Fli2u18WBE8vabKew1Ppo7X2JHY21NH8Gk7becGtcg20a3VvulZ6s=
X-Received: from pjbqo12.prod.google.com ([2002:a17:90b:3dcc:b0:2ea:3a1b:f493])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a86:b0:30e:840a:92ed
 with SMTP id 98e67ed59e1d1-310e973cef6mr1696555a91.31.1747962045911; Thu, 22
 May 2025 18:00:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:26 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-22-seanjc@google.com>
Subject: [PATCH v2 21/59] KVM: SVM: Stop walking list of routing table entries
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

Now that KVM explicitly passes the new/current GSI routing to
pi_update_irte(), simply use the provided routing entry and stop walking
the routing table to find that entry.  KVM, via setup_routing_entry() and
sanity checked by kvm_get_msi_route(), disallows having a GSI configured
to trigger multiple MSIs.

I.e. this is subtly a glorified nop, as KVM allows at most one MSI per
GSI, the for-loop can only ever process one entry, and that entry is the
new/current entry (see the WARN_ON_ONCE() added by "KVM: x86: Pass new
routing entries and irqfd when updating IRTEs" to ensure @new matches the
entry found in the routing table).

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 109 ++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 65 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 6260bf3697ba..a83769bb8123 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -843,11 +843,10 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			unsigned int host_irq, uint32_t guest_irq,
 			struct kvm_kernel_irq_routing_entry *new)
 {
-	struct kvm_kernel_irq_routing_entry *e;
-	struct kvm_irq_routing_table *irq_rt;
 	bool enable_remapped_mode = true;
-	bool set = !!new;
-	int idx, ret = 0;
+	struct vcpu_data vcpu_info;
+	struct vcpu_svm *svm = NULL;
+	int ret = 0;
 
 	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
 		return 0;
@@ -859,72 +858,53 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	svm_ir_list_del(irqfd);
 
 	pr_debug("SVM: %s: host_irq=%#x, guest_irq=%#x, set=%#x\n",
-		 __func__, host_irq, guest_irq, set);
+		 __func__, host_irq, guest_irq, !!new);
 
-	idx = srcu_read_lock(&kvm->irq_srcu);
-	irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
+	/**
+	 * Here, we setup with legacy mode in the following cases:
+	 * 1. When cannot target interrupt to a specific vcpu.
+	 * 2. Unsetting posted interrupt.
+	 * 3. APIC virtualization is disabled for the vcpu.
+	 * 4. IRQ has incompatible delivery mode (SMI, INIT, etc)
+	 */
+	if (new && new->type == KVM_IRQ_ROUTING_MSI &&
+	    !get_pi_vcpu_info(kvm, new, &vcpu_info, &svm) &&
+	    kvm_vcpu_apicv_active(&svm->vcpu)) {
+		struct amd_iommu_pi_data pi;
 
-	if (guest_irq >= irq_rt->nr_rt_entries ||
-		hlist_empty(&irq_rt->map[guest_irq])) {
-		pr_warn_once("no route for guest_irq %u/%u (broken user space?)\n",
-			     guest_irq, irq_rt->nr_rt_entries);
-		goto out;
-	}
+		enable_remapped_mode = false;
 
-	hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
-		struct vcpu_data vcpu_info;
-		struct vcpu_svm *svm = NULL;
-
-		if (e->type != KVM_IRQ_ROUTING_MSI)
-			continue;
-
-		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
+		/*
+		 * Try to enable guest_mode in IRTE.  Note, the address
+		 * of the vCPU's AVIC backing page is passed to the
+		 * IOMMU via vcpu_info->pi_desc_addr.
+		 */
+		pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
+					     svm->vcpu.vcpu_id);
+		pi.is_guest_mode = true;
+		pi.vcpu_data = &vcpu_info;
+		ret = irq_set_vcpu_affinity(host_irq, &pi);
 
 		/**
-		 * Here, we setup with legacy mode in the following cases:
-		 * 1. When cannot target interrupt to a specific vcpu.
-		 * 2. Unsetting posted interrupt.
-		 * 3. APIC virtualization is disabled for the vcpu.
-		 * 4. IRQ has incompatible delivery mode (SMI, INIT, etc)
+		 * Here, we successfully setting up vcpu affinity in
+		 * IOMMU guest mode. Now, we need to store the posted
+		 * interrupt information in a per-vcpu ir_list so that
+		 * we can reference to them directly when we update vcpu
+		 * scheduling information in IOMMU irte.
 		 */
-		if (!get_pi_vcpu_info(kvm, e, &vcpu_info, &svm) && set &&
-		    kvm_vcpu_apicv_active(&svm->vcpu)) {
-			struct amd_iommu_pi_data pi;
-
-			enable_remapped_mode = false;
-
-			/*
-			 * Try to enable guest_mode in IRTE.  Note, the address
-			 * of the vCPU's AVIC backing page is passed to the
-			 * IOMMU via vcpu_info->pi_desc_addr.
-			 */
-			pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
-						     svm->vcpu.vcpu_id);
-			pi.is_guest_mode = true;
-			pi.vcpu_data = &vcpu_info;
-			ret = irq_set_vcpu_affinity(host_irq, &pi);
-
-			/**
-			 * Here, we successfully setting up vcpu affinity in
-			 * IOMMU guest mode. Now, we need to store the posted
-			 * interrupt information in a per-vcpu ir_list so that
-			 * we can reference to them directly when we update vcpu
-			 * scheduling information in IOMMU irte.
-			 */
-			if (!ret && pi.is_guest_mode)
-				svm_ir_list_add(svm, irqfd, &pi);
-		}
-
-		if (!ret && svm) {
-			trace_kvm_pi_irte_update(host_irq, svm->vcpu.vcpu_id,
-						 e->gsi, vcpu_info.vector,
-						 vcpu_info.pi_desc_addr, set);
-		}
-
-		if (ret < 0) {
-			pr_err("%s: failed to update PI IRTE\n", __func__);
-			goto out;
-		}
+		if (!ret)
+			ret = svm_ir_list_add(svm, irqfd, &pi);
+	}
+
+	if (!ret && svm) {
+		trace_kvm_pi_irte_update(host_irq, svm->vcpu.vcpu_id,
+					 guest_irq, vcpu_info.vector,
+					 vcpu_info.pi_desc_addr, !!new);
+	}
+
+	if (ret < 0) {
+		pr_err("%s: failed to update PI IRTE\n", __func__);
+		goto out;
 	}
 
 	if (enable_remapped_mode)
@@ -932,7 +912,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	else
 		ret = 0;
 out:
-	srcu_read_unlock(&kvm->irq_srcu, idx);
 	return ret;
 }
 
-- 
2.49.0.1151.ga128411c76-goog

