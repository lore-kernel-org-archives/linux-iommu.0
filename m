Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA798224B1F
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962033; cv=none; b=bZBruchRNorQV3Ns81zjiQzsBRHtK1nJw58UOjsY93N4Doy+9FElv6Wdhxmn3YHu2ua1snBE61gHxJjf0gjzW40/2ck53nt5kkHxyh35pliHDFMMI+88q1+dZRuGJvsGyykYTNHKRtkY4QKPi2yRtIeEb2F5TWI6OOxWs7Slut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962033; c=relaxed/simple;
	bh=1u7yaWCSV8swor7EDb2Vzxng28EOGOs32xp2c0ARZ8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EHKRBsFbJ66DSI1vwgiyW+LspWV0xoFV1cKs2ZyqvirBJs5KhX3AgcRQiHe82muTZ2NT4amVkZQUbbtkxxpN0IDznuruCW8I+a8uninGtelXEG9lF+DtzdqII9dTp9EI7jecXIX9qvD8ItwAb8kEF848Xhfr/6cYU++IelCqzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPQ/S/0b; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPQ/S/0b"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e9b2e7a34so4949949a91.0
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962031; x=1748566831; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TWVWI0HB+j/yivqbFmMmYR1x9Y24z6jTPvGpz798n6o=;
        b=nPQ/S/0bHpdG/TgzhPkcseduuI5Pix82Uuc0wicnXsBoPiYcg1pL8nR3uoZhODAeRC
         5ZJYkY9db99QOV3Tbd6e7205TV07hKPdeOvcAvyvd9WK091OJR0GRicQhVgzIa+lc9zX
         8C3QEbqPKVWHFjojlUaZ+0/3m7CZ568AEXeJwvSwtIMBYW2CInsE4hj04227v3Q1tXyy
         X3fZT20h1rwIfbpYdf15gYyHgUR/zvznyeiKk1OIeqPuyG0+VDFJT3uybsaHnVCFuzOi
         g5cwvPphZBBbunUKuZzEyEvFtadk426wwmhWyaE6v0Rm5IoFLl9e7I7KkO/8es5Hr/2i
         JJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962031; x=1748566831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TWVWI0HB+j/yivqbFmMmYR1x9Y24z6jTPvGpz798n6o=;
        b=Mwby2SDvYTWEXHlJWh5wci+5Q9HSNLmqYjRo8iA4bG5OmyWho4nc+zh8p+ayWHByzO
         x+nvwmoXEEbbx3x7QiNScN8P/1qYuZvSeZeI3CJY+HibE9z9umXu3TFD3poVhrIzoCUK
         PgSfoia9cupBwSoeWdCaWDdq0mwD4584F6I28VZdxqgfR85PeQh0zmwjql2dgN1/jUQq
         OYApcYgSELkHULheYVsVgcDzljImeDgHFESJNC35nq0OZNScBi3FGRFf9ZhhRgZ7V3TO
         g77CD3J0pOitzHmVeK1MPYHZ7Jzagfs/NfWO0TiGpVxCNLZk9EIXjfaXo6WePUvhFn7a
         FvDw==
X-Forwarded-Encrypted: i=1; AJvYcCUP6WgzX5NB3wcs9o+pDBNvGJlgyW4JCaaPQ36gJVAcFTxFL1GBq826QuNOzqF8LZRnpW+zxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVmLnEa1eOScZUWtJ79Ycl/xVXXlVM9DfrY1EIa1KrpJVQpsRz
	VNao14usokJiGP1iJ+ZRbHCrbTZYp+Wr1qS+Y9sa7TwcNoqFdEnOaEVaKXr1wZVhzvZ0vVg3wUX
	HsKyHWw==
X-Google-Smtp-Source: AGHT+IFAvtZwrOPujc8Jiezt5ZUqdB9goJmViesuN7rSLHyglpb7Gd0+oRTXrUjZLjFNcb4QeIdzixEWwiw=
X-Received: from pjf14.prod.google.com ([2002:a17:90b:3f0e:b0:2fc:d77:541])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1645:b0:2ee:94d1:7a89
 with SMTP id 98e67ed59e1d1-310e96b6096mr1702204a91.1.1747962031141; Thu, 22
 May 2025 18:00:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:17 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-13-seanjc@google.com>
