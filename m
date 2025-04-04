Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093F224230
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795611; cv=none; b=p/MWxLHi4vuQUNQURcwpMtadASrfhsFePoDMtfZEE1Je25h7RKG3rqWxDFxCFqXJIXfdiFmFkebctqsCrUlDXCsjxFk5tgKiGy41Yu+HnAe7xwNT5+y065rbl9FZGS/C9t6a2yHADDKJgkkIPUY2zaZI0nn/R4j3RXoWPRbm4RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795611; c=relaxed/simple;
	bh=+cf2Ksm3rNxUCqZDmz14iRQrHlrznLeIaeOW6HbZuz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tQ6kCJgQmYuvjN4A1ke2QHpLMdngF52QiSRyOvTiBAKCoT0QYtd0AdI/H6bnXRSpiVsa5+tTpR9DTQB0onQy55dK/a95gdxpRYpeIo63J3vcw0Adklq4z666W0f1fObLHtuoESo5xsvs0E1bu7ekUE55jJXddrtSq3GctCaVW7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aREvXb56; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aREvXb56"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7398d70abbfso3439852b3a.2
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795609; x=1744400409; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=W9APkMUQeyaT/9vh/qCbtT1Smo+i6/9PSzpMaw1arTA=;
        b=aREvXb56PHE4pl6ZYc680JLOJAljAEot0/6xGyyJ0G7IFVHeINfnvV5brroljh/LfS
         R9edpGksYTkVYTXOI04F+QSysxYn+qMHLQ+QauCi0k4rhyk47DJxqG2BVk9KAgYYHzSC
         ikDhmfn1VosnBxks6E316eYmKFWMjIOlxIw4su7m+D/mx+sJUene/G82P8LZMSkzD9CE
         u2H6+o9/2Fvr54i3w8p8cn7dxHTIHnUISUxurSv/7Lvj7tywpP/FuNUeM2cg42X55THF
         5dTadegLdMCtayKh4lwCZkFR5Hyo/eW0S5HYxITZF66TEbEAUEokeMzh7BZVi8KtZI7/
         +RBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795609; x=1744400409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W9APkMUQeyaT/9vh/qCbtT1Smo+i6/9PSzpMaw1arTA=;
        b=BVhL2irPipbALr0wviQkgPxdaBucpsDa+5V821zbc0pjFanxMZ4IprQlGwAMkbEdDB
         eVF2wWL4JNdUBLzDf6ZMuU1eJmIxFHi+bYdPxMUTJcZwt4I3N/eYTGFvIwSZuLfXDq8v
         T8sLiCX6X69w3VJDJjTSpQV4MnxWSrD90rezX0IwkPh8NGGg8ZcvxJMhCgjKjfBvtl0C
         /FX1JDZh78Rk3zAMAahv8uu00ZQ7Mdu/wBdKNF7RTcg5uIn5iIBaiFTOPKmrmKqOKQCz
         BEN2ScIV1I+UgprtPr2rfFlhrgwwo3wiBvZdzzezA57T6MEOUlQpwjjinTpr93mZMkUP
         ikJA==
X-Forwarded-Encrypted: i=1; AJvYcCXeOjsaItp96M28RBeR0NkDTG4tN283qc8ZK4HVcjjr5aif5jTjnLNILydeK7lPKzqctGnfPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzrXZTk/3BmXcDvRp0ot0mOFszyfNS3+YsCPoC10UvthZ4Bgoy
	ZB00tQImy3OlfAyOq87gJDFJ9+JMwRe2ItT7xw9YerN1CdtrU0eUJ4NN9jMgOjxnkaqDwuW/qsf
	ATw==
X-Google-Smtp-Source: AGHT+IHalJ84y5RZE6lIh9ca7jwC0g2+DKaK5EknSYSwFsFGl6+cpbF1yHJUby80bAdxdbQykyr6DzCtB1E=
X-Received: from pfbhq12.prod.google.com ([2002:a05:6a00:680c:b0:736:ae72:7543])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1308:b0:736:bfc4:ef2c
 with SMTP id d2e1a72fcca58-73b69a3ef7emr853006b3a.0.1743795609327; Fri, 04
 Apr 2025 12:40:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:28 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-14-seanjc@google.com>
Subject: [PATCH 13/67] KVM: SVM: Drop pointless masking of kernel page pa's
 with AVIC HPA masks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop AVIC_HPA_MASK and all its users, the mask is just the 4KiB-aligned
