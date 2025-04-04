Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A822E418
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795651; cv=none; b=Ftng+6fArtBJE6NoXOzrfyxsREPeUmCFGlngnmK5SkqEjqr1fZIpDRTEgtAEZ/tKfsJ0Y6wOBXAukNJioLAf2u49YJyVTl6BQuNxZt42h/4WFlQoVAcRwi9219XlYc+xMYIOR0C9xZk6Kjv0nVyv8D6y0wvCfRZOxQvVm91TaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795651; c=relaxed/simple;
	bh=QVytKcLMLwjvtacZRhoTDTCcvk9oIVDgKzcE8SfOka4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YIztyuGQ6UB26RIsego6574Qj5K47U9cf8QjLiog9R83Wj1kO2s02jCDVtj8MvQsRPSDoh3X+s1iaTVjNyMThUzO1Tor/iM5Xc0cBXl0FaBhUUSHohZuY5BYqfnv7bmlmNOISG7MZbGt4npLcUpiVpZHprQ2+mDt6phdmgccvPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2GkczMCe; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2GkczMCe"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff605a7a43so3696852a91.3
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795649; x=1744400449; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7/Cs2Fc53f29HQTq4mv2ZlQ9k1Jo4Mf2ffuO1b42Tf4=;
        b=2GkczMCeOnGA546oT6ahfMCsPjx6H6XVE1LKXW5ScIxd7Gq/QpM5sHKo6JcoJoyDgu
         dh4ESJjaUxx8t88fYZ17/eQ8eYI4TKMBmlFQgSfMvKoFddiQ+6MUtA0bVi3EQPTwre4F
         QVoZYRvX7J1kBkhuT65/t7gUlJRKd1er8tbeI9ITKl9r3qoLgXW/cr5sc8yvVQYIeBLN
         vUn2m9VTlkWZLfYyOIt12AIlTCjFOOvoQVUDl5ncGlRGrX5nFA6h9XIK+8tZw3yKRCEe
         QL4hXrULCdPY3u7X+IrL0X9VfAJf9i2Y0eyK7vyvtDVr9A5FQJ0tzAQz4np0cPNjo8yS
         C43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795649; x=1744400449;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/Cs2Fc53f29HQTq4mv2ZlQ9k1Jo4Mf2ffuO1b42Tf4=;
        b=Wx/QOFRC5mqY2Me5RnHq/FoYE4pvhHHMPj5is0DdZx4UDnJf77dKKiwPqnAIAFhpq+
         8/Ni2yF5QWuAIaMjCMCIkVSZgf9iBzRJZjkho2hoe+r9UZS8Qzqqrvf8Uz/yYigPJNPt
         PlP7f+QV46kSusafJqeICzyeZGWYL24VyViJjjE6SLIkaRURmibXbS0wcPNwgHPyZ7Hh
         T8++MpixwhGTRQNH/DlIwRIa4nnOu3ZYsEvixS1HlZot/hQOKPmchCid1+yjbyFMH14Q
         jwFVzJDVog8S2wahIVuIOBl+oNR7NofE7P9V0SorqsjM/pelJCMjbMt/3L1KiDzwfbmW
         1DBg==
X-Forwarded-Encrypted: i=1; AJvYcCXMi1BC3Sb8SfPvXTx5cEgFBbxqtU3LIUx5Bpo8GzY7QlrRZ946Qdv2dhCX2/aGo7Q1jMc+iQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHPVKeG6AmguukuoI9FSC8cI7mImDnBrAvpglJeDfhtvF5bokh
	G2/XeFgqPkNzEUJVxhMQD5GqGoEvdToksp9wjM74EOVJa/gSXSchrLbEshIFgGNYVpVq8kY+eDB
	6Pw==
