Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3E226CE8
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795620; cv=none; b=aZyqsgrRHLeoX4dOFL1qzLVTIyCpVFAhX0JLtdEAk61KHA0eGdjHXqgwvkr/q1ol2N7c5KoGaw2PWzIf8S8CTXjTOh1Uu77+596ohMwSwEnorexoIiyR24aOJ/gT/IT89cM/As0ysO7tfHrw/CDNM0+UdaPZ5Zt6P+VmDJAnpas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795620; c=relaxed/simple;
	bh=J6mC0nFXHJAOtYEIFo2PwmBBEXnUBJqNHuBrgJLfJvQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QF4S9SCNSePhQg8GrxdAerS8svCkfEarpvLJTcLu0nK/GtFBHRUIne75L1QveGjeMYjDCJkeVeLyrENIZsK0uYUIvG1KCSxnHxPn/nNW9SxmoAUfRF9/FCDgY5vfUK+OBhG9SMq0HIARNgPziw/cHu7L/2EU7sUCCMUU/BPyvn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWR8+0Dl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWR8+0Dl"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736abba8c5cso3046513b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795618; x=1744400418; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mBYvsppdkEsCC9jB3KHtPaQFQe07zBHNgFlVF26LQEY=;
        b=pWR8+0Dl9jjfpiu6jK2bWeJpufkBTZk21FWtrtN5vXwcIGwWeedCXnGDrvIfCOujeB
         zGCRoK5he/sNPIupBV2G3e8P+jrc71Ktp8GHEStvexSC7wAfcvGGOb7XfRhYemaK24a/
         ZEurSr/pfBxtDIFsC+kfj9ruiYV9L83ThWDTSwRjtc65gRIb17pKNHzqCfZ4fS7r37B3
         wKkQO96W+3gvUVzqw32fmnC5n+r6sh/KX6d91nW7EZQGWhOokDS2ZpyVkRGjJ3NtR7Qd
         l4HiglJPAw/XQS6OWALTLLXE8ZNfLLkn75t6o+347KyWQzulNYLNmgE5zsEcYqibKbLy
         2Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795618; x=1744400418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBYvsppdkEsCC9jB3KHtPaQFQe07zBHNgFlVF26LQEY=;
        b=ZMtPzoEUE+2tsBaIZmiHt2XFKtLAdNFoYHPXK1BAycsOI+OjeFrz3GWMPk9YxxcJsl
         /WN6vy2qvP0lxP5tNyTsXkfLuFwSlTMQxgMlUdQrxUgKes2Kf5X2fzDpvUfrY2ShcGDz
         C7421loOtlzIlPJwRuGKH7wbMW2pKtPIqn+Rf/yqXK/oDuu8LIisZ+nm/uEj5v0wY0Dj
         2mxpm/eQN4rCYlPxbUhlmciXWwYay7tZkuAFli9D7q2PdJBeal5to65x2NQ8j1slx176
         UlJ89OnhcVGbAPVqcEicHA5BPKJXegaTEPEyMVsIFOWLYDqPfdINIUV/JtwozsV7QN+W
         tnVg==
X-Forwarded-Encrypted: i=1; AJvYcCXoR4j2cLC5eYWJAA40vqhaa9bPt3jj5uqfdRuFk6FM/wxikryZ4wzfiJMn1GtlQFh2Bwz61g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5Q0rt1ytrsVJFRWCSZEGq9C+FUG3yGSTwZR3UDNw3ofQBvr3Q
	wiIpUBVzMu13Z3R/UE6+d9syvk+ZrAcT2LGUg0fsKViWDyAbiuQyuo6ujXj+A9rOulE4ikz61q9
	YFA==
