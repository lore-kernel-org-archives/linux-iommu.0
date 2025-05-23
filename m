Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02D727147E
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962112; cv=none; b=uQ9/MRiXCoRpzjIS9Pcl7vHBsrE6F1cWgJxn2YnRVBlOquK2U5ll4qIVwn9rZtoS0EHUTu5uZHtcCWYTh1rSG2jRBCzWvk9i1N5rYwsTNbbbRI6wYeou2fkFNni8YMhPr+WZHPPnbdQ3yI+0gWMyPRy63SjMNDsKCTvnpCd5qI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962112; c=relaxed/simple;
	bh=hquM5XEaF1tV/UsD0O/H8Zlv63arDHb+DJY9dbNKYEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SrC5YL2o4si/7kd4AIKkpTpnrRafzNBPVmQ39u9M0cAp4R4DwHqXccBr586xVRGvWD3l2oxoREnaetKYGa6kLjpHn/3rNzrCd46hjTyCP7LrFfvI/b2YCRVfIif3HBVQdmkYJV1ZXGKIUNAEzoguW8MSJ5KewiJdluS7eJMTgLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/NC5btl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/NC5btl"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2320502023fso54847195ad.2
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962108; x=1748566908; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SdJtI6mzcHfEMtRnbz/7WQgOGD6qOvwTAePlcw8+5D8=;
        b=c/NC5btlJMRKoL918hDKVhGzK8eyK64Ah7BVtqnKvTVGJ44bGQZYflWpfDwEj3PYwp
         niDnuS0PdPv4qVWOT/4yjef6NUPpeQN5ywugLmrRbC0VykCalngMvMHF2OG+8dC8YOo5
         Z4/OV0xX178Skyx4M7OlbSKdumZPmQjVQSVTQqhF4jpWnqSdkunB5HGqAmDuAy+cOYI/
         o0AaZpoJ9n8f+BUdp8ntpTa2ZOlTUR5RpSKFcI7MC4253mkoEse/XklwsdNlStEqbu4f
         +nTbbNTcHnTO8OccNlHj/Qp/pSzYJJuRoXz5lpXbrIViIydfsk6pma97f8HAqthAD+aS
         MiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962108; x=1748566908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdJtI6mzcHfEMtRnbz/7WQgOGD6qOvwTAePlcw8+5D8=;
        b=D25qKMWdk8JNIH+S6fewQro8jS3xJr2I96EcQGzZb8PSrUQHeYN2i066YNk9GmI86R
         n9Q2eHktVILcE4VUnU1w2HGHVmtpFtJvqrsvLtPZ/tCFhGnYKo5aJ2YMa2w8m4XcZzTP
         44pmcnnWkVe7+y38FY0NtQFw6QSah9jaBDYncaPxAW+p7xukGR7fRfInk4W58a07ig+u
         Ny+lpatntpafxN0izwBkOW8lfqzny2Ee9FDq8CYg/3YJBVlvDEFSZwdrH1+utq4AU4+d
         U8LbWf34xm31F4icBL4NDj0Qs3KsGeWKdYPdmhfVz3XacI7kgRCbmgemE/lWjZ+Cu0sH
         Gf2w==
X-Forwarded-Encrypted: i=1; AJvYcCWd/JrFtbsKf3Eb/A1LrcK0Hs1UKtgBhoU1hTp/JYZscAU3dnzMaGT4SYiDI/muLUccxpY+1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+XYV9CS7c3CF5pbBh0a0B+k+wSyPnYp7SAFKfYHZT4CrgcPYV
	AxwaP+ur3+/ZOjXokdyciA/vlBdBRAdxZNCDOzIdUs5GBsuFTqP6cj5dCmA6KKB/ii6Ux0YNDIt
	wu2d+ZA==
