Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608E221FDF
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962028; cv=none; b=nWQ4ITD5Sa5pSlNESeCyluOuskF44HS2+rd+XpghHo8s/ga4/muETtMzSiU4Az8YH4EvM2Aw91SToXlx4Wn/AH7s3fmdOdUcAStbaSMs6hqtY1iapod+Zn0Tg1DgTvkSezBtcWzuqwGhO4h906840gFC4nz6ie7fuAcxj2arpTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962028; c=relaxed/simple;
	bh=j0ASWP3bWTrNWVjsJSKCYoX8Gmsgdig5lrhdNEmpSMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OR+Au4P/YM+/uNz86Kg5coxAHae04QjMuraUDH9QVhtXQKWGPVDU2XDXSrDo3boZcD3Zk6u8PQZIwf6vM4RIxx12iDkIinzGptPHKiKq3yT2m1K5cXkr8Xx3a7E52O9NN4pepHkGs457rTOqX4oeQ05jDQKw7pBzm2IICjLZ18U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XR3JP5dw; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XR3JP5dw"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ebfc28a1eso8131565a91.2
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962026; x=1748566826; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HLLwB8uaam+w+auGeOJdoWeeiO/rpte3+zLDk0hPf3k=;
        b=XR3JP5dwb04dYpaYP9WP80JE1FHsNbxrGaBLjP6HkL0kHSkwYfHwPtZVeWYW4Zm0tw
         cYE3pf4Q+5RDemDrKYkR+f1y0wA66bVp/Ayxcy+PG27VPKVDoX+HVJHx5h0bkpIGMTG0
         eoieEf9f6GUhQyoYlkZrCihpBlktZ4bUtu8BVEs2X1W5BuQI/Vo+lO72SWJ0eriOUsMZ
         iCPCaYw/1sVPHcYb5YpHL8ZCVoSRGZ5xURM5dwM8CQhSc/YmkL+ytiuzheMLcPcwrKa1
         NhLrWp+ZIZMFXHBV825Zpb56HlpltmvCgbfi4IYiT5Ko+zPelbdDmdAc5iv2zSWU5wtU
         jFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962026; x=1748566826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLLwB8uaam+w+auGeOJdoWeeiO/rpte3+zLDk0hPf3k=;
        b=eHLWYk+qgviMU8NaANh0st3v5RLk2uEKcg9RqRtGlU+0n4ZW8Iv8PX2e6RrsMNk50p
         bwSs0d6NDtrKAY8rCqZbZAe1JDft7AZ/RlACS9gSRPkP0MGZVN+/7VzhSKZwyVInsLac
         neTem+WISdO704xyoyU96fnrJuo0EZo5aP085a6v8S0kCa5lSQxIlAO2ggmps4RKcvFU
         PfbaSim6dYo6ziBsasmNQDkzEkzj0enS1dMl8dKc6Lun2SJDAcsJkl9pq2YrHpM4ayaD
         /PKXg7ovHQxQcEv7HDjliLGevGZN5ksJ5BPHqOJWl37/3nvzsSe05nNWUfaeP051+8QV
         jdyw==
X-Forwarded-Encrypted: i=1; AJvYcCXr5pxjjtYYleyZU4rWKNzsi9VBtbZBzUKY9gR334cPLU0d/oKksZEYpI5rIE5XkNAVZr0QRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUh0oBejMNRyJRRkg87JrWTR5Vy35ZJa7xPIjcBnNsTe2gVTLo
	ppJnIOE2Xmsm6zhWLUf4GRnYVkc6yUWQ2Ph30Aq9BB5pV+aR+rt7CZQxdpqEEd4PxzsUtS6V1yS
	BYSb11A==
X-Google-Smtp-Source: AGHT+IFfuPhNF4QHWjfa9+uUgFQmIGeujJj5PfNmNyVQGzTqn6A2kUoJFJoVip3tZ9o2B4MRTJUIsR9I0NA=
X-Received: from pjbrr6.prod.google.com ([2002:a17:90b:2b46:b0:30a:89a8:cef0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e18b:b0:2fe:a515:4a98
 with SMTP id 98e67ed59e1d1-30e8323ecdfmr32685566a91.31.1747962026242; Thu, 22
 May 2025 18:00:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:14 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-10-seanjc@google.com>
Subject: [PATCH v2 09/59] KVM: SVM: Drop vcpu_svm's pointless
 avic_backing_page field
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop vcpu_svm's avic_backing_page pointer and instead grab the physical
address of KVM's vAPIC page directly from the source.  Getting a physical
address from a kernel virtual address is not an expensive operation, and
getting the physical address from a struct page is *more* expensive for
CONFIG_SPARSEMEM=y kernels.  Regardless, none of the paths that consume
the address are hot paths, i.e. shaving cycles is not a priority.

Eliminating the "cache" means KVM doesn't have to worry about the cache
being invalid, which will simplify a future fix when dealing with vCPU IDs
that are too big.

WARN if KVM attempts to allocate a vCPU's AVIC backing page without an
in-kernel local APIC.  avic_init_vcpu() bails early if the APIC is not
in-kernel, and KVM disallows enabling an in-kernel APIC after vCPUs have
been created, i.e. it should be impossible to reach
avic_init_backing_page() without the vAPIC being allocated.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 6 ++----
 arch/x86/kvm/svm/svm.h  | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index c36f7db9252e..ab228872a19b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -236,7 +236,7 @@ int avic_vm_init(struct kvm *kvm)
 
 static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
 {
-	return __sme_set(page_to_phys(svm->avic_backing_page));
+	return __sme_set(__pa(svm->vcpu.arch.apic->regs));
 }
 
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
@@ -281,7 +281,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	    (id > X2AVIC_MAX_PHYSICAL_ID))
 		return -EINVAL;
 
-	if (!vcpu->arch.apic->regs)
+	if (WARN_ON_ONCE(!vcpu->arch.apic->regs))
 		return -EINVAL;
 
 	if (kvm_apicv_activated(vcpu->kvm)) {
@@ -298,8 +298,6 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 			return ret;
 	}
 
-	svm->avic_backing_page = virt_to_page(vcpu->arch.apic->regs);
-
 	/* Setting AVIC backing page address in the phy APIC ID table */
 	entry = avic_get_physical_id_entry(vcpu, id);
 	if (!entry)
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index cc27877d69ae..1585288200f4 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -306,7 +306,6 @@ struct vcpu_svm {
 
 	u32 ldr_reg;
 	u32 dfr_reg;
-	struct page *avic_backing_page;
 	u64 *avic_physical_id_cache;
 
 	/*
-- 
2.49.0.1151.ga128411c76-goog

