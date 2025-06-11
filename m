Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB16293462
	for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682040; cv=none; b=t5H2dvyx0iofAp4E+BKpNJBkLyHuvpfEFRVUvuJDpsNhJAjaW/sWTfn0p7iyVJWpdUKEAJVkc41UZiVPWbnQs4Jp/WWjhmlKPUyLtHC5Z3B6eM0L4THbFVA9rQ5/V3hhEx8Ep8QZslGXTELFFWUL+eXMsa9kRbZdfBBJsAMDBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682040; c=relaxed/simple;
	bh=+WCgHtdp2H3zFROg/kXRAOiJNVGT+bH93q9WZnv07eE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FHc/sQ+EIGwQHX6y5VS7bUSSE2cYjGTFZzI596qhirpnNtxvTT6Tt1XDQsXCp/q2n0GojYZOOFYsOAapz73FlyEkzB7QOqOmcZso3qdJA2wtVD2M+j42BmvDyuyELjFF1Q1rAyHgk81sIH4rFvJFCnVCL2c83jUzcjxp7YN9CZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NTqqa4oU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTqqa4oU"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74880a02689so83631b3a.0
        for <iommu@lists.linux.dev>; Wed, 11 Jun 2025 15:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682038; x=1750286838; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oUvsQ8mDIzQb0qFFdXVmPhQyIfkBQRy6OI+aTTyokEg=;
        b=NTqqa4oUN8ixIapGTt3ZlEEWMLHqS9GFnhdcsbramSGbafNiFrsSBVw2De1S9qErIi
         hSAy8TYDW/FrPbk9CKYJtAmgNmXRsbqU9jhmrXFz+s8XSOkXNXyZLa5azdVOSr4/V4BB
         rN+rxExa/YtWckm/KKTTCWTrtpcHlOY9NV2SjI/0DsDSzG0c/3zm3uxVkVABqt9FrmWR
         YF1KWOO5eBIrfk+KoMiODU37krSE2vc4DHEXw8/sW7azLhmLoMADgxJNappsR36HH1Wx
         S6er7jjgHBPK0vcX/54NJTSNbQzBBarb3Tz3MzhxdA55Av7q/ZjfBrgxE5lwYuEaoosj
         zY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682039; x=1750286839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUvsQ8mDIzQb0qFFdXVmPhQyIfkBQRy6OI+aTTyokEg=;
        b=cXxd8oPq8KqZGilzuUpkg/FagbWWxqCmUENjKqR8LY2YD8sa/mvx3ibV5abd0PESQk
         ja8K5I940MfgeIc9DXDXXbshZ46MKtswUkIKmouKfuK1as/hCYXI2eRhbYTK3RTgC9rd
         sqshl+6n/T/qFbSCuvt3kivlmsbZzNEVrMIlmuF33Rf268qrBPIrTaOozBNRayUQa+4Z
         jmG/+rkqV33NV4Jb60nvaLJKRfq07Q8b6Zc8yJ2qUqptDOyWbZh6EaKPhqnCzrVow+sW
         EmnqSXDg6LS4aCSbRJ8Fqld7HfOpFasCmiGApdHnLNVA1Ef0nyNaQ1RiNX/IiKy5z6UH
         lupw==
X-Forwarded-Encrypted: i=1; AJvYcCUwcBb52W3XYCjrCoSNsHdzXuCt0AI8bOTo2EBvCKVMDkcqB+YKCEQe9r4f0PUmWX+vI8YSWw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKX6FOJaNiLyszb5HUvAZURSJCzH0gpFK6LJgUtOh64pnCtuTY
	EjIgdcsfOlGyzEUB94f9OjXNexwdaGAcmJOya3+RAFpqbhxb3EVndcB19e0APNTD25oVERlI0oP
	kMuFlZg==
X-Google-Smtp-Source: AGHT+IEfPx6THB86jTUP6dJfz6pw9nwRImiQrl8t3HHDUWJ7TfKep9MrKXl6SwXip961tO69ZHuJKVDD+j4=
X-Received: from pfbfn21.prod.google.com ([2002:a05:6a00:2fd5:b0:746:270f:79c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17a4:b0:748:31ed:ba8a
 with SMTP id d2e1a72fcca58-7486cbbf515mr6176704b3a.15.1749682038641; Wed, 11
 Jun 2025 15:47:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:16 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-15-seanjc@google.com>
Subject: [PATCH v3 13/62] KVM: SVM: Drop redundant check in AVIC code on ID
 during vCPU creation
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
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

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index f0a74b102c57..948bab48083b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -256,26 +256,12 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
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
@@ -291,6 +277,9 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
+	BUILD_BUG_ON((AVIC_MAX_PHYSICAL_ID + 1) * sizeof(*table) > PAGE_SIZE ||
+		     (X2AVIC_MAX_PHYSICAL_ID + 1) * sizeof(*table) > PAGE_SIZE);
+
 	if (WARN_ON_ONCE(!vcpu->arch.apic->regs))
 		return -EINVAL;
 
@@ -309,9 +298,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	}
 
 	/* Setting AVIC backing page address in the phy APIC ID table */
-	entry = avic_get_physical_id_entry(vcpu, id);
-	if (!entry)
-		return -EINVAL;
+	table = page_address(kvm_svm->avic_physical_id_table_page);
 
 	/* Note, fls64() returns the bit position, +1. */
 	BUILD_BUG_ON(__PHYSICAL_MASK_SHIFT >
@@ -319,9 +306,9 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 
 	new_entry = avic_get_backing_page_address(svm) |
 		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
-	WRITE_ONCE(*entry, new_entry);
+	WRITE_ONCE(table[id], new_entry);
 
-	svm->avic_physical_id_cache = entry;
+	svm->avic_physical_id_cache = &table[id];
 
 	return 0;
 }
@@ -1004,6 +991,9 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	if (WARN_ON(h_physical_id & ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK))
 		return;
 
+	if (WARN_ON_ONCE(!svm->avic_physical_id_cache))
+		return;
+
 	/*
 	 * No need to update anything if the vCPU is blocking, i.e. if the vCPU
 	 * is being scheduled in after being preempted.  The CPU entries in the
@@ -1044,6 +1034,9 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 
 	lockdep_assert_preemption_disabled();
 
+	if (WARN_ON_ONCE(!svm->avic_physical_id_cache))
+		return;
+
 	/*
 	 * Note, reading the Physical ID entry outside of ir_list_lock is safe
 	 * as only the pCPU that has loaded (or is loading) the vCPU is allowed
-- 
2.50.0.rc1.591.g9c95f17f64-goog