X-Google-Smtp-Source: AGHT+IH58D3xxc8J66XG4flIppBKdnX8bdKHTWvQ5Mizc35RqXeILg635z0uscQCli4EDu258GtvZcGvkSI=
X-Received: from pjbeu7.prod.google.com ([2002:a17:90a:f947:b0:2fa:15aa:4d2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:6c6:b0:301:98fc:9b5a
 with SMTP id 98e67ed59e1d1-306af704d02mr660629a91.6.1743795648884; Fri, 04
 Apr 2025 12:40:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:51 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-37-seanjc@google.com>
Subject: [PATCH 36/67] iommu: KVM: Split "struct vcpu_data" into separate AMD
 vs. Intel structs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Split the vcpu_data structure that serves as a handoff from KVM to IOMMU
drivers into vendor specific structures.  Overloading a single structure
makes the code hard to read and maintain, is *very* misleading as it
suggests that mixing vendors is actually supported, and bastardizing
Intel's posted interrupt descriptor address when AMD's IOMMU already has
its own structure is quite unnecessary.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/irq_remapping.h | 15 ++++++++++++++-
 arch/x86/kvm/svm/avic.c              | 21 ++++++++-------------
 arch/x86/kvm/vmx/posted_intr.c       |  4 ++--
 drivers/iommu/amd/iommu.c            | 12 ++++--------
 drivers/iommu/intel/irq_remapping.c  | 10 +++++-----
 include/linux/amd-iommu.h            | 12 ------------
 6 files changed, 33 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 5036f13ab69f..2dbc9cb61c2f 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -26,7 +26,20 @@ enum {
 	IRQ_REMAP_X2APIC_MODE,
 };
 
-struct vcpu_data {
+/*
+ * This is mainly used to communicate information back-and-forth
+ * between SVM and IOMMU for setting up and tearing down posted
+ * interrupt
+ */
+struct amd_iommu_pi_data {
+	u64 vapic_addr;		/* Physical address of the vCPU's vAPIC. */
+	u32 ga_tag;
+	u32 vector;		/* Guest vector of the interrupt */
+	bool is_guest_mode;
+	void *ir_data;
+};
+
+struct intel_iommu_pi_data {
 	u64 pi_desc_addr;	/* Physical address of PI Descriptor */
 	u32 vector;		/* Guest vector of the interrupt */
 };
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 4382ab2eaea6..355673f95b70 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -832,23 +832,18 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	 */
 	if (vcpu && kvm_vcpu_apicv_active(vcpu)) {
 		/*
-		 * Try to enable guest_mode in IRTE.  Note, the address
-		 * of the vCPU's AVIC backing page is passed to the
-		 * IOMMU via vcpu_info->pi_desc_addr.
+		 * Try to enable guest_mode in IRTE.
 		 */
-		struct vcpu_data vcpu_info = {
-			.pi_desc_addr = avic_get_backing_page_address(to_svm(vcpu)),
-			.vector = vector,
-		};
-
-		struct amd_iommu_pi_data pi = {
-			.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id, vcpu->vcpu_id),
+		struct amd_iommu_pi_data pi_data = {
+			.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
+					     vcpu->vcpu_id),
 			.is_guest_mode = true,
-			.vcpu_data = &vcpu_info,
+			.vapic_addr = avic_get_backing_page_address(to_svm(vcpu)),
+			.vector = vector,
 		};
 		int ret;
 
-		ret = irq_set_vcpu_affinity(host_irq, &pi);
+		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
 		if (ret)
 			return ret;
 
@@ -859,7 +854,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * we can reference to them directly when we update vcpu
 		 * scheduling information in IOMMU irte.
 		 */
-		return svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
+		return svm_ir_list_add(to_svm(vcpu), irqfd, &pi_data);
 	}
 	return irq_set_vcpu_affinity(host_irq, NULL);
 }
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index baf627839498..2958b631fde8 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -270,12 +270,12 @@ int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		       struct kvm_vcpu *vcpu, u32 vector)
 {
 	if (vcpu) {
-		struct vcpu_data vcpu_info = {
+		struct intel_iommu_pi_data pi_data = {
 			.pi_desc_addr = __pa(vcpu_to_pi_desc(vcpu)),
 			.vector = vector,
 		};
 
-		return irq_set_vcpu_affinity(host_irq, &vcpu_info);
+		return irq_set_vcpu_affinity(host_irq, &pi_data);
 	} else {
 		return irq_set_vcpu_affinity(host_irq, NULL);
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 08c4fa31da5d..bc6f7eb2f04b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3831,10 +3831,10 @@ int amd_iommu_deactivate_guest_mode(void *data)
 }
 EXPORT_SYMBOL(amd_iommu_deactivate_guest_mode);
 
-static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
+static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 {
 	int ret;
-	struct amd_iommu_pi_data *pi_data = vcpu_info;
+	struct amd_iommu_pi_data *pi_data = info;
 	struct amd_ir_data *ir_data = data->chip_data;
 	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
 	struct iommu_dev_data *dev_data;
@@ -3857,14 +3857,10 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	ir_data->cfg = irqd_cfg(data);
 
 	if (pi_data) {
-		struct vcpu_data *vcpu_pi_info = pi_data->vcpu_data;
-
 		pi_data->ir_data = ir_data;
 
-		WARN_ON_ONCE(!pi_data->is_guest_mode);
-
-		ir_data->ga_root_ptr = (vcpu_pi_info->pi_desc_addr >> 12);
-		ir_data->ga_vector = vcpu_pi_info->vector;
+		ir_data->ga_root_ptr = (pi_data->vapic_addr >> 12);
+		ir_data->ga_vector = pi_data->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
 		ret = amd_iommu_activate_guest_mode(ir_data);
 	} else {
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index ad795c772f21..8ccec30e5f45 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1236,10 +1236,10 @@ static void intel_ir_compose_msi_msg(struct irq_data *irq_data,
 static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 {
 	struct intel_ir_data *ir_data = data->chip_data;
-	struct vcpu_data *vcpu_pi_info = info;
+	struct intel_iommu_pi_data *pi_data = info;
 
 	/* stop posting interrupts, back to the default mode */
-	if (!vcpu_pi_info) {
+	if (!pi_data) {
 		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
 	} else {
 		struct irte irte_pi;
@@ -1257,10 +1257,10 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		/* Update the posted mode fields */
 		irte_pi.p_pst = 1;
 		irte_pi.p_urgent = 0;
-		irte_pi.p_vector = vcpu_pi_info->vector;
-		irte_pi.pda_l = (vcpu_pi_info->pi_desc_addr >>
+		irte_pi.p_vector = pi_data->vector;
+		irte_pi.pda_l = (pi_data->pi_desc_addr >>
 				(32 - PDA_LOW_BIT)) & ~(-1UL << PDA_LOW_BIT);
-		irte_pi.pda_h = (vcpu_pi_info->pi_desc_addr >> 32) &
+		irte_pi.pda_h = (pi_data->pi_desc_addr >> 32) &
 				~(-1UL << PDA_HIGH_BIT);
 
 		modify_irte(&ir_data->irq_2_iommu, &irte_pi);
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index deeefc92a5cf..99b4fa9a0296 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -12,18 +12,6 @@
 
 struct amd_iommu;
 
-/*
- * This is mainly used to communicate information back-and-forth
- * between SVM and IOMMU for setting up and tearing down posted
- * interrupt
- */
-struct amd_iommu_pi_data {
-	u32 ga_tag;
-	bool is_guest_mode;
-	struct vcpu_data *vcpu_data;
-	void *ir_data;
-};
-
 #ifdef CONFIG_AMD_IOMMU
 
 struct task_struct;
-- 
2.49.0.504.g3bcea36a83-goog

