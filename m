Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEFC27145B
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962108; cv=none; b=kYO1hJe/qhBnPt7sTGWJYRqO6Qvg9PGtWMwZNMWEV6/3dZnnkeGqkabeLxuFKHep6ld4j5T7Wxi3ydfNXthETvVhBP9ZDkzYUezerGldVcNM9z7WWtOBrC6pIo5/TqQmQnlLnvpavcfi1jmuJ/duvWpbV+HZGH8v9H6dCWlqFM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962108; c=relaxed/simple;
	bh=cgx/76xcA3zklybCr4c/hJY0siLMm57qoWAoljueJzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VkNvxuusmGbtGPTzuMDS+nk+yTa/AQY+8t+snRW4kTitI3QDAlZXRgFcI5txtTsroX/Sus663aFjFKRAmeD8vas6YgtoWLSP29VjyrsBYNow2Mf+7XZxRZzhdG+NdG1sanG/R19ou16wWv57fWmc5WZ52I2SEbTuauyOCdPE0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Js0Z2D2l; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Js0Z2D2l"
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3dc7bc950ceso40364555ab.1
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962106; x=1748566906; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GOvRUDhf6WzZUhQYcj+S2GSmTkywb2uxqC7sAPGcWlY=;
        b=Js0Z2D2l9DDSUFOUH5PewvIaRJ5nVLLv/KtVvrumULSIiF3f8jsnZQEWvYY+tkvFm4
         UAny/Z2y0zm7taSpqh+XUAYrawdawxJmOO47jb+lQHh/1tOk4SZ2d3S0ts6H9JA4UVzM
         wVOJmXGgU3CEurU5Zn8MmzR1apM9lXvCYcugJkcn8S1YNYms+sADtyKxJkmubzcay4tO
         SJt9mD71nj7G6TOxSqPzGulkxJJqzlwqCSsAdVvAX2gS5fzaJO4/fOQUmSFu9kO9MyAy
         B1qqcGZ0sxrUFmVR6pGlYoc/VKz8kAj3x0kbtr/2+Fz16eXqUOIwJNscxBpRwx2XNBD3
         845w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962106; x=1748566906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOvRUDhf6WzZUhQYcj+S2GSmTkywb2uxqC7sAPGcWlY=;
        b=IsNhvrWL7y3+I1F1vgLVGD1R6h5HDOm+6QpX4Dtglk1D+y6M0XsXQwf2iRScMkUnX3
         8S1IQxHbucM43jMlt3SEfw/vS4mBvymLZkUTOZmRbpi1OyBdBCEhzPwcLIgBD7PpV2Nt
         Ll9EIVPwbHZirQgVgJ+U6gK8SE5dJFOitE61GP/JesW+wt8efS75comf7BICQS2BccVc
         E5QI1dMMRr0Y7sl/hkC+FnnbvtUFNgR4YzuK+9n/m0OQNNkuZcZQychj7AfS8sO6fUa5
         GSw2ep3C0XmtMj5V2AIXc3wSxuHPzu9nAUUTmq21XkW+YE8vzUuNsK+27Tep3W11Ib4U
         mKAg==
X-Forwarded-Encrypted: i=1; AJvYcCVdCu/EoGErRWWM4AauEuL4yxuPD4bl4nGE/SLYRm9hui1BrzU4wD4RFVbegdTCfd5Q8D9MBA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVWAjiubW1NSjNXGHGBUlBNzRgd5nKovEaPXKdD7sGIfR4tw9V
	LCfeqQaYgp05mHNPSSCTVP0OBYOUr1hrnf1zspkF5ZkjPWyIHvwfhR4X0UrHb7FUEf4kDRoWmXL
	t5SfoZA==
X-Google-Smtp-Source: AGHT+IFDHkcBTdgDBcf9RfdN3IcCGgtfCXkYoLUg7YY7Kt3b/82DHTKb51w7MjiVGEMAMdbOkvSZTJ677AI=
X-Received: from pjbsb7.prod.google.com ([2002:a17:90b:50c7:b0:30e:6bb2:6855])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:743:b0:3dc:8c4e:2b8b
 with SMTP id e9e14a558f8ab-3dc8c4e2c10mr58843225ab.8.1747962106431; Thu, 22
 May 2025 18:01:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 18:00:02 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-58-seanjc@google.com>
Subject: [PATCH v2 57/59] KVM: SVM: Consolidate IRTE update when toggling AVIC on/off
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Fold the IRTE modification logic in avic_refresh_apicv_exec_ctrl() into
__avic_vcpu_{load,put}(), and add a param to the helpers to communicate
whether or not AVIC is being toggled, i.e. if IRTE needs a "full" update,
or just a quick update to set the CPU and IsRun.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 85 ++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 1e6e5d1f6b4e..2e47559a4134 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -810,7 +810,28 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	return irq_set_vcpu_affinity(host_irq, NULL);
 }
 
