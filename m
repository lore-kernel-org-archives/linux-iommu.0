Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362202951A8
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962079; cv=none; b=fkqsfMUL1EE7wb8+TDP2/9q6TSI1PDjG4HDmGWermfRFzt605UdEZFTR3x/v6FYPLFy/W+A4OkVoduMSsGKN6j7L2FTrnFx5l5d40Uqqag4UF/ghIrMzjy4EXZypsbCfZNGCbgXiME0BjOeCbNTCkoAz2A5UtR5AZf2eEw7GMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962079; c=relaxed/simple;
	bh=gFtnllkdHoK++kmV2uIN5igfGRjKb467ITbvyuZHPpg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a/VQmt7YHOD6UAb4kmzWe4Q6hovRYZ7TDbIkEOlvfo+fN+GHHZp1lx+iOFJrWswoOcn9AAQmVJkWkjfSRLB50rnC8SPDPH8cJMhRl8u9v+ChCDDM77Garbrokb7i/LOsZ7xxe286MwegIrjhaLNibp5T8ndGIguBwBo+Y2TSK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BGWPI5G9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BGWPI5G9"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-310e7c24158so475243a91.3
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962077; x=1748566877; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hpBhApwrSh8aZyMZyjubfokkuVPDDm+wIxTVx+y5WkM=;
        b=BGWPI5G93QxwwESK2xAHf3+vrH5R0RyiojgeXJSMQDd6Yk1MEoueGcjlRjesnCWhmS
         4hiQe2aoRDqfAgUimoFiNIoMgArgSXGrN/5uO43KGHf69D3/blYF36awvPEfDwfLyEti
         v01aTUNRIKQFRrJOy+HSvd7/ZragCiRwhnByknIaZqWfiE+FGZsa5cSL8Q6Y6YCUXrc2
         L7onljm3ElQ7qiMWUtY+K/DMHsajgQijA2B7xrG+GWdsa1dlLllqMAOsKWfdlAPT0fOe
         WleLSjkeDstpvEULULKnHIE9KuJXh0LXi8Znsyrt8MWOIUH/XScyEAZ3K938yre8gBVH
         zWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962077; x=1748566877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpBhApwrSh8aZyMZyjubfokkuVPDDm+wIxTVx+y5WkM=;
        b=qeoE6LSm0jY8P2aRHipfpmEK6+1T1OJi0zitzINo5hq+0KTqnryvmJOWA1TFE+Vsaz
         6/08znCBNqlUlEosZRsXau1yQ4TRtJEAkOEmVdkSQEF+jcgNw7l+iJ0ZL70LkDiqdSN6
         quWFgVvWEvYB1MQzu2bDdSAk/EIJM87z9cmx9Xdzs7Ed+Enx64LkMEL7cLB3sWn0qjt4
         ff0H7m2AutqgWIObOpXYNSn29Kvbytsydvmwj5om3PhOtLDnXSllFgrmxwKJhdhWEEpz
         +iZznRC5p+6kTXqQ2FEdVHb/T23aL1MGY088UcwyyRKRaKJ7vEXXD7bDLOi7S3z8jSSA
         UQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFn8c7VE2IVB1JVXLBUu2F8MYP0vMP4C0Ts7nDIyjv6gEBo0LmuBkRFias8+VOFYpzd8ujpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzHayAferDihy9cvyxheVHU1t5aNQY7Pr4h8tJKqPlO0UqDVAzD
	eOxe6UZRNn0qTxaqSfjmZmNBX0A4CkOEOVWNhCVG+8mPi3N6v8ICRPMJHCCzXdh9e4kID/fDtTt
	KI2Zldw==
X-Google-Smtp-Source: AGHT+IGTYhCOjxbmKRXOrjbAavunsh63uzQMspWrxbHwEJtJhbbYao5aLSwUJ5OJG/DqIAodT2HfVFXoKXw=
X-Received: from pjb7.prod.google.com ([2002:a17:90b:2f07:b0:2ff:6132:8710])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4acf:b0:2ee:aa28:79aa
 with SMTP id 98e67ed59e1d1-30e830c772dmr35674777a91.6.1747962077355; Thu, 22
 May 2025 18:01:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:45 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-41-seanjc@google.com>
Subject: [PATCH v2 40/59] iommu/amd: KVM: SVM: Set pCPU info in IRTE when
 setting vCPU affinity
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that setting vCPU affinity is guarded with ir_list_lock, i.e. now that
avic_physical_id_entry can be safely accessed, set the pCPU info
straight-away when setting vCPU affinity.  Putting the IRTE into posted
mode, and then immediately updating the IRTE a second time if the target
vCPU is running is wasteful and confusing.

