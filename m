Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7902253344
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795699; cv=none; b=FtDG6zyVQ0riTWj5rKpaxnGxIJYdMUrHp/hsyEpvWlK6fKaXA+XDqQbe8Yif3QvIdoDIhzL70LTCiLq9CQW3/oIKv7zPtsB/ZjdTo84aVa7xHo7BP0jK/2WLhvJFD5EFcnf6lKaaVLAi2PP+ZgrrY8bn/F8aPH+QOAs5XVjYg0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795699; c=relaxed/simple;
	bh=jY+2nzVN06DMGMLsSMn2WmOE/1Wygg/5G8qjzC8xCTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=noncsV4FLEXlI25r2DwfHTcCXzbxG1i8tRN8kXRNqtXcSqjvXeMqRrf61TDH7Nd1S/bh4OSkPAWUdVvIKa3k89XRx24vX+jl7CzI/CBDOZLA8J320kpSwxVc6xIrcVyJKmhiXWB3OIxppoQJZeI4jKZ5uzninAvNnfEGAjvNSJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ozYsODA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ozYsODA"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72f3b4c0305so2931062b3a.0
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795697; x=1744400497; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Ep0zYMwQk7PHwLo351NMM2Hs6HgJxECJlzek6kNKg+8=;
        b=3ozYsODAUbNsTglz6n9jDEEvkn2CmpNR8yHuHEw3rTpjfqsdas/eMzh/uE23EK0VWU
         tdUGy82XX9R9eQVpWXvTRiqOmSGjXivvLQudJ0YZMiJlGxlnFSLVi1OyhQgkgAN6kmGM
         HC9XWwaRCY6vTusVv2qKdO36tIOcQBXGZEVRk6uDCfjRTKR1vvQys0NlA/SHtoYeS5+v
         l3OYpnqCrCxC1l3PuMQC4/RKYIcnDdraHnHhasCkdYcnli15UHI3+/V08rv1UTv61u0K
         uHL7TNg5gaG//bynpO4loxm3Dz/IdKGVqKT1XPfGw22BwDnm89aDI/pqOzNBi1QY71UH
         2zog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795697; x=1744400497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ep0zYMwQk7PHwLo351NMM2Hs6HgJxECJlzek6kNKg+8=;
        b=wV8a3IxFMXa/HMjsErIgcDwqRuKunR2hR+PO4OVgm8ApwKws4QDpC+8VtYXcYPca0U
         f1n57/IllkjYr57bIa5kTbSS7fjwp1/4/bW/Orb7yQbJa5Jty+3cJhjTfOgvGIuGOnr3
         DqjReMSDNk5pyecPjDz4ZSk05hYikw8P4q7kOrS7GXuVTSHofDEotJCHT1LVV5uABV2t
         lHpQSC7y+FZJDdkdU2Z5RV5OjMKDkZ/yVQ2i14Qk4frxVkqewQ6hJorBy3PMj5ZWOCUn
         FpGQsp3J1HWaUEgNKIhTVmkPs2hRa843OxYD7IVkgRSuxnTgei6yZ2OEdmzlPa4Qnlf1
         PYAA==
X-Forwarded-Encrypted: i=1; AJvYcCWoIR8tYjpg2X/ncIkmuqI34/JR1WNt5akE6Nv1FjUy71MliJcoBq4dK+/gMFMVAON3dfsJPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb05Nvdp/jxXT2EdcnV6ObuRj0PjE+ys4fxzgiFpbtWa+lOYH9
	zjZdfxAscTbLNmm7q7PbANHiqd4GE86pL5F/gqQiq5FaGGOVIgFj0Cq3Mku8gW6heqpXWSWp1bT
	bGg==
