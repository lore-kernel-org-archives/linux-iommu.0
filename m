Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B402E62D2
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962108; cv=none; b=gxLDmA+y2BHhQdeg0r5PXGGJoKyKaYhtee6EA0VofMk2tLIAc6aAlhK2cBLkfpZHOKORPcLu0+2UPJkQM8T+XIIZqQwh6JnV9beTIZcjRzXzxtgC4Q4d1n+XGt4l/4AbEdOEWkQ4feLpR8hsp6UESdhx/4MmFJrCRX+0+V3vPn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962108; c=relaxed/simple;
	bh=2QBb5/XIqsfvIc456zHCbrENEH2By/61zuGLujz3Rzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sVlaWEnEJQTCI7Hkvx/69ZYE+6bpPrF3abupAWLD0vs6ac4/z7lFg8yToJ1n60Iu5tNZDwi7aV6+J0OyQw33wlZg5/YSbA7fMRbVm07K/5VlGb85nzzQKHOyQJU/l/k1gIlIgGUp0TKtd4Y3ySBvFJjqoSuI+rtDaYSAaHjuIhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N4PTQ8L6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N4PTQ8L6"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742b01ad1a5so9603618b3a.0
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962104; x=1748566904; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/e9UYgTv1sZ7z5b1x8uYjd+06D7YFK/4pMDs1/TTKKw=;
        b=N4PTQ8L6mfPyKfAlm6iGgDY4XoOzRXlI1Z9Q9ve9UeFFdRFa2WEHrx3DIsYAefmqfb
         VtPdPiM64Myg7QRn2zYaVOTfS1tok72Fi1b/FS554KFL/+iKi6ywhW7rJr6YHI4VYEyU
         dVOb3lN0ndJ+nVJ3Lp4jZCvBXiZAGdyuUzYJVXA1dqub7sen6fu5UeAgAwt6NX2VAXdd
         GFc9DZfi2g2jZCgiRGkyGnp+Z53EcZ7naX7WbrZ/KSkEhyOul1pTYwYletAYWjyPB6xP
         zLBq/OS/t3AaAJYRSrVF+1efVpeNZkxi4OH/CRy03WjwzBCzdIRA4VXfTUlBoyFQpyW9
         9YjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962104; x=1748566904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/e9UYgTv1sZ7z5b1x8uYjd+06D7YFK/4pMDs1/TTKKw=;
        b=SsJSkWE1hM0IB3pxcEX5SsV4+0UqiNH4ENeq0QnBWxBPfW52aybe/JwN+liTC96+mz
         2tqa2d7YBmrlx2o91xueiRLU6qZSL3YyP1xYPdpRlxmNaLr6nQy1grTeXkCwA54xWSgs
         Bm35xFdkEOtN+4NsSYm+0zyk5Ctyc/S1E5cjeJrx9X8wuXMSPJNRe5XxgdXV0XEU8k7x
         ZoTCHu/xI57NnjfPFIHHMdFTZCqwxWftwCfFiq43Uo29qitdf+xMRKn+GfqM9OVR1zv0
         2zhP1+PRpzIEd4GU2zPTY4J3SkgG8whq4r44QuTbut5lPRjX0FYdXkrOlgs7TCXvzduM
         mITw==
X-Forwarded-Encrypted: i=1; AJvYcCVpzTU+7up5yRlkHRMvve2hyYFVAFtVZWx4xC3u7cOmkUV92Aongv/lpYJTryA9Bm0jb1gH/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YypOyT4+3yl6dRs77R5usFkTZgDOCHdtbbhcj0pZTiNwpCn+Sao
	dFX/bNa2AiDFuYvnHQtgB8BSYbqYQTGDKrMgk5FROK0muw7Jr1eQquD1KoU2T0q3/Ms7xWYWOmU
	ad3iJKg==
X-Google-Smtp-Source: AGHT+IEQRYTnAxDbAwwyPpwl8BUMXr/CByqDWtsE69Ozfi2WC7I9F1/uYDQUgOID+Lp8MTwFn4NoVPso1aA=
X-Received: from pgbcz10.prod.google.com ([2002:a05:6a02:230a:b0:b0d:967f:23de])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a103:b0:218:6dc8:2cb
 with SMTP id adf61e73a8af0-2186dc802cfmr5175120637.0.1747962104546; Thu, 22
 May 2025 18:01:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 18:00:01 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-57-seanjc@google.com>
