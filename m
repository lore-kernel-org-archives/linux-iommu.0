Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5DC22578C
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795618; cv=none; b=UaFp2e+H+KWsKblFLpjZVda00HAyAY9goPgwZXvaa5EzQyk4UnpVxyl3c9/Uv+ZPHp/ynNBvIoRkYqV6MXBJnScaR9Xwi6foPhtO44qSQG1Xdo3EoV0gUyqAdpfL7FlCDeNi4F2iq200NYq/UfuXPEuOb+5ZTNM65LlBybKFZUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795618; c=relaxed/simple;
	bh=8CNUPuQxWruAqazLiQ2U7Se/O49wV/nzU7fAMxK6IVw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SqhsoAYRgIoPfdyZOmweh+c/FJPfM7N8FuBarKCgN5pgznHlvmudyFSfyF5kF9T7qtmfQEUngRKScz5B0+lYNHqBHiAxfx/iXRktqaYyDyam9zZ/mvauds7kGxD2uT5uGW64gpu/oD9tvcGnv4UXDqp1XHPH78bmDhbL0QUGLls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cC19rWSp; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cC19rWSp"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7369c5ed395so2832825b3a.0
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795616; x=1744400416; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HPznh6CGxUFhqaGN+tuF1KZuEdkc3IM8iRC+hka4d9I=;
        b=cC19rWSp9Cvb0IUZi9kMsYq0X99CtIYjdbXFh1baw8xIyELJxUMCkfRU0fWfj/2yJ5
         34q6uXMiJyiScRtjS825iZTjcFvBuqy8VBfBpelRdRmFLCNgO5d+HVZeSOfASHEozBDQ
         5JRUO5aWO6wKPLo6zEffw7XPX1Ci66SFFUbiOObo+dKVgQ/ipPsV5sRqc3z7mdzrOxbj
         1VCylMfpJUycVE7uiJOTwb3j+FJVPNiUudTqQ48d7E2HPV5HWcFwX4UakXchv8KPwoDd
         mOKH+OcF3AnDe6LmIDZkj5wDPVce1In211ZSAVFaDWvsM3Ik4heqgfVohCC9uSbtN8nP
         ZkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795616; x=1744400416;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPznh6CGxUFhqaGN+tuF1KZuEdkc3IM8iRC+hka4d9I=;
        b=IzUWvv+88YWu3TUA7rH8eleNquNO1ijgNfU4pImLv9QWt9dNT6CsnNaI0opH005OTW
         ihVRu++uEr79wZ9IjeexG/BAyxEldEQ2/1wvX7toB9061eYuaxAyNgg7yJEJwPfcymCu
         7fyaEZkJLmIMAdO24oJw0JLI3NYt8FeOzD1yK6bi1OtSWwxTaB3eWE86GFjNNUFZkbMX
         mFb5A/NKgDoh1LaSeGrJjtHg5Aa49JAAsZGKKQlAu2pCGcR7Avv8sLMsvSnGEqP/Ciyt
         eUWKVqoYLEXiJGuNyKIxl0OA5LphfUnK8SQLWZmAV9e0PlgMMF8xjhKHQrLtBKtZer/Y
         0vyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeniPIK1ELnAACc5A9z9OXtFrCYiMC0IQZrYTuHcbH5CZPAEsn8BKdj/gEJ6BoUi3ksPnVFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxthRUSHmU6EPSv3FnUfnbaMtzYj6W8XDaJZsaa57UCiAwH+zCZ
	AsIX0N8QObiKks8f3lNmhK3x5v+f6ayGPvRClXDs55XtFhmHS9jA3ePvkpTeJRPkbdJl87aP0q+
	BWQ==
X-Google-Smtp-Source: AGHT+IHdDhY3q1PoCzEN393Qre591g1t5JRHt7vREsmAZfu9y83GvrelcK4mphnOUkWNilXZrFXu1h6Tod0=
X-Received: from pfbhb19.prod.google.com ([2002:a05:6a00:8593:b0:737:79:e096])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:244c:b0:736:546c:eb69
 with SMTP id d2e1a72fcca58-739e492c849mr5818791b3a.9.1743795616257; Fri, 04
 Apr 2025 12:40:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:32 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-18-seanjc@google.com>
Subject: [PATCH 17/67] KVM: SVM: Drop redundant check in AVIC code on ID
 during vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop avic_get_physical_id_entry()'s compatibility check on the incoming