Subject: [PATCH v2 12/59] KVM: SVM: Track AVIC tables as natively sized
 pointers, not "struct pages"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Allocate and track AVIC's logical and physical tables as u32 and u64
pointers respectively, as managing the pages as "struct page" pointers
adds an almost absurd amount of boilerplate and complexity.  E.g. with
page_address() out of the way, svm->avic_physical_id_cache becomes
completely superfluous, and will be removed in a future cleanup.

No functional change intended.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 49 ++++++++++++++---------------------------
 arch/x86/kvm/svm/svm.h  |  4 ++--
 2 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 948bab48083b..bf18b0b643d9 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -172,10 +172,8 @@ void avic_vm_destroy(struct kvm *kvm)
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
@@ -188,27 +186,19 @@ int avic_vm_init(struct kvm *kvm)
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
@@ -242,12 +232,10 @@ static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
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
@@ -261,7 +249,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 id = vcpu->vcpu_id;
-	u64 *table, new_entry;
+	u64 new_entry;
 
 	/*
 	 * Inhibit AVIC if the vCPU ID is bigger than what is supported by AVIC
@@ -277,8 +265,8 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 		return 0;
 	}
 
-	BUILD_BUG_ON((AVIC_MAX_PHYSICAL_ID + 1) * sizeof(*table) > PAGE_SIZE ||
-		     (X2AVIC_MAX_PHYSICAL_ID + 1) * sizeof(*table) > PAGE_SIZE);
+	BUILD_BUG_ON((AVIC_MAX_PHYSICAL_ID + 1) * sizeof(new_entry) > PAGE_SIZE ||
+		     (X2AVIC_MAX_PHYSICAL_ID + 1) * sizeof(new_entry) > PAGE_SIZE);
 
 	if (WARN_ON_ONCE(!vcpu->arch.apic->regs))
 		return -EINVAL;
@@ -297,18 +285,16 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
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
@@ -442,7 +428,7 @@ static int avic_kick_target_vcpus_fast(struct kvm *kvm, struct kvm_lapic *source
 		if (apic_x2apic_mode(source))
 			avic_logical_id_table = NULL;
 		else
-			avic_logical_id_table = page_address(kvm_svm->avic_logical_id_table_page);
+			avic_logical_id_table = kvm_svm->avic_logical_id_table;
 
 		/*
 		 * AVIC is inhibited if vCPUs aren't mapped 1:1 with logical
@@ -544,7 +530,6 @@ unsigned long avic_vcpu_get_apicv_inhibit_reasons(struct kvm_vcpu *vcpu)
 static u32 *avic_get_logical_id_entry(struct kvm_vcpu *vcpu, u32 ldr, bool flat)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
-	u32 *logical_apic_id_table;
 	u32 cluster, index;
 
 	ldr = GET_APIC_LOGICAL_ID(ldr);
@@ -565,9 +550,7 @@ static u32 *avic_get_logical_id_entry(struct kvm_vcpu *vcpu, u32 ldr, bool flat)
 		return NULL;
 	index += (cluster << 2);
 
-	logical_apic_id_table = (u32 *) page_address(kvm_svm->avic_logical_id_table_page);
-
-	return &logical_apic_id_table[index];
+	return &kvm_svm->avic_logical_id_table[index];
 }
 
 static void avic_ldr_write(struct kvm_vcpu *vcpu, u8 g_physical_id, u32 ldr)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 71e3c003580e..ec5d77d42a49 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -123,8 +123,8 @@ struct kvm_svm {
 
 	/* Struct members for AVIC */
 	u32 avic_vm_id;
-	struct page *avic_logical_id_table_page;
-	struct page *avic_physical_id_table_page;
+	u32 *avic_logical_id_table;
+	u64 *avic_physical_id_table;
 	struct hlist_node hnode;
 
 	struct kvm_sev_info sev_info;
-- 
2.49.0.1151.ga128411c76-goog