Subject: [PATCH v2 56/59] KVM: SVM: Don't check vCPU's blocking status when
 toggling AVIC on/off
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't query a vCPU's blocking status when toggling AVIC on/off; barring
KVM bugs, the vCPU can't be blocking when refreshing AVIC controls.  And
if there are KVM bugs, ensuring the vCPU and its associated IRTEs are in
the correct state is desirable, i.e. well worth any overhead in a buggy
scenario.

Isolating the "real" load/put flows will allow moving the IOMMU IRTE
(de)activation logic from avic_refresh_apicv_exec_ctrl() to
avic_update_iommu_vcpu_affinity(), i.e. will allow updating the vCPU's
physical ID entry and its IRTEs in a common path, under a single critical
section of ir_list_lock.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 65 +++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 9ddec6f3ad41..1e6e5d1f6b4e 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -828,7 +828,7 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu)
 		WARN_ON_ONCE(amd_iommu_update_ga(cpu, irqfd->irq_bypass_data));
 }
 
-void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	int h_physical_id = kvm_cpu_get_apicid(cpu);
@@ -844,16 +844,6 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >= PAGE_SIZE))
 		return;
 
-	/*
-	 * No need to update anything if the vCPU is blocking, i.e. if the vCPU
-	 * is being scheduled in after being preempted.  The CPU entries in the
-	 * Physical APIC table and IRTE are consumed iff IsRun{ning} is '1'.
-	 * If the vCPU was migrated, its new CPU value will be stuffed when the
-	 * vCPU unblocks.
-	 */
-	if (kvm_vcpu_is_blocking(vcpu))
-		return;
-
 	/*
 	 * Grab the per-vCPU interrupt remapping lock even if the VM doesn't
 	 * _currently_ have assigned devices, as that can change.  Holding
@@ -888,31 +878,33 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
 
-void avic_vcpu_put(struct kvm_vcpu *vcpu)
+void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	/*
+	 * No need to update anything if the vCPU is blocking, i.e. if the vCPU
+	 * is being scheduled in after being preempted.  The CPU entries in the
+	 * Physical APIC table and IRTE are consumed iff IsRun{ning} is '1'.
+	 * If the vCPU was migrated, its new CPU value will be stuffed when the
+	 * vCPU unblocks.
+	 */
+	if (kvm_vcpu_is_blocking(vcpu))
+		return;
+
+	__avic_vcpu_load(vcpu, cpu);
+}
+
+static void __avic_vcpu_put(struct kvm_vcpu *vcpu)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	unsigned long flags;
-	u64 entry;
+	u64 entry = svm->avic_physical_id_entry;
 
 	lockdep_assert_preemption_disabled();
 
 	if (WARN_ON_ONCE(vcpu->vcpu_id * sizeof(entry) >= PAGE_SIZE))
 		return;
 
-	/*
-	 * Note, reading the Physical ID entry outside of ir_list_lock is safe
-	 * as only the pCPU that has loaded (or is loading) the vCPU is allowed
-	 * to modify the entry, and preemption is disabled.  I.e. the vCPU
-	 * can't be scheduled out and thus avic_vcpu_{put,load}() can't run
-	 * recursively.
-	 */
-	entry = svm->avic_physical_id_entry;
-
-	/* Nothing to do if IsRunning == '0' due to vCPU blocking. */
-	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
-		return;
-
 	/*
 	 * Take and hold the per-vCPU interrupt remapping lock while updating
 	 * the Physical ID entry even though the lock doesn't protect against
@@ -932,7 +924,24 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 		WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
+}
 
+void avic_vcpu_put(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Note, reading the Physical ID entry outside of ir_list_lock is safe
+	 * as only the pCPU that has loaded (or is loading) the vCPU is allowed
+	 * to modify the entry, and preemption is disabled.  I.e. the vCPU
+	 * can't be scheduled out and thus avic_vcpu_{put,load}() can't run
+	 * recursively.
+	 */
+	u64 entry = to_svm(vcpu)->avic_physical_id_entry;
+
+	/* Nothing to do if IsRunning == '0' due to vCPU blocking. */
+	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
+		return;
+
+	__avic_vcpu_put(vcpu);
 }
 
 void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu)
@@ -973,9 +982,9 @@ void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 	avic_refresh_virtual_apic_mode(vcpu);
 
 	if (activated)
-		avic_vcpu_load(vcpu, vcpu->cpu);
+		__avic_vcpu_load(vcpu, vcpu->cpu);
 	else
-		avic_vcpu_put(vcpu);
+		__avic_vcpu_put(vcpu);
 
 	/*
 	 * Here, we go through the per-vcpu ir_list to update all existing
-- 
2.49.0.1151.ga128411c76-goog

