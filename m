Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0756B27D77D
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962062; cv=none; b=nW0rpz6yVdDoSWMVjdto5Ap7uM0/CN2UDfLE2Ns+11jusn4MgZhe9rDtQRJfINfV53X/UFPpVfEzTWJ4zOjVgYxN/Kjiej03pYDAcArB/OzZwHeNlW7CSErvRJidriKwTLrjkVVMJLqq5INPjqfvki2ds/bBGvEep8wNFpesloA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962062; c=relaxed/simple;
	bh=oNRMXcQ79z/ppsp/MdXUoLSNSsfC0IRqSoysTfP2n0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DqNfpoEYItxJpo6OSTw9RxmCjlnRW8gX+92OMgkZ6eT6LpX6j8KWKul6JgIPf7sHySHH+Z1QTvSZn4lBSdx5yoMLenAEkV/VDVEQw5J4P7UmGGsKp/ete9wDM/Jwu6ze0Ra0BTEVYXm3zIpENRgBUHERCTffL7NA/0TKsIQC2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJPcRN5m; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJPcRN5m"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30eac9886ffso4645758a91.1
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962059; x=1748566859; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JMjSdTj+suhJzKf/G1gZtLOB7F2Sxx7/bINJC6X9hG0=;
        b=rJPcRN5mTT2FOA6yozI6hebPB3Y7m2CmQlOFA3w9PtxnR6lZKhWldo+g1yIdW8oP81
         TfIFEoef5l4JBsisXmqQWL/86vBVGfSdA/elGqgMNg1i3c0s/d/X/K3SN5NFM4PdTEu0
         XlFr1Cep7ivgdFKhWgY53OQ4sL2HiApjFMFgGo1dt57EJoSz3gZMFLDFiaAaf0WUSF8k
         H23HHeKqqDveRQWArpE3vyNOy6KbFU037oIkBedFjCCeJqSDL3pS9qhUhNqjhMNY73lJ
         vUmZPuL8MO8Dqu4u2H8njCKp9ws121DGYwx0AhxKI4XgoWryytdmlXSv5dhw4+vajLDm
         DsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962059; x=1748566859;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMjSdTj+suhJzKf/G1gZtLOB7F2Sxx7/bINJC6X9hG0=;
        b=OJ27FPUEa3UnDrD6hM3gZ2yzCTdHUjY4oqA5zYLovTqsUgR4vAOuJZgI6m9OhixGTI
         E0oNMkLkw2TSwelzmg+RMq+xAWQ3VvjBYwI5WHLAyMvUBKUNSKU0sxoP1K3iJkadDknC
         vFYmE9qyDvZx+mXsaaYoDyIlnD43MAYHLetYbWKkHMtAVxi5BO0g39r6S8AS6GaB/q72
         z8Wr/UkRASZgvfPWgBpeqiHoIwrw2gIuUZGnxDW3SytwSIjfY+N40Da42k9Aenpg+qmZ
         NlTttVqASviUx/WMiAe5wcgouweTAY6Ool/4QOMbXNch5iJZau8Ta8TwlCU+hZ+Kri/E
         FNKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwth4eMyd/FH21EZoIllyroJSzSeMix481rnWKhH98xdEeZyY70P/0S547vrOI2rsBzERfUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIKD8jJpxeNg+OGk/S/6AQIS9XAfxOfRkO5Uzyyfg7hhVLNTrq
	jjrDOt02xqAHaDDnzbbWLwbtl8+AwqirkAKmMQtFivk5kafbiEG3WBo2QcHMUtvnVAH6ZXzT6b0
	O+lIsAA==
X-Google-Smtp-Source: AGHT+IF8c6fJ8yMCN4wj6UnyIXb58GYfChHNsI8pVlq/3hKy38hpN1X8/00HWG6ufh/FDU2XY+RsgA7OHYI=
X-Received: from pjbnd11.prod.google.com ([2002:a17:90b:4ccb:b0:301:b354:8d63])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17c7:b0:30e:a1ec:68dd
 with SMTP id 98e67ed59e1d1-310e96c95aemr1724491a91.8.1747962059471; Thu, 22
 May 2025 18:00:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:34 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-30-seanjc@google.com>
Subject: [PATCH v2 29/59] iommu: KVM: Split "struct vcpu_data" into separate
 AMD vs. Intel structs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Split the vcpu_data structure that serves as a handoff from KVM to IOMMU
drivers into vendor specific structures.  Overloading a single structure
makes the code hard to read and maintain, is *very* misleading as it
suggests that mixing vendors is actually supported, and bastardizing
Intel's posted interrupt descriptor address when AMD's IOMMU already has
its own structure is quite unnecessary.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
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
index a0f3cdd2ea3f..6085a629c5e6 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -822,23 +822,18 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
 
@@ -849,7 +844,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * we can reference to them directly when we update vcpu
 		 * scheduling information in IOMMU irte.
 		 */
-		return svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
+		return svm_ir_list_add(to_svm(vcpu), irqfd, &pi_data);
 	}
 	return irq_set_vcpu_affinity(host_irq, NULL);
 }
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 687ffde3b61c..3a23c30f73cb 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -303,12 +303,12 @@ int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
index 5141507587e1..36749efcc781 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3860,10 +3860,10 @@ int amd_iommu_deactivate_guest_mode(void *data)
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
@@ -3886,14 +3886,10 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
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
index 3bc2a03cceca..6165bb919520 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1244,10 +1244,10 @@ static void intel_ir_compose_msi_msg(struct irq_data *irq_data,
 static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 {
 	struct intel_ir_data *ir_data = data->chip_data;
-	struct vcpu_data *vcpu_pi_info = info;
+	struct intel_iommu_pi_data *pi_data = info;
 
 	/* stop posting interrupts, back to the default mode */
-	if (!vcpu_pi_info) {
+	if (!pi_data) {
 		__intel_ir_reconfigure_irte(data, true);
 	} else {
 		struct irte irte_pi;
@@ -1265,10 +1265,10 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
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
 
 		ir_data->irq_2_iommu.posted_vcpu = true;
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
2.49.0.1151.ga128411c76-goog