X-Google-Smtp-Source: AGHT+IFmbGhp+Z2Q3iEhmqPOb4c8JbJPwoNpBaO41LBdBcOtaCAkgkkCsoxNppdx0bYM0erihZvIs9VkUcQ=
X-Received: from pfbdf8.prod.google.com ([2002:a05:6a00:4708:b0:737:6b9f:8ab4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ccc:b0:736:6202:3530
 with SMTP id d2e1a72fcca58-73b6b8f7617mr741609b3a.22.1743795697337; Fri, 04
 Apr 2025 12:41:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:19 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-65-seanjc@google.com>
Subject: [PATCH 64/67] iommu/amd: KVM: SVM: Allow KVM to control need for GA
 log interrupts
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Add plumbing to the AMD IOMMU driver to allow KVM to control whether or
not an IRTE is configured to generate GA log interrupts.  KVM only needs a
notification if the target vCPU is blocking, so the vCPU can be awakened.
If a vCPU is preempted or exits to userspace, KVM clears is_run, but will
set the vCPU back to running when userspace does KVM_RUN and/or the vCPU
task is scheduled back in, i.e. KVM doesn't need a notification.

Unconditionally pass "true" in all KVM paths to isolate the IOMMU changes
from the KVM changes insofar as possible.

Opportunistically swap the ordering of parameters for amd_iommu_update_ga()
so that the match amd_iommu_activate_guest_mode().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/irq_remapping.h |  1 +
 arch/x86/kvm/svm/avic.c              | 10 ++++++----
 drivers/iommu/amd/iommu.c            | 17 ++++++++++-------
 include/linux/amd-iommu.h            |  9 ++++-----
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 4c75a17632f6..5a0d42464d44 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -36,6 +36,7 @@ struct amd_iommu_pi_data {
 	u32 ga_tag;
 	u32 vector;		/* Guest vector of the interrupt */
 	int cpu;
+	bool ga_log_intr;
 	bool is_guest_mode;
 	void *ir_data;
 };
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index c896f00f901c..1466e66cca6c 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -794,10 +794,12 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * is awakened and/or scheduled in.  See also avic_vcpu_load().
 		 */
 		entry = svm->avic_physical_id_entry;
-		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
+		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK) {
 			pi_data.cpu = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
-		else
+		} else {
 			pi_data.cpu = -1;
+			pi_data.ga_log_intr = true;
+		}
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
 		if (ret)
@@ -837,9 +839,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
 
 	list_for_each_entry(ir, &svm->ir_list, node) {
 		if (!toggle_avic)
-			WARN_ON_ONCE(amd_iommu_update_ga(cpu, ir->data));
+			WARN_ON_ONCE(amd_iommu_update_ga(ir->data, cpu, true));
 		else if (cpu >= 0)
-			WARN_ON_ONCE(amd_iommu_activate_guest_mode(ir->data, cpu));
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(ir->data, cpu, true));
 		else
 			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(ir->data));
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e016b98fa1b..27b03e718980 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3775,7 +3775,8 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
 	.deactivate = irq_remapping_deactivate,
 };
 
-static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu)
+static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu,
+				  bool ga_log_intr)
 {
 	if (cpu >= 0) {
 		entry->lo.fields_vapic.destination =
@@ -3783,12 +3784,14 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu)
 		entry->hi.fields.destination =
 					APICID_TO_IRTE_DEST_HI(cpu);
 		entry->lo.fields_vapic.is_run = true;
+		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
 		entry->lo.fields_vapic.is_run = false;
+		entry->lo.fields_vapic.ga_log_intr = ga_log_intr;
 	}
 }
 
-int amd_iommu_update_ga(int cpu, void *data)
+int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -3802,14 +3805,14 @@ int amd_iommu_update_ga(int cpu, void *data)
 	if (!ir_data->iommu)
 		return -ENODEV;
 
-	__amd_iommu_update_ga(entry, cpu);
+	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
 
 	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 				ir_data->irq_2_irte.index, entry);
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 
-int amd_iommu_activate_guest_mode(void *data, int cpu)
+int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -3828,12 +3831,11 @@ int amd_iommu_activate_guest_mode(void *data, int cpu)
 
 	entry->lo.fields_vapic.valid       = valid;
 	entry->lo.fields_vapic.guest_mode  = 1;
-	entry->lo.fields_vapic.ga_log_intr = 1;
 	entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
-	__amd_iommu_update_ga(entry, cpu);
+	__amd_iommu_update_ga(entry, cpu, ga_log_intr);
 
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
@@ -3904,7 +3906,8 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		ir_data->ga_vector = pi_data->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
 		if (pi_data->is_guest_mode)
-			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu);
+			ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu,
+							    pi_data->ga_log_intr);
 		else
 			ret = amd_iommu_deactivate_guest_mode(ir_data);
 	} else {
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index c9f2df0c4596..8cced632ecd0 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -30,9 +30,8 @@ static inline void amd_iommu_detect(void) { }
 /* IOMMU AVIC Function */
 extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
-extern int amd_iommu_update_ga(int cpu, void *data);
-
-extern int amd_iommu_activate_guest_mode(void *data, int cpu);
+extern int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr);
+extern int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
@@ -43,12 +42,12 @@ amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 	return 0;
 }
 
-static inline int amd_iommu_update_ga(int cpu, void *data)
+static inline int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
 {
 	return 0;
 }
 
-static inline int amd_iommu_activate_guest_mode(void *data, int cpu)
+static inline int amd_iommu_activate_guest_mode(void *data, int cpu, bool ga_log_intr)
 {
 	return 0;
 }
-- 
2.49.0.504.g3bcea36a83-goog

