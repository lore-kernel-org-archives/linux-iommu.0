Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843F622C33A
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795639; cv=none; b=eV33ui7JQyVNF+VZRpATbfg38pqBF6qw4PFkMmJ62WCPyUC6QpFcbJ1c9aSrSLi8nUyKWLvv0mk8BFQ5J9L+b54p3rRgDDlq+rRBRrlykHePDL2JT6oSJaNoK6RpStMdloR1DVQb6dVePQf6TGfyFAjIjZX08K9g0ucITQ/3ZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795639; c=relaxed/simple;
	bh=cdKlTVqFAw8ApvEuQ7prWTD3bUNet1piEa49vQ1EufI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cAorEQeIPBGCaWINX8uNF3FaYscNlX5E0QpE/v4Mxe/kYms0b90c2NoNKjgcgg90IC0I8CjVotivOerEypFic66+I6WQjnrHQAiJ2F4BhU4AggS+oQ6qSXa3zrK1aMqxzeeJ+Su5O2qvHd0zdF0DyXjAseO8pRdzYH3A0MC3EGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hQbRQWwu; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hQbRQWwu"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736cd27d51fso2260700b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795637; x=1744400437; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1QbRZKRmRkfriBxkLy7PYXuhu9Zt47DLy3JPC1CCZP0=;
        b=hQbRQWwuXYef4koxCYA+03PMNJqFtjB7/eGU83Uk9k0jo0BV9euggveJF9DOP2FzSA
         jBGV1xDHD5LQer/fUWI5oGb/rHFAsUoLr39zmr4x0FuWgc3AtQqDm5woOQyZB9f0ID3G
         1AQCDkN4Ru45aW2h2BZy/B/XCskZC3BKrIMD9X+bnKaQ1q1F+x5ZDQnTW77kQBnnumjU
         Cz8LwScSvEkIV3z6ibq84ZuHOctGiPQePh/2tTrsQtFsq1psNReqyNOsPqBp0UK7D6LD
         xPe6ypa8Me1Ln57d3SZkKbUxT5sjSvapWEgcKBCp4ItpROcTQooSRsxJpY/3DixmhiGH
         r2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795637; x=1744400437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QbRZKRmRkfriBxkLy7PYXuhu9Zt47DLy3JPC1CCZP0=;
        b=mYSzfw7zzwOY+qL/lFhptMzH75HxMG2Eml6Y16Fl0RWSsZX+Mo7K+7Mlv55Sr2xVCi
         neiWak4RdhAS6ivQ8jTPNdOuOCaNe6KHrGslR04swuljUYZClKNmabVpuA3E4L+ESryZ
         QBTRNhSTPSIZj/SW5X40Byw4FVClfI92lri82Prq+6aC11bFhmCP4ftiIBU5LAXdNJ84
         Etac0LwtyIcaRW9rQyX/46RnzAphVp1QJVpXOAz+V3F7dkUifDi6QrrvHWGgokVzHDZT
         tayfpedzPiQRg5H+5D3coOe/admLs7c7YLWbvjBKR8lx2SQz3T7FhhN0iTyqUFXxesgB
         7KuQ==
X-Forwarded-Encrypted: i=1; AJvYcCULD8y5mFoo/edr3PqzrX+kVW9CDQ3wPZRpiW6r33xSmMKvFJSZ3CX/0p4Jpe+HuE6JObdBVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ3jgC4gfjJyFjSF42nzxwwj5ZsndLiAv4vv6szPLM0R9pT3ax
	DNgLKRCKO9s/F8ojUekk8Jq4+Rs5lZS+WB7ki1p3ybxB1pLk6b5vwCBkoB3hkolTPtvzTGhqM+P
	n5Q==
X-Google-Smtp-Source: AGHT+IF7hVw0fjyQPYLVoXo+ylFst6APnbo8/gAtHy3E1LET5Ypzmt4DGEcGNQw0IysuKrRghF3jHnzmiw0=
X-Received: from pfbic5.prod.google.com ([2002:a05:6a00:8a05:b0:736:3a40:5df5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:240d:b0:736:4d44:8b77
 with SMTP id d2e1a72fcca58-739e6fdea83mr6214670b3a.8.1743795637056; Fri, 04
 Apr 2025 12:40:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:44 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-30-seanjc@google.com>
Subject: [PATCH 29/67] KVM: SVM: Stop walking list of routing table entries
 when updating IRTE
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that KVM SVM simply uses the provided routing entry, stop walking the
routing table to find that entry.  KVM, via setup_routing_entry() and
sanity checked by kvm_get_msi_route(), disallows having a GSI configured
to trigger multiple MSIs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 106 ++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 63 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index eb6017b01c5f..685a7b01194b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -852,10 +852,10 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			unsigned int host_irq, uint32_t guest_irq,
 			struct kvm_kernel_irq_routing_entry *new)
 {
-	struct kvm_kernel_irq_routing_entry *e;
-	struct kvm_irq_routing_table *irq_rt;
 	bool enable_remapped_mode = true;
-	int idx, ret = 0;
+	struct vcpu_data vcpu_info;
+	struct vcpu_svm *svm = NULL;
+	int ret = 0;
 
 	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
 		return 0;
@@ -869,70 +869,51 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	pr_debug("SVM: %s: host_irq=%#x, guest_irq=%#x, set=%#x\n",
 		 __func__, host_irq, guest_irq, !!new);
 
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
-		if (new && !get_pi_vcpu_info(kvm, new, &vcpu_info, &svm) &&
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
-						 vcpu_info.pi_desc_addr, !!new);
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
@@ -940,7 +921,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	else
 		ret = 0;
 out:
-	srcu_read_unlock(&kvm->irq_srcu, idx);
 	return ret;
 }
 
-- 
2.49.0.504.g3bcea36a83-goog

