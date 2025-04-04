Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E222500DE
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795694; cv=none; b=ojPUqxG0T8dEhPWO6TdLrpapZiqncph7QaZ3I7XX2uoQ3Rt2LucgtsPBTwtIt9VI0bnOAlszFSqyx3JagshEtBM3CnY8dUGV+oV0GSDbe+u99BendrnQv4jZF5nZVepLWwlFhaFAsiOK6B0i0//ESpkZ6CadZLVzIS4ZuTHD1EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795694; c=relaxed/simple;
	bh=R9sMWALkBgwfi6cvHRh8b/xeGw/exHZkwCm6FFV2BPA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EX8XWkVPDrQGswXMoD3/sxOJO3V7Z68aTXoQmN/xEl2J/e/MOvDNOg8ngxydWOWIXFyUZ2ypf02KlE1LZ6OzJDae6C6gfbjGrh7gUAJtxb+o0J/2nyjL7bTjLwNmPoKgYL3iYiNgQ6jxmsC7t0w0g0yBuwpCbi2jDNzMFAN+DnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PpCfNM6G; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PpCfNM6G"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7394792f83cso1891535b3a.3
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795692; x=1744400492; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yvqzDsLCWBVkAFBTdSkT6iL07PKtulllv44RSpoEpAk=;
        b=PpCfNM6GDLSJDGaAx9AG9/wsaKg1oxCNaKVDs5sXmWgHw2fXP9GCaY3M08sXQM3Ee4
         syNeLPThuTER0QJWaqX8OGMGeEL4MY++XGSKnFi3RFNd6iH0rSGOncBbBDF/4AdVFSa7
         JtLYBzKqCkrwx2ZKEWvWQOeX/McaD4xFnRpmHASMJrpBw+Z1ex1AilDyJXBeOJN8i3/K
         S3cEin0Td+DUCGj6bQiu0uBIpa7yv1eXJpt/tcxYY05Qb+ZoE4gTZnghwd4TYQ6A6l+D
         rurKW5bvDAnk8emEP5E/CG4gGVliFqL+uPDrujW5t7GLgMDnegQQAf1Edhly+pjB++mu
         OZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795692; x=1744400492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvqzDsLCWBVkAFBTdSkT6iL07PKtulllv44RSpoEpAk=;
        b=WBJpnZwCDtRDSP66U93gcTN68C6y5wiYhVOkwJD76Gg87IOR7ALRtOJXxfJ0Wp5sjt
         pU53xxYv7CPk+3zlUf9ojvXB+KVot4S3sdzcILHH/3GRFgyu34bwSecwvDNKS+aH/tra
         5B4zy7nmUFhVgflnHq73tANDLiBByBr6nMcOXCfxV0zkwuHkmOEUbiw4+R3FAhTbvEkz
         d6q1LHsWtZ9vfV264NH78HRNEzTjQBMjMJmLy9YXuHaunQ1nUbuywY76bm4yCUcjyLbT
         +NyTrQAU5EUJyiG9txfICXcQZJkui7uaWHqSfl6Ea+vOS/gf36Gb8tWfFj1TnAf+Nw1p
         azKg==
X-Forwarded-Encrypted: i=1; AJvYcCWTS30XlY+x4JDD1XuL61A05nBZn/F5M2NAjGLgo9cYl1BQcXYRXJjhfKHK4ZkM2awTm09xuA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzcutr69SJUM25iy1Lo01R0638FxBCuT9X2OSx+Dj4nAci0R30g
	p83DW0tVJHIQINZXL1qFBzTcYUKQ+JOk5Z8tH0EdwikbzuQHnuF3e+ilVSAb63z9JYGdzotqwOY
	Q6w==
X-Google-Smtp-Source: AGHT+IE79fYw6sxc2mtR0ZTsjUgMLzDtlDBHKt8S//qI+fFV8JgTCb/EHs15a16b5eLDWcD9q+k3TdFqdb0=
X-Received: from pfbef12.prod.google.com ([2002:a05:6a00:2c8c:b0:730:796b:a54a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4653:b0:736:a540:c9ad
 with SMTP id d2e1a72fcca58-73b6b8f82e9mr712492b3a.20.1743795692201; Fri, 04
 Apr 2025 12:41:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:39:16 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-62-seanjc@google.com>
Subject: [PATCH 61/67] KVM: SVM: Fold avic_set_pi_irte_mode() into its sole caller
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Fold avic_set_pi_irte_mode() into avic_refresh_apicv_exec_ctrl() in
anticipation of moving the __avic_vcpu_{load,put}() calls into the
critical section, and because having a one-off helper with a name that's
easily confused with avic_pi_update_irte() is unnecessary.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 48 ++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d567d62463ac..0425cc374a79 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -737,32 +737,6 @@ void avic_apicv_post_state_restore(struct kvm_vcpu *vcpu)
 	avic_handle_ldr_update(vcpu);
 }
 
-static void avic_set_pi_irte_mode(struct kvm_vcpu *vcpu, bool activate)
-{
-	int apic_id = kvm_cpu_get_apicid(vcpu->cpu);
-	unsigned long flags;
-	struct amd_svm_iommu_ir *ir;
-	struct vcpu_svm *svm = to_svm(vcpu);
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
-	list_for_each_entry(ir, &svm->ir_list, node) {
-		if (activate)
-			WARN_ON_ONCE(amd_iommu_activate_guest_mode(ir->data, apic_id));
-		else
-			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(ir->data));
-	}
-out:
-	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
-}
-
 static void svm_ir_list_del(struct kvm_kernel_irqfd *irqfd)
 {
 	struct kvm_vcpu *vcpu = irqfd->irq_bypass_vcpu;
@@ -998,6 +972,10 @@ void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu)
 void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
 	bool activated = kvm_vcpu_apicv_active(vcpu);
+	int apic_id = kvm_cpu_get_apicid(vcpu->cpu);
+	struct vcpu_svm *svm = to_svm(vcpu);
+	struct amd_svm_iommu_ir *ir;
+	unsigned long flags;
 
 	if (!enable_apicv)
 		return;
@@ -1009,7 +987,23 @@ void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 	else
 		avic_vcpu_put(vcpu);
 
-	avic_set_pi_irte_mode(vcpu, activated);
+	/*
+	 * Here, we go through the per-vcpu ir_list to update all existing
+	 * interrupt remapping table entry targeting this vcpu.
+	 */
+	spin_lock_irqsave(&svm->ir_list_lock, flags);
+
+	if (list_empty(&svm->ir_list))
+		goto out;
+
+	list_for_each_entry(ir, &svm->ir_list, node) {
+		if (activated)
+			WARN_ON_ONCE(amd_iommu_activate_guest_mode(ir->data, apic_id));
+		else
+			WARN_ON_ONCE(amd_iommu_deactivate_guest_mode(ir->data));
+	}
+out:
+	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
 
 void avic_vcpu_blocking(struct kvm_vcpu *vcpu)
-- 
2.49.0.504.g3bcea36a83-goog