X-Google-Smtp-Source: AGHT+IFroOYrJ+kcqTin7sT6kzOgrQyeQ3nstylTnZcNfGmu9/enZgKduOi8pFFg82qyNAlelMjm4Cirvic=
X-Received: from pjl6.prod.google.com ([2002:a17:90b:2f86:b0:30a:7d22:be7b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:289:b0:231:8030:74ab
 with SMTP id d9443c01a7336-233f25f3f59mr15398355ad.36.1747962108214; Thu, 22
 May 2025 18:01:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 18:00:03 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-59-seanjc@google.com>
Subject: [PATCH v2 58/59] iommu/amd: KVM: SVM: Allow KVM to control need for
 GA log interrupts
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
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

Note, as of this writing, the AMD IOMMU manual doesn't list GALogIntr as
a non-cached field, but per AMD hardware architects, it's not cached and
can be safely updated without an invalidation.

Link: https://lore.kernel.org/all/b29b8c22-2fd4-4b5e-b755-9198874157c7@amd.com
Cc: Vasant Hegde <vasant.hegde@amd.com>
Cc: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/irq_remapping.h |  1 +
 arch/x86/kvm/svm/avic.c              | 10 ++++++----
 drivers/iommu/amd/iommu.c            | 28 +++++++++++++++++-----------
 include/linux/amd-iommu.h            |  9 ++++-----
 4 files changed, 28 insertions(+), 20 deletions(-)

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
index 2e47559a4134..e61ecc3514ea 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -784,10 +784,12 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
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
@@ -849,9 +851,9 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
 		void *data = irqfd->irq_bypass_data;
 
 		if (!(action & AVIC_TOGGLE_ON_OFF))
-			WARN_ON_ONCE(amd_iommu_update_ga(cpu, data));
+			WARN_ON_ONCE(amd_iommu_update_ga(data, cpu, true));
 		else if (cpu >= 0)
-			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, cpu));
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, cpu, true));
 		else
 			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
 	}
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 926dcdfe08c8..e79f583da36b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3804,7 +3804,8 @@ static const struct irq_domain_ops amd_ir_domain_ops = {
 	.deactivate = irq_remapping_deactivate,
 };
 
-static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu)
+static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu,
+				  bool ga_log_intr)
 {
 	if (cpu >= 0) {
 		entry->lo.fields_vapic.destination =
@@ -3812,8 +3813,10 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu)
 		entry->hi.fields.destination =
 					APICID_TO_IRTE_DEST_HI(cpu);
 		entry->lo.fields_vapic.is_run = true;
+		entry->lo.fields_vapic.ga_log_intr = false;
 	} else {
 		entry->lo.fields_vapic.is_run = false;
+		entry->lo.fields_vapic.ga_log_intr = ga_log_intr;
 	}
 }
 
@@ -3822,16 +3825,19 @@ static void __amd_iommu_update_ga(struct irte_ga *entry, int cpu)
  * a vCPU, without issuing an IOMMU invalidation for the IRTE.
  *
  * If the vCPU is associated with a pCPU (@cpu >= 0), configure the Destination
- * with the pCPU's APIC ID and set IsRun, else clear IsRun.  I.e. treat vCPUs
- * that are associated with a pCPU as running.  This API is intended to be used
- * when a vCPU is scheduled in/out (or stops running for any reason), to do a
- * fast update of IsRun and (conditionally) Destination.
+ * with the pCPU's APIC ID, set IsRun, and clear GALogIntr.  If the vCPU isn't
+ * associated with a pCPU (@cpu < 0), clear IsRun and set/clear GALogIntr based
+ * on input from the caller (e.g. KVM only requests GALogIntr when the vCPU is
+ * blocking and requires a notification wake event).  I.e. treat vCPUs that are
+ * associated with a pCPU as running.  This API is intended to be used when a
+ * vCPU is scheduled in/out (or stops running for any reason), to do a fast
+ * update of IsRun, GALogIntr, and (conditionally) Destination.
  *
  * Per the IOMMU spec, the Destination, IsRun, and GATag fields are not cached
  * and thus don't require an invalidation to ensure the IOMMU consumes fresh
  * information.
  */
-int amd_iommu_update_ga(int cpu, void *data)
+int amd_iommu_update_ga(void *data, int cpu, bool ga_log_intr)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -3845,14 +3851,14 @@ int amd_iommu_update_ga(int cpu, void *data)
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
@@ -3871,12 +3877,11 @@ int amd_iommu_activate_guest_mode(void *data, int cpu)
 
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
@@ -3947,7 +3952,8 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
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
2.49.0.1151.ga128411c76-goog