maximum theoretical physical address for x86-64 CPUs, as x86-64 is
currently defined (going beyond PA52 would require an entirely new paging
mode, which would arguably create a new, different architecture).

All usage in KVM masks the result of page_to_phys(), which on x86-64 is
guaranteed to be 4KiB aligned and a legal physical address; if either of
those requirements doesn't hold true, KVM has far bigger problems.

Drop masking the avic_backing_page with
AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK for all the same reasons, but
keep the macro even though it's unused in functional code.  It's a
distinct architectural define, and having the definition in software
helps visualize the layout of an entry.  And to be hyper-paranoid about
MAXPA going beyond 52, add a compile-time assert to ensure the kernel's
maximum supported physical address stays in bounds.

The unnecessary masking in avic_init_vmcb() also incorrectly assumes that
SME's C-bit resides between bits 51:11; that holds true for current CPUs,
but isn't required by AMD's architecture:

  In some implementations, the bit used may be a physical address bit

Key word being "may".

Opportunistically use the GENMASK_ULL() version for
AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK, which is far more readable
than a set of repeating Fs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/svm.h |  4 +---
 arch/x86/kvm/svm/avic.c    | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 9d3f17732ab4..8b07939ef3b9 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -247,7 +247,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define AVIC_LOGICAL_ID_ENTRY_VALID_MASK		(1 << 31)
 
 #define AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK	GENMASK_ULL(11, 0)
-#define AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK	(0xFFFFFFFFFFULL << 12)
+#define AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK	GENMASK_ULL(51, 12)
 #define AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK		(1ULL << 62)
 #define AVIC_PHYSICAL_ID_ENTRY_VALID_MASK		(1ULL << 63)
 #define AVIC_PHYSICAL_ID_TABLE_SIZE_MASK		(0xFFULL)
@@ -282,8 +282,6 @@ enum avic_ipi_failure_cause {
 static_assert((AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == AVIC_MAX_PHYSICAL_ID);
 static_assert((X2AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AVIC_MAX_PHYSICAL_ID);
 
-#define AVIC_HPA_MASK	~((0xFFFULL << 52) | 0xFFF)
-
 #define SVM_SEV_FEAT_SNP_ACTIVE				BIT(0)
 #define SVM_SEV_FEAT_RESTRICTED_INJECTION		BIT(3)
 #define SVM_SEV_FEAT_ALTERNATE_INJECTION		BIT(4)
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 69bf82fc7890..f04010f66595 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -250,9 +250,9 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 	phys_addr_t lpa = __sme_set(page_to_phys(kvm_svm->avic_logical_id_table_page));
 	phys_addr_t ppa = __sme_set(page_to_phys(kvm_svm->avic_physical_id_table_page));
 
-	vmcb->control.avic_backing_page = bpa & AVIC_HPA_MASK;
-	vmcb->control.avic_logical_id = lpa & AVIC_HPA_MASK;
-	vmcb->control.avic_physical_id = ppa & AVIC_HPA_MASK;
+	vmcb->control.avic_backing_page = bpa;
+	vmcb->control.avic_logical_id = lpa;
+	vmcb->control.avic_physical_id = ppa;
 	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE;
 
 	if (kvm_apicv_activated(svm->vcpu.kvm))
@@ -310,9 +310,12 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	if (!entry)
 		return -EINVAL;
 
-	new_entry = __sme_set((page_to_phys(svm->avic_backing_page) &
-			      AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK) |
-			      AVIC_PHYSICAL_ID_ENTRY_VALID_MASK);
+	/* Note, fls64() returns the bit position, +1. */
+	BUILD_BUG_ON(__PHYSICAL_MASK_SHIFT >
+		     fls64(AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK));
+
+	new_entry = __sme_set(page_to_phys(svm->avic_backing_page)) |
+		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
 	WRITE_ONCE(*entry, new_entry);
 
 	svm->avic_physical_id_cache = entry;
@@ -912,8 +915,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			enable_remapped_mode = false;
 
 			/* Try to enable guest_mode in IRTE */
-			pi.base = __sme_set(page_to_phys(svm->avic_backing_page) &
-					    AVIC_HPA_MASK);
+			pi.base = __sme_set(page_to_phys(svm->avic_backing_page));
 			pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
 						     svm->vcpu.vcpu_id);
 			pi.is_guest_mode = true;
-- 
2.49.0.504.g3bcea36a83-goog