ID, as its sole caller, avic_init_backing_page(), performs the exact same
check.  Drop avic_get_physical_id_entry() entirely as the only remaining
functionality is getting the address of the Physical ID table, and
accessing the array without an immediate bounds check is kludgy.

Opportunistically add a compile-time assertion to ensure the vcpu_id can't
result in a bounds overflow, e.g. if KVM (really) messed up a maximum
physical ID #define, as well as run-time assertions so that a NULL pointer
dereference is morphed into a safer WARN().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 47 +++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index ba8dfc8a12f4..344541e418c3 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -265,35 +265,19 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 		avic_deactivate_vmcb(svm);
 }
 
-static u64 *avic_get_physical_id_entry(struct kvm_vcpu *vcpu,
-				       unsigned int index)
-{
-	u64 *avic_physical_id_table;
-	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
-
-	if ((!x2avic_enabled && index > AVIC_MAX_PHYSICAL_ID) ||
-	    (index > X2AVIC_MAX_PHYSICAL_ID))
-		return NULL;
-
-	avic_physical_id_table = page_address(kvm_svm->avic_physical_id_table_page);
-
-	return &avic_physical_id_table[index];
-}
-
 static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 {
-	u64 *entry, new_entry;
-	int id = vcpu->vcpu_id;
+	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	struct vcpu_svm *svm = to_svm(vcpu);
+	u32 id = vcpu->vcpu_id;
+	u64 *table, new_entry;
 
 	/*
 	 * Inhibit AVIC if the vCPU ID is bigger than what is supported by AVIC
-	 * hardware.  Do so immediately, i.e. don't defer the update via a
-	 * request, as avic_vcpu_load() expects to be called if and only if the
-	 * vCPU has fully initialized AVIC.  Immediately clear apicv_active,
-	 * as avic_vcpu_load() assumes avic_physical_id_cache is valid, i.e.
-	 * waiting until KVM_REQ_APICV_UPDATE is processed on the first KVM_RUN
-	 * will result in an NULL pointer deference when loading the vCPU.
+	 * hardware.  Immediately clear apicv_active, i.e. don't wait until the
+	 * KVM_REQ_APICV_UPDATE request is processed on the first KVM_RUN, as
+	 * avic_vcpu_load() expects to be called if and only if the vCPU has
+	 * fully initialized AVIC.
 	 */
 	if ((!x2avic_enabled && id > AVIC_MAX_PHYSICAL_ID) ||
 	    (id > X2AVIC_MAX_PHYSICAL_ID)) {
@@ -302,6 +286,9 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
+	BUILD_BUG_ON((AVIC_MAX_PHYSICAL_ID + 1) * sizeof(*table) > PAGE_SIZE ||
+		     (X2AVIC_MAX_PHYSICAL_ID + 1) * sizeof(*table) > PAGE_SIZE);
+
 	if (WARN_ON_ONCE(!vcpu->arch.apic->regs))
 		return -EINVAL;
 
@@ -320,9 +307,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	}
 
 	/* Setting AVIC backing page address in the phy APIC ID table */
-	entry = avic_get_physical_id_entry(vcpu, id);
-	if (!entry)
-		return -EINVAL;
+	table = page_address(kvm_svm->avic_physical_id_table_page);
 
 	/* Note, fls64() returns the bit position, +1. */
 	BUILD_BUG_ON(__PHYSICAL_MASK_SHIFT >
@@ -330,9 +315,9 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 
 	new_entry = avic_get_backing_page_address(svm) |
 		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
-	WRITE_ONCE(*entry, new_entry);
+	WRITE_ONCE(table[id], new_entry);
 
-	svm->avic_physical_id_cache = entry;
+	svm->avic_physical_id_cache = &table[id];
 
 	return 0;
 }
@@ -1018,6 +1003,9 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (WARN_ON(h_physical_id & ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
 		return;
 
+	if (WARN_ON_ONCE(!svm->avic_physical_id_cache))
+		return;
+
 	/*
 	 * No need to update anything if the vCPU is blocking, i.e. if the vCPU
 	 * is being scheduled in after being preempted.  The CPU entries in the
@@ -1058,6 +1046,9 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 
 	lockdep_assert_preemption_disabled();
 
+	if (WARN_ON_ONCE(!svm->avic_physical_id_cache))
+		return;
+
 	/*
 	 * Note, reading the Physical ID entry outside of ir_list_lock is safe
 	 * as only the pCPU that has loaded (or is loading) the vCPU is allowed
-- 
2.49.0.504.g3bcea36a83-goog

