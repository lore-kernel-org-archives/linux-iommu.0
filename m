Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3555318B1A
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 21:35:46 +0000 (UTC)
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-589f7d66f22so25203407b3.3
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 14:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692135346; x=1692740146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IBUBLv/HPCB4LKxnLIHtLexFhB0Q0oPfVfCHc1YuUoQ=;
        b=ftNRWSl2wcGncg449q6rittoHtsDkLodn9kmNNUK4LvngOrGtwDM2K09o9jf3R2pWi
         J3rnWu1wfSmkPaWGCrTivT9XIwI25fnxEfMmLd6yElwf41//GnxDXpOLLLVK7QiJpuph
         UKe2V+pWXdFaU0qqnuvDqot6lzX4CyW+S+uwhI8I6SEQKtr1i6KNzbfokbei/gfCCPoT
         ZmVsyHDjk0qvfkmihtZhiRv4q2CrPlagNMXQjJOA1vii66vGwm3w3VkLMCuZDqEakcrX
         KT0mCmG0VjFv/EahokcTaUV85DWjL6GdJehIiImnAwPJF2dIpRUWlXyzp6djaTYHXdaR
         Vg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692135346; x=1692740146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBUBLv/HPCB4LKxnLIHtLexFhB0Q0oPfVfCHc1YuUoQ=;
        b=ciG7Kb+DF74tEiHSaddx1lQDbcIO/F+NMzwgeIB+lOgjXPUiAQ4Mrjhwov+Q0dHtmk
         9I7lbj7MUQN1mH4b0NZ0E3H2lG3y6msedYh7Q9pwXlKL77P1pdAFo30yiGOqJj34cXYz
         /9V5GqSlIZqDIhTDUo13YadTVY5G2MuiVBWYHOKbkhixj4Mw+09oVGEBtasNT6DDjj8F
         yKQAei5N9sdXRWHCCJBt5HN3xM3txYkfLprJD3DXLlkNiNrm0qvu5L2zhSCI+vzZ7u+v
         wdtbpWh3PT6WHps/pawbtRAqfcl5In97WXQpmvjrjEb2GaXqRoR+7Du3Cq2a/4Fa2wKH
         PblQ==
X-Gm-Message-State: AOJu0YzaujM3OiTZRGgCcmnhDSCcVlp9z5YnFMix8H1SsZyfKF8up7no
	iRZvK+9YKVNpVtaWjwANgYXemjmLgok=
X-Google-Smtp-Source: AGHT+IEe878IgObP3kTHS4toaTgW55ygHhngjMRQJ+zm+0LnGR8rirD+rxQqbK+V+ONXjM8I6rX58b3A/iQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:90e:0:b0:d6b:1a89:6673 with SMTP id
 a14-20020a5b090e000000b00d6b1a896673mr100ybq.5.1692135345838; Tue, 15 Aug
 2023 14:35:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 15 Aug 2023 14:35:27 -0700
In-Reply-To: <20230815213533.548732-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230815213533.548732-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815213533.548732-5-seanjc@google.com>
Subject: [PATCH 04/10] KVM: SVM: Add helper to deduplicate code for getting
 AVIC backing page
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Add a helper to get the physical address of the AVIC backing page, both
to deduplicate code and to prepare for getting the address directly from
apic->regs, at which point it won't be all that obvious that the address
in question is what SVM calls the AVIC backing page.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index b8313f2d88fa..954bdb45033b 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -241,14 +241,18 @@ int avic_vm_init(struct kvm *kvm)
 	return err;
 }
 
+static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
+{
+	return __sme_set(page_to_phys(svm->avic_backing_page));
+}
+
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
-	phys_addr_t bpa = __sme_set(page_to_phys(svm->avic_backing_page));
 	phys_addr_t lpa = __sme_set(page_to_phys(kvm_svm->avic_logical_id_table_page));
 	phys_addr_t ppa = __sme_set(page_to_phys(kvm_svm->avic_physical_id_table_page));
 
-	vmcb->control.avic_backing_page = bpa;
+	vmcb->control.avic_backing_page = avic_get_backing_page_address(svm);
 	vmcb->control.avic_logical_id = lpa;
 	vmcb->control.avic_physical_id = ppa;
 	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE;
@@ -308,7 +312,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	if (!entry)
 		return -EINVAL;
 
-	new_entry = __sme_set(page_to_phys(svm->avic_backing_page)) |
+	new_entry = avic_get_backing_page_address(svm) |
 		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
 	WRITE_ONCE(*entry, new_entry);
 
@@ -859,7 +863,7 @@ get_pi_vcpu_info(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
 	pr_debug("SVM: %s: use GA mode for irq %u\n", __func__,
 		 irq.vector);
 	*svm = to_svm(vcpu);
-	vcpu_info->pi_desc_addr = __sme_set(page_to_phys((*svm)->avic_backing_page));
+	vcpu_info->pi_desc_addr = avic_get_backing_page_address(*svm);
 	vcpu_info->vector = irq.vector;
 
 	return 0;
@@ -917,7 +921,7 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 			struct amd_iommu_pi_data pi;
 
 			/* Try to enable guest_mode in IRTE */
-			pi.base = __sme_set(page_to_phys(svm->avic_backing_page));
+			pi.base = avic_get_backing_page_address(svm);
 			pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
 						     svm->vcpu.vcpu_id);
 			pi.is_guest_mode = true;
-- 
2.41.0.694.ge786442a9b-goog