-static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu)
+enum avic_vcpu_action {
+	/*
+	 * There is no need to differentiate between activate and deactivate,
+	 * as KVM only refreshes AVIC state when the vCPU is scheduled in and
+	 * isn't blocking, i.e. the pCPU must always be (in)valid when AVIC is
+	 * being (de)activated.
+	 */
+	AVIC_TOGGLE_ON_OFF	= BIT(0),
+	AVIC_ACTIVATE		= AVIC_TOGGLE_ON_OFF,
+	AVIC_DEACTIVATE		= AVIC_TOGGLE_ON_OFF,
+
+	/*
+	 * No unique action is required to deal with a vCPU that stops/starts
+	 * running, as IRTEs are configured to generate GALog interrupts at all
+	 * times.
+	 */
+	AVIC_START_RUNNING	= 0,
+	AVIC_STOP_RUNNING	= 0,
+};
+
+static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
+					    enum avic_vcpu_action action)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_kernel_irqfd *irqfd;
@@ -824,11 +845,20 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu)
 	if (list_empty(&svm->ir_list))
 		return;
 
-	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list)
-		WARN_ON_ONCE(amd_iommu_update_ga(cpu, irqfd->irq_bypass_data));
+	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list) {
+		void *data = irqfd->irq_bypass_data;
+
+		if (!(action & AVIC_TOGGLE_ON_OFF))
+			WARN_ON_ONCE(amd_iommu_update_ga(cpu, data));
+		else if (cpu >= 0)
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, cpu));
+		else
+			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
+	}
 }
 
-static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
+			     enum avic_vcpu_action action)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	int h_physical_id = kvm_cpu_get_apicid(cpu);
@@ -873,7 +903,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, action);
 
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
@@ -890,10 +920,10 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (kvm_vcpu_is_blocking(vcpu))
 		return;
 
-	__avic_vcpu_load(vcpu, cpu);
+	__avic_vcpu_load(vcpu, cpu, AVIC_START_RUNNING);
 }
 
-static void __avic_vcpu_put(struct kvm_vcpu *vcpu)
+static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -915,7 +945,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu)
 	 */
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
 
-	avic_update_iommu_vcpu_affinity(vcpu, -1);
+	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 	svm->avic_physical_id_entry = entry;
@@ -941,7 +971,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
 		return;
 
-	__avic_vcpu_put(vcpu);
+	__avic_vcpu_put(vcpu, AVIC_STOP_RUNNING);
 }
 
 void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu)
@@ -970,41 +1000,18 @@ void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu)
 
 void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
-	bool activated = kvm_vcpu_apicv_active(vcpu);
-	int apic_id = kvm_cpu_get_apicid(vcpu->cpu);
-	struct vcpu_svm *svm = to_svm(vcpu);
-	struct kvm_kernel_irqfd *irqfd;
-	unsigned long flags;
-
 	if (!enable_apicv)
 		return;
 
+	/* APICv should only be toggled on/off while the vCPU is running. */
+	WARN_ON_ONCE(kvm_vcpu_is_blocking(vcpu));
+
 	avic_refresh_virtual_apic_mode(vcpu);
 
-	if (activated)
-		__avic_vcpu_load(vcpu, vcpu->cpu);
+	if (kvm_vcpu_apicv_active(vcpu))
+		__avic_vcpu_load(vcpu, vcpu->cpu, AVIC_ACTIVATE);
 	else
-		__avic_vcpu_put(vcpu);
-
-	/*
-	 * Here, we go through the per-vcpu ir_list to update all existing
-	 * interrupt remapping table entry targeting this vcpu.
-	 */
-	spin_lock_irqsave(&svm->ir_list_lock, flags);
-
-	if (list_empty(&svm->ir_list))
-		goto out;
-
-	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list) {
-		void *data = irqfd->irq_bypass_data;
-
-		if (activated)
-			WARN_ON_ONCE(amd_iommu_activate_guest_mode(data, apic_id));
-		else
-			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(data));
-	}
-out:
-	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
+		__avic_vcpu_put(vcpu, AVIC_DEACTIVATE);
 }
 
 void avic_vcpu_blocking(struct kvm_vcpu *vcpu)
@@ -1030,7 +1037,7 @@ void avic_vcpu_blocking(struct kvm_vcpu *vcpu)
 	 * CPU and cause noisy neighbor problems if the VM is sending interrupts
 	 * to the vCPU while it's scheduled out.
 	 */
-	avic_vcpu_put(vcpu);
+	__avic_vcpu_put(vcpu, AVIC_STOP_RUNNING);
 }
 
 void avic_vcpu_unblocking(struct kvm_vcpu *vcpu)
-- 
2.49.0.1151.ga128411c76-goog