This also fixes a flaw where a posted IRQ that arrives between putting
the IRTE into guest_mode and setting the correct destination could cause
the IOMMU to ring the doorbell on the wrong pCPU.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/irq_remapping.h |  1 +
 arch/x86/kvm/svm/avic.c              | 26 ++++++++++++++------------
 drivers/iommu/amd/iommu.c            |  6 ++++--
 include/linux/amd-iommu.h            |  4 ++--
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
index 2dbc9cb61c2f..4c75a17632f6 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -35,6 +35,7 @@ struct amd_iommu_pi_data {
 	u64 vapic_addr;		/* Physical address of the vCPU's vAPIC. */
 	u32 ga_tag;
 	u32 vector;		/* Guest vector of the interrupt */
+	int cpu;
 	bool is_guest_mode;
 	void *ir_data;
 };
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index c79648d96752..16557328aa58 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -726,6 +726,7 @@ void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 
 static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 {
+	int apic_id = kvm_cpu_get_apicid(vcpu->cpu);
 	int ret = 0;
 	unsigned long flags;
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -745,7 +746,7 @@ static int avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
 
 	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list) {
 		if (activate)
-			ret = amd_iommu_activate_guest_mode(irqfd->irq_bypass_data);
+			ret = amd_iommu_activate_guest_mode(irqfd->irq_bypass_data, apic_id);
 		else
 			ret = amd_iommu_deactivate_guest_mode(irqfd->irq_bypass_data);
 		if (ret)
@@ -809,6 +810,18 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 */
 		guard(spinlock_irqsave)(&svm->ir_list_lock);
 
+		/*
+		 * Update the target pCPU for IOMMU doorbells if the vCPU is
+		 * running.  If the vCPU is NOT running, i.e. is blocking or
+		 * scheduled out, KVM will update the pCPU info when the vCPU
+		 * is awakened and/or scheduled in.  See also avic_vcpu_load().
+		 */
+		entry = svm->avic_physical_id_entry;
+		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
+			pi_data.cpu = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
+		else
+			pi_data.cpu = -1;
+
 		ret = irq_set_vcpu_affinity(host_irq, &pi_data);
 		if (ret)
 			return ret;
@@ -823,17 +836,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			return -EIO;
 		}
 
-		/*
-		 * Update the target pCPU for IOMMU doorbells if the vCPU is
-		 * running.  If the vCPU is NOT running, i.e. is blocking or
-		 * scheduled out, KVM will update the pCPU info when the vCPU
-		 * is awakened and/or scheduled in.  See also avic_vcpu_load().
-		 */
-		entry = svm->avic_physical_id_entry;
-		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
-			amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
-					    pi_data.ir_data);
-
 		irqfd->irq_bypass_data = pi_data.ir_data;
 		list_add(&irqfd->vcpu_list, &svm->ir_list);
 		return 0;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 15718b7b8bd4..718bd9604f71 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3850,7 +3850,7 @@ int amd_iommu_update_ga(int cpu, void *data)
 }
 EXPORT_SYMBOL(amd_iommu_update_ga);
 
-int amd_iommu_activate_guest_mode(void *data)
+int amd_iommu_activate_guest_mode(void *data, int cpu)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -3871,6 +3871,8 @@ int amd_iommu_activate_guest_mode(void *data)
 	entry->hi.fields.vector            = ir_data->ga_vector;
 	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
 
+	__amd_iommu_update_ga(entry, cpu);
+
 	return modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 			      ir_data->irq_2_irte.index, entry);
 }
@@ -3937,7 +3939,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		ir_data->ga_root_ptr = (pi_data->vapic_addr >> 12);
 		ir_data->ga_vector = pi_data->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
-		ret = amd_iommu_activate_guest_mode(ir_data);
+		ret = amd_iommu_activate_guest_mode(ir_data, pi_data->cpu);
 	} else {
 		ret = amd_iommu_deactivate_guest_mode(ir_data);
 	}
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index fe0e16ffe0e5..c9f2df0c4596 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -32,7 +32,7 @@ extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
 extern int amd_iommu_update_ga(int cpu, void *data);
 
-extern int amd_iommu_activate_guest_mode(void *data);
+extern int amd_iommu_activate_guest_mode(void *data, int cpu);
 extern int amd_iommu_deactivate_guest_mode(void *data);
 
 #else /* defined(CONFIG_AMD_IOMMU) && defined(CONFIG_IRQ_REMAP) */
@@ -48,7 +48,7 @@ static inline int amd_iommu_update_ga(int cpu, void *data)
 	return 0;
 }
 
-static inline int amd_iommu_activate_guest_mode(void *data)
+static inline int amd_iommu_activate_guest_mode(void *data, int cpu)
 {
 	return 0;
 }
-- 
2.49.0.1151.ga128411c76-goog