X-Google-Smtp-Source: AGHT+IHlJ1S/97WVKpR7s7eWnhf8FHowO+clanPhx/S3rl8+pkCvYLrtJLRFmIybzKrDhNaukmJeObbrPxI=
X-Received: from pfbjc20.prod.google.com ([2002:a05:6a00:6c94:b0:736:451f:b9f4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4606:b0:736:592e:795f
 with SMTP id d2e1a72fcca58-739e6ff6b02mr4669074b3a.9.1743795618072; Fri, 04
 Apr 2025 12:40:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:33 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-19-seanjc@google.com>
Subject: [PATCH 18/67] KVM: SVM: Track AVIC tables as natively sized pointers,
 not "struct pages"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Allocate and track AVIC's logical and physical tables as u32 and u64
pointers respectively, as managing the pages as "struct page" pointers
adds an almost absurd amount of boilerplate and complexity.  E.g. with
page_address() out of the way, svm->avic_physical_id_cache becomes
completely superfluous, and will be removed in a future cleanup.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 49 ++++++++++++++---------------------------
 arch/x86/kvm/svm/svm.h  |  4 ++--
 2 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 344541e418c3..ae6d2c00397f 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -181,10 +181,8 @@ void avic_vm_destroy(struct kvm *kvm)
 	if (!enable_apicv)
 		return;
 
-	if (kvm_svm->avic_logical_id_table_page)
-		__free_page(kvm_svm->avic_logical_id_table_page);
-	if (kvm_svm->avic_physical_id_table_page)
-		__free_page(kvm_svm->avic_physical_id_table_page);
+	free_page((unsigned long)kvm_svm->avic_logical_id_table);
+	free_page((unsigned long)kvm_svm->avic_physical_id_table);
 
 	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
 	hash_del(&kvm_svm->hnode);
@@ -197,27 +195,19 @@ int avic_vm_init(struct kvm *kvm)
 	int err = -ENOMEM;
 	struct kvm_svm *kvm_svm = to_kvm_svm(kvm);
 	struct kvm_svm *k2;
-	struct page *p_page;
-	struct page *l_page;
 	u32 vm_id;
 
 	if (!enable_apicv)
 		return 0;
 
-	/* Allocating physical APIC ID table (4KB) */
-	p_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-	if (!p_page)
+	kvm_svm->avic_physical_id_table = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	if (!kvm_svm->avic_physical_id_table)
 		goto free_avic;
 
-	kvm_svm->avic_physical_id_table_page = p_page;
-
-	/* Allocating logical APIC ID table (4KB) */
-	l_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-	if (!l_page)
+	kvm_svm->avic_logical_id_table = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	if (!kvm_svm->avic_logical_id_table)
 		goto free_avic;
 
-	kvm_svm->avic_logical_id_table_page = l_page;
-
 	spin_lock_irqsave(&svm_vm_data_hash_lock, flags);
  again:
 	vm_id = next_vm_id = (next_vm_id + 1) & AVIC_VM_ID_MASK;
@@ -251,12 +241,10 @@ static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
-	phys_addr_t lpa = __sme_set(page_to_phys(kvm_svm->avic_logical_id_table_page));
-	phys_addr_t ppa = __sme_set(page_to_phys(kvm_svm->avic_physical_id_table_page));
 
 	vmcb->control.avic_backing_page = avic_get_backing_page_address(svm);
-	vmcb->control.avic_logical_id = lpa;
-	vmcb->control.avic_physical_id = ppa;
+	vmcb->control.avic_logical_id = __sme_set(__pa(kvm_svm->avic_logical_id_table));
+	vmcb->control.avic_physical_id = __sme_set(__pa(kvm_svm->avic_physical_id_table));
 	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE;
 
 	if (kvm_apicv_activated(svm->vcpu.kvm))
@@ -270,7 +258,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 id = vcpu->vcpu_id;
-	u64 *table, new_entry;
+	u64 new_entry;
 
 	/*
 	 * Inhibit AVIC if the vCPU ID is bigger than what is supported by AVIC
@@ -286,8 +274,8 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	BUILD_BUG_ON((AVIC_MAX_PHYSICAL_ID + 1) * sizeof(*table) > PAGE_SIZE ||
-		     (X2AVIC_MAX_PHYSICAL_ID + 1) * sizeof(*table) > PAGE_SIZE);
+	BUILD_BUG_ON((AVIC_MAX_PHYSICAL_ID + 1) * sizeof(new_entry) > PAGE_SIZE ||
+		     (X2AVIC_MAX_PHYSICAL_ID + 1) * sizeof(new_entry) > PAGE_SIZE);
 
 	if (WARN_ON_ONCE(!vcpu->arch.apic->regs))
 		return -EINVAL;
@@ -306,18 +294,16 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 			return ret;
 	}
 
-	/* Setting AVIC backing page address in the phy APIC ID table */
-	table = page_address(kvm_svm->avic_physical_id_table_page);
-
 	/* Note, fls64() returns the bit position, +1. */
 	BUILD_BUG_ON(__PHYSICAL_MASK_SHIFT >
 		     fls64(AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK));
 
+	/* Setting AVIC backing page address in the phy APIC ID table */
 	new_entry = avic_get_backing_page_address(svm) |
 		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
-	WRITE_ONCE(table[id], new_entry);
+	WRITE_ONCE(kvm_svm->avic_physical_id_table[id], new_entry);
 
-	svm->avic_physical_id_cache = &table[id];
+	svm->avic_physical_id_cache = &kvm_svm->avic_physical_id_table[id];
 
 	return 0;
 }
@@ -451,7 +437,7 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
 		if (apic_x2apic_mode(source))
 			avic_logical_id_table = NULL;
 		else
-			avic_logical_id_table = page_address(kvm_svm->avic_logical_id_table_page);
+			avic_logical_id_table = kvm_svm->avic_logical_id_table;
 
 		/*
 		 * AVIC is inhibited if vCPUs aren't mapped 1:1 with logical
@@ -553,7 +539,6 @@ unsigned long avic_vcpu_get_apicv_inhibit_reasons(struct kvm_vcpu *vcpu)
 static u32 *avic_get_logical_id_entry(struct kvm_vcpu *vcpu, u32 ldr, bool flat)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
-	u32 *logical_apic_id_table;
 	u32 cluster, index;
 
 	ldr = GET_APIC_LOGICAL_ID(ldr);
@@ -574,9 +559,7 @@ static u32 *avic_get_logical_id_entry(struct kvm_vcpu *vcpu, u32 ldr, bool flat)
 		return NULL;
 	index += (cluster << 2);
 
-	logical_apic_id_table = (u32 *) page_address(kvm_svm->avic_logical_id_table_page);
-
-	return &logical_apic_id_table[index];
+	return &kvm_svm->avic_logical_id_table[index];
 }
 
 static void avic_ldr_write(struct kvm_vcpu *vcpu, u8 g_physical_id, u32 ldr)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 7af28802ebee..4c83b6b73714 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -119,8 +119,8 @@ struct kvm_svm {
 
 	/* Struct members for AVIC */
 	u32 avic_vm_id;
-	struct page *avic_logical_id_table_page;
-	struct page *avic_physical_id_table_page;
+	u32 *avic_logical_id_table;
+	u64 *avic_physical_id_table;
 	struct hlist_node hnode;
 
 	struct kvm_sev_info sev_info;
-- 
2.49.0.504.g3bcea36a83-goog

